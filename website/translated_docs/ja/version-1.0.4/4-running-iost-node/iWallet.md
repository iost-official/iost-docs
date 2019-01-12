---
id: version-1.0.4-iWallet
title: iWallet
sidebar_label: iWallet
original_id: iWallet
---

**IOSBlockchain**は、２つのプログラムで構成されています。`iServer`はコアプログラムで、複数の`iServer`でブロックチェーンネットワークを構成しています。`iWallet`は、ブロックチェーンである`iServer`とやり取りするためのコマンドラインツールです。

システムの`ビルド`に成功しすると、`iWallet`が、プロジェクトディレクトリの`target/`フォルダに生成されます。

![iwallet1](assets/4-running-iost-node/iWallet/iwallet.png)

## コマンド

|コマンド      |内容                                |説明
|:-----------:|:--------------------------------------:|:--------------------------------------------|
|help         |コマンドの説明                 |  iwallet -h でさらに説明が表示されます
|account      |アカウント管理                 |  ./iwallet account -n id
|balance      |指定したアカウントの残高をチェック       |  ./iwallet balance ~/.iwallet/id_ed25519.pub
|block        |prブロックの情報を表示、デフォルトではブロック番号   |  
|call         |コントラクト内のメソッドの呼び出し           |  ./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' -k SecKeyPath --expiration 50
|compile      |スマートコントラクトファイルをコンパイル|  ./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
|net          |ネットワークIDの取得                         |  ./iwallet net
|publish      |sig ファイルを使って、.sc ファイルに署名してパブリッシュ        |./iwallet publish -k ~/.iwallet/id_ed25519 ./dashen.sc ./dashen.sig0 ./dashen.sig1
|sign         |.sc ファイルに署名                         |  ./iwallet sign -k ~/.iwallet/id_ed25519 ./test.sc
|transaction  |トランザクションハッシュによりトランザクションを見つけるHUVdKWhstUHbdHKiZma4YRHGQZwVXerh75hKcXTdu39t

## コマンドの例

### help:

`iwallet`のヘルプ情報を表示します。

```
./iwallet -h
```

### account:

IOSTアカウントを作成します。アカウントの公開鍵と秘密鍵が`~/.iwallet/`ディレクトリに保存されます。

```
./iwallet account -n id
return:
the iost account ID is:
IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
```

### balance:

アカウントの残高を表示します。

```
./iwallet balance IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
return:
1000 iost
```

### block:

ハッシュによりブロックを検索します。

```
# 查询0号block数据
./iwallet block -m num 0
return:
{"head":{"txsHash":"bG7L/GLaF4l8AhMCzdl9r7uVvK6BwqBq/sMMuRqbUH0=","merkleHash":"cv7EfVzjHCzieYStfEm61Ew4zbNFYN80i/6J8Ijhbos=","witness":"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A"},"hash":"9NzDz2iueLZ4e8YDotIieJRZrlTMddbjaJAvSV23TFU=","txhash":["3u12deEbLcyP7kI5k+WIuxUrskAOu8UKUOPV+H51bjE="]}
```

### call:

コントラクトのメソッドを呼び出します。

```
# Calls iost.system contract's Transfer method，Account IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP transfers Account IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk 100 token,
# -k is private key，--expiration specifies timeout
./iwallet call "iost.system" "Transfer" '["IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP", "IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk", 100]' -k ~/.iwallet/id_ed25519 --expiration 50
return:
ok
8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
```

### net:

iserverのネットワークアドレスを取得します。

```
./iwallet net
return:
netId: 12D3KooWNdJgdRAAYoHvrYgCHhNEXS9p7LshjmJWJhDApMXCfahk

```

### transaction:

トランザクションを照会します。

```
./iwallet transaction 8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
return:
txRaw:<time:1537540108548894481 expiration:1537540158548891677 gasLimit:1000 gasPrice:1 actions:<contract:"iost.system" actionName:"Transfer" data:"[\"IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP\", \"IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk\", 100]" > publisher:<algorithm:2 sig:"\224iI\0300\317;\337N\030\031)'\277/xO\231\325\277\022\217M\017k.\260\205+*$\235\017}\353\007\206\352\367N(\203\343\333\017\374\361\230\313,\231\313* oK\270.f;6\371\332\010" pubKey:"_\313\236\251\370\270:\004\\\016\312\300\2739\304\317Jt\330\344P\347s\2413!\3725\3126\246\247" > > hash:"m\005\2613%\371\234\233\315\377@\016\253Aw\024\214IX@\0368\330\370T\241\267\342\256\252\354P"

```

### compile/publish/sign:

[デプロイと呼び出し](3-smart-contract/Deployment-and-invocation.md)を参照してください。
