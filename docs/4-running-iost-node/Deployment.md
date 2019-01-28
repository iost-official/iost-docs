---
id: Deployment
title: Join IOST Testnet
sidebar_label: Join IOST Testnet
---

The documentation introduces how to setup a running server connecting to IOST testnet, if you just want to setup a local single-server blockchain net for debugging/testing, you may better refer to [Launch Local Server](4-running-iost-node/LocalServer.md)   

We are using Docker to deploy an IOST node.

## Machine requirements

If you want to run a full-node connection test network, your physical machine needs to meet the following requirements:

- CPU: CPU requires 8 cores and above (Recommend 8 cores)
- Memory: Memory requires 8GB and above (Recommend 16GB)
- Disk: Disk requires 5TB and above (Recommend 5TB HDD)
- Network: Need to be able to connect to the Internet and open port 30000 (Recommend open port 30000,30001,30002)

## Prerequisites

- Curl (any version you like)
- Python (any version you like)
- [Docker 1.13/Docker CE 17.03 or newer](https://docs.docker.com/install) (older versions are not tested)
- (Optional) [Docker Compose](https://docs.docker.com/compose/install)

## Start the node

### Using *boot* script:

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

This script purges `$PREFIX` and starts a fresh new full node connecting to IOST testnet network.
It also generates a keypair for *producer* in order to prepare for generating blocks.

To start, stop or restart the node, change directory to `$PREFIX` and execute: `docker-compose (start|stop|restart|down)`

### Manual:
#### Before start

By default, `/data/iserver` is going to mount as the data volume, you might change the path to suit your needs.
We refer to `PREFIX` hereafter.

*If you have already run previous version of iServer, make sure the old data has been purged:*

```
rm -rf $PREFIX/storage
```

#### Start
Run the command to start a node:

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

## Checking the node

The log file is located at `$PREFIX/logs/iost.log`. However, it is disabled by default.
You can enable it, as long as you remember to delete old log files.

You are able to get logs using `(docker|docker-compose) logs iserver`.
An increasing value of `confirmed` like below means that it is syncing the block data:

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

You may also check the state of the node using `iwallet` tool.
See also [iWallet](4-running-iost-node/iWallet.md).

```
docker exec -it iserver iwallet state
```

The latest blockchain info is also shown at [blockchain explorer](https://explorer.iost.io).

