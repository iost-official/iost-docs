---
id: iServer
title: iServer
sidebar_label: iServer
---

## Launching iServer

IOST node service iServer includes consensus, synchronization, transaction pool and network modules. Launch iServer service to deploy IOST nodes.

* To compile the project in the root directory, run the following command and the executables will be saved the `target` directory in the root folder.

```
make build
```

* Use the below command to run the IOST node

```
./target/iserver -f ./config/iserver.yml
```

* Change ./config/iserver.yml configuration file

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

* Set node account information

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

* Set up genesis block information and witness the block and amount.


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```


```
db:
  ldbpath: storage/
```

Set up database location.


```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

Set up network information. This requires setting up seed nodes to access the network.

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

Set up RPC ports.


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

Set up logging services.


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
