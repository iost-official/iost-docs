---
id: Lucky-Bet-Operation
title: 컨트랙트 배포와 실행
sidebar_label: 컨트랙트 배포와 실행
---

## 환경 설정
### Golang 설치하기
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
### 도커 설치하기  
[공식 가이드 문서](https://docs.docker.com/install/linux/docker-ce/ubuntu/)를 참조해서 도커를 설치해주세요. 설치가 끝난 후에, 'docker run heelo-world'를 입력하면 다음과 같은 결과가 출력됩니다.
![docker_output](../assets/5-lucky-bet/Lucky-Bet-Operation/docker_output.png)
## go-iost 빌드하기
```shell
go get -d github.com/iost-official/go-iost
cd $GOPATH/src/github.com/iost-official/go-iost
git checkout develop # master is the stable branch, while develop is the active branch
make image # build the whole project to make one docker image. Wait for a moment. You will see outputs like 'Successfully tagged iostio/iost-node:1.0.0-ed23f6d'.
```
## IOST 노드 로컬 구동하기
```shell
mkdir -p data/iserver # The dir will be used to store config and blockchain data
cp config/iserver.docker.yml data/iserver/iserver.yml
# Start the Node. You must make sure that the docker image name in this command is the same as the output of the 'make image' command.
docker run -it --rm -v `pwd`/data/iserver:/var/lib/iserver -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:1.0.0-ed23f6d
```
![server_output](../assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)
## 스마트 컨트랙트 배포와 실행
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

## 트러블슈팅
### 빌드 에러
Problem: make build error：can't load package: package github.com/iost-official/go-iost/cmd/iserver. 와 같은 에러메시지가 뜨는 경우.
Solution: GOPATH를 올바르게 설정해주어야 합니다. "echo $GOPATH" 명령어를 입력하면, 현재 설정되어있는 GOPATH를 볼 수 있습니다. 경로가 올바르게 설정되어있는지 확인해주세요.
