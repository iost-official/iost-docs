---
id: API
title: API
sidebar_label: API
---



## /getNodeInfo
##### GET

Retoune des informations sur le nœud serveur IOST

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getNodeInfo
```

### Réponse

Une réponse peut ressembler à ça :

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

Key             |Type       |Description
----                |--         |--
build\_time |string         |Building time of the 'server' binary
git\_hash       |string     |Git hash of the 'iserver' binary
mode            |string     |Current mode of the server. It can be one of 'ModeInit', 'ModeNormal' and 'ModeSync'
network     |[NetworkInfo](#network)|Network information of the node

### NetworkInfo

Key             |Type       |Description
----                |--         |--
id                  |string         |Node ID in the p2p network
peer\_count |int32      |Peer count of the node
peer\_info      |[PeerInfo]|Peer information of the node

### PeerInfo

Key             |Type       |Description
----                |--         |--
id                  |string     |ID of the peer
addr                |struct     |Address of the idx-th peer




## /getChainInfo
##### GET

Retourne des informations sur la blockchain IOST

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getChainInfo
```

### Réponse

Une réponse peut ressembler à ça :

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

Key                     |Type       |Description
----                        |--         |--
net\_name           |string     |Network name, such as "mainnet" or "testnet"
protocol\_version   |string     |iost protocol version
head\_block         |int64      |the lastest block height
head\_block\_hash|string        |the hash of the lastest block
lib\_block              |int64      |height of irreversible blocks
lib\_block\_hash    |int64      |hash of irreversible blocks
witness\_list           |repeated string|list of pubkeys for the block production nodes

## /getGasRatio
##### GET

Option le multiplieur de GAS permettant aux utilisateurs de définir leur multiplicateurs de trading. Nous recommandons un ratio de gas légèrement supérieur que le ratio minimal (lowest_gas_ratio) afin que les transactions soient publiées rapidement.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getGasRatio
```

### Réponse

Une réponse peut ressembler à ça :

```
200 OK

{
    "lowest_gas_ratio": 1.5,
    "median_gas_ratio": 1.76
}
```

Key                 |Type       |Description
----                    |--         |--
lowest\_gas\_ratio|double|the lowest gas ratio of the most recently packed blocks
median\_gas\_ratio|double|the median gas ratio of the most recently packed blocks


## /getRAMInfo
##### GET

Obtien l'information RAM pour la blockchain actuelle y compris son utilisation et prix.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getRAMInfo
```

### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
available\_ram  |int64      |RAM available, in byte
used\_ram       |int64      |The amount of RAM sold, in byte
total\_ram          |int64      |The system's total RAM count, in byte
buy\_price      |double |The buying price of RAM, in IOST/byte
sell\_price         |double |The selling price of RAM, in IOST/byte






## /getTxByHash
##### GET

Récupère la transaction à partir de son hash encodé en base58

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getTxByHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

Key                 |Type       |Description
----                    |--         |--
hash                |string     |hash of the transaction

### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
status              |enum       |PENDING- transaction is cached, PACKED - transaction is in reversible blocks, IRREVERSIBLE - transaction is in irreversible blocks
transaction     |Transaction|Transaction data

### Transaction

Key                 |Type       |Description
----                    |--         |--
hash                |string     |transaction's hash
time                    |int64      |timestamp of the transaction
expiration      |int64      |the expiration of the transaction
gas_ratio           |double |GAS ratio, we recommend it to be 1.00 (1.00 – 100.00). Raise the ratio to let the network pack it faster
gas_limit           |double |Upper limits of GAS. This transaction will never cost more GAS than this amount
delay               |int64      |Transactions will be delayed by this much, in nanosecond
actions         |repeated Action|the smallest transaction execution unit
signers         |repeated string|list of transaction signatures
publisher           |string     |sender of the transaction, who is responsible for fees
referred_tx     |string     |dependency of transaction generation; used for delayed transactions
amount_limit    |repeated AmountLimit|Users may specify token limits. For example, {"iost": 100} specifies each signers will not spend more than 100 IOST for the transaction
tx_receipt      |TxReceipt|the receipt of the transaction Action

### Action

Key                 |Type       |Description
----                    |--         |--
contract            |string     |contract name
action_name |string     |function name of the contract
data                    |string     |Specific parameters of the call. Put every parameter in an array, and JSON-serialize this array. It may looks like `["a_string", 13]`

### AmountLimit

Key                 |Type       |Description
----                    |--         |--
token               |string     |token name
value               |double |corresponding token limit

### TxReceipt

Key                 |Type       |Description
----                    |--         |--
tx_hash         |string     |hash of the transaction
gas_usage       |double |GAS consumption of the transaction
ram_usage       |map\<string, int64\>|RAM consumption for the transaction. map-key is account name, and value is RAM amount
status_code |enum       |Status of the transaction. SUCCESS; GAS_RUN_OUT - insufficient GAS; BALANCE_NOT_ENOUGH - insufficient balance; WRONG_PARAMETER; RUNTIME_ERROR - a run-time error; TIMEOUT; WRONG_TX_FORMAT; DUPLICCATE_SET_CODE - set code is duplicated unexpectedly; UNKNOWN_ERROR
message         |string     |a message descripting status_code
returns         |repeated string    |return values for each Action
receipts            |repeated Receipt|for event functions

### Receipt

Key                 |Type       |Description
----                    |--         |--
func_name       |string     |ABI function name
content         |string     |content

<!-- CONTINUER ICI : http://developers.iost.io/docs/zh-CN/next/6-reference/API/#gettxreceiptbytxhash-hash -->


## /getTxReceiptByTxHash/{hash}
##### GET

Obtient le reçu de la transaction à partir du hash.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getTxReceiptByTxHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

Key                 |Type       |Description
----                    |--         |--
hash                |string     |hash of the receipt

### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
                        |TxReceipt|receipt of the transaction




## /getBlockByHash/{hash}/{complete}
##### GET

Obtient l'information sur le block à partir du hash.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getBlockByHash/4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY/false
```

Key                 |Type       |Description
----                    |--         |--
hash                |string     |block hash
complete            |bool       |true - show detailed transactions within the block; false - don't.

### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
status              |enum       |PENDING - block is in cache; IRREVERSIBLE - block is irreversible.
block               |Block      |a Block struct

### Block

Key                 |Type       |Description
----                    |--         |--
hash                |string     |block hash
version         |int64      |block version number
parent\_hash    |string     |the hash of the parent block of this block
tx\_merkle\_hash    |string |the merkle tree hash of all transactions
tx\_receipt\_merkle\_hash   |string |the merkle tree hash of all receipts
number          |int64      |block number
witness         |string     |public key of the block producer
time                    |int64      |time of block production
gas\_usage      |double |total GAS consumption within the block
tx\_count           |int64      |(This key is reserved.)
transactions    |repeated Transaction   |all the transactions.

### Info

Key                 |Type       |Description
----                    |--         |--
mode                |int32      |mode of concurrency; 0 - non-concurrent; 1 - concurrent
thread              |int32      |the thread count of transaction concurrent execution
batch_index |repeated int32 |indices of the transaction


## /getBlockByNumber/{number}/{complete}
##### GET

Otenir les infos de block à l'aide du numéro de block.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getBlockByNumber/3/false
```

Key                 |Type       |Description
----                    |--         |--
number          |int64      |block number
complete            |bool       |true - display transactions of the block; false - don't.


### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
status              |enum       |PENDING - block is in cache; IRREVERSIBLE - block is not reversible
block               |Block      |the block struct







## /getAccount/{name}/{by_longest_chain}
##### GET

Obtenir les informations de compte

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getAccount/admin/true
```

Key                 |Type       |Description
----                    |--         |--
name                |string     |the block number
by\_longest\_chain  |bool   |true - get data from the longest chain; false - get data from irreversible blocks


### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
name                |string     |account name
balance         |double |the balance of the account
create\_time        |int64      |the time when the account was created
gas\_info           |GasInfo    |Gas information
ram\_info           |RAMInfo    |Ram information
permissions |map<string, Permission>    |permissions
groups              |map<string, Group>         |permission groups
frozen\_balances    |repeated FrozenBalance |information on the frozen balance

### GasInfo

Key                 |Type       |Description
----                    |--         |--
current\_total  |double |Total gas for the moment
transferable\_gas   |double |Gas available for trade
pledge\_gas     |double |Gas obtained from deposits
increase\_speed |double |The rate of gas increase, in gas per second
limit                   |double |The upper limit of gas from token deposit
pledged\_info   |repeated PledgeInfo    |The information on deposit made by other accounts, on behalf of the inquired account

### PledgeInfo

Key                 |Type       |Description
----                    |--         |--
pledger         |string     |the account receiving the deposit
amount          |double |the amount of the deposit

### RAMInfo

Key                 |Type       |Description
----                    |--         |--
available           |int64      |RAM bytes available for use
used           |int64      |RAM bytes used
total           |int64      |RAM bytes total

### Permission

Key                 |Type       |Description
----                    |--         |--
name                |string     |permission name
groups              |repeated string    |permission group
items               |repeated Item  |permission information
threshold           |int64      |permission threshold

### Item

Key                 |Type       |Description
----                    |--         |--
id                      |string     |permission name or key paid ID
is_key_pair     |bool       |true - id is a key pair; false - id is a permission name
weight              |int64      |permission weight
permission      |string     |the permission

### Group

Key                 |Type       |Description
----                    |--         |--
name                |string     |name of the group
items               |repeated Item  |information on the permission group

### FrozenBalance

Key                 |Type       |Description
----                    |--         |--
amount          |double |the amount
time                    |int64      |the time when the amount is unfrozen






## /getTokenBalance/{account}/{token}/{by_longest_chain}
##### GET

Get account balance of a specified token.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getTokenBalance/admin/iost/true
```

Key                 |Type       |Description
----                    |--         |--
account         |string     |account name
token               |string     |token name
by\_longest\_chain  |bool   |true - get information from the longest chain; false - get data from irreversible blocks

### Réponse

Une réponse peut ressembler à ça :

```
200 OK

{
    "balance": 982678652,
    "frozen_balances": []
}
```

Key                 |Type       |Description
----                    |--         |--
balance             |double |the balance
frozen\_balances    |repeated FrozenBalance |the information on frozen balance





## /getContract/{id}/{by_longest_chain}
##### GET

Get contract information using contract ID.

### Requête

Une requête peut ressembler à ça :

```
curl http://127.0.0.1:30001/getContract/base.iost/true
```

Key                 |Type       |Description
----                    |--         |--
id                      |string     |contract ID
by\_longest\_chain  |bool   |true - get data from longest chain; false - get data from irreversible blocks


### Réponse

Une réponse peut ressembler à ça :

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

Key                 |Type       |Description
----                    |--         |--
id                      |string     |contract ID
code                |string     |the code of the contract
language            |string     |the language of the contract
version         |string     |contract version
abis                    |repeated ABI   |the ABIs of the contract

### ABI

Key                 |Type       |Description
----                    |--         |--
name                |string     |interface name
args                    |repeated string    |arguments of the interface
amount\_limit   |repeated AmountLimit   |The limits on the amount





## /getContractStorage
##### POST

Obtenir des données sur le stockage sur contrat.

### Requête

Une requête peut ressembler à ça :

```
curl -X POST http://127.0.0.1:30001/getContractStorage -d '{"id":"vote_producer.iost","field":"producer00001","key":"producerTable","by_longest_chain":true}'
```

Key                 |Type       |Description
----                    |--         |--
id                      |string     |ID of the smart contract
field                   |string     |the values from StateDB; if StateDB\[key\] is a map then it is required to configure field to obtain values of StateDB\[key\]\[field\]
key                 |struct     |the key of StateDB
by\_longest\_chain  |bool   |true - get data from the longest chain; false - get data from irreversible blocks

### Réponse

Une réponse peut ressembler à ça :

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


## /sendTx
##### POST

Publier la transaction sur le nœud. Lorsque le nœud reçoit la transaction, il effectue un contrôle d'intégrité et renvoie les erreurs si le contrôle échoue. Si le contrôle est passé, la transaction sera ajoutée au pool de transactions et retournera un Hash de la transaction.

Les utilisateurs peuvent utiliser le hash comme argument de l'API `getTxByHash` ou `getTxReceiptByTxHash` afin de rechercher l'état de la transaction et de vérifier si l'exécution succède.

**Notes :**

Cette API nécessite le hash de transaction et une signature et est compliquée à appeler directement.

<!-- 可能需要更新以下链接 -->

Nous recommandons que les utilisateurs utilisent nos [Outils CLI](http://developers.iost.io/docs/zh-CN/6-reference/API/iwallet-example).

Les développeurs peuvent envoyer des transactions avec le [SDK JavaScript](https://github.com/iost-official/iost.js).

### Paramètres de requête

Key                 |Type       |Description
----                    |--         |--
time                    |int64      |Time of the transaction generation, in nanoseconds, from UnixEpoch-zero.
expiration      |int64      |The time when the transaction expires, in nanoseconds since UnixEpoch-zero. If a block-producing node receives the transaction after expiration, it will not execute the transaction.
gas\_ratio          |double |GAS ratio. This transaction will be executed with default ratio, multiplied by this parameter. The higher the ratio, the faster the transaction gets executed. The value can be reasonably between 1.0 to 100.0
gas\_limit          |double |Maximum GAS allowed by this transaction. Should not be lower than 50,000
delay               |int64      |The nanoseconds of the transaction delay. Set to 0 for non-delayed transactions.
actions         |repeated Action    |Specific calls of the transaction
amount\_limit   |repeated AmountLimit   |Limits on token of the transaction. More than one token limits may be specified; if the transaction exceeds theses limits, execution will halt.
publisher           |string     |ID of the transaction publisher
publisher\_sigs |repeated Signature |Signatures of the publisher, [as described here](/MISSING_URL_HERE). The publisher may provide multiple signatures for different permissions. Refer to documentations on the permission system.
signers         |repeated string    |The IDs of signers other than the publisher. May be left empty.
signatures      |repeated Signature |Signatures of the signers. Each signers should have one or many signatures, so the length of the signatures should not be less than that of the signers.

<!-- 上表中需要提供 URL -->


### Réponse

Key                 |Type       |Description
----                    |--         |--
hash                |string     |the transaction hash


### Signer une transaction

Il y a trois étapes pour signer une transaction : convertir la structure de la transaction en tableau de bits, calculer le hash sha3 du tableau de bits, et signer ce hash avec votre clé privée.

* **Convertit la structure de transaction en tableau de bits**

    L'algorithme : convertit les paramètres (dans l'ordre de déclaration) en tableau de bits, les encode comme ci-dessous, ajoute des balises <code>\`</code> avant chaque objet et les concatène. Voici le processus d'encodage :

    Type    |Conversion Method                          |Example
    ---     |--------------                                 |--------------------
    int     |Convert to byte array with Big-endian  |int64(1023) is converted to \[0 0 0 0 0 0 3 255\]
    string  |Splice the byte of each character in the string    |"iost" is converted to \[105 111 115 116\]
    array   |After converting each element of the array into a byte array, put them together and add `^` character before each of them      |\["iost" "iost"\] is converted to \[94 105 111 115 116 94 105 111 115 116\], or "^iost^iost"
    map     |Convert keys and values to byte arrays, splice each key and its value with `<`, add `/` before each item, and concatenate the items in the ascending order of the keys.    |\["b":"iost", "a":"iost"\] converts to \[47 97 60 105 111 115 116 47 98 60 105 111 115 116\], or "/a<iost/b<iost"

    Pour les int et les strings, il faut encode les tableaux de bits. Ajouter `\` avant <code>\`</code>, `^`, `<`, `/`, ou `\` pour ne pas considérer ces caractères.

    Les paramètres de transactions sont "time", "expiration", "gas\_ratio", "gas\_limit", "delay", "signers", "actions", "amount\_limit", et "signatures", ainsi le pseudo-code convertit une structure de transaction en tableau de bits :

    ```
    func TxToBytes(t transaction) []byte {
            return '`' + Int64ToBytes(t.time) + '`' + Int64ToBytes(t. expiration) +
        '`' + Int64ToBytes(int64(t.gas_ratio * 100)) + '`' + Int64ToBytes(int64(t.gas_limit * 100)) +     // Node that gas_ratio and gas_limit need to be multiplied by 100 and convert to int64
        '`' + Int64ToBytes(t.delay) + '`' + ArrayToBytes(t.signers) +
        '`' + ArrayToBytes(t.actions) + '`' + ArrayToBytes(t.amount_limit) +
        '`' + ArrayToBytes(t.signatures)
        }
    ```

  Se référer à [go-iost](https://github.com/iost-official/go-iost/blob/develop/core/tx/tx.go#L314) pour l'implémentation golang ; se référer à [iost.js](https://github.com/iost-official/iost.js/blob/master/lib/structs.js#L68) pour l'implémentation JavaScript.

* **Calculer le hash du tableau de bits avec l'algorithme sha3**

    Utiliser les librairies sha3 dans votre langage afin de calculer le hash du tableau de bits obtenu. step.

* **Signer le hash avec votre clé privée**

    IOST supporte deux algorithmes de chiffrage asymétriques : Ed25519 et Secp256k1. Ces deux algorithmes partagent le même processus de signature : générer une paire de clé publique/privée et signer le hash de l'étape précédente.

    La clé privée de "publisher\_sigs" doit être en accord avec le compte du créateur de la transaction. Les clés privées de signature doivent être en accord avec les clés du signeur de la transaction. "signatures" est utilisé pour les signatures multi-couches et n'est pas nécessaire ; "publisher\_sigs" est requis. Les frais pour l'exécution des transactions seront prélevées sur le compte du créateur de transaction.

### Requête example

Imaginons que le compte "testaccount" a une transaction qui transfère 100 iost vers le compte "anothertest".

* **Construction de la transaction**

    ```
    {
        "time": 1544709662543340000,
        "expiration": 1544709692318715000,
        "gas_ratio": 1,
        "gas_limit": 50000,
        "delay": 0,
        "signers": [],
        "actions": [
            {
                "contract": "token.iost",
                "actionName": "transfer",
                "data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
            },
        ],
        "amount_limit": [],
        "signatures": [],
    }
    ```

* **Calcul du hash**

    Après avoir sérialisé et hashé la transaction nous obtenons le hash "SEos66QidNOT+xOHYJOGpBs3g6YOPvzh7fujjaINpZA=".

* **Calcul de la signature**

    Si "testaccount" a une clé publique avec algorithme ED25519, la clé publique est "9RhdenfTcEsg93gKvRccFYICaug+H0efBpOFLwafERQ=", et la clé privée "rwhlQzbvFdtsyZAkE5JkadxhGIhu2eMy+T89GC/7fsH1GF16d9NwSyD3eAq9FxwVggJq6D4fR58Gk4UvBp8RFA==". Signer le hash avec la clé privée donne "OCc68Q7Jq7DCZ2TP3yGQtWew/JmVzIFSlSOVgcRqQF9u6H3AKmKjuQi1SRtiT/HgmK04cze5XKnkgjXE8uAoAg=="

* **Publier la transaction**

    Les paramètres de transaction complets sont :

    ```
    {
        "time": 1544709662543340000,
        "expiration": 1544709692318715000,
        "gas_ratio": 1,
        "gas_limit": 50000,
        "delay": 0,
        "signers": [],
        "actions": [
            {
                "contract": "token.iost",
                "actionName": "transfer",
                "data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
            },
        ],
        "amount_limit": [],
        "signatures": [],
        "publisher": "testaccount",
        "publisher_sigs": [
            {
                "algorithm": "ED25519",
                "public_key": "9RhdenfTcEsg93gKvRccFYICaug+H0efBpOFLwafERQ=",
                "signature": "OCc68Q7Jq7DCZ2TP3yGQtWew/JmVzIFSlSOVgcRqQF9u6H3AKmKjuQi1SRtiT/HgmK04cze5XKnkgjXE8uAoAg==",
            },
        ],
    }
    ```

    Ensuite nous sérialisons au format JSON la structure, et envoyons le RPC suivant :

    ```
    curl -X POST http://127.0.0.1:30001/sendTx -d '{"actions":[{"actionName":"transfer","contract":"token.iost","data":"[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]"}],"amount_limit":[],"delay":0,"expiration":1544709692318715000,"gas_limit":50000,"gas_ratio":1,"publisher":"testaccount","publisher_sigs":[{"algorithm":"ED25519","public_key":"9RhdenfTcEsg93gKvRccFYICaug+H0efBpOFLwafERQ=","signature":"OCc68Q7Jq7DCZ2TP3yGQtWew/JmVzIFSlSOVgcRqQF9u6H3AKmKjuQi1SRtiT/HgmK04cze5XKnkgjXE8uAoAg=="}],"signatures":[],"signers":[],"time":1544709662543340000}'
    ```


## /execTx
##### POST

Envoyer la transaction au noeud et exécuter immédiatement. Ceci ne cherchera pas le consensus sur la chaine, et ne sera pas persistent.

Cette API est utilisée afin de vérifier si un contrat test s'exécute comme attendu. Evidemment execTx ne peut pas garantir le même résultat lors d'une exécution on-chain à cause de la différence de temps.

### Requête

Cette API partage les mêmes paramètres que /sendTx.

### Réponse

Cette API partage le même format de réponse que /getTxReceiptByTxHash.
