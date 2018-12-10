---
id: API
title: API
sidebar_label: API
---

## /getNodeInfo
---

##### **GET**
**概要:** 获得节点的信息

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getNodeInfo
```

### 响应格式

一个成功响应的例子

```
200 OK

{
	"build_time": "20181208_161822+0800",
	"git_hash": "1f540ec5b619812cb01b7bbc3dd89dbd3849c6fb",
	"mode": "ModeNormal",
	"network": {
		"id": "12D3KooWGGauAVW7vQw33kAAttbyTVf81Urpi2f4LYBAXTYzhwqj",
		"peer_count": 1,
		"peer_info": [{
			"id": "12D3KooWPSPLPyDFtcbKUvQGWM7pCXWEhRAjA1A5nAAFEvnce1Dm",
			"addr": "/ip4/127.0.0.1/tcp/50004"
		}]
	}
}
```

| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| build_time |string  | 构建可执行程序的时间 |
| git_hash |string  | 版本的git hash |
| mode |string  | 节点运行模式， ModeNormal - 正常模式，ModeSync - 同步块模式，ModeInit - 初始化模式 |
| network |[NetworkInfo](#NetworkInfo) network  | 网络连接信息 |

### NetworkInfo
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| id |string  | 本节点的ID |
| peer_count |int32  | 邻居节点的数量 |
| peer_info |repeated [PeerInfo](#PeerInfo)  | 邻居节点的信息 |

### PeerInfo
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| id | string  | 邻居节点的ID |
| addr |struct  | 邻居节点的地址 |


## /getChainInfo
---

##### **GET**
**概要:** 获得区块链的信息

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getChainInfo
```

### 响应格式

一个成功响应的例子

```
200 OK

{
	"net_name": "debugnet",
	"protocol_version": "1.0",
	"head_block": "16041",
	"head_block_hash": "DLJVtko6nQnAdvQ7y6dXHo3WMdG324yRLz8tPKk9tGHu",
	"lib_block": "16028",
	"lib_block_hash": "8apn7vCvQ6s9PFBzGfaXrvyL5eAaLNc4mEAgnTMoW8tC",
	"witness_list": ["IOST2K9GKzVazBRLPTkZSCMcyMayKv7dWgdHD8uuWPzjfPdzj93x6J", "IOST2YKPmRDGy5xLR7Gv65CN5nQ3vMmVhRjAsEM7Gj9xcB1LWgZUAd", "IOST7E4T5rG9wjPZXDeM1zjhhWU3ZswtPQ1heeRUFUxntr65sYRBi"]
}
```

| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| net_name |string  | 网络名字，例如mainnet或testnet|
| protocol_version |string  | iost协议版本 |
| head_block |int64  | 最新块的块号 |
| head\_block\_hash | string  | 最新块的hash |
| lib_block |int64  | 不可逆块的高度 |
| lib\_block\_hash | string  | 不可逆块的hash |
| witness_list |repeated string  | 造块节点的pubkey列表 |


## /getTxByHash/{hash}
---

##### **GET**
**概要:** 通过交易hash获取交易数据

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getTxByHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| hash | string  | 交易的hash|

### 响应格式

一个成功响应的例子

```
200 OK

{
	"status": "IRREVERSIBLE",
	"transaction": {
		"hash": "6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR",
		"time": "1544269519362042000",
		"expiration": "1544279519362041000",
		"gas_ratio": 1,
		"gas_limit": 50000,
		"delay": "0",
		"actions": [{
			"contract": "ContractTBv8ZDKUhTyeS4MomdcHRrXnJMELa5usSMHP6QJntFQ",
			"action_name": "transfer",
			"data": "[\"admin\",\"i1544269477\",1]"
		}],
		"signers": [],
		"publisher": "admin",
		"referred_tx": "",
		"amount_limit": [],
		"tx_receipt": null
	}
}
```

| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| status |enum  | PENDING-交易在缓存中, PACKED - 交易在非不可逆块中，IRREVERSIBLE - 交易在不可逆的块中|
| transaction |[Transaction](#Transaction) transaction   | 交易数据 |

### Transaction
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| hash |string  | 交易的hash |
| time |int64  | 交易的时间戳 |
| expiration | int64  | 交易的过期时间 |
| gas_ratio |double  | Gas费率，建议设置成1(1.00 ~ 100.00)，可以通过提高费率来让交易更容易被打包 |
| gas_limit | double  | Gas上限,执行交易所消耗的Gas不会超过这个上限 |
| delay | int64  | 延迟时间，交易会在延迟时间之后被执行，单位纳秒 |
| actions |repeated [Action](#Action)  | 交易的最小执行单元 |
| signers |repeated string  | 交易的签名列表 |
| publisher |string  | 交易提交者,承担交易的执行费用 |
| referred_tx |string  | 交易生成依赖，用于延迟交易 |
| amount_limit |repeated [AmountLimit](#AmountLimit)  | 用户可以设置的花费token的限制, 如 {"iost": 100} 即本次交易对于每个签名者花费iost不超过100 |
| tx_receipt |[TxReceipt](#TxReceipt) tx_receipt  | 交易Action的receipt |

### Action
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| contract | string  | 被调用的合约名字 |
| action_name |string  | 被调用的Action名字 |
| data |string  | 入参数据 |

### AmountLimit
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| token | string  | token名字 |
| value |double  | 限制的值 |

### TxReceipt
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| tx_hash | string| 交易的hash|
| gas_usage |double| 交易执行的Gas消耗 |
| ram_usage |map<string, int64>| 交易的RAM消耗，map-key - 账户名，map-value - 使用RAM量 |
| status_code | enum  | 交易执行状态，SUCCESS - 成功，GAS_RUN_OUT - Gas不足，BALANCE_NOT_ENOUGH - 余额不足，WRONG_PARAMETER - 错误参数， RUNTIME_ERROR - 运行时错误， TIMEOUT - 超时， WRONG_TX_FORMAT - 交易格式错误， DUPLICATE_SET_CODE - 重复设置set code, UNKNOWN_ERROR - 未知错误 |
| message| string |status_code的详细描述信息|
| returns | repeated string| 每个Action的返回值 |
| receipts | repeated [Receipt](#Receipt)  | event功能使用 |

### Receipt
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| func_name | string  | abi函数的名字 |
| content | string  | 内容 |



## /getTxReceiptByTxHash/{hash}
---

##### ***GET***
**概要:** 通过交易hash获取交易receipt数据

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getTxReceiptByTxHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| hash | string  | receipt的hash|

### 响应格式

一个成功响应的例子

```
200 OK

{
	"tx_hash": "6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR",
	"gas_usage": 6633,
	"ram_usage": {
		"admin": "0",
		"issue.iost": "0"
	},
	"status_code": "SUCCESS",
	"message": "",
	"returns": ["[\"\"]"],
	"receipts": [{
		"func_name": "token.iost/transfer",
		"content": "[\"iost\",\"admin\",\"i1544269477\",\"1\",\"\"]"
	}]
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| | [TxReceipt](#TxReceipt)  | 交易的receipt|


## /getBlockByHash/{hash}/{complete}
---


##### **GET**
**概要:** 通过block hash获取block的数据

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getBlockByHash/4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY/false
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| hash | string  | block hash|
| complete | bool  | true - 显示block中的交易， false - 不显示block中交易详情|

### 响应格式

一个成功响应的例子

```
200 OK

{
	"status": "IRREVERSIBLE",
	"block": {
		"hash": "4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY",
		"version": "0",
		"parent_hash": "G4njPLnYskU4DcuTz5CwpLPETcfH6yN78V8emge8t21f",
		"tx_merkle_hash": "HHKAG2D7Kon2on5SqV66ZsfdNk9Wus8yhWqdTb86wgPJ",
		"tx_receipt_merkle_hash": "FXr8Mf7hr568MP23BFWJiBUej2xSj3M7416WAKJpswzx",
		"number": "2",
		"witness": "IOST2YKPmRDGy5xLR7Gv65CN5nQ3vMmVhRjAsEM7Gj9xcB1LWgZUAd",
		"time": "1544262978309033000",
		"gas_usage": 0,
		"tx_count": "1",
		"info": null,
		"transactions": []
	}
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| status | enum  | PENDIND - block在缓存中，IRREVERSIBLE - block不可逆|
| block |[Block](#Block) block   | block结构体 |

### Block
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| hash | string   | block hash |
| version | int64  | bock版本号 |
| parent_hash |string  | block父块的hash |
| tx\_merkle_hash | string  | 所有交易的merkle tree hash |
| tx\_receipt\_merkle_hash | string  | 所有receipt的merkle tree hash |
| number | int64  | block号 |
| witness | string  | block生产者的pubkey |
| time | int64  | block生产时间 |
| gas_usage | double  | block中交易消耗的总Gas |
| tx_count | int64  | block中交易总数 |
| info | [Info](#info) info  | 保留字段 |
| transactions | repeated [Transaction](#Transaction) | 交易字段 |

### Info

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| mode | int32  | 并发的模式，0 - 不并发， 1 - 并发 |
| thread |int32   | 交易并发执行的线程数量 |
| batch_index | repeated int32   | 交易的索引 |

## /getBlockByNumber/{number}/{complete}
---


##### **GET**
**概要:** 通过block号获取block的数据

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getBlockByNumber/3/false
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| number | int64  | block号|
| complete | bool  | true - 显示block中的交易， false - 不显示block中交易详情|

### 响应格式

一个成功响应的例子

```
200 OK

{
	"status": "IRREVERSIBLE",
	"block": {
		"hash": "HPZyoPQ44vsyLDRspjgrySyHnpuiGwckPx8uNtHZugJW",
		"version": "0",
		"parent_hash": "4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY",
		"tx_merkle_hash": "HHKAG2D7Kon2on5SqV66ZsfdNk9Wus8yhWqdTb86wgPJ",
		"tx_receipt_merkle_hash": "62pESNUGDVsH4B1BCymJvmjGxPu5bb4R3u4x45K9Ybdq",
		"number": "3",
		"witness": "IOST2YKPmRDGy5xLR7Gv65CN5nQ3vMmVhRjAsEM7Gj9xcB1LWgZUAd",
		"time": "1544262978609003000",
		"gas_usage": 0,
		"tx_count": "1",
		"info": null,
		"transactions": []
	}
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| status | enum  | PENDIND - block在缓存中，IRREVERSIBLE - block不可逆|
| block |[Block](#Block) block   | block结构体 |

## /getAccount/{name}/{by\_longest\_chain}
---


##### **GET**
**概要:** 获取账号信息

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getAccount/admin/true
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| name | string  | block 的号|
| by\_longest\_chain | bool  | true - 从最长链得到数据，false - 从不可逆块得到数据|

### 响应格式

一个成功响应的例子

```
200 OK

{
	"name": "admin",
	"balance": 982678652,
	"create_time": "0",
	"gas_info": {
		"current_total": 53102598634,
		"transferable_gas": 60000,
		"pledge_gas": 53102538634,
		"increase_speed": 330011,
		"limit": 90003000000,
		"pledged_info": [{
			"pledger": "admin",
			"amount": 3000100
		}]
	},
	"ram_info": {
		"available": "99000"
	},
	"permissions": {
		"active": {
			"name": "active",
			"groups": [],
			"items": [{
				"id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
				"is_key_pair": true,
				"weight": "1",
				"permission": ""
			}],
			"threshold": "1"
		},
		"owner": {
			"name": "owner",
			"groups": [],
			"items": [{
				"id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
				"is_key_pair": true,
				"weight": "1",
				"permission": ""
			}],
			"threshold": "1"
		}
	},
	"groups": {},
	"frozen_balances": []
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string  | 账户名字|
| balance |double   | 余额 |
| create_time |int64   | 账号创建时间 |
| gas_info |[GasInfo](#GasInfo) gas_info   | Gas信息 |
| ram_info |[RAMInfo](#RAMInfo)   | Ram信息 |
| permissions |map<string, [Permission](#Permission)>   | 权限 |
| groups |map<string, [Group](#Group)>   | 权限组 |
| frozen_balances |repeated [FrozenBalance](#FrozenBalance)   | 冻结余额信息 |

### GasInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| current_total | double  | 当前Gas总量|
| transferable_gas |double   | 可以流通的Gas量 |
| pledge_gas |double   | 质押获得的Gas |
| increase_speed |double   | 每秒增加的Gas |
| limit |double   | 质押Token获得的Gas上限 |
| pledged_info |repeated [PledgeInfo](#PledgeInfo)   | 其他账号帮本账号质押的信息 |

### PledgeInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| pledger | string  | 质押的账号|
| amount |double   | 质押金额 |

### RAMInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| available | int64  | 可用的RAM bytes|

### Permission
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string  | 	权限名字|
| groups | repeated string   | 权限组|
| items | repeated [Item](#Item)   | 权限信息|
| threshold | int64  | 权限阈值|

### Item
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| id | string   | 权限名字或者key pair id|
| is\_key\_pair | bool   | true - id是key pair, false - id为权限名字|
| weight | int64   | 权限权重|
| permission | string   | 权限|

### Group
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string   | 组名字|
| items | repeated [Item](#Item)   | 权限组信息|

### FrozenBalance
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| amount | double   | 金额|
| time | int64   | 解冻时间|

## /getTokenBalance/{account}/{token}/{by\_longest\_chain}
---


##### **GET**
**概要:** 获取账号指定代币的余额

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getTokenBalance/admin/iost/true
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| account | string  | 账号名|
| token | string  | 代币名字|
| by\_longest\_chain | bool  | true - 从最长链得到数据，false - 从不可逆块得到数据|

### 响应格式

一个成功响应的例子

```
200 OK

{
	"balance": 982678652,
	"frozen_balances": []
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| balance | double  | 余额|
| frozen_balances |repeated [FrozenBalance](#FrozenBalance)   | 冻结信息 |

## /getContract/{id}
---

##### **GET**
**概要:** 通过合约ID获取合约数据

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getContract/base.iost
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| id | string  | 合约的ID |

### 响应格式

一个成功响应的例子

```
200 OK

{
	"id": "base.iost",
	"code": "const producerPermission = 'active';\nconst voteStatInterval = 200;\nclass Base {\n    constructor() {\n    }\n    init() {\n        _IOSTInstruction_counter.incr(12);this._put('execBlockNumber', 0);\n    }\n    InitAdmin(adminID) {\n        _IOSTInstruction_counter.incr(4);const bn = block.number;\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(bn, 0, '!==')) {\n            _IOSTInstruction_counter.incr(14);throw new Error('init out of genesis block');\n        }\n        _IOSTInstruction_counter.incr(12);this._put('adminID', adminID);\n    }\n    can_update(data) {\n        _IOSTInstruction_counter.incr(12);const admin = this._get('adminID');\n        _IOSTInstruction_counter.incr(12);this._requireAuth(admin, producerPermission);\n        return true;\n    }\n    _requireAuth(account, permission) {\n        _IOSTInstruction_counter.incr(12);const ret = BlockChain.requireAuth(account, permission);\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(ret, true, '!==')) {\n            _IOSTInstruction_counter.incr(22);throw new Error(_IOSTBinaryOp('require auth failed. ret = ', ret, '+'));\n        }\n    }\n    _get(k) {\n        _IOSTInstruction_counter.incr(12);const val = storage.get(k);\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(val, '', '===')) {\n            return null;\n        }\n        _IOSTInstruction_counter.incr(12);return JSON.parse(val);\n    }\n    _put(k, v) {\n        _IOSTInstruction_counter.incr(24);storage.put(k, JSON.stringify(v));\n    }\n    _vote() {\n        _IOSTInstruction_counter.incr(12);BlockChain.callWithAuth('vote_producer.iost', 'Stat', `[]`);\n    }\n    _bonus(data) {\n        _IOSTInstruction_counter.incr(24);BlockChain.callWithAuth('bonus.iost', 'IssueContribute', JSON.stringify([data]));\n    }\n    _saveBlockInfo() {\n        _IOSTInstruction_counter.incr(12);let json = storage.get('current_block_info');\n        _IOSTInstruction_counter.incr(36);storage.put(_IOSTBinaryOp('chain_info_', block.parentHash, '+'), JSON.stringify(json));\n        _IOSTInstruction_counter.incr(24);storage.put('current_block_info', JSON.stringify(block));\n    }\n    Exec(data) {\n        _IOSTInstruction_counter.incr(12);this._saveBlockInfo();\n        _IOSTInstruction_counter.incr(4);const bn = block.number;\n        _IOSTInstruction_counter.incr(12);const execBlockNumber = this._get('execBlockNumber');\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(bn, execBlockNumber, '===')) {\n            return true;\n        }\n        _IOSTInstruction_counter.incr(12);this._put('execBlockNumber', bn);\n        if (_IOSTInstruction_counter.incr(16),_IOSTBinaryOp(_IOSTBinaryOp(bn, voteStatInterval, '%'), 0, '===')) {\n            _IOSTInstruction_counter.incr(12);this._vote();\n        }\n        _IOSTInstruction_counter.incr(12);this._bonus(data);\n    }\n}\n_IOSTInstruction_counter.incr(7);module.exports = Base;",
	"language": "javascript",
	"version": "1.0.0",
	"abis": [{
		"name": "Exec",
		"args": ["json"],
		"amount_limit": []
	}, {
		"name": "can_update",
		"args": ["string"],
		"amount_limit": []
	}, {
		"name": "InitAdmin",
		"args": ["string"],
		"amount_limit": []
	}, {
		"name": "init",
		"args": [],
		"amount_limit": []
	}]
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| id | string  | 合约的id|
| code | string  | 合约的代码|
| language | string  | 合约语言|
| version | string  | 合约版本|
| abis | repeated [ABI](#ABI)  | 合约的abis|

### ABI
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string  | 接口的名字|
| args | repeated string  | 接口的参数|
| amount_limit | repeated [AmountLimit](#AmountLimit)  | 金额限制|


## /getContractStorage
---


##### **POST**
**概要:** 本地获取合约的存储数据

### 请求格式

一个请求格式的例子

```
curl -X POST http://127.0.0.1:30001/getContractStorage -d '{"id":"vote_producer.iost","field":"producer00001","key":"producerTable","by_longest_chain":true}'
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| id |string  | 智能合约的ID |
| field |string  | 从StateDB中得到值，如果StateDB[key]是一个map,那么需要设置field(可以得到StateDB[key][field]的值) |
| key |struct  | StateDB的key |
| by\_longest\_chain |bool  | true - 从最长链得到数据，false - 从不可逆块得到数据 |


### 响应格式

一个成功响应的例子

```
200 OK
{"data":"
	{
		"pubkey": "IOST2K9GKzVazBRLPTkZSCMcyMayKv7dWgdHD8uuWPzjfPdzj93x6J",
		"loc": "",
		"url": "",
		"netId": "",
		"online": true,
		"registerFee": "200000000"
	}
"}
```

## /SendTransaction
---

##### **POST**
**概要:**    
把交易发到节点上。   
节点收到这个交易后，首先会做基本检查，如果不通过则返回错误，如果通过，则将本交易加入交易池中，并且返回交易的 Hash。   
用户在一段时间之后，可以使用这个收到的 Hash 通过 getTxReceiptByTxHash 接口来查询本交易的状态，查看是否执行成功。   
**注意:**   
由于交易中需要做签名，因此交易一般无法通过 curl 来手动发送。因此在此不提供基于 curl 的例子。 也不建议直接调用本 RPC 接口。    
普通用户可以使用 [命令行工具](https://docs.qq.com/doc/DSW1BR2ZScW1sZmxt) 发送交易。  
开发者可以使用 [Javascript SDK](https://github.com/iost-official/iost.js) 中的函数接口发送交易。

### 请求格式
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |


## /getContractStorage
---


##### **POST**
**概要:** 本地获取合约的存储数据

### 请求格式

一个请求格式的例子

```
curl -X POST http://127.0.0.1:30001/getContractStorage -d '{"id":"vote_producer.iost","field":"producer00001","key":"producerTable","by_longest_chain":true}'
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| id |string  | 智能合约的ID |
| field |string  | 从StateDB中得到值，如果StateDB[key]是一个map,那么需要设置field(可以得到StateDB[key][field]的值) |
| key |struct  | StateDB的key |
| by\_longest\_chain |bool  | true - 从最长链得到数据，false - 从不可逆块得到数据 |


### 响应格式

一个成功响应的例子

```
200 OK
{"data":"
	{
		"pubkey": "IOST2K9GKzVazBRLPTkZSCMcyMayKv7dWgdHD8uuWPzjfPdzj93x6J",
		"loc": "",
		"url": "",
		"netId": "",
		"online": true,
		"registerFee": "200000000"
	}
"}
```




