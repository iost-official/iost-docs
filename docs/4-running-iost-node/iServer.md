---
id: iServer
title: iServer
sidebar_label: iServer
---

### 启动 iServer
IOST节点服务iServer，包含共识、同步、交易池和网络等模块。启动iServer服务即可部署IOST的节点。

* 在项目根目录编译项目，运行以下命令，iServer的可执行文件会保存在项目根目录下的target文件夹下。

```
make build
```

* 运行以下命令启动IOST节点。

```
./target/iserver -f ./config/iserver.yaml
```

* 修改./config/iserver.yaml 配置文件。

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```
account设置节点账户信息。


```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```
genesis设置创世块信息，witnessinfo设置创世块的账号和数额。


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```


```
db:
  ldbpath: storage/
```
db配置数据库存储位置。


```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```
p2p配置网络信息，需设置seednodes来连入网络。


```
rpc:
  jsonport: 30001
  grpcport: 30002
```
rpc配置RPC服务的端口。


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
```
log配置日志服务。


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
