---
id: Transaction-class
title: Transaction
sidebar_label: Transaction
---

This is the main class that interact with IOST blockchain and IOST smart contracts to send and get transactions from them.

## constructor
constructor method is a special method for creating and initializing Transaction class.
<b>DO NOT</b> need to initialize by user, user will use Transaction class by rpc.transaction.

## getTxByHash
get tx by hash from blockchain

### Parameters
Name             |Type       |Description 
----                |--         |--
hash 		|String          | base58 encode txHash

### Returns
Promise returns transaction object.
Name             |Type       |Description 
----                |--         |--
status 		|String          | transaction status
transaction |Object 		 | [Transaction Object](Blockchain-class#transaction-object)

#### Transaction Object
Name             |Type       |Description 
----                |--         |--
hash 			|String          | transaction hash
time 			|Number 		 | transaction timestamp
expiration 		|Number          | expiration timestamp
gas_ratio 		|Number          | gas gas_ratio
gas_limit  		|Number          | gas limit
delay 			|Number          | delay nanoseconds
actions 		|Array           | array of [Action Object](#action-object)
signers 		|Array           | array of signer string
publisher 		|String          | transaction publisher
referred_tx 	|String          | referred transaction hash
amount_limit	|Array			 | array of [AmountLimit Object](#amountlimit-object)
tx_receipt 		|Object          | [TxReceipt Object](#txreceipt-object)

#### Action Object
Name             |Type       |Description 
----                |--         |--
contract 			|String          | contract name
action_name 			|String 		 | action name
data 		|String          | data

#### AmountLimit Object
Name             |Type       |Description 
----                |--         |--
token 			|String          | token name
value 			|Number 		 | limit value

#### TxReceipt Object
Name             |Type       |Description 
----                |--         |--
tx_hash 			|String          | transaction hash
gas_usage 			|Number 		 | gas usage
ram_usage 		|Map          | ram usage
status_code 		|String          | status code
message  		|String          | message
returns 			|Array          | transaction returns
receipts 		|Array           | array of [Receipt Object](#receipt-object)

#### Receipt Object
Name             |Type       |Description 
----                |--         |--
func_name 			|String          | function name
content 			|String 		 | content

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
get transaction receipt by transaction hash

### Parameters
Name             |Type       |Description 
----                |--         |--
hash 		|String          | base58 encode txHas

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
send transaction to IOST blockchain