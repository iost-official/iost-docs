---
id: ContractStart
title: スマートコントラクトクイックスタート
sidebar_label: スマートコントラクトクイックスタート
---


# DApp開発の開始

## IOSTのDAppの基礎

ブロックチェーンは、ネットワーク内で同期するステートマシンとして抽象化されています。スマートコントラクトは、ブロックチェーンシステム上で、実行されるコードで、ステートマシンのステート(状態)をトランザクションを通じて変化させます。ブロックチェーンの特徴により、スマートコントラクトの呼び出しは、連続かつグローバルな一貫性を保証します。

IOSTのスマートコントラクトは、現在はJavaScript (ES6) での開発をサポートしています。

IOSTのスマートコントラクトはスマートコントラクトのコードとABIを記述したJSONファイルを含みます。それは名前空間と独立したストレージを持ちます。外部からは、ストレージの内容の読み出しのみが可能です。

### キーワード

| キーワード | 説明 |
| :-- | :-- |
| ABI | スマートコントラクトのインターフェース。ここで宣言したインターフェースを通してのみ外部から呼び出すことが可能 |
Tx | トランザクション。トランザクションをサブミットすることでブロックチェーンの状態を変。トランザクションはブロック内にパッケージ化されている |
|


## デバッグ環境設定

### iwalletの使用とテストノード

スマートコントラクトの開発には、iwalletが必要です。同時に、テストノードを開始することで、デバッグを促進できます。それには、次に挙げる２つの方法のどちらか選択してください。

#### Docker環境 (推奨)

Dockerを開始して、Docker環境に入ります。ローカルテストノードも開始します。

```
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:2.1.0-29b893a5
docker ps # the last column of the output is the docker container name, which will be used in next command
docker exec -it <container_name> /bin/bash # you will enter docker
./iwallet -h
```

#### ソースコードのコンパイル

go 1.11以上が必要

```
go get -u iost-official/go-iost
cd $GOPATH/src/github.com/iost-official/go-iost
make install
# Check the configuration config/
iserver -f config/iserver.yml # Start the test node, no need
iwallet -h
```
### iwalletの初期アカウント```admin```のインポート

テストをするには、秘密鍵をiwalletにインポートする必要があります。関連する鍵は、config/genesis.yml のadmininfoフィールドにあります。
```
iwallet account import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```
Dockerでは、Dockerイメージ内にインストールされていない"iwallet"の代わりに"./iwallet"を使用する必要があります。


## Hello world

### コードの準備
最初にJavaScriptクラスを用意します。
```
// helloWorld.js
class HelloWorld {
    init() {} // needs to provide an init function that will be called during deployment
    hello(someone) {
        return "hello, "+ someone
    }
}

module.exports = HelloWorld;
```
このスマートコントラクトには入力を受け取って、```hello, + 入力した値 ```を出力するインターフェースがあります。このインターフェースで、スマートコントラクトの外部から呼び出すことができるように、ABIファイルを用意します。
```
// helloWorld.abi
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "hello",
      "args": [
        "string"
      ]
    }
  ]
}
```
ABIのnameフィールドは、jsファイルの関数名と関連付けられ、argsが事前の型チェック情報になります。３つの型、string、number、boolだけを使うことを推奨します。

## ローカルテストノードへのパブリッシュ

スマートコントラクトをパブリッシュするには次のようにします。
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 publish helloworld.js helloworld.abi
```
実行例


    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa
    Checking transaction receipt...
    SUCCESS!
    The contract id is: Contract2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa

Test ABI call

```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf" "hello" '["developer"]' # contract id needs to be changed to the id you received
```

出力

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: CzQi1ro44E6ysVq6o6c6UEqYNrPbN7HruAjewoGfRTBy
    Checking transaction receipt...
    SUCCESS!

その後、いつでも次のコマンドでTxReceipt(レシート)を取得できます。

```
iwallet receipt GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```
HTTPを通して取得することもできます。
```
curl -X GET \
  http://localhost:30001/getTxReceiptByTxHash/GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

呼び出しは、IOSTによって永久に記録され、手を入れることはできません。

## スマートコントラクトのステートストレージ

スマートコントラクトの出力を(UXTOのコンセプトと同様の)使うのは不便です。IOSTはこのモードは使いません。IOSTはtxReceipt内のそれぞれのフィールドのインデックスを提供しませんし、スマートコントラクトは特定のTxReceiptにアクセスすることもできません。ブロックチェーンのステートマシンを維持するために、ステートを保持するブロックチェーンデータベースを使います。

データベースは純粋なK-V(Key-Value)データベースで、値の型は文字列(string)です。各スマートコントラクトは、他のスマートコントラクトからステータスデータを読むことができますが、自分のフィールド以外は書き込むことができません。

### コーディング
```
class Test {
    init() {
        storage.put("value1", "foobar")
    }
    read() {
        console.log(storage.get("value1"))
    }
    change(someone) {
        storage.put("value1", someone)
    }
}
module.exports = Test;
```
ABIは省略します。

### ステートストレージの使用
コードをデプロイした後、次の方法でストレージを入手できます。
```
curl -X POST \
  http://localhost:30001/getContractStorage \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "id": "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e",
    "key": "value1",
    "by_longest_chain": true
}'
```
このPOSTメッセージはJSONを返します。
```
{
    "data": "foobar"
}
```
この値は、changeを呼び出すことで変更できます。
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e" "change" '["foobaz"]'
```

## 権限管理とスマートコントラクトの失敗

権限管理の基礎は次のようになっています。

例
```
if (!blockchain.requireAuth("someone", "active")) {
    Throw "require auth error" // throw that is not caught will be thrown to the virtual machine, causing failure
}
```
次の点に注意してください。
1. requireAuth自身は、操作を終了しないで、ブール値を返すだけですので、判断が必要になります。
2. requireAuth(tx.publisher, "active")は、常にtrueを返します。

トランザクションが実行に失敗したら、スマートコントラクトは完全にロールバックされますが、トランザクションを実行したユーザのGAS代は差し引かれます。(ロールバックされるので、RAMは請求されません)

失敗したトランザクションは簡単なテストで確認できます。
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "token.iost" "transfer" '["iost", "someone", "me". "10000.00", "this is steal"]'
```
この結果は次のようになります。

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 6KY4h4gKHFwuovXZJEDzvPtN9YYcJ5kUFHLf84gktYYu
    Checking transaction receipt...
    running action Action{Contract: token.iost, ActionName: transfer, Data: ["iost", "someone", "me". "10000.00", "this... error: prepare contract: error in data: invalid character '.' after array element, ["iost", "someone", "me". "10000.00", "this is steal"]

## デバッグ

上記のように、最初にローカルノードを開始します。Dockerなら、次のコマンドでログを表示することができます。
```
Docker ps -f <container>
```

この時点で、console.log()を追加することでコードに必要なログを追加できます。以下はストレージサンプルの実行中に出力されたログです。

```
Info 2019-01-08 06:44:11.110 pob.go:378 Gen block - @7 id:IOSTfQFocq..., t:1546929851105164574, num:378, confirmed:377, txs:1, pendingtxs:0, et: 4ms
Info 2019-01-08 06:44:11.416 value.go:447 foobar
Info 2019-01-08 06:44:11.419 pob.go:378 Gen block - @8 id:IOSTfQFocq..., t:1546929851402828690, num:379, confirmed:378, txs:2, pendingtxs:0, et: 16ms
```