---
id: Deployment
title: IOSTテストネットへの参加
sidebar_label: IOSTテストネットへの参加
---

このドキュメントで、IOSTテストネットへ接続するサーバーをセットアップする方法を紹介します。デバッグやテストのためにローカルシングルサーバブロックチェーンネットをセットアップしたいだけなら、[ローカルサーバーの起動](LocalServer.md)を参照してください。

IOSTノードをデプロイするために、ここではDockerを使用しています。

# マシン要件
IOSTネットワークにフルノードで接続する場合は、物理的に次の要件を満たす必要があります。

CPU：CPUは4コア以上（8コア推奨）
メモリ：メモリは8GB以上（16GB推奨）
ディスク：ディスクには1TB以上（5TB HDD推奨）
ネットワーク：インターネット接続のため、TCPポート30000を開く（RPC接続が必要なら30001と30002も開く）


# 前提条件

- [Docker 1.13/Docker CE 18.06以上](https://docs.docker.com/install)
- (オプション) [Docker Compose](https://docs.docker.com/compose/install)

# ノードの開始

デフォルトでは、`/data/iserver`はdataボリュームにマウントされます。これは変更しても構いません。ここでは`$PREFIX`を参照します。

## *boot*スクリプトの使用

```
curl https://developers.iost.io/docs/assets/boot.sh | bash
```

環境変数を使って、Pythonの実行ファイルを設定できます。
例えば、PythonがインストールされていないUbuntuのために、`curl ... | PYTHON=python3 bash` が使えます。

Dockerをインストールしていないなら、スクリプトは自動的にDockerをインストールします。
Dockerグループ内にいることを確認して、ブートスクリプトを再起動する必要があります。

このスクリプトは $PREFIX ディレクトリを破棄して、IOSTテストネットワークに接続する新しいフルノードを起動します。ブロックを生成する準備として、*フルノード*のためのキーペアを生成します。
**Serviノード**になりたい場合は、[ここ](4-running-iost-node/Become-Servi-Node.md)に従ってください。

ノードを起動、停止、または再起動するには、次のコマンドを使ってください。

```
# start
docker start iserver
# stop
docker stop iserver
# restart
docker restart iserver
```

## マニュアルでの操作
### データ

もし前のバージョンのiServerを実行しているなら、古いデータを確実に消してください

```
rm -rf $PREFIX/storage
```
### 設定

最新の設定を取得してください。

```
# get genesis
curl -fsSL "https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz" | tar zxC $PREFIX/
# get iserver config
curl -fsSL "https://developers.iost.io/docs/assets/testnet/latest/iserver.yml" -o $PREFIX/iserver.yml
```

### 実行

次のコマンドでノードを開始します。
```
docker pull iostio/iost-node
docker run -d \
    --name iserver \
    -v /data/iserver:/var/lib/iserver \
    -p 30000-30003:30000-30003 \
    --restart unless-stopped \
    iostio/iost-node
```

# ノードの確認

ログファイルは、`$PREFIX/logs/iost.log`にありますが、デフォルトでは無効になっています。古いログを消してから有効にしてください。

ログは、`(docker|docker-compose) logs iserver`で、取得することができます。

次のような増加する`confirmed`は、ブロックデータの同期が進んでいっていることを示しています。

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
`iwallet`ツールを使って、ノードの状態を確認することもできます。[iWallet](4-running-iost-node/iWallet.md)もご覧ください。

```
docker exec -it iserver iwallet state
```

最新のブロックチェーン情報は、[ブロックチェーンエクスプローラ](https://explorer.iost.io)にも表示されます。

# シードノードリスト

テストネットのシードノード情報は次のとおりです。

| ロケーション | GRPC-URL | HTTP-URL | P2P-URL |
| :------: | :------: | :------: | :-----: |
| United States | 13.52.105.102:30002 | http://13.52.105.102:30001 | /ip4/13.52.105.102/tcp/30000/ipfs/12D3KooWQwH8BTC4QMpTxm7u4Bj38ZdaCLSA1uJ4io3o1j8FCqYE |
| 日本 | 13.115.202.226:30002| http://13.115.202.226:30001 | /ip4/13.115.202.226/tcp/30000/ipfs/12D3KooWHRi93eskqrYzxfToHccmgd4Ng7u2QH1e7Cz3X2M6dHVR |
| 日本 | 54.199.158.64:30002 | http://54.199.158.64:30001 | /ip4/54.199.158.64/tcp/30000/ipfs/12D3KooWKyh6BH5i66g4bBFgbJoNF97jvB1soXSg17zw8Hj1Mq5j |

## GRPC
テストネットのGRPC APIを使いたい場合は、例えば次のようにします。

```
# Get the node information
iwallet -s 13.52.105.102:30002 state
iwallet -s ${GRPC-URL} state
```

## HTTP
テストネットのHTTP APIを使いたい場合は、例えば次のようにします。

```
# Get the block information by block height
curl http://13.52.105.102:30001/getBlockByNumber/3/true
curl ${HTTP-URL}/getBlockByNumber/3/true
```

## P2P
iserverのシードノードを変更したいなら、`/data/iserver/iserver.yml`ファイルを編集してください。例えば次のようにします。

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/13.52.105.102/tcp/30000/ipfs/12D3KooWQwH8BTC4QMpTxm7u4Bj38ZdaCLSA1uJ4io3o1j8FCqYE
    - ${P2P-URL}
    - ...
```
