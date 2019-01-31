#!/bin/sh
#
# boot.sh
# Copyright (C) 2019 jack <jack@iOSTdeMacBook-Pro.local>
#
# Distributed under terms of the MIT license.
#

set -ue

PREFIX=${PREFIX:="/data/iserver"}
INET=${PREFIX:="testnet"}
VERSION=${VERSION:="latest"}

PRODUCER_KEY_FILE=keypair
CURL="curl -fsSL"
PYTHON=${PYTHON:=python}

#
# function
#

_SYS_MIN_CPU=4          # 4 cpu
_SYS_REC_CPU=8          # 8 cpu
_SYS_MIN_MEM=8          # 8G ram
_SYS_REC_MEM=16         # 16G ram
_SYS_MIN_STO=100        # 100G storage
_SYS_REC_STO=1000       # 1T storage

print_requirements() {
    {
        printf "\nWarning: please consider upgrading your hardware to get better performance."
        printf "\n"
        printf "\nSystem requirements to run IOST node:\n\n"
        printf "\tMinimal: \t$_SYS_MIN_CPU cpu / ${_SYS_MIN_MEM}G ram / ${_SYS_MIN_STO}G storage\n"
        printf "\tRecommended: \t$_SYS_REC_CPU cpu / ${_SYS_REC_MEM}G ram / ${_SYS_REC_STO}G storage\n"
        printf "\n"
    }>&2
}

print_minimal_fail() {
    {
        echo Minimal requirements not satisfied. Stopped.
    }>&2
    return 1
}

install_docker() {
    $CURL https://get.docker.com | sudo sh
    return 1
}

install_docker_compose() {
    _SYS=$(uname)
    if [ x$_SYS = x"Linux" ]; then
        >&2 echo Installing docker-compose ...
        sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        docker-compose version >/dev/null && return 0
    fi
    >&2 echo Install docker-compose failed. See https://docs.docker.com/compose/install/.
    return 1
}

pre_check() {
    curl --version &>/dev/null
    ${PYTHON} -V &>/dev/null || { >&2 echo "Python not found. You might need to set '$PYTHON' manually."; return 1; }
    docker version &>/dev/null || install_docker
    docker-compose version &>/dev/null || install_docker_compose
}

init_prefix() {
    if [ -d "$PREFIX" ]; then
        {
            echo Warning: path \"$PREFIX\" exists\; this script will remove it.
            echo You may press Ctrl+C now to abort this script.
        }>&2
        ( set -x; sleep 20 )
    fi
    ( set -x; sudo rm -rf $PREFIX)
    sudo mkdir -p $PREFIX
    sudo chown -R $(id -nu):$(id -ng) $PREFIX
    cd $PREFIX
}

do_system_check() {
    >&2 printf 'Checking system ... '

    _SYS_WARN=0
    _SYS_STOP=0
    _SYS=$(uname)
    _CPU=$(getconf _NPROCESSORS_ONLN)
    _STO=$(df -k $PREFIX | awk 'NR==2 {print int($4/1000^2)}')
    if [ x$_SYS = x"Linux" ]; then
        _MEM=$(awk '/MemTotal/{print int($2/1000^2)}' /proc/meminfo)
    elif [ x$_SYS = x"Darwin" ]; then
        _MEM=$(sysctl hw.memsize | awk '{print int($2/1000^3)}')
    else
        >&2 echo System not recognized !
    fi

    if [ $_CPU -lt $_SYS_MIN_CPU ]; then
        _SYS_STOP=1
    elif [ $_CPU -lt $_SYS_REC_CPU ]; then
        _SYS_WARN=1
    fi

    if [ $_MEM -lt $_SYS_MIN_MEM ]; then
        _SYS_STOP=1
    elif [ $_MEM -lt $_SYS_REC_MEM ]; then
        _SYS_WARN=1
    fi

    if [ "$_STO" -lt $_SYS_MIN_STO ]; then
        _SYS_STOP=1
    elif [ $_STO -lt $_SYS_REC_STO ]; then
        _SYS_WARN=1
    fi

    if [ $_SYS_STOP -eq 1 ]; then
        print_requirements
        print_minimal_fail
    fi
    if [ $_SYS_WARN -eq 1 ]; then
        print_requirements
    fi
}

print_servi() {
    {
        echo If you want to register Servi node, exec:
        printf "\n\t"
        echo "iwallet --account <your-account> --amount_limit '*:unlimited' call 'vote_producer.iost' 'applyRegister' '[\"<your-account>\",\"$PUBKEY\",\"\",\"\",\""$NETWORK_ID"\",true]'"
        echo
        echo To set the Servi node online:
        printf "\n\t"
        echo "iwallet --acount <your-account> --amount_limit '*:unlimited' call 'vote_producer.iost' 'logInProducer' '[\"<your-account>\"]'"
        echo
        echo See full doc at https://developers.iost.io
        echo
    }>&2
}

print_bye() {
    {
        echo Happy hacking !
        echo
    }>&2
}

#
# main
#

pre_check
init_prefix
do_system_check

#
# Build compose file
#

cat <<EOF >docker-compose.yml
version: "2.2"

services:
  iserver:
    image: iostio/iost-node:$VERSION
    container_name: iserver
    restart: on-failure
    ports:
      - "30000-30003:30000-30003"
    volumes:
      - $PREFIX:/var/lib/iserver:Z
EOF

docker-compose pull

#
# Generate key producer pair
#

( docker run --rm iostio/iost-node:$VERSION iwallet key; ) >> $PRODUCER_KEY_FILE

#
# Get genesis info
#

$CURL "https://developers.iost.io/docs/assets/$INET/$VERSION/genesis.tgz" | tar zxC $PREFIX
$CURL "https://developers.iost.io/docs/assets/$INET/$VERSION/iserver.yml" -o $PREFIX/iserver.yml

#
# Config producer
#

PUBKEY=$(cat $PRODUCER_KEY_FILE | ${PYTHON} -c 'import sys,json;print(json.load(sys.stdin)["Pubkey"])')
PRIKEY=$(cat $PRODUCER_KEY_FILE | ${PYTHON} -c 'import sys,json;print(json.load(sys.stdin)["Seckey"])')

#sed -i.bak 's/  id: .*$/  id: '$PUBKEY'/g' iserver.yml
sed -i.bak 's/  seckey: .*$/  seckey: '$PRIKEY'/g' iserver.yml

#
# Start iServer
#

docker-compose up -d

until $($CURL localhost:30001/getNodeInfo &>/dev/null); do
    >&2 printf '.'
    sleep 2
done

NETWORK_ID=$($CURL localhost:30001/getNodeInfo | ${PYTHON} -c 'import json,sys;print(json.load(sys.stdin)["network"]["id"])')
{
    echo
    echo Your network ID is:
    echo $NETWORK_ID
    echo
}>&2

print_servi
print_bye
