---
id: Configuration
title: Configuration
sidebar_label: Configuration
---

This page shows detailed information of configuration.
You can get the latest config as below:

- genesis.tgz: https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz
- iserver.yml: https://developers.iost.io/docs/assets/testnet/latest/iserver.yml

We are going to step through each section in [default configuration](https://github.com/iost-official/go-iost/tree/master/config).

## Config iServer

- acc

```
acc:
  id: producer000
  seckey: 1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB
  algorithm: ed25519
```

When iServer becomes a producer, it signs the block with the privkey `acc.seckey`.   
`acc.id` is the IOST account bind to that producer.
However this field is not used actually.

- genesis

```
genesis: config/genesis
```

Since [Everest v2.3.0](https://github.com/iost-official/go-iost/releases/tag/everest-v2.2.0), iServer reads genesis info from a directory instead of a single config file.   
Such directory contains essential system contract as well as the genesis config file.   
See also [config genesis](#config-genesis)

- vm & db

```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""
db:
  ldbpath: storage/
```

Settins of v8vm and database.

- snapshot

```
snapshot:
  enable: false
  filepath: storage/snapshot.tar.gz
```

If enabled, iServer will start from a snapshot of the blockchain instead of nothing.   
You can easily catch up the current height using a snapshot.

- p2p

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
  inboundConn: 15
  outboundConn: 15
  blackPID:
  blackIP:
  adminPort: 30005
```

Each iServer has a network ID for the p2p network.
*** To be completed ***

- rpc

```
rpc:
  enable: true
  gatewayaddr: 0.0.0.0:30001
  grpcaddr: 0.0.0.0:30002
  trytx: false
  allowOrigins:
    - "*"
```

*** To be completed ***

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

There are both console and file handlers for logging.
It's recommended to leave this block default.

- metrics

```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```

We are using [Prometheus](https://prometheus.io/) to collect realtime data, or [Prometheus Pushgateway](https://github.com/prometheus/pushgateway) particularly.   
[HTTP Basic authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) is supported.   
Check [this](4-running-iost-node/Metrics.md) to set up your own Prometheus server.

- version

```
version:
  netname: "debugnet"
  protocolversion: "1.0"
```

*** To be completed ***

## Config Genesis

Change of genesis will prevent iServer from connecting to the IOST network.   
Make sure you know what you are doing.

- tokeninfo

```
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 90000000000
  iostdecimal: 8
```

`iosttotalsupply` defines the maximum amount of IOST.
It does not mean those amount of IOST is going to be created at genesis stage.

- witnessinfo

```
witnessinfo:
  - id: producer000
    owner: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    active: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    signatureblock: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    balance: 0
```

Witnesses are the producers on top of the genesis.   
Producer will alternates with new come Servi nodes.

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

This section defines admin and foundation account.

### initialtimestamp

```
nitialtimestamp: "2018-11-10T11:04:05Z"
```

It is the start time of the network.
