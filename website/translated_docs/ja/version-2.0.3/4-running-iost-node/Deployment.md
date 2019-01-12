---
id: version-2.0.3-Deployment
title: デプロイ
sidebar_label: デプロイ
original_id: Deployment
---

## リポジトリの取得

次のコマンドでリポジトリを取得します。

```
git clone https://github.com/iost-official/go-iost.git && cd go-iost
```

## ビルド

次のコマンドでコンパイルして、`target`ディレクトリにファイルを生成します。

```
git checkout v2.0.0
make vmlib
make build
```

# 実行

次のコマンドでローカルノードを起動してください。iServerの設定を[iServer](iServer.md)でチェックします。

```
./target/iserver -f config/iserver.yml
```

## Docker

### 実行

次のコマンドで、Dockerを使ってローカルノードを起動します。

```
docker run -d iostio/iost-node:2.0.0
```

### ボリュームのマウント

`-v`フラグでボリュームをマウントします。

```
mkdir -p /data/iserver
cp config/{docker/iserver.yml,genesis.yml} /data/iserver/
docker run -d -v /data/iserver:/var/lib/iserver iostio/iost-node:2.0.0
```

### ポートのバインド

`-p`フラグで、ポートをバインドします。

```
docker run -d -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:2.0.0
```

### Docker-Composeの利用

Docker-Composeを使ってデプロイすることをお勧めします。

```
# docker-compose.yml

version: "2.2"

services:
  iserver:
    image: iostio/iost-node:2.0.0
    restart: always
    ports:
      - "30000:30000"
      - "30001:30001"
      - "30002:30002"
      - "30003:30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

ノードを起動するには次のようにします。

`docker-compose up -d`

## テストネットへのアクセス

### 設定の変更

ジェネシスブロックの設定を次のように変更してください。

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

`iserver.yml`内の`p2p.seednodes`を次のように変更します。

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

設定中に、次のようにシードノードネットワークIDが変更されます。

| 名前   | リージョン | ネットワークID                                                                          |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |

### iServerの実行

更新した設定でiServerを実行してテストネットへ接続してください。

```
./target/iserver -f config/iserver.yml
```
