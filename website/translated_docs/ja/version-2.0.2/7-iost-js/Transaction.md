---
id: version-2.0.2-Transaction-class
title: Transaction
sidebar_label: Transaction
original_id: Transaction-class
---

Transactionクラスは、IOSTブロックチェーンやIOSTのスマートコントラクトを使って、トランザクションを送信したり、トランザクションを取得したりするためのクラスです。

## constructor
constructorメソッドは、特殊なメソッドで、Transactionクラスを作成し、初期化します。
ユーザは初期化<b>する必要はありません</b>。ユーザはrpc.transactionでTransactionクラスを使えます。

## getTxByHash
ブロックチェーンからハッシュを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
hash 		|String          | Base58エンコードしたトランザクションハッシュ

### 戻り値
トランザクションオブジェクトを返すPromise。

名前             |型       |説明 
----                |--         |--
status 		|String          | トランザクションステータス
transaction |Object 		 | [Transactionオブジェクト](Blockchain-class#transaction-object)

#### Transactionオブジェクト
名前             |型       |説明
----                |--         |--
hash 			|String          | トランザクションハッシュ
time 			|Number 		 | トランザクションのタイムスタンプ
expiration 		|Number          | 有効期限gas_ratio 		|Number          | GAS比率gas_limit  		|Number          | GAS上限delay 			|Number          | 遅延時間(ナノ秒)
actions 		|Array           | [Actionオブジェクト](#action-object)配列
signers 		|Array           | 署名者の配列
publisher 		|String          | トランザクションパブリッシャー
referred_tx 	|String          | 参照トランザクションハッシュ
amount_limit	|Array			 | [AmountLimitオブジェクト](#amountlimit-object)配列
tx_receipt 		|Object          | [TxReceiptオブジェクト](#txreceipt-object)

#### Actionオブジェクト
名前             |型       |説明 
----                |--         |--
contract 			|String          | コントラクト名
action_name 			|String 		 | アクション名
data 		|String          | データ

#### AmountLimitオブジェクト
名前             |型       |説明 
----                |--         |--
token 			|String          | トークン名
value 			|Number 		 | 上限値

#### TxReceiptオブジェクト
名前             |型       |説明 
----                |--         |--
tx_hash 			|String          | トランザクションハッシュ
gas_usage 			|Number 		 | GAS使用量
ram_usage 		|Map          | RAM使用量
status_code 		|String          | ステータスコード
message  		|String          | メッセージ
returns 			|Array          | トランザクションの戻り値配列
receipts 		|Array           | [Receiptオブジェクト](#receipt-object)配列

#### Receiptオブジェクト
名前             |型       |説明 
----                |--         |--
func_name 			|String          | 関数名
content 			|String 		 | 内容

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.transaction.getTxByHash("5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa").then(console.log);

/*{
	"status": "IRREVERSIBLE",
	"transaction": {
		"hash": "5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa",
		"time": "0",
		"expiration": "0",
		"gas_ratio": 1,
		"gas_limit": 1000000,
		"delay": "0",
		"actions": [
			{
				"contract": "base.iost",
				"action_name": "Exec",
				"data": "[{\"parent\":[\"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A\", \"0\"]}]"
			}
		],
		"signers": [],
		"publisher": "_Block_Base",
		"referred_tx": "",
		"amount_limit": [],
		"tx_receipt": null
	}
}*/
```

## getTxReceiptByTxHash
トランザクションハッシュからトランザクションを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
hash 		|String          | Base58エンコードしたトランザクションハッシュ

### 戻り値
[TxReceiptオブジェクト](#txreceipt-object)を返すPromise。

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.transaction.getTxByHash("5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa").then(console.log);

/*{
	"tx_hash": "5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa",
	"gas_usage": 0,
	"ram_usage": {
		"_Block_Base": "0",
		"base.iost": "284",
		"bonus.iost": "107"
	},
	"status_code": "SUCCESS",
	"message": "",
	"returns": [
		"[\"\"]"
	],
	"receipts": [
		{
			"func_name": "token.iost/issue",
			"content": "[\"contribute\",\"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A\",\"900\"]"
		}
	]
}*/
```

## sendTx
IOSTブロックチェーンにトランザクションを送信します。
