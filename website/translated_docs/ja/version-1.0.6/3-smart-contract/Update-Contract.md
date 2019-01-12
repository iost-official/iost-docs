---
id: version-1.0.6-Update-Contract
title: コントラクトの更新
sidebar_label: コントラクトの更新
original_id: Update-Contract
---

## 機能

コントラクトをブロックチェーンにデプロイした後、バグをフィックスしたり、バージョンアップするために開発者はコントラクトを更新する必要があります。

トランザクションを送信することにより、容易にスマートコントラクトを更新するメカニズムを提供します。さらに重要なのは、任意の権限の要求に対して、非常に柔軟な更新権限制御を提供します。

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

### コントラクトの作成

最初に、`iwallet`コマンドを使ってアカウントを作成して、画面に表示されたアカウントIDを記録します。
```console
./iwallet account -n update
return:
the iost account ID is:
IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h
```

次のように、新規のコントラクトファイルhelloContract.jsと関係するABIファイルhelloContract.jsonを作成します。
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "hello block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": []
        },
		{
			"name": "can_update",
			"args": ["string"]
		}
    ]
}
```
コントラクトファイル内のcan_update()関数実装を見てください。adminIDアカウント認証があるときだけ、コントラクトが更新できるようになっています。

### コントラクトのデプロイ

[デプロイと呼び出し](3-smart-contract/Deployment-and-invocation.md)を参照してください。

RContractHDnNufJLz8YTfY3rQYUFDDxo6AN9F5bRKa2p2LUdqWVWのようなコントラクトIDをメモしてください。

### コントラクトの更新
コントラクトの更新
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "update block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
hello()関数の実装を、"message"の内容として、"update block chain"をデータベースに書くように変更しました。

次のコマンドでスマートコントラクトを更新できます。

```console
./iwallet compile -u -e 3600 -l 100000 -p 1 ./helloContract.js ./helloContract.json <contract ID> <can_update parameter> -k ~/.iwallet/update_ed25519
```
-uは、コントラクトを更新、-kは署名やパブリッシュのための秘密鍵、ここでは アカウント`update_ed25519`がトランザクションを承認するのに使われています。

トランザクションを確認した後、iwalletを通してhello()関数を呼び出し、データベースの"message"の内容をチェックして、変更された内容を確認できます。
