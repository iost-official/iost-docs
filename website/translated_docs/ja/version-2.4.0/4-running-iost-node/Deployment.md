---
id: Deployment
title: IOSTテストネットへの参加
sidebar_label: IOSTテストネットへの参加
---

このドキュメントで、IOSTテストネットへ接続するサーバーをセットアップする方法を紹介します。デバッグやテストのためにローカルシングルサーバブロックチェーンネットをセットアップしたいだけなら、[ローカルサーバーの起動](LocalServer.md)を参照してください。

IOSTノードをデプロイするために、ここではDockerを使用しています。

## 前提条件

- [Docker 1.13/Docker CE 18.06以上](https://docs.docker.com/install) (旧バージョンはテストしていません)
- (オプション) [Docker Compose](https://docs.docker.com/compose/install)

## 事前準備

デフォルトでは、`/data/iserver`はdataボリュームにマウントされます。これは変更しても構いません。ここでは`PREFIX`を参照します。

*もし前のバージョンのiServerを実行しているなら、古いデータを確実に消してください*

```
rm -rf $PREFIX/storage
```

### ノードの開始

次のコマンドでノードを開始します。
```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

または、*boot*スクリプトを使ってください。

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

このスクリプトは`$PREFIX`を破棄し、IOSTネットワークに接続している新しい新しいフルノードを起動します。またブロックを生成するために*プロデューサー*のキーペアを生成します。

ノードを起動、停止、または再起動するには、`$PREFIX`にディレクトリをに変更して、`docker-compose (start|stop|restart|down)`を実行します。

## ノードの確認

ログファイルは、`$PREFIX/logs/iost.log`にあります。次のような増加する`confirmed`は、ブロックデータの同期が進んでいっていることを示しています。

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
docker-compose exec iserver ./iwallet state
```

最新のブロックチェーン情報は、[ブロックチェーンエクスプローラ](https://explorer.iost.io)にも表示されます。

## Servi Node

Serviノード(別名スーパーノード)は、*プロデューサー*である場合にのみブロックを生成でき、IOSTアカウントとフルノードが必要です。
**プロデューサーのアカウントとは違うキーペアを使用することを強くお勧めします。**

### IOSTアカウントの作成

アカウントのない場合は、次のステップに従って作成してください。

- iWalletを使用して、*キーペア*を作成します。
- 作成した*キーペア*で、[blockchain explorer](https://explorer.iost.io)にサインアップします。

iWalletを使ってあなたのアカウントをインポートすることを忘れないでください。

### ノードの開始

起動スクリプトを実行して、フルノードを起動します。[ノードの開始](#start-the-node)も参照してください。

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

プロデューサーの鍵ペアは、`$PREFIX/keypair`にあります。 `http://localhost:30001/getNodeInfo`の`.network.id`セクションで、ネットワークIDを取得できます。

### 登録の申請

iWalletを使って自分のノードを登録するためのトランザクション(tx)を投げます。

```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",true]' --amount_limit '*:unlimited'
```

`vote_producer.iost`のAPIドキュメントは[ここ](6-reference/SystemContract.html#vote-produceriost)にあります。

## Serviノードのオペレーター

**admin**に承認後、ノードの準備ができたらノードをオンラインにします。

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]' --amount_limit '*:unlimited'
```

ブロックの生成を止めるには次のようにします。

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]' --amount_limit '*:unlimited'
```
