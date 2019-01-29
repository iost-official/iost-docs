---
id: Deployment
title: IOSTテストネットへの参加
sidebar_label: IOSTテストネットへの参加
---

このドキュメントで、IOSTテストネットへ接続するサーバーをセットアップする方法を紹介します。デバッグやテストのためにローカルシングルサーバブロックチェーンネットをセットアップしたいだけなら、[ローカルサーバーの起動](LocalServer.md)を参照してください。

IOSTノードをデプロイするために、ここではDockerを使用しています。

## マシン要件
フルノードで接続するテストネットワークを実行する場合は、物理的に次の要件を満たす必要があります。

CPU：CPUは8コア以上（8コア推奨）
メモリ：メモリは8GB以上（16GB推奨）
ディスク：ディスクには5TB以上（5TB HDD推奨）
ネットワーク：インターネットに接続して、ポート30000を開く（30000、30001、30002ポートを開くことを推奨）。

## 前提条件

- [Docker 1.13/Docker CE 18.06以上](https://docs.docker.com/install) (旧バージョンはテストしていません)
- (オプション) [Docker Compose](https://docs.docker.com/compose/install)

## ノードの開始

### *boot*スクリプトの使用

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX bash
```

このスクリプトは$PREFIXを破棄して、IOSTテストネットネットワークに接続する新しいフルノードを起動します。ブロックを生成する準備として、*プロデューサー*のための鍵ペアを生成します。

ノードを起動、停止、または再起動するには、ディレクトリを$PREFIXに変更して、docker-compose (start|stop|restart|down) を実行します。

### マニュアル
#### 事前準備

デフォルトでは、`/data/iserver`はdataボリュームにマウントされます。これは変更しても構いません。ここでは`PREFIX`を参照します。

*もし前のバージョンのiServerを実行しているなら、古いデータを確実に消してください*

```
rm -rf $PREFIX/storage
```

### 開始

次のコマンドでノードを開始します。
```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

## ノードの確認

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

