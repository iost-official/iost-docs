---
id: Deployment
title: Deployment
sidebar_label: Deployment
---

## Get repo
执行如下命令获取代码仓库：
```
git clone git@github.com:iost-official/Go-IOS-Protocol.git
```

## Build
执行如下命令进行编译，生成`target`目录：
```
make build
```

## Run
执行如下命令可以跑一个单机节点，iserver的具体配置可以参见：[iServer](iServer)
```
./target/iserver -f config/iserver.yml
```

## Docker
### Run
执行如下命令可以用docker跑一个单机节点
```
docker run -it --rm iostio/iost-node:2.0.0
```

### Mount volume


### Bind port



## Access testnet

### Update config
