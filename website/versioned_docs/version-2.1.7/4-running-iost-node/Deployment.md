---
id: version-2.1.7-Deployment
title: Join IOST Testnet
sidebar_label: Join IOST Testnet
original_id: Deployment
---

The documentation introduces how to setup a running server connecting to IOST testnet, if you just want to setup a local single-server blockchain net for debugging/testing, you may better refer to [Launch Local Server](4-running-iost-node/LocalServer.md)   

We are using Docker to deploy an IOST node.

## Prerequisites

- [Docker 1.13/Docker CE 18.06 or newer](https://docs.docker.com/install) (older versions are not tested)
- (Optional) [Docker Compose](https://docs.docker.com/compose/install)

## Prepare Config File

For more details of iServer, see [here](4-running-iost-node/LocalServer.md).

First get the configuration templates:

```
mkdir -p /data/iserver
curl https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz | tar zxC /data/iserver
curl https://developers.iost.io/docs/assets/testnet/latest/iserver.yml -o /data/iserver/iserver.yml
```

`/data/iserver` is going to mount as the data volume, you might change the path to suit your needs.

*If you have already run previous version of iServer, make sure the old data has been purged:*

```
rm -rf /data/iserver/storage
```

## Starting the node

Run the command to start a node

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

Or using docker-compose:

```
# docker-compose.yml

version: "2"

services:
  iserver:
    image: iostio/iost-node
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
An increasing value of `confirmed` means that it is syncing the block data.

You may also check the state of the node using `iwallet` tool inside the docker.
See also [iWallet](4-running-iost-node/iWallet.md).

```
docker-compose exec iserver ./iwallet state
```

The latest blockchain info is also shown at [blockchain explorer](https://explorer.iost.io).
