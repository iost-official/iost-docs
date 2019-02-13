---
id: iWallet
title: コマンドラインウォレットツール
sidebar_label: コマンドラインウォレットツール
---

iwalletは、IOSTはブロックチェーンのコマンドラインツールです。

このツールで、ブロックチェーンに接続し、送金したり、アカウントを作成したり、残高を確認したり、コントラクトを呼び出したりできます。
iwalletと[API](6-reference/API.md)は、共にRPC APIを内部で使っていで、同様の機能を持っています。
  
## インストール

まず、最初に[Go言語のインストール](4-running-iost-node/Building-IOST.html#install-golang)をしてください。

Go言語をインストール後、次のコマンドでiwalletをインストールできます。

```
go get github.com/iost-official/go-iost/cmd/iwallet
```

ブロックチェーンにコントラクトをパブリッシュしたいなら、[Node.js](https://nodejs.org/en/download/)を先にインストールしてください。

上のステップを一度完了したら、`iwallet`を実行すると、次の使い方情報が表示されます。

```
iwallet
```

    An IOST RPC client

    Usage:
      iwallet [command]

    Available Commands:
      account     KeyPair manager
      balance     Check the information of a specified account
      block       Print block info
      call        Call the method in contracts
      compile     Generate contract abi
      help        Help about any command
      key         Create a key pair
      publish     Publish a contract
      receipt     Find receipt
      save        Save a transaction request with given actions to a file
      sign        Sign a tx loaded from given file and save the signature as a binary file
      state       Get blockchain and node state
      system      Send system contract action to blockchain
      transaction Find transactions

    Flags:
          --account string                 which account to use
          --amount_limit string            amount limit for one transaction (e.g. "iost:300.00|ram:2000" or "*:unlimited" for no limits) (default "*:unlimited")
          --chain_id uint32                chain id which distinguishes different network (default 1024)
          --check_result                   check publish/call status after sending to chain (default true)
          --check_result_delay float32     rpc checking will occur at [checkResultDelay] seconds after sending to chain. (default 3)
          --check_result_max_retry int32   max times to call grpc to check tx status (default 20)
          --config string                  configuration file (default $HOME/.iwallet.yaml)
      -e, --expiration int                 expiration time for a transaction in seconds (default 300)
      -l, --gas_limit float                gas limit for a transaction (default 1e+06)
      -p, --gas_ratio float                gas ratio for a transaction (default 1)
      -h, --help                           help for iwallet
      -s, --server string                  set server of this client (default "localhost:30002")
          --sign_algo string               sign algorithm (default "ed25519")
          --tx_time string                 use the special tx time instead of now, format: 2019-01-22T17:00:39+08:00
          --use_longest                    get info on longest chain
      -v, --verbose                        print verbose information

    Use "iwallet [command] --help" for more information about a command.

## 基本機能

### アカウント情報の照会

iwalletで、残高、RAM,GASなどのアカウント情報を調べることができます。
出力形式は、[getAccountInfo API](6-reference/API.md#getaccount-name-by-longest-chain)と同じです。

コマンドの`--server`フラグには、リモートIOSTサーバーを指定します。もし、[ローカルでサーバーを起動](LocalServer.md)するなら、フラグなしでデフォルト値を使用できます(localhost:30002)。後のセクションではこのフラグを省略します。

```
iwallet --server 127.0.0.1:30002 balance xxxx
```

    {
        "name": "xxxx",
        "balance": 993939670,
        "createTime": "0",
        "gasInfo": {
            "currentTotal": 2994457,
            "increaseSpeed": 11,
            "limit": 3000000,
            "pledgedInfo": ...
        },
        "ramInfo": {
            "available": "90000",
            "used": "10000",
            "total": "100000"
        },
        "permissions": ...
        "groups": {
        },
        "frozenBalances": [
        ],
        "voteInfos": [
        ]
    }

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
このコマンドは秘密鍵を`~/.iwallet/YOUR_ACCOUNT_ID_ed25519`にコピーします。ブロックチェーンとのやり取りなしでローカルで行われます。

```
iwallet account import <account_id> <private_key>
```
#### 使用法 - コントラクトの呼び出し

```
iwallet --account <account_name> [flags] call <contract_name> <function_name> '["arg1","arg2",...]'
```

| フラグ  | 説明 | デフォルト |
| :----: | :-----: | :------ |
| server | 接続するためのiserverアドレス  | localhost:30002 |
| account | コントラクトの呼び出し元 | *<ユーザー指定>* |
| gas_limit | 呼び出しに許容される最大GAS | 1000000 |
| gas_ratio | gas_ratioを大きくするとより速く実行される | 1.0 |
| amount_limit | トークン量の上限 (IOST:300.0&#124;RAM:2000) | \*:無制限 |
| verbose | 詳細情報の表示 | false |

#### サンプル：トークンの転送

`admin`により'token.iost'コントラクトの'transfer'を呼び出します。
このコマンドの最後の引数は、'transfer'関数のパラメータで、トークンの型、支払者、受信者、送信量、追加情報です。

```
iwallet --account admin call 'token.iost' 'transfer' '["iost","admin","lispczz","100",""]'
```

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: CzQi1ro44E6ysVq6o6c6UEqYNrPbN7HruAjewoGfRTBy
    Checking transaction receipt...
    SUCCESS!

### アカウントの作成

アカウントを作成すると、ランダムなキーペアが生成され、秘密鍵が`~/.iwallet/YOUR_ACCOUNT_ID_ed25519`に保存されます。

#### 使用法 - アカウントの作成

新しいアカウントを作成するにはコントラクト呼び出しが必要ですので、すべての[契約を呼び出すためのフラグ](#usage-call-contract)が必要です。

```
iwallet --account <account_name> [flags] account create <new_account_name>
```

| フラグ  | 説明 | デフォルト |
| :----: | :-----: | :------ |
| account | 新アカウントの作成者 | *<ユーザー指定>* |
| initial_ram | 新規アカウントのために作成者が買うRAM量| 1024 |
| initial\_gas\_pledge | 新規アカウントの作成者がプレッジするIOSTのGAS量| 10 |
| initial_balance | アカウントの作成者に転送されるIOSTの量| 0 |

#### サンプル - アカウントの作成

```
iwallet --account admin --amount_limit "ram:1000|iost:10" account create lispczz3 --initial_balance 0 --initial_gas_pledge 10 --initial_ram 0
```

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 6519HCdkDpB29FqMeGWQVY82fjicWyjbwdV99CPNeRCW
    Checking transaction receipt...
    SUCCESS!
    Account info of < test1 >:
    {
    ...
    }
    The IOST account ID is: test1
    Owner permission key: 7Z9US64vfcyopQpyEwV1FF52HTB8maEacjU4SYeAUrt1
    Active permission key: 7Z9US64vfcyopQpyEwV1FF52HTB8maEacjU4SYeAUrt1
    Your account private key is saved at: /Users/iost/.iwallet/lispczz3_ed25519

### コントラクトのパブリッシュ

Javascriptのコントラクトをパブリッシュするためには、最初にABIファイルを生成します。次のステップでJavaScriptファイルとABIファイルをブロックチェーンにパブリッシュします。

#### ABIの生成

次のコマンドで、`example.js.abi`ファイルが作成されます。(メモ `node.js` をインストールして、`iwallet/contract`フォルダ内で`npm install`を実行していることを確認してください)

```
iwallet compile example.js
```

生成されたABIファイルは通常は調整する必要があります。パラメータ型とアクションの量の制限は、常に実際の使い方によって調整する必要があります。

#### コントラクトのパブリッシュ

```
iwallet --account admin --amount_limit "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
```

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa
    Checking transaction receipt...
    SUCCESS!
    The contract id is: Contract2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa
    
最終行の`ContractXXX`はコントラクト名で、後でこのコントラクトを呼び出す場合に必要になります。

## 高度な機能

### ブロックの照会

高さが10のブロックの情報を取得します。

```
iwallet block --method num 10
```

ハッシュが、6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU のブロックを取得します。

```
iwallet block --method hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
```

### トランザクション情報の照会

#### トランザクションの詳細の取得

出力形式は、[getTxByHash API](6-reference/API.md#gettxbyhash-hash])と同じです。

```
iwallet transaction 3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx
```

    {
        "status": "IRREVERSIBLE",
        "transaction": {
            "hash": "3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx",
            "time": "1545470082534696000",
            "expiration": "1545470382534696000",
            "gasRatio": 1,
            "gasLimit": 1000000,
            "delay": "0",
            "chainId": 1024,
            "actions": [
                {
                    "contract": "token.iost",
                    "actionName": "transfer",
                    "data": "[\"iost\",\"admin\",\"admin\",\"10\",\"\"]"
                }
            ],
            "signers": [
            ],
            "publisher": "admin",
            "referredTx": "",
            "amountLimit": ...
            "txReceipt": ...
        }
    }

#### トランザクションハッシュによるトランザクションレシートの取得

出力形式は、[getTxReceiptByTxHash API](6-reference/API.md#gettxreceiptbytxhash-hash)と同じです。

```
iwallet receipt 3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx
```

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
