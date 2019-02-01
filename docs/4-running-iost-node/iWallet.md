---
id: iWallet
title: Command Line Wallet Tool
sidebar_label: Command Line Wallet Tool
---

`iwallet` is the command line tool for IOST blockchain. You can use this tool to connect IOST blockchain to transfer coins, create accounts, query balance or call contracts.

Both `iwallet` and [API](6-reference/API.md) use RPC API inside and they have similar features.

## Install

You could run `iwallet` and get the following usage information once you finish the steps in [building IOST](4-running-iost-node/Building-IOST.md).

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

## Basic Features

### Query Account

`iwallet` can be used to query account information including balance, RAM, GAS etc.

Output format will be same as [getAccountInfo API](6-reference/API.md#getaccount-name-by-longest-chain).

The `--server` flag inside the following command indicates the remote IOST server. If you [launch server locally](4-running-iost-node/LocalServer.md), yon can skip this flag to use default value (localhost:30002) - we will omit this flag in following sections.

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

### Query Blockchain Information

Query information of blockchain and server node.

The output is combination of [getNodeInfo](6-reference/API.md#getnodeinfo) and [getChainInfo](6-reference/API.md#getchaininfo).

```
iwallet state
```

    {
        "buildTime": "20181208_161822+0800",
        "gitHash": "c949172cb8063e076b087d434465ecc4f11c3000",
        "mode": "ModeNormal",
        "network": {
            "id": "12D3KooWK1ALkQ6arLJNd5vc49FLDLaPK931pggFr7X49EA5yhnr",
            "peerCount": 0,
        }
        "netName": "debugnet",
        "protocolVersion": "1.0",
        "chainId": 1024,
        "headBlock": "9408",
        "headBlockHash": "FKtcg2qgUnfuXNe6Zz6p2CJMLSUjDSSK2PrvzPtpA3jp",
        "libBlock": "9408",
        "libBlockHash": "FKtcg2qgUnfuXNe6Zz6p2CJMLSUjDSSK2PrvzPtpA3jp",
        "witnessList": [
            "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
        ]
    }

### Call Contract

#### Import Account

An account must be imported before calling any contracts.  
This command will copy private key to `~/.iwallet/YOUR_ACCOUNT_ID_ed25519`. It is done locally without any interaction with blockchain.

```
iwallet account import <account_id> <private_key>
```

#### Usage - Call contract

```
iwallet --account <account_name> [flags] call <contract_name> <function_name> '["arg1","arg2",...]'
```

| Flag  | Description | Default |
| :----: | :-----: | :------ |
| account | who calls the contract | *< user specified >* |
| gas_limit | max gas allowed for the calling | 1000000 |
| gas_ratio | transaction with bigger gas_ratio will be exectuted sooner | 1.0 |
| amount_limit | all token amount limits (e.g. iost:300.0&#124;ram:2000) | \*:unlimited |
| verbose | print verbose infomation | false |

#### Sample - Transfer token by calling contract

Call function "transfer" of contract "token.iost" by account "admin".  
The last argument of this command is the parameters for function "transfer" which are token type, payer, receiver, amount and optional memo.

```
iwallet --account admin call 'token.iost' 'transfer' '["iost","admin","lispczz","100",""]'
```

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: CzQi1ro44E6ysVq6o6c6UEqYNrPbN7HruAjewoGfRTBy
    Checking transaction receipt...
    SUCCESS!

### Create Account

Creating account would generate a random keypair and save the private key to `~/.iwallet/YOUR_ACCOUNT_ID_ed25519`.

#### Usage - Create account

All [flags for calling contract](#usage-call-contract) are needed since creating new account needs calling contracts.

```
iwallet --account <account_name> [flags] account create <new_account_name>
```

| Flag  | Description | Default |
| :----: | :-----: | :------ |
| account | who create the new account | *< user specified >* |
| initial_ram | ram amount bought for new account by creator| 1024 |
| initial\_gas\_pledge | IOST amount pledged for gas for new account by creator| 10 |
| initial_balance | IOST amount transferred to new account by creator| 0 |

#### Sample - Create account

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

### Publish Contract

To publish a javascript contract, you need to generate abi file firstly, and then publish javascript file and abi file onto blockchain.

#### Generate abi

The following command will generate file `example.js.abi`.
(Note that make sure you have installed `node.js` and already ran the command `npm install` inside folder `iwallet/contract`.)

```
iwallet compile example.js
```

Usually you need to adjust the abi file that just generated since the parameter type and amount limit of action always need to be adjusted according to your actual usage.

#### Publish Contract

```
iwallet --account admin --amount_limit "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
```

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa
    Checking transaction receipt...
    SUCCESS!
    The contract id is: Contract2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa

`ContractXXX` of the last line in output is the contract name, which would be needed if one wants to call this new contract later.

## Advanced features

### Query Block

Get information about the block at height 10

```
iwallet block --method num 10
```

Get information about the block with hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU

```
iwallet block --method hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
```

### Query Transaction Information

#### Get Transaction Detail

Output format will be same as [getTxByHash API](6-reference/API.md#gettxbyhash]).

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

#### Get transaction receipt by transaction hash

Output format will be same as [getTxReceiptByTxHash API](6-reference/API.md#gettxreceiptbytxhash-hash).

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
