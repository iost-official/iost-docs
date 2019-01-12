---
id: version-2.1.7-Blockchain-class
title: Blockchain
sidebar_label: Blockchain
original_id: Blockchain-class
---

Blockchainクラスは、IOSTブロックチェーンを使ったり、情報を取得したりするためのクラスです。

## constructor
constructorメソッドは、特殊なメソッドで、Blockchainクラスを作成し、初期化します。
ユーザが初期化<b>する必要はありません</b>。ユーザはrpc.blockchainでBlockchainクラスを使えます。

## getChainInfo
ブロックチェーンからチェーン情報を取得します。

### 戻り値
chainInfoオブジェクトを返すPromise。

名前             |型       |説明 
----                |--         |--
net_name 			|String          | ネットワーク名、mainnetまたはtestnet
protocol_version 	|String 		 | IOSTプロトコルのバージョン
head_block	 		|Number			 | 先頭ブロック高
head_block_hash		|String			 | 先頭ブロックハッシュ
lib_block	 		|Number			 | 最終不可逆ブロック番号
lib_block_hash	 	|String			 | 最終不可逆ブロックハッシュ
witness_list	 	|Array			 | 現在の目撃者リスト

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getChainInfo().then(console.log);

/*{
	"net_name": "debugnet",
	"protocol_version": "1.0",
	"head_block": "142",
	"head_block_hash": "ryj9qWvbypFd1VJeUiyxmyNiav9E8ZHH1t47zSbMmGk",
	"lib_block": "142",
	"lib_block_hash": "ryj9qWvbypFd1VJeUiyxmyNiav9E8ZHH1t47zSbMmGk",
	"witness_list": [
		"IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
	]
}*/
```

## getBlockByHash
ハッシュにより、ブロックチェーンからブロック情報を取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
hash 		|String          | ブロックハッシュ
complete 	|Boolean 		 | 完全なトランザクションとトランザクションレシートを持っていればtrue

### 戻り値
ブロックオブジェクトを返すPromise。

名前             |型       |説明 
----                |--         |--
status 		|String          | トランザクションのステータス
block 	|Object 		 | [Blockオブジェクト](#block-object)

#### Blockオブジェクト
名前             |型       |説明 
----                |--         |--
hash 					|String          | ブロックハッシュ
version 				|Number 		 | ブロックのバージョン
parent_hash 			|String          | 親のブロックハッシュ
tx_merkle_hash 			|String          | トランザクションのマークルツリールートハッシュ
tx_receipt_merkle_hash  |String          | トランザクションレシートのマークルツリールートハッシュ
number 					|String          | ブロック番号
witness 				|String          | ブロックプロデューサー
time 					|String          | ブロックのタイムスタンプ
gas_usage 				|String          | ブロックのGAS使用量
tx_count 				|String          | トランザクション数
transactions			|Array			 | [Transactionオブジェクト](Transaction-class.md#transaction-object)の配列
info 					|Object          | [Infoオブジェクト](#info-object)

#### AmountLimitオブジェクト
名前             |型       |説明 
----                |--         |--
token 			|String          | トークン名 name
value 			|Number 		 | 制限値

#### Infoオブジェクト
名前             |型       |説明 
----                |--         |--
mode 					|Number          | パックモード
thread 				|Number 		 | トランザクション実行中スレッド番号
batch_index 			|Array          | 各バッチ実行のトランザクションインデックス

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getBlockByNum(1, true).then(console.log);

/*{
	"status": "IRREVERSIBLE",
	"block": {
		"hash": "HSSXypC9GwRowiG6e1FG9qGbvVZFjT9mR7RY8mGZzoLJ",
		"version": "0",
		"parent_hash": "CyoyPDfRM8a4HWwSbDBRv3UbFoUUQxWu4T5JuaJsmLvs",
		"tx_merkle_hash": "7thvoWaULNdrXVYR6wRTfWYSpJDFj6vKX1jitCsh7KRj",
		"tx_receipt_merkle_hash": "GvjAbjP9c626UPSMFjPMERyVDxqwvdu5uziqyiZdmoox",
		"number": "1",
		"witness": "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C",
		"time": "1545384717001253745",
		"gas_usage": 0,
		"tx_count": "1",
		"info": null,
		"transactions": [
			{
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
				"tx_receipt": {
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
				}
			}
		]
	}
}*/
```

## getBlockByNum
番号でブロックチェーンからブロックを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
num 		|Number          | ブロック番号
complete 	|Boolean 		 | 完全なトランザクションとトランザクションレシートを持っていればtrue

### 戻り値
ブロックオブジェクトを返すPromise。
[getBlockByHash](#getBlockByHash)をチェックしてください。

## getBalance
残高を取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
name 		|String          | アカウント名
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか

### 戻り値
残高オブジェクトを返すPromise。

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getBalance('myaccount', true).then(console.log);

/*{
	balance: 12000,
	frozen_balances: null
}*/
```

## getToken721Balance
アカウントのtoken721残高を取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
name 		|String          | アカウント名
tokenSymbol |String 		 | token721 シンボル
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか

### 戻り値
残高オブジェクトを返すPromise。

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Balance('myaccount', 'my721Token', true).then(console.log);

/*{
	balance: 12000,
	tokenIDs: null
}*/
```

## getToken721Metadata
token721のメタデータを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
token 		|String          | トークン名
token_id |String 		 | トークンID
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか

### 戻り値
メタデータを返すPromise。

名前             |型       |説明 
----                |--         |--
metadata 		|String          | メタデータ

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Metadata('symbol', 'id', true).then(console.log);

/*{
	metadata: ''
}*/
```

## getToken721Owner
token721のオーナーを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
token 		|String          | トークン名 token_id |String 		 | トークンID
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか

### 戻り値
オーナーオブジェクトを返すPromise。

名前             |型       |説明 
----                |--         |--
owner 		|String          | メタデータ

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Owner('symbol', 'id', true).then(console.log);

/*{
	owner: 'theowner'
}*/
```

## getContract
ブロックチェーンからコントラクトを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
id 		|String          | コントラクトID
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか

### 戻り値
コントラクトオブジェクトを返すPromise。

名前             |型       |説明 
----                |--         |--
id 			|String          | コントラクトID
code 		|String 		 | コントラクトコード
language 	|String 		 | コントラクト使用言語
version 	|String 		 | コントラクトのバージョン
abis | Array | [ABIオブジェクト](#abi-object)の配列

#### ABI Object
名前             |型       |説明 
----                |--         |--
name 			|String          | コントラクトID
args 		|Array 		 | ABI引数
amount_limit 	|Array 		 [AmountLimitオブジェクト](#amountlimit-object)の配列

## getContractStorage
ブロックチェーンからコントラクトのストレージを取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
id 		|String          | コントラクトID
key |String 		 | StateDBのキー
field 	|String 		 | StateDBからの値で、StateDB[key]がマップなら、fieldは必須(この場合、StateDB[key][field]を取得)
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか

### 戻り値
コントラクトの結果オブジェクトを返すPromise。

名前             |型       |説明 
----                |--         |--
data 		|String          | データ

## getAccountInfo
ブロックチェーンからアカウント情報を取得します。

### パラメータ
名前             |型       |説明 
----                |--         |--
anme 		|String          | アカウント名
by_longest_chain 	|Boolean 		 | 最長のチェーンの先頭ブロック、または最終不可逆ブロックによるアカウントか


### 戻り値
アカウント情報を返すPromise。

名前             |型       |説明 
----                |--         |--
name 		|String          | アカウント名￥
balance 		|Number          | アカウントの残高
gas_info 		|Object          | [GasInfoオブジェクト](#gasinfo-object)
ram_info 		|Object          | [RAMInfoオブジェクト](#raminfo-object)
permissions 		|Map          | map<String, [Permissionオブジェクト](#permission-object)>
groups | Map | map<String, [Groupオブジェクト](#group-object)>
frozen_balances | Array | [FrozenBalanceオブジェクト](#frozenbalance-object)の配列

#### GasInfoオブジェクト
名前             |型       |説明 
----                |--         |--
current_total 		|Number          | 現在の総GAS量
transferable_gas 		|Number          | 現在の転送可能GAS
pledge_gas 		|Number          | 出資GAS
increase_speed 		|Number          | GAS増加速度
limit 		|Number          | 制限
pledged_info | Array | [PledgeInfoオブジェクト](#pledgeinfo-object)の配列

#### PledgeInfoオブジェクト
名前             |型       |説明 
----                |--         |--
pledger 		|String          | 出資者
amount 		|Number          | 出資する量

#### RAMInfoオブジェクト
名前             |型       |説明 
----                |--         |--
available 		|Number          | 使用可能RAM量(バイト)

#### Permissionオブジェクト
名前             |型       |説明 
----                |--         |--
name 		|String          | 権限名
groups 		|Array          | 権限グループの配列
items 		|Array          |  [Itemオブジェクト](#item-object)の配列
threshold 		|Number          | 権限のしきい値

#### Itemオブジェクト
名前             |型       |説明 
----                |--         |--
id 		|String          | 権限名またはキーペアID
is_key_pair 		|Boolen          | キーペアIDか
weight 		|Number          | 権限の重み
permission 		|String          | 権限

#### Groupオブジェクト
名前             |型       |説明 
----                |--         |--
name 		|String          | グループ名
items 		|Array          | [Itemオブジェクト](#item-object)の配列

#### FrozenBalanceオブジェクト
名前             |型       |説明 
----                |--         |--
amount 		|Number          | 残高
time 		|Number          | 解放までの時間(free time)

### 例
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getAccountInfo("myaccount").then(console.log);

/*{
	"name": "myaccount",
	"balance": 993939700,
	"gas_info": {
		"current_total": 3000000,
		"transferable_gas": 0,
		"pledge_gas": 3000000,
		"increase_speed": 11,
		"limit": 3000000,
		"pledged_info": [
			{
				"pledger": "myaccount",
				"amount": 100
			}
		]
	},
	"ram_info": {
		"available": "100000"
	},
	"permissions": {
		"active": {
			"name": "active",
			"groups": [],
			"items": [
				{
					"id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
					"is_key_pair": true,
					"weight": "1",
					"permission": ""
				}
			],
			"threshold": "1"
		},
		"owner": {
			"name": "owner",
			"groups": [],
			"items": [
				{
					"id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
					"is_key_pair": true,
					"weight": "1",
					"permission": ""
				}
			],
			"threshold": "1"
		}
	},
	"groups": {},
	"frozen_balances": []
}*/
```
