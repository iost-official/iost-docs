---
id: iServer
title: iServer
sidebar_label: iServer
---

### 启动 iServer


在项目根目录编译项目，运行 make build 

```
./target/iserver -f ./config/iserver.yaml
```


```
acc:
  id: YOUR_ID 
  seckey: YOUR_SECERT_KEY 
  algorithm: ed25519

genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
  
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

db:
  ldbpath: storage/

p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/

rpc:
  jsonport: 30001
  grpcport: 30002

log:
  filelog:
    path: logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true

metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00

debug:
```
