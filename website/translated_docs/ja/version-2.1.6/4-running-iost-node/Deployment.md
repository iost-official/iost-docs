---
id: version-2.1.6-Deployment
title: IOSTテストネットへの参加
sidebar_label: IOSTテストネットへの参加
original_id: Deployment
---

このドキュメントで、IOSTテストネットへ接続するサーバーをセットアップする方法を紹介します。デバッグやテストのためにローカルシングルサーバブロックチェーンネットをセットアップしたいだけなら、[ローカルサーバーの起動](LocalServer)を参照してください。

IOSTノードをデプロイするために、ここではDockerを使用しています。

## 前提条件

- [Docker CE 18.06以上](https://docs.docker.com/install/) (旧バージョンはテストしていません)
- (オプション) [Docker Compose](https://docs.docker.com/compose/install/)

## 設定ファイルの準備

iServerについては、[こちら](/4-running-iost-node/iServer/)を参照してください。

最初に設定テンプレートを取得します。

```
mkdir -p /data/iserver
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/docker/iserver.yml -o /data/iserver/iserver.yml
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/genesis.yml -o /data/iserver/genesis.yml
```

`/data/iserver`をデータボリュームとしてマウントしています。これは変更しても構いません。 

*もし前のバージョンのiServerを実行しているなら、古いデータを確実に消してください*

```
rm -rf /data/iserver/storage
```

Everest v2.1.0テストネットにアクセスするためには、ジェネシスファイル`/data/iserver/genesis.yml`を次のように変更する必要があります。

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
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node:2.1.0
```

または、Docker-Composeを使ってください。

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

次のようにノーを起動してください。

`docker-compose up -d`

起動、停止、再起動、削除するには、次のようにしてください。

`docker-compose (start|stop|restart|down)`

## ノードのチェック

ログファイルは、`/data/iserver/logs/iost.log`にあります。増加する`confirmed`は、ブロックデータの同期が進んでいっていることを示しています。

`iwallet`を使って、次のように状態をチェックすることもできます。
```
docker-compose exec iserver ./iwallet state
```

`-s`とシードノードのIPで、最新のブロックチェーン情報を取得できます。
```
docker-compose exec iserver ./iwallet -s 35.176.129.71:30002 state
```
