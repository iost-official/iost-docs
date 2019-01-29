---
id: Transaction-class
title: Transaction
sidebar_label: Transaction
---

Ceci est la classe principale qui interagit avec la blockchain IOST et ses smart contracts afin d'envoyer et recevoir des transactions de ceux-cis.

## constructor
La méthode constructor est spécifique à la création et à l'initialisation de la classe transaction.

<b>NE pas</b> initialiser via l'utilisateur. L'utilisateur utilisera la classe transaction via rpc.transaction.

## getTxByHash
obtient le hash de tx de la blockchain

### Paramètres
Name             |Type       |Description
----                |--         |--
hash 		|String          | base58 encode txHash

### Retourne
Retourne l'objet transaction.
Name             |Type       |Description
----                |--         |--
status 		|String          | transaction status
transaction |Object 		 | [Transaction Object](Blockchain-class#transaction-object)

#### Objet Transaction
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

#### Objet Action
Name             |Type       |Description
----                |--         |--
contract 			|String          | contract name
action_name 			|String 		 | action name
data 		|String          | data

#### Objet AmountLimit
Name             |Type       |Description
----                |--         |--
token 			|String          | token name
value 			|Number 		 | limit value

#### Objet TxReceipt
Name             |Type       |Description
----                |--         |--
tx_hash 			|String          | transaction hash
gas_usage 			|Number 		 | gas usage
ram_usage 		|Map          | ram usage
status_code 		|String          | status code
message  		|String          | message
Retourne 			|Array          | transaction Retourne
receipts 		|Array           | array of [Receipt Object](#receipt-object)

#### Objet Reçu
Name             |Type       |Description
----                |--         |--
func_name 			|String          | function name
content 			|String 		 | content

### Exemple
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
obtient le reçu de transaction depuis le hash de transaction

### Paramètres
Name             |Type       |Description
----                |--         |--
hash 		|String          | base58 encode txHas

### Retourne
Retourne [Objet TxReceipt](#txreceipt-object)

### Exemple
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
	"Retourne": [
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
envoie la transaction sur la blockchain IOST
