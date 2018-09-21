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
```
p2p:
  seednodes:
  - /ip4/18.218.255.180/tcp/30000/ipfs/12D3KooWLwNFzkAf3fRmjVRc9MGcn89J8HpityXbtLtdCtPSHDg1
```

其中种子节点Network ID可以进行替换，测试网络提供的种子节点列表如下：

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node16 | 美国东 | /ip4/18.218.255.180/tcp/30000/ipfs/12D3KooWLwNFzkAf3fRmjVRc9MGcn89J8HpityXbtLtdCtPSHDg1 |
| node17 | 美国西 | /ip4/52.9.253.198/tcp/30000/ipfs/12D3KooWABS9bLYUnvmLYeuZvkgL2WY3TLHJDbmG2tUWB4GfJJiq   |
| node19 | 孟买   | /ip4/13.127.153.57/tcp/30000/ipfs/12D3KooWAx1pZHvUq73UGMSXqjUBsKBKgXFoFBoXZZAhfvM9HnVr  |
| node20 | 首尔   | /ip4/52.79.231.23/tcp/30000/ipfs/12D3KooWCsq3Lfxe8E17anTred2o7X4cSZ77faai8hkHH611RjMp   |
| node21 | 新加坡 | /ip4/13.229.176.106/tcp/30000/ipfs/12D3KooWKGK1ah5JgMEic2dH8oYE3LMEZLBJUzCNP165tPaQnaW9 |
| node22 | 悉尼   | /ip4/13.238.140.219/tcp/30000/ipfs/12D3KooWGHmaxL8LmRpvXoFPNYj3FavYgqqEBks4YPVUL6KRcQFs |
| node23 | 加拿大 | /ip4/52.60.78.2/tcp/30000/ipfs/12D3KooWAivafPT52QEf2eStdXS4DjiRyLCGhLanvVgJ7hhbqans     |
| node24 | 德国   | /ip4/52.58.16.220/tcp/30000/ipfs/12D3KooWPKjYYL4tvbUQF2VzA1mg6XsByA8GVN4anDfrRxp9qdxm   |
| node25 | 爱尔兰 | /ip4/18.202.100.127/tcp/30000/ipfs/12D3KooWDL2BdvSR65kS2z8LX8142ksX35mNFWhtVpK6a24WXBoV |
| node26 | 英国   | /ip4/35.176.96.113/tcp/30000/ipfs/12D3KooWHfCWdXnKkTqFYNh8AhrjJ21v7RrTTuwSBLztHgGLWYyX  |
| node27 | 法国   | /ip4/52.47.133.32/tcp/30000/ipfs/12D3KooWScNNuMLh1AEnWoNppXKY6qwVVGrvzYF4dKQxBMmnwW3b   |
| node28 | 巴西   | /ip4/52.67.231.15/tcp/30000/ipfs/12D3KooWRJxjPsVxRR7spvfRPRWzvGKZrWggRj5kEiqyS4tzPq78   |
| node40 | 东京   | /ip4/52.192.86.141/tcp/30000/ipfs/12D3KooWS4kyTpyjEA8ixqFGT7uLd4mAh4fYbYNYhaPYNEWE69BA  |

### Run iserver
跑iserver时指定修改后的配置，即可连上testnet
```
./target/iserver -f config/iserver.yml
```
