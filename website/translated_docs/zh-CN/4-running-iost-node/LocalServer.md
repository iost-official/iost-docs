---
id: iServer
title: iServer
sidebar_label: iServer
---

## Docker启动
安装好[Docker](https://docs.docker.com/install)之后，如下命令启动一个单节点测试网。

```
docker run --rm -p 30000-30003:30000-30003 iostio/iost-node
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

## Host启动


[编译](4-running-iost-node/Building-IOST.md)完成后, 如下命令启动
```
iserver -f ./config/iserver.yml
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

