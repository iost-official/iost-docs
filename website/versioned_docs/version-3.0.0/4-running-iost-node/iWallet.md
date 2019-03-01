---
id: version-3.0.0-iWallet
title: Command Line Wallet Tool
sidebar_label: Command Line Wallet Tool
original_id: iWallet
---

`iwallet` is the command line tool for IOST blockchain. You can use this tool to connect IOST blockchain to transfer coins, create accounts, query balance or call contracts.

Both `iwallet` and [API](6-reference/API.md) use RPC API inside and they have similar features.

## Install

You need to [install golang](Building-IOST.html#install-golang) firstly before you get `iwallet` by the following command:

```
go get github.com/iost-official/go-iost/cmd/iwallet
```

Please install [Node.js](https://nodejs.org/en/download/) if you want to [publish contracts onto the blockchain](#publish-contract).

## Basic Usage

You could run `iwallet` and get the following usage information once you finish the steps above:

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
      sign        Sign a tx and save the signature
      state       Get blockchain and node state
      system      Send system contract action to blockchain
      table       Fetch stored info of given contract
      transaction Find transactions
      transfer    Transfer IOST

    Flags:
      -a, --account string                 which account to use
          --amount_limit string            amount limit for one transaction, eg iost:300.00|ram:2000 (default "*:unlimited")
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
          --signers strings                additional signers
          --tx_time string                 use the special tx time instead of now, format: 2019-01-22T17:00:39+08:00
          --use_longest                    get info on longest chain
      -v, --verbose                        print verbose information (default true)

    Use "iwallet [command] --help" for more information about a command.

For more information about a command like `system` by following:

```
iwallet system --help
```

    Send system contract action to blockchain

    Usage:
      iwallet system [command]

    Aliases:
      system, sys

    Examples:
      iwallet system producer-list
      iwallet sys producer-list
      iwallet sys plist

    Available Commands:
      gas-pledge          Pledge IOST to obtain gas
      gas-unpledge        Undo pledge
      producer-clean      Clean producer info
      producer-info       Show producer info
      producer-list       Show current/pending producer list
      producer-login      Producer login as online state
      producer-logout     Producer logout as offline state
      producer-redeem     Redeem the contribution value obtained by the block producing to IOST tokens
      producer-register   Register as producer
      producer-unregister Unregister from a producer
      producer-unvote     Unvote a producer
      producer-update     Update producer info
      producer-vote       Vote a producer
      producer-withdraw   Withdraw all voting reward for producer
      ram-buy             Buy ram from system
      ram-sell            Sell unused ram to system
      ram-transfer        Transfer ram
      voter-withdraw      Withdraw all voting reward for voter

    Flags:
      -h, --help   help for system

    Global Flags:
      -a, --account string                 which account to use
          --amount_limit string            amount limit for one transaction, eg iost:300.00|ram:2000 (default "*:unlimited")
          --chain_id uint32                chain id which distinguishes different network (default 1024)
          --check_result                   check publish/call status after sending to chain (default true)
          --check_result_delay float32     rpc checking will occur at [checkResultDelay] seconds after sending to chain. (default 3)
          --check_result_max_retry int32   max times to call grpc to check tx status (default 20)
          --config string                  configuration file (default $HOME/.iwallet.yaml)
      -e, --expiration int                 expiration time for a transaction in seconds (default 300)
      -l, --gas_limit float                gas limit for a transaction (default 1e+06)
      -p, --gas_ratio float                gas ratio for a transaction (default 1)
      -s, --server string                  set server of this client (default "localhost:30002")
          --sign_algo string               sign algorithm (default "ed25519")
          --signers strings                additional signers
          --tx_time string                 use the special tx time instead of now, format: 2019-01-22T17:00:39+08:00
          --use_longest                    get info on longest chain
      -v, --verbose                        print verbose information (default true)

    Use "iwallet system [command] --help" for more information about a command.

In above examples, you may find some flags (like `--account`) have the corresponding shortcut flag (like `-a`) that has exactly same effect. And there are some commands that would have corresonding shortcuts (like `system` has an alias `sys`). But for clarity, we will use the full name flags and full name commands instead of shortcuts in following sections.

The verbose information of a command will commonly include RPC connecting information, elapsed time and transaction details if it contains a transaction sending action. We will omit the verbose information in following output examples for concise.

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
    Account info of < lispczz3 >:
    {
    ...
    }
    The IOST account ID is: lispczz3
    Owner permission key: 7Z9US64vfcyopQpyEwV1FF52HTB8maEacjU4SYeAUrt1
    Active permission key: 7Z9US64vfcyopQpyEwV1FF52HTB8maEacjU4SYeAUrt1
    Your account private key is saved at: /Users/iost/.iwallet/lispczz3_ed25519

### Publish Contract

To publish a javascript contract, you need to generate abi file firstly, and then publish javascript file and abi file onto blockchain.

#### Generate ABI

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

### Transfer IOST Tokens

Transfer 100 IOST tokens to user `test1` by user `test0`:

```
iwallet transfer test1 100 --account test0
```

### Get Reward

Check [reward](2-intro-of-iost/Economic-model.md#reward) for more information about the reward model.

#### Redeem Contribution Value

Redeem all contribution value to IOST tokens:

```
iwallet sys producer-redeem --account test0
```

Redeem 100 contribution value to 100 IOST tokens:

```
iwallet sys producer-redeem 100 --account test0
```

#### Get Producer Voting Reward

If user `test0` is a producer:

```
iwallet sys producer-withdraw --account test0
```

#### Get Voter Voting Reward

If user `test0` is a voter:

```
iwallet sys voter-withdraw --account test0
```

####

## Advanced features

### Query Block

Get information about the block at height 10:

```
iwallet block --method num 10
```

Get information about the block with hash `6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU`:

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

#### Get Transaction Receipt Detail

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

### Producer Related

Check [Become Servi Node](Become-Servi-Node) for real examples about producer related commands.

### Advanced Account Management
You can use a password to encrypt your local private key file.

```
$ iwallet account import --encrypt lispczz 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
encrypting seckey, need password
Enter Password:
Repeat Password:
import account lispczz done
```

Once your local key file is encrypted, you need input password from command line to send transactions later.

```
$ iwallet --account lispczz call ram.iost buy '["lispczz","lispczz",1000]'
Enter Password:
Repeat Password:
decrypt keystore succeed
Sending transaction...
Transaction:
{
    "time": "1550654357305753000",
    ...
```    

You can use the password to dump the private key to the console.

```
$ iwallet account dumpkey lispczz
Enter Password:
Repeat Password:
decrypt keystore succeed
active:2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
owner:2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```

## Account Permission Related Commands
[IOST Account Document] (2-intro-of-iost/Account.md)

### Add permissions
The addperm command is equivalent to [addPermission](6-reference/SystemContract.md#addPermission)

```
Iwallet sys addperm myperm 100

...
SUCCESS!
Transaction receipt:
{
    "txHash": "BqbRLp7QinvmryBiq3m2cLdEZno4zUn3VVphMg7cU7SN",
    "gasUsage": 41792,
    "ramUsage": {
        "admin": "457",
        "auth.iost": "-399" #If it is the first time to add permissions, the transfer ram will be transferred to the user name
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

### Delete permission
The dropperm command is equivalent to [dropPermission](6-reference/SystemContract.md#dropPermission)

```
Iwallet sys dropperm myperm

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

### Add a reference to a permission or other permission
The assignperm command is equivalent to [assignPermission](6-reference/SystemContract.md#assignPermission)

```
Iwallet sys assignperm myperm pub_key_in_base58 100

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

### Delete key, permission reference
The revokeperm command is equivalent to [revokePermission](6-reference/SystemContract.md#revokePermission)

```
Iwallet sys revokeperm myperm pub_key_in_base58

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

### Add permission group
The addgroup command is equivalent to [addGroup](6-reference/SystemContract.md#addGroup)

```
Iwallet sys addgroup mygroup

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

### Delete permission group
The dropgroup command is equivalent to [dropGroup](6-reference/SystemContract.md#dropGroup)

```
Iwallet sys dropgroup mygroup

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

### Add a key or reference to a group
The assigngroup command is equivalent to [assigngroup](6-reference/SystemContract.md#assigngroup)

```
Iwallet sys assigngroup mygroup pub_key_in_base58 100

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

### Remove a key or reference from a group
The revokegroup command is equivalent to [revokeGroup](6-reference/SystemContract.md#revokeGroup)

```
Iwallet sys revokegroup mygroup pub_key_in_base58

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

### Add permissions to the group
The bindperm command is equivalent to [assignPermissionToGroup](6-reference/SystemContract.md#assignPermissionToGroup)

```
Iwallet sys bindperm myperm mygroup

SUCCESS!
Transaction receipt:
{
    "txHash": "4yCZLoyPmFo7wz5q

