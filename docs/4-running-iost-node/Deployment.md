---
id: Deployment
title: Deployment
sidebar_label: Deployment
---

## Get Repository

Run the command to get the code repository:

```
git clone git@github.com:iost-official/go-iost.git
```

## Build

Run the command to compile and generate file in the `target` directory:

```
make build
```

## Run

Run the command to run a local node. Check iServer setup here: [iServer](iServer).

```
./target/iserver -f config/iserver.yml
```

## Docker

### Run

Run the command to run a local node with the docker:

```
docker run -it --rm iostio/iost-node:1.0.0
```

### Mount volume

Use the `-v` flag to mount a volume:

```
mkdir -p /data/iserver
cp config/iserver.docker.yml /data/iserver
docker run -it --rm -v /data/iserver:/var/lib/iserver iostio/iost-node:1.0.0
```

### Bind port

Use `-p` flag to map the ports:

```
docker run -it --rm -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:1.0.0
```


## Access the Testnet

### Update config

Change genesis settings as below:

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOST2g5LzaXkjAwpxCnCm29HK69wdbyRKbfG4BQQT7Yuqk57bgTFkY
  - "100000000000000000"
  - IOST22TgXbjvgrDd3DuMkVufcWbYDMy7vpmQoCgZXmgi8eqM7doxWD
  - "100000000000000000"
  - IOSTAXksR6rKvmkjJyzhJJkDsG3yip47BJJWmbSTYqwqoNErBoN2k
  - "100000000000000000"
  - IOSTFPe9aXhZMmyvy6BsmgeucKEgzXy3zHMhsBFFeqNtKsqy98sbX
  - "100000000000000000"
  - IOST23xQCcviwn7AGxDnJbkL2Sjh8ijsKL6sPJWAkVEP8jACHLGknX
  - "100000000000000000"
  - IOST2CxDxZJwo2Useu2kMvZRTmMpHiwrK4UzQRLEQccLTfAmY9Z4Up
  - "100000000000000000"
  - IOSTKbYwTYpGZUTQqnmnbQAeJKhCBAMfW3pNvtJn6nEtVj6aozGMQ
  - "100000000000000000"
  - IOSTxUBnFHNBb22TSU8ruiEPfVUx6utxxbUcat3ZaDmtZea4roPES
  - "100000000000000000"
  - IOSTpWBkze9vPL3rxmnobgVN6s6WwHUFJGMo7wFcAHwkbhij3eDZY
  - "100000000000000000"
  - IOST27LJHEEBZ8oNqQR9EhutmybLuNdeitNfWdkoFk8MwQ2pSbifig
  - "100000000000000000"
  - IOST2AcBEJawoVzg4MW6UcvQsP6p6mSwACF7bbroNU2jBtE3MDSt6G
  - "100000000000000000"
  votecontractpath: config/
```

Change the settings of `p2p.seednodes` as below:

```
p2p:
  seednodes:
  - /ip4/18.218.255.180/tcp/30000/ipfs/12D3KooWLwNFzkAf3fRmjVRc9MGcn89J8HpityXbtLtdCtPSHDg1
```

Among the settings, the network IDs of seed nodes can be changed. Seed nodes of the testnet is shown below:

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node16 | US East | /ip4/18.218.255.180/tcp/30000/ipfs/12D3KooWLwNFzkAf3fRmjVRc9MGcn89J8HpityXbtLtdCtPSHDg1 |
| node17 | US West | /ip4/52.9.253.198/tcp/30000/ipfs/12D3KooWABS9bLYUnvmLYeuZvkgL2WY3TLHJDbmG2tUWB4GfJJiq   |
| node19 | Mumbai   | /ip4/13.127.153.57/tcp/30000/ipfs/12D3KooWAx1pZHvUq73UGMSXqjUBsKBKgXFoFBoXZZAhfvM9HnVr  |
| node20 | Seoul   | /ip4/52.79.231.23/tcp/30000/ipfs/12D3KooWCsq3Lfxe8E17anTred2o7X4cSZ77faai8hkHH611RjMp   |
| node21 | Singapore | /ip4/13.229.176.106/tcp/30000/ipfs/12D3KooWKGK1ah5JgMEic2dH8oYE3LMEZLBJUzCNP165tPaQnaW9 |
| node22 | Sydney   | /ip4/13.238.140.219/tcp/30000/ipfs/12D3KooWGHmaxL8LmRpvXoFPNYj3FavYgqqEBks4YPVUL6KRcQFs |
| node23 | Canada | /ip4/52.60.78.2/tcp/30000/ipfs/12D3KooWAivafPT52QEf2eStdXS4DjiRyLCGhLanvVgJ7hhbqans     |
| node24 | Germany   | /ip4/52.58.16.220/tcp/30000/ipfs/12D3KooWPKjYYL4tvbUQF2VzA1mg6XsByA8GVN4anDfrRxp9qdxm   |
| node25 | Ireland | /ip4/18.202.100.127/tcp/30000/ipfs/12D3KooWDL2BdvSR65kS2z8LX8142ksX35mNFWhtVpK6a24WXBoV |
| node26 | UK   | /ip4/35.176.96.113/tcp/30000/ipfs/12D3KooWHfCWdXnKkTqFYNh8AhrjJ21v7RrTTuwSBLztHgGLWYyX  |
| node27 | France   | /ip4/52.47.133.32/tcp/30000/ipfs/12D3KooWScNNuMLh1AEnWoNppXKY6qwVVGrvzYF4dKQxBMmnwW3b   |
| node28 | Brazil   | /ip4/52.67.231.15/tcp/30000/ipfs/12D3KooWRJxjPsVxRR7spvfRPRWzvGKZrWggRj5kEiqyS4tzPq78   |
| node40 | Tokyo   | /ip4/52.192.86.141/tcp/30000/ipfs/12D3KooWS4kyTpyjEA8ixqFGT7uLd4mAh4fYbYNYhaPYNEWE69BA  |

### Run iServer

Connect to Testnet by runing iServer with updated config:

```
./target/iserver -f config/iserver.yml
```
