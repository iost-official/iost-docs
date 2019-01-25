---
id: API
title: API
sidebar_label: API
---



## /getNodeInfo
##### GET

IOSTサーバーノードの情報を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getNodeInfo
```

### レスポンス  

成功レスポンスの例

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

キー             |型       |説明 
----                |--         |--
build\_time |string         |'server'バイナリのビルド時間git\_hash       |string     |'iserver'バイナリのGitハッシュ
mode            |string     |サーバーの実行中モード。 'ModeInit'、'ModeNormal'、'ModeSync'のいずれか
network     |[NetworkInfo](#network)|network|ノードのネットワーク情報

### NetworkInfo

キー             |型       |説明 
----                |--         |--
id                  |string         |P2Pネットワーク内のノードID
peer\_count |int32      |ノードのピア(隣接)ノード数
peer\_info      |[PeerInfo]|ピアノードの情報

### PeerInfo

キー             |型       |説明 
----                |--         |--
id                  |string     |ピアノードID
addr                |struct     |idx番目のピアノードアドレス




## /getChainInfo
##### GET

IOSTブロックチェーンの情報を取得します。

### リクエスト 

リクエストの例

```
curl http://127.0.0.1:30001/getChainInfo
```

### レスポンス

成功レスポンスの例

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

キー                     |型       |説明 
----                        |--         |--
net\_name           |string     |ネットワーク名。"mainnet"または"testnet"
protocol\_version   |string     |IOSTプロトコルのバージョン
chain\_id   | uint32     |IOSTのチェーンID
head\_block         |int64      |最新ブロック番号
head\_block\_hash|string        |最新ブロックのハッシュ
lib\_block              |int64      |不可逆ブロックの高さ
lib\_block\_hash    |int64      |不可逆ブロックのハッシュ
witness\_list           |stringの繰り返し|ブロック生成ノードの公開鍵のリスト

## /getGasRatio
##### GET

ユーザーが希望するGAS取引係数を設定できるようにGAS係数情報を取得します。トランザクションがタイムリーにパブリッシュされるように、lowest_gas_ratioより少し多めのGAS比率にすることをお勧めします。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getGasRatio
```

### レスポンス

成功レスポンスの例

```
200 OK

{
    "lowest_gas_ratio": 1.5,
    "median_gas_ratio": 1.76
}
```

キー                 |型       |説明 
----                    |--         |--
lowest\_gas\_ratio|double|直近にパックされたブロックの最も低いGAS比率
median\_gas\_ratio|double|直近にパックされたブロックのGAS比率の中央値


## /getRAMInfo
##### GET

使用状況や価格などの現在のブロックチェーンのRAM情報を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getRAMInfo
```

### レスポンス

成功レスポンスの例

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

キー                 |型       |説明 
----                    |--         |--
available\_ram  |int64      |利用可能RAM(バイト)
used\_ram       |int64      |販売済RAM(バイト)
total\_ram          |int64      |システムの総RAM(バイト)
buy\_price      |double |RAMの購入価格(IOST/バイト)
sell\_price         |double |RAMの販売価格(IOST/バイト)






## /getTxByHash
##### GET

Base58でエンコードされたハッシュによりトランザクションを取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getTxByHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

キー                 |型       |説明 
----                    |--         |--
hash                |string     |トランザクションのハッシュ

### レスポンス

成功レスポンスの例

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

キー                 |型       |説明 
----                    |--         |--
status              |enum       |PENDING: トランザクションはキャッシュされている、PACKED: トランザクションは可逆ブロックにある、IRREVERSIBLE: トランザクションは不可逆ブロックにある
transaction     |Transaction|トランザクションデータ

### Transaction

キー                 |型       |説明 
----                    |--         |--
hash                |string     |トランザクションのハッシュ
time                    |int64      |トランザクションのタイムスタンプ
expiration      |int64      |トランザクションの有効期限
gas_ratio           |double |GAS比率、1.00 (1.00 – 100.00)を推奨。比率を上げるとネットワーク上でのパックが高速化
gas_limit           |double |GASの上限。この値よりGAS代が大きくなることはない
delay               |int64      |トランザクションの最大遅延(ナノ秒)
chain_id               |uint32      | トランザクションを実行したブロックチェーンのID
actions         |Actionの繰り返し|最小トランザクション実行単位
signers         |stringの繰り返し|トランザクションの署名リスト
publisher           |string     |トランザクションの送信者、手数料を支払う
referred_tx     |string     |遅延しているトランザクションのためのトランザクションの依存関係
amount_limit    |AmountLimitの繰り返し|ユーザはトークン上限を設定できる。例えば、{"iost": 100} は、各署名者がトランザクションに100IOSTを超えないことを指定
tx_receipt      |TxReceipt|トランザクションのアクションのレシート

### Action

キー                 |型       |説明 
----                    |--         |--
contract            |string     |コントラクト名
action_name |string     |コントラクトの関数名
data                    |string     |呼び出しパラメータ。すべてのパラメータを配列に入れて、JSONシリアライズしたもの。例: `["a_string", 13]`

### AmountLimit

キー                 |型       |説明 
----                    |--         |--
token               |string     |トークン名
value               |double |トークン上限

### TxReceipt

キー                 |型       |説明 
----                    |--         |--
tx_hash         |string     |トランザクションのハッシュ
gas_usage       |double |トランザクションのGAS消費
ram_usage       |map\<string, int64\>|トランザクションのRAM消費。マップのキーはアカウント名、値はRAMの量
status_code |enum       |トランザクションのステータス。SUCCESS: 成功、
 GAS_RUN_OUT: GAS不足、BALANCE_NOT_ENOUGH : 残高不足、WRONG_PARAMETER: 不正なパラメータ、 RUNTIME_ERROR : ランタイムエラー、 TIMEOUT: タイムアウト、 WRONG_TX_FORMAT: 不正なトランザクションフォーマット、 DUPLICCATE_SET_CODE: コードの予期せぬダブリ、 UNKNOWN_ERROR: 未知のエラー
message         |string     |ステータスコードを説明するメッセージ
returns         |stringの繰り返し    |アクションの戻り値
receipts            |Receiptの繰り返し|イベント関数用レシート

### Receipt

キー                 |型       |説明 
----                    |--         |--
func_name       |string     |ABI関数名
content         |string     |内容


## /getTxReceiptByTxHash/{hash}
##### GET

トランザクションのハッシュによりレシートを取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getTxReceiptByTxHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

キー                 |型       |説明 
----                |--         |--
hash                |string|トランザクションのレシート

### レスポンス

成功レスポンスの例

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

キー                 |型       |説明 
----                    |--         |--
|TxReceipt|トランザクションのレシート




## /getBlockByHash/{hash}/{complete}
##### GET

ブロックハッシュによりブロック情報を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getBlockByHash/4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY/false
```

キー                 |型       |説明 
----                    |--         |--
hash                |string     |ブロックハッシュ
complete            |bool       |true: ブロック内のトランザクションの詳細情報を表示、false: 表示しない

### レスポンス

成功レスポンスの例

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

キー                 |型       |説明 
----                    |--         |--
status              |enum       |PENDING: ブロックはキャッシュ内、IRREVERSIBLE: ブロックは不可逆
block               |Block      |ブロック構造

### Block

キー                 |型       |説明 
----                    |--         |--
hash                |string     |ブロックのハッシュ
version         |int64      |ブロックのバージョン番号
parent\_hash    |string     |ブロックの親ブロックのハッシュ
tx\_merkle\_hash    |string |すべてのトランザクションのマークルツリーハッシュ
tx\_receipt\_merkle\_hash   |string |すべてのレシートのマークルツリーハッシュ
number          |int64      |ブロック番号
witness         |string     |ブロックプロデューサーの公開鍵
time                    |int64      |風呂奥生成時間
gas\_usage      |double |ブロックの総GAS消費
tx\_count           |int64      |ブロック内のトランザクション番号
info           | Info      |(予約済)
transactions    |Transactionの繰り返し   |すべてのトランザクション

### Info

キー                 |型       |説明
----                    |--         |--
mode                |int32      |並列動作モード。 0: 並列動作なし、1: 並列動作
thread              |int32      |トランザクション並列動作時のスレッド数
batch_index |int32の繰り返し |トランザクションのインデックス


## /getBlockByNumber/{number}/{complete}
##### GET

ブロック番号によりブロック情報を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getBlockByNumber/3/false
```

キー                 |型       |説明 
----                    |--         |--
number          |int64      |ブロック番号
complete            |bool       |true: ブロック内のトランザクションを詳細表示する、false: 詳細表示しない


### レスポンス

成功レスポンスの例

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

キー                 |型       |説明 
----                    |--         |--
status              |enum       |PENDING : ブロックはキャッシュ内、IRREVERSIBLE: ブロックは不可逆
block               |Block      |ブロック構造







## /getAccount/{name}/{by_longest_chain}
##### GET

アカウント情報を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getAccount/admin/true
```

キー                 |型       |説明 
----                    |--         |--
name                |string     |ブロック番号
by\_longest\_chain  |bool   |true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得


### レスポンス

成功レスポンスの例

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
    "frozen_balances": [],
    "vote_infos": []
}
```

キー                 |型       |説明 
----                    |--         |--
name                |string     |アカウント名
balance         |double |アカウントの残高
gas\_info           |GasInfo    |GAS情報
ram\_info           |RAMInfo    |RAM情報
permissions |map<string, Permission>    |権限
group_names              |map<string, Group>         |権限グループ名
frozen\_balances    |FrozenBalanceの繰り返し |凍結した残高の情報
vote\_infos    |VoteInfoの繰り返し |投票の情報

### GasInfo

キー                 |型       |説明 
----                    |--         |--
current\_total  |double |瞬間総GAS
transferable\_gas   |double |トランザクションに使えるGAS
pledge\_gas     |double |デポジットから取得できるGAS
increase\_speed |double |秒あたりのGAS増加率
limit           |double |トークンのデポジットの上限
pledged\_info   |PledgeInfoの繰り返し    |問い合わせを受けたアカウントの代わりに、別アカウントにより作成されたデポジットの情報

### PledgeInfo

キー                 |型       |説明 
----                    |--         |--
pledger         |string     |デポジット受け取りアカウント
amount          |double |デポジット量

### RAMInfo

キー                 |型       |説明 
----                    |--         |--
available           |int64      |使用可能RAM(バイト)
used           |int64      |使用済RAM(バイト)
total           |int64      |総RAM(バイト)

### Permission

キー                 |型       |説明 
----                    |--         |--
name                |string     |権限名
groups              |stringの繰り返し    |権限グループ
items               |Itemの繰り返し  |権限情報
threshold           |int64      |権限のしきい値

### Item

キー                 |型       |説明 
----                    |--         |--
id                      |string     |権限名かキーペアのID
is_key_pair     |bool       |true: IDはキーペア、false: IDは権限名
weight              |int64      |権限の重み
permission      |string     |権限

### Group

キー                 |型       |説明 
----                    |--         |--
name                |string     |グループ名
items               |Itemの繰り返し  |権限グループ情報

### FrozenBalance

キー                 |型       |説明 
----                    |--         |--
amount          |double |量
time                    |int64      |解凍時間

### VoteInfo

キー                 |型       |説明 
----                    |--         |--
option          |string |候補者
votes                    |string      |得票数
cleared_votes                    |string      |クリアした得票数



## /getTokenBalance/{account}/{token}/{by_longest_chain}
##### GET

指定したトークンのアカウント残高を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getTokenBalance/admin/iost/true
```

キー                 |型       |説明 
----                    |--         |--
account         |string     |アカウント名
token               |string     |トークン名
by\_longest\_chain  |bool   |true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得

### レスポンス

成功レスポンスの例

```
200 OK

{
    "balance": 982678652,
    "frozen_balances": []
}
```

キー                 |型       |説明 
----                    |--         |--
balance             |double |残高
frozen\_balances    |repeated FrozenBalance |凍結された残高





## /getContract/{id}/{by_longest_chain}
##### GET

コントラクトIDによりコントラクト情報を取得します。

### リクエスト

リクエストの例

```
curl http://127.0.0.1:30001/getContract/base.iost/true
```

キー                 |型       |説明 
----                    |--         |--
id                      |string     |コントラクトID
by\_longest\_chain  |bool   |true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得
ｖ

### レスポンス

成功レスポンスの例

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

キー                 |型       |説明 
----                    |--         |--
id                      |string     |コントラクトID
code                |string     |コントラクトコード
language            |string     |コントラクトの使用言語
version         |string     |コントラクトのバージョン
abis                    |ABIの繰り返し   |コントラクトのABI

### ABI

キー                 |型       |説明 
----                    |--         |--
name                |string     |インターフェース名
args                    |stringの繰り返し    |インターフェースの引数
amount\_limit   |AmountLimitの繰り返し   |数量制限





## /getContractStorage
##### POST

ローカルにコントラクトのストレージデータを取得します。

### リクエスト

リクエストの例

```
curl -X POST http://127.0.0.1:30001/getContractStorage -d '{"id":"vote_producer.iost","field":"producer00001","key":"producerTable","by_longest_chain":true}'
```

キー                 |型       |説明 
----                    |--         |--
id                      |string     |スマートコントラクトのID
field                   |string     |StateDBの値。StateDBの\[キー\]が マップなら、StateDB\[key\]\[field\]の値を取得するために fieldを設定する必要がある
key                 |string     |StateDBのキー
by\_longest\_chain  |bool   |true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得

### レスポンス

成功レスポンスの例

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
##### POST

最大256までのマップのコントラクトストレージのキーリストを取得します。

### リクエスト

リクエストの例

```
curl -X POST http://127.0.0.1:30001/getContractStorageFields -d '{"id":"token.iost","key":"TIiost","by_longest_chain":true}'
```

キー                 |型       |説明 
----                    |--         |--
id                      |string     |スマートコントラクトID
key                 |string     |ステートDBのキー
by\_longest\_chain  |bool   |true: 最長のチェーンからデータを取得、false: 不可逆ブロックからデータを取得

### レスポンス

成功レスポンスの例

```
200 OK
{
	"fields": ["issuer","totalSupply","supply","canTransfer","onlyIssuerCanTransfer","defaultRate","decimal","fullName"]
}
```

## /sendTx
##### POST

トランザクションをノードにパブリッシュします。ノードがトランザクションを受け取ると、サニティーチェックをして、失敗ならエラーを返します。チェックに合格したら、トランザクションはトランザクションプールに追加され、トランザクションのハッシュを返します。

ユーザーはハッシュを`getTxByHash` APIか`getTxReceiptByTxHash` APIの引数として使用して、トランザクションの状態を調べ、実行が成功したかどうかをチェックします。

**メモ:**

APIはトランザクションハッシュと署名を必要とし、直接呼び出すのは、トリッキーな操作が必要になります。

<!-- 可能需要更新以下链接 -->

 ユーザには、[CLI tools](4-running-iost-node/iWallet.md)を使って、トランザクションを送信することをお勧めします。

開発者は[JavaScript SDK](https://github.com/iost-official/iost.js)を使ってください。

### リクエスト Parameters

キー                 |型       |説明 
----                    |--         |--
time                    |int64      |トランザクション生成時刻(UNIX時間、ナノ秒)
expiration      |int64      |トランザクション有効時刻(UNIX時間、ナノ秒)、ブロックが有効期限を過ぎてから、トランザクションを受け取ったらトランザクションは実行されない
gas\_ratio          |double |GAS比率、トランザクションはデフォルトの比率で実行され、このパラメーで乗算される。値は1.0から100.0。
gas\_limit          |double |トランザクションで許可される最大GASで、50,000以上
delay               |int64      |トランザクションの遅延(ナノ秒)。0にすると遅延なし
chain_id               |uint32      |チェーンID
actions         |Actionの繰り返し    |トランザクションの特定呼び出し
amount\_limit   |AmountLimitの繰り返し   |トランザクションのトークンの制限。複数指定可能で、この制限を超えると実行は停止する
publisher           |string     |トランザクションパブリッシャーID
publisher\_sigs |Signatureの繰り返し |[ここで説明してあるように](/MISSING_URL_HERE.md)パブリッシャーの署名。パブリッシャーは、それぞれのパーミッションに複数署名を提供できる。パーミッションシステムのドキュメントを参照
signers         |stringの繰り返し    |パブリッシャーではない署名者のID。空白のままも可
signatures      |Signatureの繰り返し |署名者の署名。各署名者は１つ以上の署名が必要で、署名の数は署名者より少なくてはいけない

<!-- 上表中需要提供 URL -->

### 署名

Key                 |Type       |Description 
----                    |--         |--
algorithm                |string     | "ED25519"または"SECP256K1"
signature                    | string    |トランザクションの署名
public\_key   |string   |署名に関連する公開鍵

### レスポンス

キー                 |型       |説明 
----                    |--         |--
hash                |string     |トランザクションハッシュ


### トランザクションの署名

トランザクションの署名には、３つのステップがあります。トランザクション構造のバイト配列への変換し、バイト配列のSHA3ハッシュの計算後、秘密鍵によるハッシュの署名します。

* **トランザクションの構造のバイト配列への変換**

    アルゴリズムは、次のとおりです。トランザクションの各フィールドを宣言順にバイト配列に変換してから、不定型(文字列や構造体など)やspliceの前に長さを追加します。さまざまなフィールド型をバイト配列に変換する方法は次のようになります。

    
        型    |変換メソッド                          |例
    ---     |--------------                                 |--------------------
    int     |バイト配列にビッグエンディアンに変換 |int64(1023)は \[0 0 0 0 0 0 3 255\]
    string  |文字列中の各文字をバイトに分けて、長さをその前に付与    |"iost" は \[0 0 0 4 105 111 115 116\]
    array   | 配列の各要素をバイト配列に変換し、長さを配列の前に付与 |\["iost" "iost"\] は \[0 0 0 2 0 0 0 4 105 111 115 116 0 0 0 4 105 111 115 116\]
    map     |ディクショナリ内のキーと値の各ペアをバイト配列に変換して分けておき、キーの昇順にして、各ペアの前に長さを付与 |\["b":"iost", "a":"iost"\] は \[0 0 0 2 0 0 0 1 97 0 0 0 4 105 111 115 116 0 0 0 1 98 0 0 0 4 105 111 115 116\] "

    トランザクションのパラメータは、 "time"、 "expiration"、 "gas_ratio"、 "gas_limit"、 "delay"、 "chain_id"、 "signers"、 "actions"、 "amount_limit"、"signature"の順に宣言されています。そのため、トランザクション構造体をバイト配列に変換する疑似コードは次のようになります。
	```
	func TxToBytes(t transaction) []byte {
			return Int64ToBytes(t.time) + Int64ToBytes(t. expiration) + 
			 		Int64ToBytes(int64(t.gas_ratio * 100)) + Int64ToBytes(int64(t.gas_limit * 100)) +     // Node that gas_ratio and gas_limit need to be multiplied by 100 and convert to int64
		 			Int64ToBytes(t.delay) + Int32ToBytes(t.chain_id) + 
		 			ArrayToBytes(t.signers) + ArrayToBytes(t.actions)  +
		 			ArrayToBytes(t.amount_limit) + ArrayToBytes(t.signatures)
		}
	```
        
    Go言語実装については、[go-iost](https://github.com/iost-official/go-iost/blob/develop/core/tx/tx.go#L410)を参照してください。JavaScript実装については、、[iost.js](https://github.com/iost-official/iost.js/blob/master/lib/structs.js#L68)を参照してください。
    
* **SHA3アルゴリズムでバイト配列のハッシュを計算**
    
    前のステップで取得したバイト配列のハッシュを計算するには、使用する言語のSHA3ライブラリを使ってください。
    
* **秘密鍵でハッシュに署名**
    
    IOSTは、Ed25519とSecp256k1の２つの非対称暗号化アルゴリズムをサポートしています。２つのアルゴリズムは同じ署名手順で、公開鍵と秘密鍵のペアを生成し、前のステップのハッシュに署名します。
    
    "publisher\_sigs"の秘密鍵は、トランザクションの"publisher"アカウントでなければなりません。"signatures"の秘密鍵は、署名者アカウントでなければなりません。"signatures"は複数署名で使用され、必須ではありません。"publisher\_sigs"は、必須です。トランザクション実行のための手数料は、パブリッシャーアカウントから引き落とされます。
    
### リクエストの例

"testaccount"アカウントが、100IOSTを"anothertest"アカウントに送金するトランザクションを持っているとします。

* **トランザクションの構築**

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
    
* **ハッシュの計算**

    シリアライズしハッシュの計算をすると、"nVJUdaE7JoWAA2htD8e/5QL+PoaUqgo+tLWpNfFI5OU="というハッシュが得られます。
    
* **署名の計算**

    ED25519アルゴリズムによる公開鍵"lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY="、秘密鍵"gkpobuI3gbFGstgfdymLBQAGR67ulguDzNmLXEJSWaGUNL5J0z5qJUdsPJdqm+uyDIrEWD2Ym4dY9lv8g0FFZg=="を"testaccount"が持っているとします。ハッシュを秘密鍵で署名すると、"yhk086dBH1dwG4tgRri33bk5lbs8OoT9o7Ar6wMrTPQwVQQoWUgswnhEgXvNz9DOdXQrDFDHNs9qrF5pwaqxCg=="が得られます。

* **トランザクションのパブリッシュ**

    完全なトランザクションパラメータは、次のようになります。
    
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
				"signature": "yhk086dBH1dwG4tgRri33bk5lbs8OoT9o7Ar6wMrTPQwVQQoWUgswnhEgXvNz9DOdXQrDFDHNs9qrF5pwaqxCg==",
			},
		],
	}
    ```
    
    構造をJSONでシリアライズした後、次のRPCが送信できます。
    
    ```
   curl -X POST http://127.0.0.1:30001/sendTx -d '{"actions":[{"action_name":"transfer","contract":"token.iost","data":"[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]"}],"amount_limit":[{"token":"*","value":"unlimited"}],"delay":0,"chain_id":1024, "expiration": 1547288372121046000,"gas_limit":500000,"gas_ratio":1,"publisher":"testaccount","publisher_sigs":[{"algorithm":"ED25519","public_key":"lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=","signature":"yhk086dBH1dwG4tgRri33bk5lbs8OoT9o7Ar6wMrTPQwVQQoWUgswnhEgXvNz9DOdXQrDFDHNs9qrF5pwaqxCg=="}],"signatures":[],"signers":[],"time": 1547288214916966000}'
    ```

## /execTx
##### POST

トランザクションをノードへ送信すると、すぐに実行されます。これは、チェーンでの合意を求めることも、このトランザクションが持続することもありません。

このAPIはテスト用コントラクトが期待通り実行されるかどうかをチェックするために使用されます。明らかに、呼び出し時刻が違いますので、execTxはオンチェーンでの実行で同じ動作を保証しません。

### リクエスト

このAPIは/sendTxのパラメータと共通です。

### レスポンス

このAPIは/getTxReceiptByTxHashのレスポンスと共通です。


## /subscribe
##### **POST**

スマートコントラクト内で発生したイベントや完了したトランザクションを含むイベントをサブスクライブします。

### リクエスト

リクエストは次のようになります。

```
curl -X POST http://127.0.0.1:30001/subscribe -d '{"topics":["CONTRACT_RECEIPT"], "filter":{"contract_id":"token.iost"}}'
```
| キー | 型 | 説明 |
| :----: | :-----: | :------ |
| topics |enumの繰り返し  | トピック。列挙は CONTRACT\_EVENT または CONTRACT\_RECEIPT|
| filter | [Filter](#filter)  | 受信イベントはフィルター内のフィールドに従ってフィルタリングされる。このフィールドを渡さないと、すべてのトピックを受け取る |
### Filter
| キー | 型 | 説明 |
| :----: | :-----: | :------ |
| contract_id | string | コントラクトID|



### レスポンス

成功レスポンスの例

```
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646637413936000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646637711757000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646638013188000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646638317840000"}}}
...
```
| キー | 型 | 説明 |
| :----: | :--------: | :------ |
| topic | 列挙  | トピック、topic，列挙は CONTRACT\_EVENT または CONTRACT\_RECEIPT|
| data | string  |イベントデータ|
| time | int64  | イベントのタイムスタンプ|
