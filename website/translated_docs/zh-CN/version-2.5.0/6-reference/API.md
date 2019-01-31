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
| network |[NetworkInfo](#networkinfo) network  | 网络连接信息 |

### NetworkInfo
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| id |string  | 本节点的ID |
| peer_count |int32  | 邻居节点的数量 |
| peer_info |repeated [PeerInfo](#peerinfo)  | 邻居节点的信息 |

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
	"chain_id": 1024,
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
| chain_id | uint32  | 网络 ID |
| head_block |int64  | 最新块的块号 |
| head\_block\_hash | string  | 最新块的hash |
| lib_block |int64  | 不可逆块的高度 |
| lib\_block\_hash | string  | 不可逆块的hash |
| witness_list |repeated string  | 造块节点的pubkey列表 |

## /getGasRatio
---
##### **GET**
**概要:** 获取当前上链交易的 gas 倍率信息，方便用户合理设置自己交易的 gas 倍率。  
建议使用比 lowest\_gas\_ratio 稍高的 gas ratio 值，来保证交易尽快上链。
### 请求格式
一个请求格式的例子

```
curl http://127.0.0.1:30001/getGasRatio
```
### 响应格式


一个成功响应的例子

```
200 OK

{
    "lowest_gas_ratio": 1.5,
    "median_gas_ratio": 1.76
}
```

| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| lowest_gas_ratio | double  | 最新的 block 中的打包成功的所有合约的最低 gas ratio|
| median_gas_ratio | double  | 最新的 block 中的打包成功的所有合约的中位数 gas ratio|

## /getRAMInfo
---
##### **GET**
**概要:** 获取当前区块链的RAM信息，包括用量和价格。
### 请求格式
一个请求格式的例子

```
curl http://127.0.0.1:30001/getRAMInfo
```
### 响应格式


一个成功响应的例子

```
200 OK

{
    "available_ram": "96207067431",
    "buy_price": 0.04227129323234719,
    "sell_price": 0.00014551844642842057,
    "total_ram": "137438953472",
    "used_ram": "41231886041"
}
```

| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| available_ram | int64  | 可用 RAM 数量，以 byte 为单位|
| used_ram | int64  | 已经出售的 RAM 数量，以 byte 为单位|
| total_ram | int64 | 系统总计 RAM 数量，以 byte 为单位|
| buy_price | double | 此刻购买 RAM 的价格，以 IOST/byte 为单位，已经包含手续费 |
| sell_price | double | 此刻购买 RAM 的价格，以 IOST/byte 为单位| 

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
		"chain_id": 1024,
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
| transaction |[Transaction](#transaction) transaction   | 交易数据 |

### Transaction
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| hash |string  | 交易的hash |
| time |int64  | 交易的时间戳 |
| expiration | int64  | 交易的过期时间 |
| gas_ratio |double  | Gas费率，建议设置成1(1.00 ~ 100.00)，可以通过提高费率来让交易更容易被打包 |
| gas_limit | double  | Gas上限,执行交易所消耗的Gas不会超过这个上限 |
| delay | int64  | 延迟时间，交易会在延迟时间之后被执行，单位纳秒 |
| chain_id | uint32  | 网络 ID |
| actions |repeated [Action](#action)  | 交易的最小执行单元 |
| signers |repeated string  | 交易的签名列表 |
| publisher |string  | 交易提交者,承担交易的执行费用 |
| referred_tx |string  | 交易生成依赖，用于延迟交易 |
| amount_limit |repeated [AmountLimit](#amountlimit)  | 用户可以设置的花费token的限制, 如 {"iost": 100} 即本次交易对于每个签名者花费iost不超过100 |
| tx_receipt |[TxReceipt](#txreceipt) tx_receipt  | 交易Action的receipt |

### Action
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| contract | string | 调用的合约名字 |
| action_name | string | 调用的合约函数名 | 
| data | string | 调用的具体参数。把所有的参数生成 array 后再用 json 序列化，一般形如 '["a_string",13]' 


### AmountLimit
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| token | string | token 名字 |
| value | double | 这种 token 对应的限额 |

### TxReceipt
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| tx_hash | string| 交易的hash|
| gas_usage |double| 交易执行的Gas消耗 |
| ram_usage |map<string, int64>| 交易的RAM消耗，map-key - 账户名，map-value - 使用RAM量 |
| status_code | enum  | 交易执行状态，SUCCESS - 成功，GAS_RUN_OUT - Gas不足，BALANCE_NOT_ENOUGH - 余额不足，WRONG_PARAMETER - 错误参数， RUNTIME_ERROR - 运行时错误， TIMEOUT - 超时， WRONG_TX_FORMAT - 交易格式错误， DUPLICATE_SET_CODE - 重复设置set code, UNKNOWN_ERROR - 未知错误 |
| message| string |status_code的详细描述信息|
| returns | repeated string| 每个Action的返回值 |
| receipts | repeated [Receipt](#receipt)  | event功能使用 |

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
| | [TxReceipt](#txreceipt)  | 交易的receipt|


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
| block |[Block](#block) block   | block结构体 |

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
| transactions | repeated [Transaction](#transaction) | 交易字段 |

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
| block |[Block](#block) block   | block结构体 |

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
			"group_names": [],
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
			"group_names": [],
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
	"frozen_balances": [],
	"vote_infos": []
}
```

| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string  | 账户名字|
| balance |double   | 余额 |
| gas_info |[GasInfo](#gasinfo) gas_info   | Gas信息 |
| ram_info |[RAMInfo](#raminfo)   | Ram信息 |
| permissions |map<string, [Permission](#permission)>   | 权限 |
| groups |map<string, [Group](#group)>   | 权限组 |
| frozen_balances |repeated [FrozenBalance](#frozenbalance)   | 冻结余额信息 |
| vote_infos |repeated [VoteInfo](#voteinfo)   | 投票信息 |

### GasInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| current_total | double  | 当前Gas总量|
| transferable_gas |double   | 可以流通的Gas量 |
| pledge_gas |double   | 质押获得的Gas |
| increase_speed |double   | 每秒增加的Gas |
| limit |double   | 质押Token获得的Gas上限 |
| pledged_info |repeated [PledgeInfo](#pledgeinfo)   | 本账号帮其他账号质押的信息 |

### PledgeInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| pledger | string  | 接受本账号质押的账号|
| amount |double   | 本账号给 pledger 质押的金额 |

### RAMInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| available | int64  | 可用的RAM bytes|
| used | int64  | 已使用的RAM bytes|
| total | int64  | 总共RAM bytes|

### Permission
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string  | 	权限名字|
| group_names | repeated string   | 权限组名字|
| items | repeated [Item](#item)   | 权限信息|
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
| items | repeated [Item](#item)   | 权限组信息|

### FrozenBalance
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| amount | double   | 金额|
| time | int64   | 解冻时间|

### VoteInfo
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| option | string   | 候选人|
| votes | string   | 投票数|
| cleared_votes | string   | 被清零投票数|


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
| frozen_balances |repeated [FrozenBalance](#frozenbalance)   | 冻结信息 |

## /getContract/{id}/{by\_longest\_chain}
---

##### **GET**
**概要:** 通过合约ID获取合约数据

### 请求格式

一个请求格式的例子

```
curl http://127.0.0.1:30001/getContract/base.iost/true
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------: |
| id | string  | 合约的ID |
| by\_longest\_chain | bool  | true - 从最长链得到数据，false - 从不可逆块得到数据|

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
| abis | repeated [ABI](#abi)  | 合约的abis|

### ABI
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| name | string  | 接口的名字|
| args | repeated string  | 接口的参数|
| amount_limit | repeated [AmountLimit](#amountlimit)  | 金额限制|


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
| key |string  | StateDB的key |
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

## /getContractStorageFields
---


##### **POST**
**概要:** 获取合约存储中 map 的 key 列表，最多返回 256 条。

### 请求格式

一个请求格式的例子

```
curl -X POST http://127.0.0.1:30001/getContractStorageFields -d '{"id":"token.iost","key":"TIiost","by_longest_chain":true}'
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| id |string  | 智能合约的ID |
| key |struct  | StateDB的key |
| by\_longest\_chain |bool  | true - 从最长链得到数据，false - 从不可逆块得到数据 |

### 响应格式

一个成功响应的例子

```
200 OK
{
	"fields": ["issuer","totalSupply","supply","canTransfer","onlyIssuerCanTransfer","defaultRate","decimal","fullName"]
}
```



## /sendTx
---

##### **POST**
**概要:**    
把交易发到节点上。   
节点收到这个交易后，首先会做基本检查，如果不通过则返回错误，如果通过，则将本交易加入交易池中，并且返回交易的 Hash。   
用户在一段时间之后，可以使用这个收到的 Hash 通过 getTxByHash 或 getTxReceiptByTxHash 接口来查询本交易的状态，查看是否执行成功。   
**注意:**   
此接口需要先计算交易的哈希和签名，直接调用较为复杂。  
普通用户可以使用 [命令行工具](4-running-iost-node/iWallet.md) 发送交易。  
开发者可以使用 [Javascript SDK](https://github.com/iost-official/iost.js) 中的函数接口发送交易。

### 请求参数
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| time | int64 | 交易产生时间。UnixEpoch起始，单位纳秒 |
| expiration | int64 | 交易过期时间。UnixEpoch起始，单位纳秒。如果造块节点在过期时间之后才收到交易，则不会执行 |
| gas_ratio | double | GAS倍率。本交易按照默认GAS的 gas_ratio 倍来支付费用。倍率越高，越会被优先执行。合理的取值范围是 [1.0, 100.0] |
| gas_limit | double | 交易最大允许的GAS，最少设置为 50000 |
| delay | int64 | 延迟交易中使用。延迟执行的纳秒数。非延迟交易设为0 | 
| chain_id | uint32 | 网络 ID |
| actions | repeated [Action](#action) | 交易中的具体调用 | 
| amount_limit | repeated [AmountLimit](#amountlimit) | 交易的 token 限制。可以指定多种 token 和对应的数量限制。如果交易超过这些限制，则执行失败 | 
| publisher | string | 交易发送者的 ID | 
| publisher_sigs | repeated [Signature](#signature) | publisher 的签名，签名过程[如下](#交易签名)。publisher 可以提供多个签名，对应多种不同的权限。可以参考权限系统的文档 | 
| signers | repeated string | 除 publisher 之外的签名人 ID。可以为空 |
| signatures | repeated [Signature](#signature) | signers 的签名。每个 signer 可以有一个或多个签名，因此长度不低于 signers 长度 | 

### Signature
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| algorithm | string | 加密算法。目前仅支持 "ED25519" 和 "SECP256K1"|
| signature | string | 合约序列化后使用 sha3 做 hash，之后使用私钥做签名。Base64 编码。细节见对应文档 |
| public_key | string | 本签名使用的公钥。Base64 编码 | 
### 响应格式
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| hash | string | 交易的 hash | 
### 交易签名
交易的签名过程分为三步：将交易结构体转为字节数组；使用 sha3 算法对字节数组计算哈希；使用私钥对哈希进行签名。  

* **交易结构体转字节数组**

	交易结构体转字节数组算法为，将交易的每个字段按照声明顺序转成字节数组，然后在不定长类型（比如 string 和结构体）前加上长度，并拼接。各种字段类型转成字节数组的方式见下表：  
	
	| 字段类型 | 转换方法 | 示例 |
	| :----: | :-----: | :------ |
	| int | 按照**大端序**转成字节数组 | 如 int64(1023) 对应的字节数组为 [0 0 0 0 0 0 3 255] |
	| string | 将字符串中每个字符对应的字节进行拼接并在前面加上长度 | 如 "iost" 对应的字节数组为 [0 0 0 4 105 111 115 116] |
	| 数组 | 将数组的每个元素转为字节数组并拼接，再在其前面加上数组的长度  | 如 ["iost" "iost"] 对应的字节数组为 [0 0 0 2 0 0 0 4 105 111 115 116 0 0 0 4 105 111 115 116] |
	| map | 将字典的每对 key:value 分别转成字节数组并拼接, 然后按照 key 升序排列后拼接每一对，再在其前面加上 map 的长度 | 如 ["b":"iost", "a":"iost"] 对应的字节数组为 [0 0 0 2 0 0 0 1 97 0 0 0 4 105 111 115 116 0 0 0 1 98 0 0 0 4 105 111 115 116] |
	  
	交易字段声明顺序为 "time"、"expiration"、"gas\_ratio"、"gas\_limit"、
"delay"、"chain\_id"、"reserved"、"signers"、"actions"、"amount\_limit"、"signatures"，所以交易结构体转字节数组伪代码为：

	```
	func TxToBytes(t transaction) []byte {
		return Int64ToBytes(t.time) + Int64ToBytes(t. expiration) + 
	 		Int64ToBytes(int64(t.gas_ratio * 100)) + Int64ToBytes(int64(t.gas_limit * 100)) +     // 注意 gas_ratio 和 gas_limit 需要乘以 100 并转成 int64
 			Int64ToBytes(t.delay) + Int32ToBytes(t.chain_id) + 
 			BytesToBytes(t.reserved) + // reserved 为预留字段，只需要在序列化的时候写入空字节数组即可，RPC 请求参数不需要带上此字段
 			ArrayToBytes(t.signers) + ArrayToBytes(t.actions)  +
 			ArrayToBytes(t.amount_limit) + ArrayToBytes(t.signatures)
	}
	```

	golang 的实现可参考 [go-iost](https://github.com/iost-official/go-iost/blob/master/iwallet/sdk.go#L686)。 javascript 的实现可参考 [iost.js](https://github.com/iost-official/iost.js/blob/master/lib/structs.js#L73)。

* **使用 sha3 算法对字节数组计算哈希**

	需要利用各个语言对应的 sha3 库对上一步的结果计算哈希，得到哈希的字节数组。

* **使用私钥对哈希进行签名**

	iost 支持两种非对称加密算法："Ed25519" 和 "Secp256k1"。两种算法签名的过程一样：先生成公私钥对，然后使用私钥对上一步的哈希字节数组进行签名。  
	publisher\_sigs 签名的私钥必须跟交易字段中的 "publisher" 账户对应，signatures 签名的私钥必须跟交易字段中的 "signers" 账户对应。signatures 用于多重签名，不是必需的，但 publisher\_sigs 签名必须要有。交易执行花费的 gas 会从 publisher 账户扣除。
	
### 请求示例
假设账户 testaccount 要发送一笔交易，给 anothertest 账户转账 100 iost。

* **构建交易**

	```
	{
		"time": 1544709662543340000,
		"expiration": 1544709692318715000,
		"gas_ratio": 1,
		"gas_limit": 500000,
		"delay": 0,
		"chain_id": 1024,
		"signers": [],
		"actions": [
			{
				"contract": "token.iost",
				"action_name": "transfer",
				"data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
			},
		],
		"amount_limit": [
			{
				"token": "*",
				"value": "unlimited",
			},
		],
		"signatures": [],
	}
	```
* **计算哈希**

	利用上述算法序列化后并 sha3 后，得到哈希值 "/gB8TJQibGI7Kem1v4vJPcJ7vHP48GuShYfd/7NhZ3w="。
* **计算签名**

	假设 testaccount 账户的公私钥算法为 ED25519，公钥为 "lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY="，私钥为 "gkpobuI3gbFGstgfdymLBQAGR67ulguDzNmLXEJSWaGUNL5J0z5qJUdsPJdqm+uyDIrEWD2Ym4dY9lv8g0FFZg=="，利用私钥对上一步的哈希签名，得到 "/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA=="
	
* **发送交易**

	现在完整的交易请求参数为:
	
	```
	{
		"time": 1544709662543340000,
		"expiration": 1544709692318715000,
		"gas_ratio": 1,
		"gas_limit": 500000,
		"delay": 0,
		"chain_id": 1024,
		"signers": [],
		"actions": [
			{
				"contract": "token.iost",
				"action_name": "transfer",
				"data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
			},
		],
		"amount_limit": [
			{
				"token": "*",
				"value": "unlimited",
			},
		],
		"signatures": [],
		"publisher": "testaccount",
		"publisher_sigs": [
			{
				"algorithm": "ED25519",
				"public_key": "lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=",
				"signature": "/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA==",
			},
		],
	}
	```
	
	对上述结构进行 json 序列化后，发送如下 rpc 请求即可：
	
	```
	curl -X POST http://127.0.0.1:30001/sendTx -d '{"actions":[{"action_name":"transfer","contract":"token.iost","data":"[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]"}],"amount_limit":[{"token":"*","value":"unlimited"}],"delay":0,"chain_id":1024, "expiration": 1544709692318715000,"gas_limit":500000,"gas_ratio":1,"publisher":"testaccount","publisher_sigs":[{"algorithm":"ED25519","public_key":"lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=","signature":"/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA=="}],"signatures":[],"signers":[],"time": 1544709662543340000}'
	```
	


## /execTx
---

##### **POST**
**概要:**    
把交易发到节点，立刻执行，但是不会被上链共识，也不会被持久化。  
本接口可以用来在测试合约的执行结果是否符合预期。当然，由于调用时间不同，execTx 的行为不能保证和正式链上执行完全一致。     

### 请求格式
本接口请求格式和 /sendTx 相同。 
### 响应格式
本接口响应格式和 /getTxReceiptByTxHash 相同。

## /subscribe
---


##### **POST**
**概要:** 订阅事件，包括智能合约中触发的事件和交易执行完的事件。

### 请求格式

一个请求格式的例子

```
curl -X POST http://127.0.0.1:30001/subscribe -d '{"topics":["CONTRACT_RECEIPT"], "filter":{"contract_id":"token.iost"}}'
```
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| topics |repeated enum  | 订阅的事件主题，枚举类型有两种值，CONTRACT\_EVENT-合约中触发的事件, CONTRACT\_RECEIPT-交易执行完的事件|
| filter | [Filter](#filter)  | 收到的事件会按照 filter 中的字段过滤，若不传这一字段，则会收到所有 topics 中的事件数据 |
### Filter
| 字段 | 类型 | 描述 |
| :----: | :-----: | :------ |
| contract_id | string | 智能合约的 id|



### 响应格式

一个成功响应的例子

```
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646637413936000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646637711757000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646638013188000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646638317840000"}}}
...
```
| 字段 | 类型 | 描述 |
| :----: | :--------: | :------ |
| topic | enum  | 事件的主题，CONTRACT\_EVENT-合约中触发的事件, CONTRACT\_RECEIPT-交易执行完的事件|
| data | string  | 事件数据|
| time | int64  | 事件的时间戳|
