---
id: IOST-Blockchain-API
title: スIOSTブロックチェーンAPI
sidebar_label: スIOSTブロックチェーンAPI
---

## IOSTブロックチェーンAPI
以下のオブジェクトは、コントラクトコード内でアクセスできます。

### storageオブジェクト

すべての変数はラインタイム上のメモリに格納されます。IOSTでは、スマートコントラクトでデータを保持するために`storage`オブジェクトを使うことができます。

開発者はこのクラスを利用して複数のコントラクト呼び出し中にデータを同期することができます。APIは、次のとおりです。詳細は、[こちらのコード](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js)を参照してください。

#### put(key, value, payer)

キー値ペアをストレージに格納します。
* パラメータ:
	* key: string
	* value: string
	* payer: string
* 戻り値: なし

#### get(key)

キーを使用してキー値ペアをストレージから取得します。
* パラメータ:
	* key: string
* 戻り値: あれば値の文字列、なければ`null`

#### has(key)

ストレージにキーがあるかどうかをチェックします。
* パラメータ:
	* key: string
* 戻り値: bool (あれば`true`、なければ`false`)

#### del(key)

キーを使用してキー値ペアをストレージから削除します。
* パラメータ:
	* key: string
* 戻り値: なし

#### mapPut(key, field, value, payer)

(key, field, value)ペアをマッピングします。key + fieldで値を見つけるようにします。
* パラメータ:
	* key: string
	* field: string
	* value: string
	* payer: string
* 戻り値: なし

#### mapGet(key, field)

key + fieldを使用して、(key, field)ペアを取得します。
* パラメータ:
	* key: string
	* field: string
* 戻り値: あれば値の文字列、なければ`null`

#### mapHas(key, field)

key + fieldを使用して、(key, field)ペアがあるかどうかをチェックします。
* パラメータ:
	* key: string
	* field: string
* 戻り値: bool (あれば`true`、なければ`false`)

#### mapKeys(key)

key内のフィールドを取得します。フィールド数が256を超えると正しい値を返す保証はなく、最大で256の結果を返します。
* パラメータ:
	* key: string
* 戻り値: 配列\[string\] (フィールドの配列)

#### mapLen(key)

key内のフィールド数を取得します。フィールド数が256を超えると正しい値を返す保証はなく、最大で256を返します。
* パラメータ:
	* key: string
* 戻り値: 整数 (フィールド数)

#### mapDel(key, field)

key + fieldを使用して、(key, field, value)ペアを削除します。
* パラメータ:
	* key: string
	* field: string
* 戻り値: なし

#### globalHas(contract, key)

キーがあるかどうかストレージ全体でチェックします。
* パラメータ:
	* contract: string
	* key: string
* 戻り値: bool (あれば`true`、なければ`false`)

#### globalGet(contract, key)

keyを使用してストレージ全体から値を取得します。
* パラメータ:
	* contract: string
	* key: string
* 戻り値: あれば値の文字列、なければ`null`

#### globalMapHas(contract, key, field)

ストレージ全体で、key + fieldを使用して、(key, field) ペアがあるかどうかをチェックします。
* パラメータ:
	* contract: string
	* key: string
	* field: string
* 戻り値: bool (あれば`true`、なければ`false`)

#### globalMapGet(contract, key, field)

ストレージ全体で、key + fieldを使用して、(key, field) ペアを取得します。
* パラメータ:
	* contract: string
	* key: string
	* field: string
* 戻り値: あれば値の文字列、なければ`null`

#### globalMapLen(contract, key)

ストレージ全体で、key内のフィールド数を取得します。フィールド数が256を超えると正しい値を返す保証はなく、最大で256を返します。
* パラメータ:
	* contract: string
	* key: string
* 戻り値: 整数 (フィールド数)

#### globalMapKeys(contract, key)

ストレージ全体で、key内のフィールドを取得します。フィールド数が256を超えると正しい値を返す保証はなく、最大で256の結果を返します。
* パラメータ:
	* contract: string
	* key: string
* 戻り値: 配列\[string\] (フィールドの配列)

### blockchainオブジェクト

blockchainオブジェクトは、システムが呼び出すためのすべてのメソッドを提供し、ユーザーが公式のAPIを呼び出すのを助けます。それには、送金、他のコントラクトの呼び出し、ブロックやトランザクションの検索が含まれます。

APIは、次のとおりです。詳細は、[こちらのコード](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js)を参照してください。

#### transfer(from, to, amount, memo)

IOSトークンを転送します。
* パラメータ:
	* from: string
	* to: string
	* amount: string/number
	* memo: string
* 戻り値: なし

#### withdraw(to, amount, memo)

IOSトークンを引き出します。
* パラメータ:
	* to: string
	* amount: string/number
	* memo: string
* 戻り値: なし

#### deposit(from, amount, memo)

IOSトークンをデポジットします。
* パラメータ:
	* from: string
	* amount: string/number
	* memo: string
* 戻り値: なし

#### blockInfo()

ブロック情報を取得します。
* パラメータ: なし
* 戻り値: ブロック情報のJSON文字列

#### txInfo()

トランザクション情報を取得します。
* パラメータ: なし
* 戻り値: トランザクション情報のJSON文字列

#### contextInfo()

コンテキスト情報を取得します。
* パラメータ: なし
* 戻り値: コンテキスト情報のJSON文字列

#### contractName()

コントラクト名を取得します。
* パラメータ: なし
* 戻り値: コントラクト名の文字列

#### publisher()

パブリッシャーを取得します。
* パラメータ: なし
* 戻り値: パブリッシャーの文字列

#### call(contract, api, args)

引数付きでコントラクトを呼び出します。
* パラメータ:
	* contract: string
	* api: string
	* args: JSONString
* 戻り値: string

#### callWithAuth(contract, api, args)

認証を伴う引数付きでコントラクトを呼び出します。
* パラメータ:
	* contract: string
	* api: string
	* args: JSONString
* 戻り値: string

#### requireAuth(pubKey, permission)

アカウントの権限をチェックします。
* パラメータ:
	* pubKey: string
	* permission: string
* 戻り値: bool (権限があれば`true`、なければ`false`)

#### receipt(data)

レシートを取得します。
* パラメータ:
	* data: string
* 戻り値: なし

#### event(content)

イベントをポストします。
* パラメータ:
	* content: string
* 戻り値: なし

### txオブジェクトとblockオブジェクト
txオブジェクトは、現在のトランザクションの情報を、blockオブジェクトは、現在のブロックの情報を含んでいます。例えば次のようになっています。
```js
{
	time: 1541541540000000000,
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000,
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn":2},
	publisher: "user0"
}
```  

blockオブジェクトは、現在のブロック情報を含んでいます。例えば次のようになっています。
```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn",
	time: 1541541540000000000
}
```

詳細は[こちら](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29)を参照してください。

### encrypt object
SHA3ハッシュを取得するために、```IOSTCrypto``` オブジェクトの ```sha3(String)``` 関数を直接使うことができます。F

##### 例

```js
IOSTCrypto.sha3(msg)
```
