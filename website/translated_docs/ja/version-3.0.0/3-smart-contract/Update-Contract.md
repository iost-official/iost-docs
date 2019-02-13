---
id: Update-Contract
title: コントラクトの更新
sidebar_label: コントラクトの更新
---

## 機能

コントラクトをブロックチェーンにデプロイした後、バグをフィックスしたり、バージョンアップするために開発者はコントラクトを更新する必要があります。

トランザクションを送信することにより、容易にスマートコントラクトを更新するメカニズムを提供します。
さらに重要なのは、任意の権限の要求に対して、非常に柔軟な更新権限制御を提供します。

スマートコントラクトを更新するには、スマートコントラクト内に次のように実装する必要があります。
```js
can_update(data) {
}
```

コントラクトを更新するリクエストを受け取ったら、システムは最初にコントラクトのcan_update(data)関数を呼び出します。dataはオプションで、string型の入力パラメータです。関数がtrueを返したならば、コントラクトの更新が実行されます。そうでなければ、`Update Refused`エラーが返ります。

この関数を適切に書くことにより、任意の権限制御の要求を実装することができます。たとえば、２人が同時に承認しないといけない、または誰がコントラクトを更新するかを投票するなどです。

コントラクト内に関数が実装されていない場合は、コントラクトはデフォルトでは更新は許可されません。

## Hello BlockChain

コントラクトの更新プロセスを示すために、単純なスマートコントラクトを例に挙げます。

コントラクトファイルhelloContract.jsを次のように作成します。
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello world";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }
};
module.exports = helloContract;
```
コントラクトファイル内のcan_update()関数実装を見てください。adminIDアカウント認証があるときだけ、コントラクトが更新できるようになっています。

### コントラクトのパブリッシュ

[コントラクトのパブリッシュ](4-running-iost-node/iWallet.md#publish-contract)を参照してください。
```
$ export IOST_ACCOUNT=admin # replace with your own account name here
$ iwallet compile hello.js
$ iwallet --account $IOST_ACCOUNT publish hello.js hello.js.abi
...
The contract id is: ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### 最初のコントラクトの呼び出し
これで、アップロードしたコントラクト内の`hello`関数を呼び出すことができます。結果として、'hello world'が返ってきます。
```
$ iwallet --account $IOST_ACCOUNT -v call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello world\"]"
    ],
    "receipts": [
    ]
}
```

### コントラクトの更新
最初にコントラクトファイルhelloContract.jsを編集して、次のように書き換えます。
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello iost";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }
};
module.exports = helloContract;
```
hello()関数の実装を、'hello world'から'hello iost'に変更しました。

次のコマンドで、スマートコントラクトをアップグレードします。

```console
iwallet --account $IOST_ACCOUNT publish --update hello.js hello.js.abi ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### ２回目のコントラクト呼び出し
トランザクションが確認された後は、iwalletを通してhello()関数を呼び出すと、'hello world'が'hello iost'に変わったのがわかります。
```
$ iwallet --account $IOST_ACCOUNT -v call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello iost\"]"
    ],
    "receipts": [
    ]
}
```







