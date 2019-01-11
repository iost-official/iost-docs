---
id: Deployment
title: 部署
sidebar_label: 部署
---
本文介绍如何加入IOST官方网。如果只是测试调试，建议部署[本地单节点网络](4-running-iost-node/LocalServer.md)

## 依赖

- [Docker CE 18.06 以上](https://docs.docker.com/install)
- (Optional) [Docker Compose](https://docs.docker.com/compose/install)

## 配置*创世块*和 iServer

获取配置模版：

```
mkdir -p /data/iserver
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/docker/iserver.yml -o /data/iserver/iserver.yml
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/genesis.yml -o /data/iserver/genesis.yml
```

这里 `/data/iserver` 是数据目录，可以根据实际情况自行修改。

*如果运行过以前版本的测试网，请清空数据:*

```
rm -rf /data/iserver/storage
```

修改*创世块*配置文件(位于`/data/iserver/genesis.yml`)：

```
creategenesis: true
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 21000000000
  iostdecimal: 8
  ramtotalsupply: 9000000000000000000
  ramgenesisamount: 137438953472
witnessinfo:
  - id: producer00000
    owner: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    active: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    balance: 1000000000
  - id: producer00001
    owner: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    active: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    balance: 1000000000
  - id: producer00002
    owner: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    active: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    balance: 1000000000
  - id: producer00003
    owner: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    active: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    balance: 1000000000
  - id: producer00004
    owner: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    active: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    balance: 1000000000
  - id: producer00005
    owner: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    active: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    balance: 1000000000
  - id: producer00006
    owner: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    active: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    balance: 1000000000
contractpath: contract/
admininfo:
  id: admin
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 14000000000
foundationinfo:
  id: foundation
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 0
initialtimestamp: "2006-01-02T15:04:05Z"
```

将 iserver.yml 中的 p2p.seednodes 配置修改为如下：

```
...
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a
  chainid: 1024
  version: 1
...
```

其中种子节点 Network ID 可以进行替换，测试网络提供的种子节点列表如下：

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | 伦敦 | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | 巴黎 | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |

## 运行

启动一个单机节点：

```
docker run -d iostio/iost-node:2.1.0
```

通常，iServer 需要持久化存储并且向外界暴露端口：

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node:2.1.0
```

如果使用 docker-compose: 

```
# docker-compose.yml

version: "2"

services:
  iserver:
    image: iostio/iost-node:2.1.0
    restart: always
    ports:
      - "30000-30003:30000-30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

创建节点: `docker-compose up -d`

*开始/停止/重启/删除*节点: `docker-compose (start|stop|restart|down)`

## 检查节点

日志文件位于 `/data/iserver/logs/iost.log`.
其中 `confirmed` 值持续快速增长说明节点正在同步。

也可以使用钱包工具(`iwallet`)查看**本地**节点信息：
`docker-compose exec iserver ./iwallet state`

使用 `-s` 参数查看全网信息：
`docker-compose exec iserver ./iwallet -s 35.176.129.71:30002 state`
