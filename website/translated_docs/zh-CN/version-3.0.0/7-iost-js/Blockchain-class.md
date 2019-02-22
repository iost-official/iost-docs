---
id: Blockchain-class
title: Blockchain
sidebar_label: Blockchain
---

Blockchain类负责与IOST区块链和IOST智能合约交互以从中获取信息。

## constructor
构造函数
<b>不要</b>新建这个类的实例，只需使用rpc.Blockchain。

## getChainInfo
从区块链获取链信息

### Returns
Promise返回chainInfo对象。
名称 | 类型 | 描述
---- |  -  |  - 
net_name | String | 网络的名称，例如mainnet或testnet
protocol_version | String | iost协议版本
head_block | Number | 头部高度
head_block_hash | String | 头块哈希
lib_block | Number | 最后一个不可逆的区号
lib_block_hash | String | 最后一个不可逆的块哈希
witness_list | Array | 目前的witness列表

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
通过哈希从区块链获取块信息

### Parameters
名称 | 类型 | 描述
---- |  -  |  - 
hash | String | 块的哈希值
complete | Boolean | 是否包括完整交易和交易收据

### Returns
Promise返回块对象。
名称 | 类型 | 描述
---- |  -  |  - 
status | String |交易状态
block | Object | [Block Object]（＃block-object）

#### Block Object
名称 | 类型 | 描述
---- |  -  |  - 
hash | String | 块哈希
version | Number | 块版本
parent_hash | String | 父块哈希
tx_merkle_hash | String | 事务merkle树根哈希
tx_receipt_merkle_hash | String | 交易收据merkle树根哈希
number | String | 区号
witness | String | 当前block的witness列表
time | String | block时间
gas_usage | String | block的gas使用量
tx_count | String | 交易数量
transactions | Array | [Transaction Object]数组（7-iost-js / Transaction-class.md＃transaction-object）
info | Object | [Info Object]（＃info-object）

#### AmountLimit Object
名称 | 类型 | 描述
---- |  -  |  - 
token | String | token名称
value | Number | 限制值
 
#### Info Object
名称 | 类型 | 描述
---- |  -  |  - 
mode | Number | 包模式
thread | Number | 事务执行线程号
batch_index | Array | 每批执行的事务索引

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
通过块高度从块链获取块信息

### Parameters
名称 | 类型 | 描述
---- |  -  |  - 
num |  Number  | 块的高度
complete |  Boolean  | 是否包括完整交易和交易收据

### Returns
Promise返回块对象。 check [getBlockByHash]（＃getBlockByHash）

## getBalance
获得帐户余额

###参数
名称 | 类型 | 描述
---- |  -  |  - 
name | String | 用户名
by_longest_chain | Boolean | 通过最长链的头部块或最后一个不可逆块来获取帐户

### Returns
Promise返回余额对象。

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
获得帐户token721余额

###参数
名称 | 类型 | 描述
---- |  -  |  - 
name | String | 用户名
tokenSymbol | String | token721的名字
by_longest_chain | Boolean | 通过最长链的头部块而非最新不可逆块来获取

### Returns
Pormise返回余额对象。

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
获取token721元数据

###参数
名称 | 类型 | 描述
---- |  -  |  - 
token | String | token名称
token_id | String | token ID
by_longest_chain | Boolean | 通过最长链的头部块而非最新不可逆块来获取

### Returns
Promise返回元数据对象。
名称 | 类型 | 描述
---- |  -  |  - 
metadata |  String  | 元数据

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Metadata('symbol', 'id', true).then(console.log);

/*{
	metadata: ''
}*/
```

## getToken721Owner
得到token721所有者

###参数
名称 | 类型 | 描述
---- |  -  |  - 
token | String |token名称
token_id | String |tokenID
by_longest_chain | Boolean |通过最长链的头部块或最后一个不可逆块来获取帐户

### Returns
Promise返回所有者对象。
名称 | 类型 | 描述
---- |  -  |  - 
owner | String |元数据

### Example
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Owner('symbol', 'id', true).then(console.log);

/*{
	owner: 'theowner'
}*/
```

## getContract
从区块链获得合同

###参数
名称 | 类型 | 描述
---- |  -  |  - 
id | String |合同ID
by_longest_chain | Boolean |通过最长链的头部块或最后一个不可逆块来获取帐户

### Returns
Promise返回合同对象。
名称 | 类型 | 描述
---- |  -  |  - 
id | String |合同ID
code | String |合同代码
language | String |合同语言
version | String |合同版
abis | Array | [ABI对象]的数组（#abi-object）

#### ABI对象
名称 | 类型 | 描述
---- |  -  |  - 
name | String |合同ID
args | Array | abi论点
amount_limit | Array | [AmountLimit对象]的数组（＃amountlimit-object）

## getContractStorage
从区块链获得合同存储

###参数
名称 | 类型 | 描述
---- |  -  |  - 
id | String |合同ID
key | String | StateDB中的关键
field | String |从StateDB获取值，如果StateDB [key]是一个map，则需要该字段。（在这种情况下我们得到StateDB [key] [field]）
by_longest_chain | Boolean | 通过最长链的头部块或最后一个不可逆块来获取帐户

### Returns
Promise返回合同结果对象。
名称 | 类型 | 描述
---- |  -  |  - 
data | String |数据


## getAccountInfo
从区块链获取帐户信息

###参数
名称 | 类型 | 描述
---- |  -  |  - 
name | String |用户名
by_longest_chain | Boolean | 通过最长链的头部块或最后一个不可逆块来获取帐户

### Returns
Promise返回帐户对象。
名称 | 类型 | 描述
---- |  -  |  - 
name | String |用户名
balance | Number |账户余额
gas_info |对象| [GasInfo对象]（＃gasinfo-object）
ram_info |对象| [RAMInfo对象]（＃raminfo-object）
permissions |地图| map <String，[Permission Object]（＃permission-object）>
groups |地图| map <String，[Group Object]（#group-object）>
frozen_balances | Array | [FrozenBalance Object]的数组（＃frozenbalance-object）

#### GasInfo对象
名称 | 类型 | 描述
---- |  -  |  - 
current_total | Number | 目前的总气量
transferable_gas | Number | 目前可转移的天然气
pledge_gas | Number | 目前的质押气
increase_speed | Number | 天然气增加速度
limit | Number | 用户名
pledged_info | Array | [PledgeInfo对象]的数组（#pledgeinfo-object）


#### PledgeInfo对象
名称 | 类型 | 描述
---- |  -  |  - 
pledger | String | 质押的帐户
balance |  Number  | 质押金额

#### RAMInfo对象
名称 | 类型 | 描述
---- |  -  |  - 
available | Number | 可用的ram字节

#### Permission Object
名称 | 类型 | 描述
---- |  -  |  - 
name | String | 许可名称
groups | Array | 权限组的数组
items | Array | [Item Object]数组（＃item-object）
threshold | Number | 许可阈值

#### Item Object
名称 | 类型 | 描述
---- |  -  |  - 
id | String | 权限名称或密钥对ID
is_key_pair | Boolen | 是否是一对钥匙
weight | Number | 许可权重
permission | String | 权限

#### Group Object
名称 | 类型 | 描述
---- |  -  |  - 
name | String | group名字
items | Array | [Item Object]数组（＃item-object）

#### FrozenBalance Object
名称 | 类型 | 描述
---- |  -  |  - 
amount | Number | 余额
time | Number | 空闲时间


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
