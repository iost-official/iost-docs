---
id: version-2.1.7-iWallet
title: コマンドラインウォレットツール
sidebar_label: コマンドラインウォレットツール
original_id: iWallet
---

iwalletは、IOSTはブロックチェーンのコマンドラインツールです。
このツールで、ブロックチェーンに接続し、送金したり、アカウントを作成したり、残高を確認したり、コントラクトを呼び出したりできます。

iwalletと[API](6-reference/API.md)は、RPC APIを内部で使っています。それは同様の機能を持っています。
  
## ビルド
最初に、[IOSTをビルド](Building-IOST.md)する必要があります。
ブロックチェーンにコントラクトをパブリッシュしたいなら、Node.jsとnpmをインストールし、次のコマンドを実行します。
コントラクトをパブリッシュしないのなら、次のステップは省略できます。
``` 
cd $GOPATH/src/github.com/iost-official/go-iost
cd iwallet/contract
npm install
```
## 基本機能
### アカウント情報の照会
iwalletで、残高、RAM,GASなどのアカウント情報を調べることができます。
出力形式は、[getAccountInfo API](6-reference/API.md#getaccount-name-by-longest-chain)と同じです。
コマンドの`--server`フラグには、リモートIOSTサーバーを指定します。もし、[ローカルでサーバーを起動](LocalServer.md)するなら、フラグなしでデフォルト値を使用できます(localhost:30002)。 

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
### ブロックチェーン情報の照会
ブロックチェーンとサーバーノードの情報を照会します。出力は、[getNodeInfo](6-reference/API.md#getnodeinfo)と[getChainInfo](6-reference/API.md#getchaininfo)を合わせたものになります。

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
  
### コントラクトの呼び出し
#### アカウントのインポート
コントラクトを呼び出す前に、アカウントをインポートする必要があります。

```
# This command will copy private key to ~/.iwallet/YOUR_ACCOUNT_ID_ed25519. It is done locally without any interaction with blockchain. 
iwallet account --import $YOUR_ACCOUNT_ID $YOUR_PRIVATE_KEY 
```
#### コマンドラインの使用法

```
iwallet --account <アカウント名> [other flags] call <コントラクト名> <アクション名> '["ARG1",ARG2,...]'
```

| フラグ  | 説明 | デフォルト |
| :----: | :-----: | :------ |
| server | 接続するためのiserverアドレス  | localhost:30002 |
| account | コントラクトの呼び出し元 | なし、必要 |
| gas_limit | 呼び出しに許容される最大GAS | 1000000 |
| gas_ratio | gas_ratioを大きくするとより速く実行される | 1.0 |
| amount_limit | トークン量の上限 | なし、必要。iost:300.0&#124;ram:2000に似ている。 "*:unlimited" は、無制限 |

#### サンプル：トークンの転送
`admin`は'token.iost'コントラクトの'transfer'を呼び出します。
コマンドの最後の引数は、'transfer'アクションのパラメータです。それは、トークンの型、支払い者、受診者、送信量、追加情報です。

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
    "gasUsage": 2172,
    "ramUsage": {
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

### アカウントの作成
#### コマンドラインの使用法

```
iwallet --server <server_addres> --account <account_name> --amount_limit  <amount_limit> account --create <new_account_name> [other flags] 
```

| フラグ  | 説明 | デフォルト |
| :----: | :-----: | :------ |
| create | 新規アカウント名  | なし、必要 |
| initial_ram | 新規アカウントの作成者が買うRAM量| 1024 |
| initial\_gas\_pledge | 新規アカウントの作成者がプレッジするIOSTのGAS量| 10 |
| initial_balance | アカウントの作成者に転送されるIOSTの量| 0 |
新規アカウントの作成は、コントラクトの呼び出しが必要があるので、上記のフラグ以外にすべての[呼び出し](#command-line-usage)フラグも必要です。

```
# After creating account,  random keypair is generated, and private key will be saved to ~/.iwallet/$(new_account_name)_ed25519    
iwallet --server 127.0.0.1:30002 --account admin --amount_limit "ram:1000|iost:10" account --create lispczz3 --initial_balance 0 --initial_gas_pledge 10 --initial_ram 0
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
### コントラクトのパブリッシュ
Javascriptのコントラクトをパブリッシュするためには、最初にABIファイルを生成します。次のステップでJavaScriptファイルとABIファイルをブロックチェーンにパブリッシュします。
#### ABIの生成
Node.jsがインストールされていることを確認して、iwallet/contractフォルダ内で、`npm install`を実行します。

```
# example.js.abi will be generated
iwallet compile example.js
```

通常は、生成されたABIファイルは調整する必要があり、アクションパラメータ型とアクションでの量の制限は実際の使用法によって調整する必要があるかもしれません。

#### コントラクトのパブリッシュ
```
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh

```
最終行の`ContractXXX`はコントラクト名で、後でアップロードした新しいコントラクトを呼び出す場合に必要です。

## 高度な機能
### ブロックの照会

```
# Get information about block at height 10
iwallet block --method num 10
# Get information about block with hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
iwallet block --method hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
```
### トランザクション情報の照会
#### トランザクションの詳細の取得
`transaction`は、[getTxByHash API](6-reference/API.md#gettxbyhash-hash])と同じです。

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
#### トランザクションハッシュによるトランザクションレシートの取得
`receipt`は、[getTxReceiptByTxHash API](6-reference/API.md#gettxreceiptbytxhash-hash)と同じです。

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
