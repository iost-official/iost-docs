---
id: iServer
title: iServer
sidebar_label: iServer
---

### 启动 iServer
iServer 是IOST节点的服务，其中包含共识、同步、交易池和网络等模块。启动iServer即可部署一个IOST的节点。

* 在项目根目录编译项目，运行命令

```
make build
```
iServer的可执行文件会保存在项目根目录下的target文件夹下。

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

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

```

vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```

```
db:
  ldbpath: storage/
```

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

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

```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
