---
id: Deployment
title: Join IOST Testnet
sidebar_label: Join IOST Testnet
---

The documentation introduces how to setup a running server connecting to IOST testnet, if you just want to setup a local single-server blockchain net for debugging/testing, you may better refer to [Launch Local Server](LocalServer)   

We are using Docker to deploy an IOST node.

## Prerequisites

- [Docker CE 18.06 or newer](https://docs.docker.com/install/) (older versions are not tested)
- (Optional) [Docker Compose](https://docs.docker.com/compose/install/)

## Prepare Config File

For more details of iServer, see [here](/4-running-iost-node/iServer/).

First get the configuration templates:

```
mkdir -p /data/iserver
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/docker/iserver.yml -o /data/iserver/iserver.yml
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/genesis.yml -o /data/iserver/genesis.yml
```

`/data/iserver` is going to mount as the data volume, you might change the path to suit your needs.

*If you have already run previous version of iServer, make sure the old data has been purged:*

```
rm -rf /data/iserver/storage
```

In order to access Everest v2.1.0 the testnet, the genesis
file `/data/iserver/genesis.yml` should be modified as below:

```
creategenesis: true
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 21000000000
  iostdecimal: 8
  ramtotalsupply: 9000000000000000000
  ramgenesisamount: 137438953472
witnessinfo:
  - id: producer00000
    owner: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    active: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    balance: 1000000000
  - id: producer00001
    owner: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    active: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    balance: 1000000000
  - id: producer00002
    owner: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    active: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    balance: 1000000000
  - id: producer00003
    owner: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    active: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    balance: 1000000000
  - id: producer00004
    owner: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    active: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    balance: 1000000000
  - id: producer00005
    owner: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    active: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    balance: 1000000000
  - id: producer00006
    owner: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    active: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    balance: 1000000000
contractpath: contract/
admininfo:
  id: admin
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 14000000000
foundationinfo:
  id: foundation
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 0
initialtimestamp: "2006-01-02T15:04:05Z"
```

Besides, section `p2p.seednodes` in `/data/iserver/iserver.yml` must also be changed:

```
...
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a
  chainid: 1024
  version: 1
...
```

Among the settings, the network IDs of seed nodes can be replaced, which is shown as below:

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |

## Starting the node

Run the command to start a node
```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node:2.1.0
```

Or using docker-compose:

```
# docker-compose.yml

version: "2"

services:
  iserver:
    image: iostio/iost-node:2.1.0
    restart: always
    ports:
      - "30000-30003:30000-30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

To start the node: `docker-compose up -d`

To start, stop, restart or remove: `docker-compose (start|stop|restart|down)`

## Checking the node

The log file is located at `/data/iserver/logs/iost.log`.
An increasing value of `confirmed` means it is syncing the block data.

You may also check the state of the node using `iwallet` tool inside the docker
```
docker-compose exec iserver ./iwallet state
```

Use `-s` together with seednode's IP to get latest blockchain info from that node
```
docker-compose exec iserver ./iwallet -s 35.176.129.71:30002 state
```
