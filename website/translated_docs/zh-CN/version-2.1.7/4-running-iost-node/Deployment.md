---
id: Deployment
title: 部署
sidebar_label: 部署
---
本文介绍如何加入IOST官方网。如果只是测试调试，建议部署[本地单节点网络](4-running-iost-node/LocalServer.md)

## 依赖

- Curl (版本任意)
- Python (版本任意)
- [Docker 1.13/Docker CE 17.03 以上](https://docs.docker.com/install)
- (推荐) [Docker Compose](https://docs.docker.com/compose/install)

## 启动之前

默认情况下 `/data/iserver` 是数据目录，可以根据实际情况自行修改。
下文用 `PREFIX` 指代数据目录。


*如果运行过以前版本的测试网，请清空数据:*

```
rm -rf $PREFIX/storage
```

## 启动节点

启动一个单机节点：

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

或者使用*启动*脚本：
如果使用 docker-compose:

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

启动脚本会清除 `$PREFIX`，然后启动一个全新的全节点，并加入 IOST 网络。
同时会给*造快者*生成一对公私钥。

*开始/停止/重启*节点，进入 `$PREFIX`: `docker-compose (start|stop|restart)`

## 检查节点

日志文件位于 `$PREFIX/logs/iost.log`,
其中 `confirmed` 值持续快速增长说明节点正在同步：

```
...
Info 2019-01-19 08:36:34.249 pob.go:456 Rec block - @4 id:Dy3X54QSkZ..., num:1130, t:1547886994201273330, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:34.550 pob.go:456 Rec block - @5 id:Dy3X54QSkZ..., num:1131, t:1547886994501284335, txs:1, confirmed:1095, et:49ms
Info 2019-01-19 08:36:34.850 pob.go:456 Rec block - @6 id:Dy3X54QSkZ..., num:1132, t:1547886994801292955, txs:1, confirmed:1095, et:49ms
Info 2019-01-19 08:36:35.150 pob.go:456 Rec block - @7 id:Dy3X54QSkZ..., num:1133, t:1547886995101291970, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:35.450 pob.go:456 Rec block - @8 id:Dy3X54QSkZ..., num:1134, t:1547886995401281644, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:35.750 pob.go:456 Rec block - @9 id:Dy3X54QSkZ..., num:1135, t:1547886995701294638, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:36.022 pob.go:456 Rec block - @0 id:EkRgHNoeeP..., num:1136, t:1547886996001223210, txs:1, confirmed:1105, et:21ms
Info 2019-01-19 08:36:36.324 pob.go:456 Rec block - @1 id:EkRgHNoeeP..., num:1137, t:1547886996301308669, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:36.624 pob.go:456 Rec block - @2 id:EkRgHNoeeP..., num:1138, t:1547886996601304333, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:36.921 pob.go:456 Rec block - @3 id:EkRgHNoeeP..., num:1139, t:1547886996901318752, txs:1, confirmed:1105, et:20ms
Info 2019-01-19 08:36:37.224 pob.go:456 Rec block - @4 id:EkRgHNoeeP..., num:1140, t:1547886997201327191, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:37.521 pob.go:456 Rec block - @5 id:EkRgHNoeeP..., num:1141, t:1547886997501297659, txs:1, confirmed:1105, et:20ms
...
```

也可以使用钱包工具 `iwallet` 查看**本地**节点信息。

```
docker-compose exec iserver ./iwallet state
```

访问[区块链浏览器](https://explorer.iost.io)获取当前区块高度。

## 超级节点

运行超级节点需要一个IOST账户(用来接收分红)和一个*生产者*节点(用来造块)。   
**生产者造块推荐使用不同于账户的公私钥对。**

### 创建IOST账户

如果还没有账户，你需要：

- 用 iWallet 生成*公私钥对*
- 用生成的*公私钥对*在[区块链浏览器](https://explorer.iost.io)上注册账户

最后用 iWallet 导入账户。

### 启动节点

请参考[启动节点](#start-the-node)执行以下命令:

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

生产者*公私钥对*在 `$PREFIX/keypair`.
访问 `http://localhost:30001/getNodeInfo` 的 `.network.id` 字段获取网络 ID.

### 注册申请

用 iWallet 发起一个交易：

```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",true]' --amount_limit '*:unlimited'
```

完整 API 文档请参阅 [`vote_producer.iost`](6-reference/SystemContract.html#vote-produceriost).

## 操作超级节点

当 **admin** 批准超级节点注册申请，且节点准备好造块后，发起一个“上线”请求让节点上线：

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]' --amount_limit '*:unlimited'
```

下线节点：

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]' --amount_limit '*:unlimited'
```
