---
id: Configuration
title: Configuration
sidebar_label: Configuration
---

本页展现配置文件细节。
获取最新配置文件：

- 主网:
    - [genesis.tgz](https://developers.iost.io/docs/assets/mainnet/latest/genesis.tgz)
    - [iserver.yml](https://developers.iost.io/docs/assets/mainnet/latest/iserver.yml)
- 测试网:
    - [genesis.tgz](https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz)
    - [iserver.yml](https://developers.iost.io/docs/assets/testnet/latest/iserver.yml)

以下以[默认配置](https://github.com/iost-official/go-iost/tree/master/config)为例。

## iServer 配置

- acc

```
acc:
  id: producer000
  seckey: 1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB
  algorithm: ed25519
```

当 iServer 作为生产者造块时，用 `acc.seckey` 对块进行签名。   
`acc.id` 是这个生产者绑定的 IOST 账户.
ID 在造块过程中没有实际作用。

- genesis

```
genesis: config/genesis
```

从 [Everest v2.3.0](https://github.com/iost-official/go-iost/releases/tag/everest-v2.2.0) 起 iServer 从 genesis 目录读取创世信息。   
这个目录包含创世阶段必要的系统合约和一个创世块配置文件。   
详见[创世配置](#config-genesis)

- vm & db

```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""
db:
  ldbpath: storage/
```

v8vm 和数据库配置。

- snapshot

```
snapshot:
  enable: false
  filepath: storage/snapshot.tar.gz
```

如果开启，iServer 从*快照*启动，而不是从创世块。   
这样可以加速节点同步。

- p2p

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
  inboundConn: 18
  outboundConn: 12
  blackPID:
  blackIP:
  adminPort: 30005
```

listenaddr 为 p2p 网络监听的地址，如果节点部署在云服务上，请务必在安全组中打开该端口。  
seednodes 为 p2p 网络发现的种子节点，可以填任意已知的节点列表。  
chainid 用于隔离不同的网络。  
version 为网络协议版本号。  
datapath 为 p2p 路由表，节点私钥等数据的存储目录。  
inboundConn 为最大连入的连接数。  
outboundConn 为最大连出的连接时。  
blackPID, blackIP 分别为网络黑名单的节点 ID 和节点 IP，配置后，节点会拒绝黑名单节点的 p2p 网络连接。  
adminPort 为网络管理端口，只能通过 localhost 访问。

- rpc

```
rpc:
  enable: true
  gatewayaddr: 0.0.0.0:30001
  grpcaddr: 0.0.0.0:30002
  trytx: true
  allowOrigins:
    - "*"
```

enable 表示是否开启 RPC 服务。  
gatewayaddr 为 JSON RPC 的监听地址。  
grpcaddr 为 GRPC 监听地址。  
trytx 表示是否预执行交易。  
allowOrigins 为跨域设置。

- log

```
log:
  filelog:
    path: logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
  enablecontractlog: true
```

iServer 日志同时拥有标准输出和文件输出。
生产环境推荐使用默认配置。

- metrics

```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```

我们使用 [Prometheus](https://prometheus.io/) 收集数据，准确的说是 [Prometheus Pushgateway](https://github.com/prometheus/pushgateway) 。   
同时支持 [HTTP Basic authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) 。   
配置 Prometheus 服务请看 [这里](4-running-iost-node/Metrics.md) 。

- version

```
version:
  netname: "debugnet"
  protocolversion: "1.0"
```

节点信息的描述。

## 创世配置

更改创世配置可能无法连接 IOST 网络。

- tokeninfo

```
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 90000000000
  iostdecimal: 8
```

`iosttotalsupply` 定义 IOST 上线。
这些 IOST 并不会在创世阶段被创建。

- witnessinfo

```
witnessinfo:
  - id: producer000
    owner: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    active: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    signatureblock: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    balance: 0
```

创世阶段生产者(造块节点)列表。   
随着投票进行，生产者进行更迭。

- admininfo & foundationinfo

```
admininfo:
  id: admin
  owner: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto 
  active: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  balance: 21000000000
foundationinfo:
  id: foundation
  owner: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  active: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  balance: 0
```

定义 *admin* 和 *foundation* 账户。
创始阶段会有 210 亿 IOST 被创建，全部归 admin 所有。

### initialtimestamp

```
nitialtimestamp: "2018-11-10T11:04:05Z"
```

网络启动时间。
