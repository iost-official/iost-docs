---
id: Configuration
title: 設定
sidebar_label: 設定
---

ここでは、設定に関する情報を紹介します。
最新の設定は次の場所にあります。

- genesis.tgz: https://developers.iost.io/docs/assets/mainnet/latest/genesis.tgz
- iserver.yml: https://developers.iost.io/docs/assets/mainnet/latest/iserver.yml



[デフォルト設定](https://github.com/iost-official/go-iost/tree/master/config)のそれぞれのセクションを準に説明します。

## iServerの設定

- acc

```
acc:
  id: producer000
  seckey: 1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB
  algorithm: ed25519
```

iServerがプロデューサーの場合、秘密鍵`acc.seckey`でブロックを署名します。
`acc.id`は、プロデューサーに紐付けられるIOSTアカウントです。
しかし、フィールドは実際には使用されません。

- genesis

```
genesis: config/genesis
```

[Everest v2.3.0](https://github.com/iost-official/go-iost/releases/tag/everest-v2.2.0)から、設定ファイルの代わりにiServerはジェネシス情報をディレクトリから読み込みます。
ディレクトリはジェネシスの設定ファイルだけでなく、基本的なシステムコントラクトも含んでいます。
[ジェネシスの設定](#config-genesis)を参照してください。

- vm と db

```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""
db:
  ldbpath: storage/
```
V8VMとデータベースの設定です。

- snapshot

```
snapshot:
  enable: false
  filepath: storage/snapshot.tar.gz
```

スナップショットが利用可能なら、iServerは何もない状態のブロックチェーンではなく、スナップショットから開始されます。
スナップショットを使えば、容易に現在の高さに追いつくことができます。

- p2p

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
  inboundConn: 15
  outboundConn: 15
  blackPID:
  blackIP:
  adminPort: 30005
```

listenaddrは、リスンしているP2Pネットワークのアドレスです。ノードがクラウドサービスにデプロイされたら、セキュリティグループ内で、ポートを開いてください。
seednodesは、P2Pネットワークで発見されたシードノードで、ノードの既知のリストで設定できます。
chainidは、独立した別のネットワークで使用されます。
versionは、ネットワークプロトコルバージョン番号です。
datapathは、P2Pルーティングテーブル、秘密鍵、その他のデータのストレージディレクトリです。
inboundConnは、接続されたの最大接続数です。
outboundConnは、最大接続数です。
blackPIDとblackIPは、ノードIDとブラックリストノードIPです。設定で、ノードはブラックリストからのP2Pネットワーク接続を拒否できます。
adminPortは、ネットワーク管理ポートで、ローカルホストからのみアクセスできます。

- rpc

```
rpc:
  enable: true
  gatewayaddr: 0.0.0.0:30001
  grpcaddr: 0.0.0.0:30002
  trytx: false
  allowOrigins:
    - "*"
```

enableは、RPCサービスを利用可能かどうかを示します。
gatewayaddrは、JSON RPCをリスンするアドレスです。
grpcaddrは、GRPCをリスンするアドレスです。
trytxは、トランザクションが実行前かどうかを示します。
allowOriginsは、クロスドメイン設定です。

- log

```
log:
  filelog:
    path: logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
  enablecontractlog: true
```

コンソールとファイルハンドラの両方がログ収集ためにあります。
この風呂億をデフォルトのままにしておくことをお勧めします。

- metrics

```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-mainnet:visitor00
```

[Prometheus](https://prometheus.io/)や特に[Prometheus Pushgateway](https://github.com/prometheus/pushgateway)をリアルタイムのデータ収集に 使います。[Prometheus Pushgateway]
[HTTP Basic authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) をサポートしています。
[ここ](4-running-iost-node/Metrics.md)をチェックして、自身のPrometheusサーバーをセットアップしてください。

- version

```
version:
  netname: "debugnet"
  protocolversion: "1.0"
```

ノード情報の説明です。

## ジェネシスの設定

ジェネシスの変更は、iServerがIOSTネットワークに接続できなくなります。
何をしているのかをわかった上で操作してください。

- tokeninfo

```
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 90000000000
  iostdecimal: 8
```

`iosttotalsupply`は、IOSTの最大供給量を定義しています。
それは、ジェネシスの段階でIOSTの全量が作成されるわけではないことを意味します。

- witnessinfo

```
witnessinfo:
  - id: producer000
    owner: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    active: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    signatureblock: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    balance: 0
```

Witnessesは、ジェネシスの最上位のプロデューサーです。
プロデューサーは追加されるServiノードと交代します。

- admininfo & foundationinfo

```
admininfo:
  id: admin
  owner: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto 
  active: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  balance: 21000000000
foundationinfo:
  id: foundation
  owner: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  active: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  balance: 0
```

このセクションは、管理者と財団のアカウントを定義します。

### initialtimestamp

```
nitialtimestamp: "2018-11-10T11:04:05Z"
```

ネットワークを開始する時間です。
