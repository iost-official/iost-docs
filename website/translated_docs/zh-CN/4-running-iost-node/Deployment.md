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

更多信息请看[iServer](4-running-iost-node/LocalServer.md).

获取配置：

```
mkdir -p /data/iserver
curl https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz | tar zxC /data/iserver
curl https://developers.iost.io/docs/assets/testnet/latest/iserver.yml -o /data/iserver/iserver.yml
```

这里 `/data/iserver` 是数据目录，可以根据实际情况自行修改。

*如果运行过以前版本的测试网，请清空数据:*

```
rm -rf /data/iserver/storage
```

## 运行

启动一个单机节点：

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

如果使用 docker-compose:

```
# docker-compose.yml

version: "2"

services:
  iserver:
    image: iostio/iost-node
    restart: always
    ports:
      - "30000-30003:30000-30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

创建节点: `docker-compose up -d`

*开始/停止/重启/删除*节点: `docker-compose (start|stop|restart|down)`

## 检查节点

日志文件位于 `/data/iserver/logs/iost.log`,
其中 `confirmed` 值持续快速增长说明节点正在同步。

也可以使用钱包工具(`iwallet`)查看**本地**节点信息。

```
docker-compose exec iserver ./iwallet state
```

访问[区块链浏览器](https://explorer.iost.io)获取当前区块高度。
