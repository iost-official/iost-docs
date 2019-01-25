---
id: Deployment
title: IOSTテストネットへの参加
sidebar_label: IOSTテストネットへの参加
---

このドキュメントで、IOSTテストネットへ接続するサーバーをセットアップする方法を紹介します。デバッグやテストのためにローカルシングルサーバブロックチェーンネットをセットアップしたいだけなら、[ローカルサーバーの起動](LocalServer.md)を参照してください。

IOSTノードをデプロイするために、ここではDockerを使用しています。

## 前提条件

- [Docker CE 18.06以上](https://docs.docker.com/install) (旧バージョンはテストしていません)
- (オプション) [Docker Compose](https://docs.docker.com/compose/install)

## 設定ファイルの準備

iServerについては、[こちら](/4-running-iost-node/iServer.md)を参照してください。

最初に設定テンプレートを取得します。

```
mkdir -p /data/iserver
t/v2.1.0/config/genesis.yml -o /data/iserver/genesis.yml
curl https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz | tar zxC /data/iserver
curl
curl https://developers.iost.io/docs/assets/testnet/latest/iserver.yml -o /data/iserver/iserver.yml
```

`/data/iserver`をデータボリュームとしてマウントしています。これは変更しても構いません。 

*もし前のバージョンのiServerを実行しているなら、古いデータを確実に消してください*

```
rm -rf /data/iserver/storage
```

### ノードの開始

次のコマンドでノードを開始します。
```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

または、Docker-Composeを使ってください。

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

次のようにノーを起動してください。

`docker-compose up -d`

起動、停止、再起動、削除するには、次のようにしてください。

`docker-compose (start|stop|restart|down)`

## ノードのチェック

ログファイルは、`/data/iserver/logs/iost.log`にあります。増加する`confirmed`は、ブロックデータの同期が進んでいっていることを示しています。

Docker内の`iwallet`を使って、次のように状態をチェックすることもできます。[iWallet](4-running-iost-node/iWallet.md)を参照してください。

```
docker-compose exec iserver ./iwallet state
```

最新のブロックチェーン情報は、[ブロックチェーンエクスプローラ](https://explorer.iost.io)にも表示されます。