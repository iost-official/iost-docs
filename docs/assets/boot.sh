#!/bin/sh
#
# boot.sh
# Copyright (C) 2019 jack <jack@iOSTdeMacBook-Pro.local>
#
# Distributed under terms of the MIT license.
#

set -ue

PREFIX=${PREFIX:="/data/iserver"}
VERSION=${VERSION:="latest"}

PRODUCER_KEY_FILE=keypair
CURL="curl -fsSL"

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

#
# Pre-check
#

{
    curl --version &>/dev/null
    python -V &>/dev/null
    docker version &>/dev/null || install_docker
    docker-compose version &>/dev/null || install_docker_compose
}

if [ -d "$PREFIX" ]; then
    >&2 echo Warning: path \"$PREFIX\" exists\; this script will remove it.
    >&2 echo You may press Ctrl+C now to abort this script.
    ( set -x; sleep 20 )
fi

sudo rm -rf $PREFIX
sudo mkdir -p $PREFIX
sudo chown -R $(id -nu):$(id -ng) $PREFIX
cd $PREFIX

#
# Generate key producer pair
#

( docker run --rm iostio/iost-node:$VERSION ./iwallet key; ) >> $PRODUCER_KEY_FILE

#
# Get genesis info
#

$CURL "https://developers.iost.io/docs/assets/testnet/$VERSION/genesis.tgz" | tar zxC $PREFIX
$CURL "https://developers.iost.io/docs/assets/testnet/$VERSION/iserver.yml" -o $PREFIX/iserver.yml

#
# Config producer
#

#PUBKEY=$(cat $PRODUCER_KEY_FILE | python -c 'import sys,json;print(json.load(sys.stdin)["Pubkey"]'))
PRIKEY=$(cat $PRODUCER_KEY_FILE | python -c 'import sys,json;print(json.load(sys.stdin)["Seckey"])')

#sed -i.bak 's/  id: .*$/  id: '$PUBKEY'/g' iserver.yml
sed -i.bak 's/  seckey: .*$/  seckey: '$PRIKEY'/g' iserver.yml

#
# Ready to start iServer
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

docker-compose up -d

until $($CURL localhost:30001/getNodeInfo &>/dev/null); do
    printf '.'
    sleep 2
done

>&2 echo Your network ID is:
( set -x; $CURL localhost:30001/getNodeInfo | python -c 'import json,sys;print(json.load(sys.stdin)["network"]["id"])' )
