---
id: Blockchain-class
title: Blockchain
sidebar_label: Blockchain
---

This is the main class that interact with IOST blockchain and IOST smart contracts to get informations from them.

## constructor
constructor method is a special method for creating and initializing Blockchain class.
<b>DO NOT</b> need to initialize by user, user will use Blockchain class by rpc.blockchain。

## getChainInfo
get chain info from blockchain

### Returns
Promise returns chainInfo object.
Name             |Type       |Description 
----                |--         |--
net_name 			|String          | the name of network, such mainnet or testnet
protocol_version 	|String 		 | the iost protocol version
head_block	 		|Number			 | head block height
head_block_hash		|String			 | head block hash
lib_block	 		|Number			 | last irreversible block number
lib_block_hash	 	|String			 | last irreversible block hash
witness_list	 	|Array			 | the current witness list

### Example
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
get block info from blockchain by hash

### Parameters
Name             |Type       |Description 
----                |--         |--
hash 		|String          | the hash of the block
complete 	|Boolean 		 | complete means whether including the full transactions and transaction receipts

### Returns
Promise returns block object.
Name             |Type       |Description 
----                |--         |--
status 		|String          | transaction status
block 	|Object 		 | [Block Object](#block-object)

#### Block Object
Name             |Type       |Description 
----                |--         |--
hash 					|String          | block hash
version 				|Number 		 | block version
parent_hash 			|String          | parent block hash
tx_merkle_hash 			|String          | transaction merkle tree root hash
tx_receipt_merkle_hash  |String          | transaction receipt merkle tree root hash
number 					|String          | block number
witness 				|String          | block producer witness
time 					|String          | block timestamp
gas_usage 				|String          | block gas usage
tx_count 				|String          | transaction count
transactions			|Array			 | array of [Transaction Object](Transaction-class#transaction-object)
info 					|Object          | [Info Object](#info-object)

#### AmountLimit Object
Name             |Type       |Description 
----                |--         |--
token 			|String          | token name
value 			|Number 		 | limit value

#### Info Object
Name             |Type       |Description 
----                |--         |--
mode 					|Number          | pack mode
thread 				|Number 		 | transaction execution thread number
batch_index 			|Array          | transaction index of every batch execution

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
get block info from blockchain by num

### Parameters
Name             |Type       |Description 
----                |--         |--
num 		|Number          | the number of the block
complete 	|Boolean 		 | complete means whether including the full transactions and transaction receipts

### Returns
Promise returns block object. check [getBlockByHash](#getBlockByHash)

## getBalance
get account balance

### Parameters
Name             |Type       |Description 
----                |--         |--
name 		|String          | account name
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns balance object.

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getBalance('myaccount', true).then(console.log);

/*{
	balance: 12000,
	frozen_balances: null
}*/
```

## getToken721Balance
get account token721 balance

### Parameters
Name             |Type       |Description 
----                |--         |--
name 		|String          | account name
tokenSymbol |String 		 | token721 symbol
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns balance object.

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Balance('myaccount', 'my721Token', true).then(console.log);

/*{
	balance: 12000,
	tokenIDs: null
}*/
```

## getToken721Metadata
get token721 metadata

### Parameters
Name             |Type       |Description 
----                |--         |--
token 		|String          | token name
token_id |String 		 | token id
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns metadata object.
Name             |Type       |Description 
----                |--         |--
metadata 		|String          | metadata

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Metadata('symbol', 'id', true).then(console.log);

/*{
	metadata: ''
}*/
```

## getToken721Owner
get token721 owner

### Parameters
Name             |Type       |Description 
----                |--         |--
token 		|String          | token name
token_id |String 		 | token id
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns owner object.
Name             |Type       |Description 
----                |--         |--
owner 		|String          | metadata

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Owner('symbol', 'id', true).then(console.log);

/*{
	owner: 'theowner'
}*/
```

## getContract
get contract from blockchain

### Parameters
Name             |Type       |Description 
----                |--         |--
id 		|String          | contract id
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns contract object.
Name             |Type       |Description 
----                |--         |--
id 			|String          | contract id
code 		|String 		 | contract code
language 	|String 		 | contract language
version 	|String 		 | contract version
abis | Array | array of [ABI Object](#abi-object)

#### ABI Object
Name             |Type       |Description 
----                |--         |--
name 			|String          | contract id
args 		|Array 		 | abi arguments
amount_limit 	|Array 		 | array of [AmountLimit Object](#amountlimit-object)

## getContractStorage
get contract storage from blockchain

### Parameters
Name             |Type       |Description 
----                |--         |--
id 		|String          | contract id
key |String 		 | the key in the StateDB
field 	|String 		 | get the value from StateDB, field is needed if StateDB[key] is a map.(we get StateDB[key][field] in this case)
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns contract result object.
Name             |Type       |Description 
----                |--         |--
data 		|String          | data

## getAccountInfo
get account info from blockchain

### Parameters
Name             |Type       |Description 
----                |--         |--
name 		|String          | account name
by_longest_chain 	|Boolean 		 | get account by longest chain's head block or last irreversible block

### Returns
Promise returns account object.
Name             |Type       |Description 
----                |--         |--
name 		|String          | account name
balance 		|Number          | account balance
gas_info 		|Object          | [GasInfo Object](#gasinfo-object)
ram_info 		|Object          | [RAMInfo Object](#raminfo-object)
permissions 		|Map          | map<String, [Permission Object](#permission-object)>
groups | Map | map<String, [Group Object](#group-object)>
frozen_balances | Array | array of [FrozenBalance Object](#frozenbalance-object)

#### GasInfo Object
Name             |Type       |Description 
----                |--         |--
current_total 		|Number          | current total gas amount
transferable_gas 		|Number          | current transferable gas
pledge_gas 		|Number          | current pledge gas
increase_speed 		|Number          | gas increase speed
limit 		|Number          | account name
pledged_info | Array | array of [PledgeInfo Object](#pledgeinfo-object)

#### PledgeInfo Object
Name             |Type       |Description 
----                |--         |--
pledger 		|String          | the account who pledges
amount 		|Number          | pledged amount

#### RAMInfo Object
Name             |Type       |Description 
----                |--         |--
available 		|Number          | available ram bytes

#### Permission Object
Name             |Type       |Description 
----                |--         |--
name 		|String          | permission name
groups 		|Array          | array of permission groups
items 		|Array          | array of [Item Object](#item-object)
threshold 		|Number          | permission threshold

#### Item Object
Name             |Type       |Description 
----                |--         |--
id 		|String          | permission name or key pair id
is_key_pair 		|Boolen          | whether it's a key pair
weight 		|Number          | permission weight 
permission 		|String          | permission

#### Group Object
Name             |Type       |Description 
----                |--         |--
name 		|String          | group name
items 		|Array          | array of [Item Object](#item-object)

#### FrozenBalance Object
Name             |Type       |Description 
----                |--         |--
amount 		|Number          | balance amount
time 		|Number          | free time

### Example
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