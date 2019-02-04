---
id: Deployment
title: Join IOST Testnet
sidebar_label: Join IOST Testnet
---

The documentation introduces how to setup a running server connecting to IOST testnet, if you just want to setup a local single-server blockchain net for debugging/testing, you may better refer to [Launch Local Server](4-running-iost-node/LocalServer.md)   

We are using Docker to deploy an IOST node.

# Machine requirements

If you want to run a full node connected to IOST network, your machine must meet the following requirements:

- CPU: 4 cores or more (8 cores recommended)
- Memory: 8GB or more (16GB recommended)
- Disk: 1TB or more (5TB HDD recommended)
- Network: access to Internet with port tcp: 30000 opened (If you want to enable rpc for node, please open port 30001, 30002)

# Prerequisites

- Curl (any version you like)
- Python (any version you like)
- [Docker 1.13/Docker CE 17.03 or newer](https://docs.docker.com/install)
- (Optional) [Docker Compose](https://docs.docker.com/compose/install)

# Start the node

By default, `/data/iserver` is going to mount as the data volume, you might change the path to suit your needs.
We refer to `$PREFIX` hereafter.

## Using *boot* script:

You can automatically deploy a full node with the following command:

```
curl https://raw.githubusercontent.com/iost-official/go-iost/master/script/boot.sh | bash
```

You might set python executable using environment variable.
E.g. `curl ... | PYTHON=python3 bash` for Ubuntu without python installed.

If you don't install docker, the script will automatically install docker.  
You need to make sure you are in the docker group, then re-run the boot script.

This script purges directory `$PREFIX` and starts a fresh new full node connected to IOST testnet network.  
It also generates a keypair for *full node* in order to prepare for generating blocks.  
If you want to be a **Servi Node**, follow next steps [here](4-running-iost-node/Become-Servi-Node.md).

To start, stop or restart the node, you could execute follow command:

```
# start
docker start iserver
# stop
docker stop iserver
# restart
docker restart iserver
```

## Manually

### Data

If you have already run previous version of iServer, make sure the old data has been purged:

```
rm -rf $PREFIX/storage
```

### Config

Fetch latest config:

```
# get genesis
curl -fsSL "https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz" | tar zxC $PREFIX/

# get iserver config
curl -fsSL "https://developers.iost.io/docs/assets/testnet/latest/iserver.yml" -o $PREFIX/iserver.yml
```

### Run

Run the command to start a node:

```
docker pull iostio/iost-node
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

# Checking the node

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

# Seed Node List

The seed node information of the testnet is as follows:

| Location | GRPC-URL | HTTP-URL | P2P-URL |
| :------: | :------: | :------: | :-----: |
| United States | 13.52.105.102:30002 | http://13.52.105.102:30001 | /ip4/13.52.105.102/tcp/30000/ipfs/12D3KooWQwH8BTC4QMpTxm7u4Bj38ZdaCLSA1uJ4io3o1j8FCqYE |
| Japan | 13.115.202.226:30002| http://13.115.202.226:30001 | /ip4/13.115.202.226/tcp/30000/ipfs/12D3KooWHRi93eskqrYzxfToHccmgd4Ng7u2QH1e7Cz3X2M6dHVR |
| Japan | 54.199.158.64:30002 | http://54.199.158.64:30001 | /ip4/54.199.158.64/tcp/30000/ipfs/12D3KooWKyh6BH5i66g4bBFgbJoNF97jvB1soXSg17zw8Hj1Mq5j |

## GRPC
If you want to use the GRPC API of testnet, for example:

```
# Get the node information
iwallet -s 13.52.105.102:30002 state
iwallet -s ${GRPC-URL} state
```

## HTTP
If you want to use the HTTP API of testnet, for example:

```
# Get the block information by block height
curl http://13.52.105.102:30001/getBlockByNumber/3/true
curl ${HTTP-URL}/getBlockByNumber/3/true
```

## P2P
If you want to modify the seed node of the iserver, you could edit the file `/data/iserver/iserver.yml`, for example:

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/13.52.105.102/tcp/30000/ipfs/12D3KooWQwH8BTC4QMpTxm7u4Bj38ZdaCLSA1uJ4io3o1j8FCqYE
    - ${P2P-URL}
    - ...
```
