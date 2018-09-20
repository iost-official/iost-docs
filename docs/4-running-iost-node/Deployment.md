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
通过-v选项可以将数据目录挂载出来，例如：
```
mkdir -p /data/iserver
cp config/iserver.docker.yml /data/iserver
docker run -it --rm -v /data/iserver:/var/lib/iserver iostio/iost-node:2.0.0
```
### Bind port
通过-p选项可以将端口绑定出来，例如：
```
docker run -it --rm -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:2.0.0
```


## Access testnet

### Update config
将genesis配置修改为如下：
```
genesis:
  creategenesis: true
  witnessinfo:
  - IOST2g5LzaXkjAwpxCnCm29HK69wdbyRKbfG4BQQT7Yuqk57bgTFkY
  - "100000000000000000"
  - IOST22TgXbjvgrDd3DuMkVufcWbYDMy7vpmQoCgZXmgi8eqM7doxWD
  - "100000000000000000"
  - IOSTAXksR6rKvmkjJyzhJJkDsG3yip47BJJWmbSTYqwqoNErBoN2k
  - "100000000000000000"
  - IOSTFPe9aXhZMmyvy6BsmgeucKEgzXy3zHMhsBFFeqNtKsqy98sbX
  - "100000000000000000"
  - IOST23xQCcviwn7AGxDnJbkL2Sjh8ijsKL6sPJWAkVEP8jACHLGknX
  - "100000000000000000"
  - IOST2CxDxZJwo2Useu2kMvZRTmMpHiwrK4UzQRLEQccLTfAmY9Z4Up
  - "100000000000000000"
  - IOSTKbYwTYpGZUTQqnmnbQAeJKhCBAMfW3pNvtJn6nEtVj6aozGMQ
  - "100000000000000000"
  - IOSTxUBnFHNBb22TSU8ruiEPfVUx6utxxbUcat3ZaDmtZea4roPES
  - "100000000000000000"
  - IOSTpWBkze9vPL3rxmnobgVN6s6WwHUFJGMo7wFcAHwkbhij3eDZY
  - "100000000000000000"
  - IOST27LJHEEBZ8oNqQR9EhutmybLuNdeitNfWdkoFk8MwQ2pSbifig
  - "100000000000000000"
  - IOST2AcBEJawoVzg4MW6UcvQsP6p6mSwACF7bbroNU2jBtE3MDSt6G
  - "100000000000000000"
  votecontractpath: config/
```
将p2p.seednodes配置修改为如下：
p2p:
  seednodes:
  - /ip4/54.88.65.72/tcp/30000/ipfs/12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht

其中种子节点Network ID可以进行替换，测试网络提供的种子节点列表如下：

| Name | Network ID |
|      |            |
|      |            |
|      |            |
|      |            |
|      |            |
|      |            |
|      |            |

### Run iserver
跑iserver时指定修改后的配置，即可连上testnet
```
./target/iserver -f config/iserver.yml
```
