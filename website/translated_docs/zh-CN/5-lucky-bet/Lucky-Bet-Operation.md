---
id: Lucky-Bet-Operation
title: 运行智能合约的具体指令
sidebar_label: 运行智能合约的具体指令
---

## 步骤一 配置环境
Step1 安装 golang 环境。
```shell
wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
# 解压到 /usr/local/go 位置
sudo tar -C /usr/local -xzf go1.11.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOROOT/bin:$GOPATH/bin:$PATH' >> ~/.bashrc
# 确保 ~/.bashrc 生效
source ~/.bashrc
go version # 此时应该能够正确输出 “go version go1.11 linux/amd64” 字样。
```
Step2 安装 Docker 环境。具体步骤见[官方文档](https://docs.docker.com/install/linux/docker-ce/ubuntu/)。安装成功的标志是，运行 docker run hello-world，能够正确输出类似如下：
![docker_output](assets/5-lucky-bet/Lucky-Bet-Operation/docker_output.png)
## 步骤二 编译IOST项目
```shell
go get -d github.com/iost-official/go-iost
cd $GOPATH/src/github.com/iost-official/go-iost
git checkout develop # master分支是相对稳定的发布分支，develop分支是最新的开发代码
make image # 这一步中，编译整个项目，并且打包成一个docker image。请耐心等待。成功后会输出类似 Successfully tagged iostio/iost-node:1.0.0-ed23f6d 的字样（可能不完全相同）。
```
## 步骤三 在本地启动IOST节点
```shell
mkdir -p data/iserver # 本目录将会用来储存IOST节点的启动配置和运行数据
cp config/iserver.docker.yml data/iserver/iserver.yml #设置节点配置文件
# 启动节点。注意！本命令最后的那一段是 docker image 的名字，必须和 步骤二 中 make image 的最后一行输出一致。
# 启动成功的标志是，输出类似如下。持续运行不退出，日志颜色一直为蓝色，不报错。报错时日志会是其他颜色。
docker run -it --rm -v `pwd`/data/iserver:/var/lib/iserver -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:1.0.0-ed23f6d
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)
## 步骤四 部署运行智能合约
```shell
# 先确保全局安装 IOST 命令行客户端工具 'iwallet'
cd ~/go/src/github.com/iost-official/go-iost
make install
iwallet # 验证安装成功。此时应该输出 An IOST RPC client 和一些命令行用法信息
  
#下面运行智能合约代码
cd ~/go/src/github.com/iost-official
git clone https://github.com/iost-official/luckybet_sample.git
cd luckybet_sample/
python3.6 luckbet.py # 此时正确运行后，应该最后会输出“Congratulations! You have just run a smart contract on IOST!”。意味着本合约部署运行成功了！
```

## 常见问题
1 make build时报错：can't load package: package github.com/iost-official/go-iost/cmd/iserver
很可能是 GOPATH 配置不正确。请运行 echo $GOPATH，确认正确输出 /home/xxx/go