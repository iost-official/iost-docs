---
id: iServer
title: iServer
sidebar_label: iServer
---

## iServerの起動

IOSTノードサービスであるiServerは、合意、同期、トランザクションプール、ネットワークなどのモジュールを持っています。IOSTノードをデプロイするためにはiServerサービスを起動する必要があります。

* ルートディレクトリにプロジェクトをコンパイルして、次のコマンドを実行すると、実行ファイルがルートフォルダ内の`target` ディレクトリに保存されます。

```
make build
```

* 次のコマンドで、IOSTノードを起動します。

```
./target/iserver -f ./config/iserver.yml
```

* 設定ファイル./config/iserver.ymlを編集します。

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

* ノードのカウント情報を設定します。

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

* ジェネシスブロック情報とブロックと量を設定します。


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```


```
db:
  ldbpath: storage/
```

データベースの位置を設定します。


```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

ネットワーク情報を設定します。ネットワークにアクセスするためのシードノードが必要です。

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

RPCポートを設定します。


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
```

ロギングサービス設定します。


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
