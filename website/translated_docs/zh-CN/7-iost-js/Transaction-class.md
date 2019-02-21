---
id: Transaction-class
title: Transaction
sidebar_label: Transaction
---

访问IOST交易相关RPC的接口

## constructor
<b>不要</b> 构造实例，使用rpc.transaction

## getTxByHash
通过hash获取交易

### Parameters
Name             |Type       |Description
----                |--         |--
hash 		|String          | base58编码的交易hash

### Returns
Promise returns transaction object.
Name             |Type       |Description
----                |--         |--
status 		|String          | 交易状态
transaction |Object 		 | [Transaction Object](7-iost-js/Blockchain-class.md#transaction-object)

#### Transaction Object
Name             |Type       |Description
----                |--         |--
hash 			|String          | 交易 hash
time 			|Number 		 | 交易时间戳
expiration 		|Number          | 超时时间戳
gas_ratio 		|Number          | gas的倍率
gas_limit  		|Number          | gas限额
delay 			|Number          | 延迟时间，以纳秒计
actions 		|Array           | [Action Object](#action-object)数组
signers 		|Array           | 签名者的数组
publisher 		|String          | 交易发送者
referred_tx 	|String          | 延迟交易生成的交易hash
amount_limit	|Array			 | [AmountLimit Object](#amountlimit-object)数组
tx_receipt 		|Object          | [TxReceipt Object](#txreceipt-object)

#### Action Object
Name             |Type       |Description
----                |--         |--
contract 			|String          | 智能合约名
action_name 			|String 		 | ABI名
data 		|String          | 传入的参数

#### AmountLimit Object
Name             |Type       |Description
----                |--         |--
token 			|String          | token名字
value 			|Number 		 | 限额

#### TxReceipt Object
Name             |Type       |Description
----                |--         |--
tx_hash 			|String          | 交易 hash
gas_usage 			|Number 		 | gas 使用量
ram_usage 		|Map          | ram 使用量
status_code 		|String          | 状态码
message  		|String          | 信息
returns 			|Array          | 交易的返回值
receipts 		|Array           | [Receipt Object](#receipt-object)交易的内部凭条数组

#### Receipt Object
Name             |Type       |Description
----                |--         |--
func_name 			|String          | 函数名
content 			|String 		 | 内容

### Example
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
通过交易hash获取交易Receipt

### Parameters
Name             |Type       |Description
----                |--         |--
hash 		|String          | base58编码的交易hash

### Returns
Promise returns [TxReceipt Object](#txreceipt-object)

### Example
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
向链上发送交易，不建议直接使用
