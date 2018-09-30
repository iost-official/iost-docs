---
id: Lucky-Bet-Operation
title: Step-by-Step Commands to Deploy and Run
sidebar_label: Step-by-Step Commands to Deploy and Run
---

## Setup Environment
### Install Golang. 
```shell
wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
# untar to /usr/local/go 
sudo tar -C /usr/local -xzf go1.11.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOROOT/bin:$GOPATH/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
go version # You will see "go version go1.11 linux/amd64".
```
### Install Docker  
Have a look at [official steps](https://docs.docker.com/install/linux/docker-ce/ubuntu/). After installing, running 'docker run hello-world', you will see the following output：
![docker_output](assets/5-lucky-bet/Lucky-Bet-Operation/docker_output.png)
## Build IOST
```shell
go get -d github.com/iost-official/go-iost
cd $GOPATH/src/github.com/iost-official/go-iost
git checkout develop # master is the stable branch, while develop is the active branch
make image # build the whole project to make one docker image. Wait for a moment. You will see outputs like 'Successfully tagged iostio/iost-node:1.0.0-ed23f6d'.
```
## Run an IOST node locally
```shell
mkdir -p data/iserver # The dir will be used to store config and blockchain data
cp config/iserver.docker.yml data/iserver/iserver.yml 
# Start the Node. You must make sure that the docker image name in this command is the same as the output of the 'make image' command.
docker run -it --rm -v `pwd`/data/iserver:/var/lib/iserver -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:1.0.0-ed23f6d
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)
## Deploy and Run the Smart Contract
```shell
# install the client tool 'iwallet'
cd ~/go/src/github.com/iost-official/go-iost
make install
iwallet # You will see the command usage infomation.
  
# deploy and run the smart contract
cd ~/go/src/github.com/iost-official
git clone https://github.com/iost-official/luckybet_sample.git
cd luckybet_sample/
python3.6 luckbet.py # You will see "Congratulations! You have just run a smart contract on IOST!".
```

## Troubleshooting
### Build Error
Problem: make build error：can't load package: package github.com/iost-official/go-iost/cmd/iserver.  
Solution: GOPATH may be incorrect。run "echo $GOPATH", make sure it outputs is correct.