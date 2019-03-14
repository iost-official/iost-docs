---
id: iWallet
title: iWallet
sidebar_label: iWallet
---

iwallet 是 IOST 的客户端命令行工具。可以使用本工具连接IOST节点，进行区块链操作，和查询余额，创建账号，转账，调用合约等。  
iwallet 和 [API](6-reference/API.md) 都是通过 RPC API 来和区块链交互。两者的功能和接口都是基本一致的。
  
## 安装
首先需要[安装golang](4-running-iost-node/Building-IOST.md#install-golang)。

安装完golang之后，你可以执行如下命令安装iwallet：
```
go get github.com/iost-official/go-iost/cmd/iwallet
```

如果你计划部署智能合约到区块链上，你应该首先安装[nodejs](https://nodejs.org/en/download/)，然后再运行下面的命令。

## 基本功能
### 查询账号信息
使用 iwallet 可以查看指定账户目前的账号信息，包括余额，可用RAM数量，GAS总量等等。   
具体的字段含义和 [getAccountInfo API](6-reference/API.md#getaccount-name-by-longest-chain) 一致.  
注意，iwallet 后面的 server 参数，可以指定连接的 IOST server。如果你在本地搭建了全节点，那么直接不指定这个参数，令其使用默认值（localhost:30002）即可。   

```
iwallet --server 127.0.0.1:30002 balance xxxx
{
    "name": "xxxx",
    "balance": 993939670,
    "createTime": "0",
    "gasInfo": {
        "currentTotal": 2994457,
        "increaseSpeed": 11,
        "limit": 3000000,
        "pledgedInfo": [            {
                "pledger": "xxxx",
                "amount": 10
            },
            {
                "pledger": "tttt",
                "amount": 10
            }
        ],
    },
    "ramInfo": {
        "available": "100000" 
    },
    "permissions": ...
    "frozenBalances": [
        {
            "amount": 30,
            "time": "1543817610001412000"
        }
    ]
}
```
### 查询区块链信息
得到当前区块链和节点的信息。是 [getNodeInfo](6-reference/API.md#getnodeinfo) 和 [getChainInfo](6-reference/API.md#getchaininfo) 两个接口返回结果的汇总。

```
iwallet --server 127.0.0.1:30002 state
{
    "buildTime": "20181208_161822+0800",
    "gitHash": "c949172cb8063e076b087d434465ecc4f11c3000",
    "mode": "ModeNormal",
    "network": {
        "id": "12D3KooWK1ALkQ6arLJNd5vc49FLDLaPK931pggFr7X49EA5yhnr",
        "peerCount": 0,
        "peerInfo": [
        ]
    }
    "netName": "debugnet",
    "protocolVersion": "1.0",
    "headBlock": "9408",
    "headBlockHash": "FKtcg2qgUnfuXNe6Zz6p2CJMLSUjDSSK2PrvzPtpA3jp",
    "libBlock": "9408",
    "libBlockHash": "FKtcg2qgUnfuXNe6Zz6p2CJMLSUjDSSK2PrvzPtpA3jp",
    "witnessList": [
        "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
    ]
}
```
  
### 合约调用
#### 导入账号
在调用任何合约之前，都需要先使用 iwallet 导入账号。

```
# 这里实际上是会把私钥复制到 ~/.iwallet/YOUR_ACCOUNT_ID_ed25519 文件中。不会和区块链有交互。 
iwallet account import $YOUR_ACCOUNT_ID $YOUR_PRIVATE_KEY 
```
#### 命令行用法和选项

```
iwallet --account <ACCOUNT_NAME> [other flags] call <CONTRACT_NAME> <ACTION_NAME> '["ARG1",ARG2,...]'
```

| 字段  | 描述 | 默认值 |
| :----: | :-----: | :------ |
| server | 连接的 iserver 地址  | localhost:30002 |
| account | 调用合约的用户名 | 无，需要填写 |
| gas_limit | 本次调用的 gas 限制 | 1000000 |
| gas_ratio | 本次调用的 gas 比率 | 1.0 |
| amount_limit | 本次交易的各种 token 限制 | 无，需要填写。形如 iost:300.0&#124;ram:2000。可以用 "*:unlimited" 不设置任何限制 |

#### 常见合约举例：转账
使用admin这个账户，调用 'token.iost' 这个合约的 'transfer' 方法。   
最后一个参数是 Action 调用的参数，对于 transfer, 依次是 token 类型，付款方，收款方，金额，和附加信息。

```
iwallet --account admin call 'token.iost' 'transfer' '["iost","admin","lispczz","100",""]' 
sending tx Tx{
	Time: 1543559175834283000,
	Publisher: admin,
	Action:
		Action{Contract: token.iost, ActionName: transfer, Data: ["iost","admin","lispczz","100",""]}
    AmountLimit:
[],
}
send tx done
the transaction hash is: GU4EHg4zE9VHu9A13JEwxqJSVbzij1VoqWGnQR5aV3Dv
exec tx done.  {
    "txHash": "GU4EHg4zE9VHu9A13JEwxqJSVbzij1VoqWGnQR5aV3Dv",
    "gasUsage": 2172, #本次调用消耗的GAS
    "ramUsage": {#每个账户或合约本次调用消耗的RAM
        "admin": "43"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[]"
    ],
    "receipts": [
        {
            "funcName": "token.iost/transfer",
            "content": "[\"iost\",\"admin\",\"lispczz\",\"100\",\"\"]"
        }
    ]
}
```

### 创建账号
#### 命令行用法和选项

```
iwallet --server <server_addres> --account <account_name> --amount_limit  <amount_limit> account create <new_account_name> [other flags] 
```

| 字段  | 描述 | 默认值 |
| :----: | :-----: | :------ |
| create | 新创建账号的用户名  | 无，需要填写 |
| initial_ram | 给新用户购买的 RAM 数量| 1024 |
| initial\_gas\_pledge | 给新用户初始质押GAS的 IOST 数量| 10 |
| initial_balance | 给新用户转账 IOST 数量 | 0 |
由于创建新账号需要发送合约，因此除了表格中的参数外，__call__ 命令的所有参数对 account 命令也有效。

```
# 创建账号后，iwallet会随机生成公私钥对，私钥会保存到 ~/.iwallet/$(new_account_name)_ed25519 文件中。
iwallet --server 127.0.0.1:30002 --account admin --amount_limit "ram:1000|iost:10" account create lispczz3 --initial_balance 0 --initial_gas_pledge 10 --initial_ram 0
...
...
    "groups": {
    },
    "frozenBalances": [
    ]
}
your account private key is saved at:
/Users/zhangzhuo/.iwallet/lispczz3_ed25519
create account done
the iost account ID is: lispczz3
owner permission key: IOSTGdkyjGmhvpM435wvSkPt2m3TVUM6npU8wbRZYcmkdprpvp92K
active permission key: IOSTGdkyjGmhvpM435wvSkPt2m3TVUM6npU8wbRZYcmkdprpvp92K 
```
### 发布合约
发布 javascript 合约时，分为两步。首先生成 abi，之后合约代码和 abi 一起发布到区块链上。
#### 生成 abi
首先确认 node.js 已经安装，并且可以通过 `node` 命令可以被直接调用。

```
#会生成 example.js.abi
iwallet compile example.js
```

注意生成的 abi 根据实际应用需要一般需要手动修改。需要修改的地方有两处，一处是每个 Action 的参数类型，一个是每个 Action 的 amount limit。
#### 发布合约
```
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh

```
最后一行输出的 `ContractXXX` 就是合约名称。调用已经上传的合约，需要使用合约名称。

## 高级功能
### 查询区块信息

```
# 获得高度 10 的块的信息
iwallet block --method num 10
# 获得指定 hash 的块的信息 
iwallet block --method hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
```
### 查询交易信息
#### 获得交易具体信息
transaction 命令和 [getTxByHash](6-reference/API.md#gettxbyhash-hash]) 等价

```
iwallet transaction 3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx
{
    "status": "PACKED",
    "transaction": {
        "hash": "3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx",
        "time": "1545470082534696000",
        "expiration": "1545470382534696000",
        "gasRatio": 1,
        "gasLimit": 1000000,
        "delay": "0",
        "actions": [
            {
                "contract": "token.iost",
                "actionName": "transfer",
                "data": "[\"iost\",\"admin\",\"admin\",\"10\",\"\"]"
            }
        ],
# 
```
#### 获得交易收据信息
receipt 命令和 [getTxReceiptByTxHash](6-reference/API.md#gettxreceiptbytxhash-hash) 等价

```
iwallet receipt 3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx
{
    "txHash": "3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx",
    "gasUsage": 2577,
    "ramUsage": {
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[]"
    ],
    "receipts": [
    ]
}
```


## 账户权限相关命令
[IOST Account文档](2-intro-of-iost/Account.md)

### 添加权限
addperm 命令和 [addPermission](6-reference/SystemContract.md#addPermission)等价

```
iwallet sys addperm myperm 100

...
SUCCESS!
Transaction receipt:
{
    "txHash": "BqbRLp7QinvmryBiq3m2cLdEZno4zUn3VVphMg7cU7SN",
    "gasUsage": 41792,
    "ramUsage": {
        "admin": "457",
        "auth.iost": "-399" #如果是第一次添加权限，会把代扣ram转移到用户名下
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/addPermission",
            "content": "[\"admin\",\"myperm\",100]"
        }
    ]
}
Executed in 3.008647288s
```

### 删除权限
dropperm 命令和 [dropPermission](6-reference/SystemContract.md#dropPermission)等价

```
iwallet sys dropperm myperm

...
SUCCESS!
Transaction receipt:
{
    "txHash": "BaF6yfoTib1ckm3svhf2MshFQu6cgbrS6k2vJx8zpy6g",
    "gasUsage": 40473,
    "ramUsage": {
        "admin": "-62"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/dropPermission",
            "content": "[\"admin\",\"myperm\"]"
        }
    ]
}
Executed in 3.009731933s
```

### 向权限添加秘钥或其他权限的引用
assignperm 命令和 [assignPermission](6-reference/SystemContract.md#assignPermission)等价

```
iwallet sys assignperm myperm pub_key_in_base58 100

...
SUCCESS!
Transaction receipt:
{
    "txHash": "FNB45hYLPbmcLsYzmhpBAWCQ1msikye4wpSVhLUT4nuZ",
    "gasUsage": 44702,
    "ramUsage": {
        "admin": "85"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/assignPermission",
            "content": "[\"admin\",\"myperm\",\"Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto\",100]"
        }
    ]
}
Executed in 3.009210363s
```

### 删除秘钥，权限引用
revokeperm 命令和 [revokePermission](6-reference/SystemContract.md#revokePermission)等价

```
iwallet sys revokeperm myperm pub_key_in_base58

SUCCESS!
Transaction receipt:
{
    "txHash": "6okevSToCRMQTsPsnG1hU3smbQEMgYdSaDETYJhpdgdU",
    "gasUsage": 43768,
    "ramUsage": {
        "admin": "-85"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/revokePermission",
            "content": "[\"admin\",\"myperm\",\"Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto\"]"
        }
    ]
}
Executed in 3.008524584s
```

### 添加权限组
addgroup 命令和 [addGroup](6-reference/SystemContract.md#addGroup)等价

```
iwallet sys addgroup mygroup

SUCCESS!
Transaction receipt:
{
    "txHash": "4ZmESGsFZvXeJJj4uaKLdSsBBFToYuWgp4HuqgCwdJJj",
    "gasUsage": 43838,
    "ramUsage": {
        "admin": "39"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/addGroup",
            "content": "[\"admin\",\"mygroup\"]"
        }
    ]
}
Executed in 3.007453024s
```

### 删除权限组
dropgroup 命令和 [dropGroup](6-reference/SystemContract.md#dropGroup)等价

```
iwallet sys dropgroup mygroup

SUCCESS!
Transaction receipt:
{
    "txHash": "FMUrp2CdMWeWs5k5TPSEMvpbXEzqTHX3guqJBWcpbqi2",
    "gasUsage": 42609,
    "ramUsage": {
        "admin": "-39"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/dropGroup",
            "content": "[\"admin\",\"mygroup\"]"
        }
    ]
}
Executed in 3.009566102s
```

### 向组添加秘钥或引用
assigngroup 命令和 [assigngroup](6-reference/SystemContract.md#assigngroup)等价

```
iwallet sys assigngroup mygroup pub_key_in_base58 100

SUCCESS!
Transaction receipt:
{
    "txHash": "BwUaxi7hXbLe3i75CD7HjGJamp1LmGduwsNKNDP7wCRj",
    "gasUsage": 45355,
    "ramUsage": {
        "admin": "85"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/assignGroup",
            "content": "[\"admin\",\"mygroup\",\"Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto\",100]"
        }
    ]
}
Executed in 3.009952435s
```

### 从组中删除秘钥或引用
revokegroup 命令和 [revokeGroup](6-reference/SystemContract.md#revokeGroup)等价

```
iwallet sys revokegroup mygroup pub_key_in_base58

SUCCESS!
Transaction receipt:
{
    "txHash": "Er9Zr5iqGhsA1FJDEW9zNQyWzxi5P5vm66dM4g9XU5LS",
    "gasUsage": 42864,
    "ramUsage": {
        "admin": "-124"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/dropGroup",
            "content": "[\"admin\",\"mygroup\"]"
        }
    ]
}
Executed in 3.008849533s
```

### 将权限加入组
bindperm 命令和 [assignPermissionToGroup](6-reference/SystemContract.md#assignPermissionToGroup)等价

```
iwallet sys bindperm myperm mygroup

SUCCESS!
Transaction receipt:
{
    "txHash": "4yCZLoyPmFo7wz5qF2wAuE974mGz1kXfDsVz5HsA5Q9c",
    "gasUsage": 43655,
    "ramUsage": {
        "admin": "9"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/assignPermissionToGroup",
            "content": "[\"admin\",\"myperm\",\"mygroup\"]"
        }
    ]
}
Executed in 3.008667982s
```

### 从组中移除权限
unbindperm 命令和 [revokePermissionInGroup](6-reference/SystemContract.md#revokePermissionInGroup)等价

```
iwallet sys unbindperm myperm mygroup

SUCCESS!
Transaction receipt:
{
    "txHash": "FxdteazkZbLTPFd5bnhmyydiPeurpx9jWrwcTar7eEQt",
    "gasUsage": 43540,
    "ramUsage": {
        "admin": "-9"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"\"]"
    ],
    "receipts": [
        {
            "funcName": "auth.iost/revokePermissionInGroup",
            "content": "[\"admin\",\"myperm\",\"mygroup\"]"
        }
    ]
}
Executed in 3.008329559s
```

## 权限设置实例
### 利用账号权限系统，实现触发投票收益领取账号和收益账号分离功能
####步骤：
- 两个账号a和b，a为接收投票收益账号、b为触发领取收益账号
- 首先账号a添加`operate`权限
   - `iwallet sys addperm operate 100 --account a_name`
- a账号向权限`operate`中添加b账号权限引用
   - `iwallet sys assignperm operate b_name@active 100 --account a_name`
- 利用b账号触发a账号的投票收益领取
   - 如果a账号是节点：`iwallet sys producer-withdraw --target a_name --account b_name`
   - 如果a账号是投票者：`iwallet sys voter-withdraw --target a_name --account b_name`
