---
id: iWallet
title: Command Line Wallet Tool
sidebar_label: Command Line Wallet Tool
---

iwallet is the command line tool for IOST blockchain.   
You can use this tool to connect to the blockchain to transfer coins/create accounts/query balance/call contracts.     
iwallet and [API](../6-reference/API) use RPC API inside both. They have similar features.   
  
## Building
You should [build IOST](Building-IOST) firstly.   
If you plan to publish contracts onto the blockchain, you should install nodejs and npm firstly, then run the following command.   
If you do not need publishing contracts, you can skip the following command.      
``` 
cd $GOPATH/src/github.com/iost-official/go-iost
cd iwallet/contract
npm install
```
## Basic Features
### Query Account
iwallet can be used to query account information including balance, RAM, GAS etc.      
Output format is same as [getAccountInfo API](../6-reference/API#getaccount-name-by-longest-chain) .     
The `--server` flag inside the command indicates the remote IOST server. If you [launch server locally](LocalServer)，yon can skip the flag, using the default value (localhost:30002).      

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
### Query Blockchain information
Query information of blockchain and server node. The output is combination of [getNodeInfo](../6-reference/API#getnodeinfo) and [getChainInfo](../6-reference/API#getchaininfo).  

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
  
### Call Contract
#### Import Account
An account must be imported before calling any contracts.   

```
# This command will copy private key to ~/.iwallet/YOUR_ACCOUNT_ID_ed25519. It is done locally without any interaction with blockchain. 
iwallet account --import $YOUR_ACCOUNT_ID $YOUR_PRIVATE_KEY 
```
#### Command Line Usage

```
iwallet --account <ACCOUNT_NAME> [other flags] call <CONTRACT_NAME> <ACTION_NAME> '["ARG1",ARG2,...]'
```

| Flag  | Description | Default |
| :----: | :-----: | :------ |
| server | iserver address to connect  | localhost:30002 |
| account | who calls the contract | None, needed |
| gas_limit | max gas allowed for the calling | 1000000 |
| gas_ratio | transaction with bigger gas_ratio will be exectuted sooner | 1.0 |
| amount_limit | all token amount limits | None, needed. Like iost:300.0&#124;ram:2000. "*:unlimited" means no limit |

#### Sample：transfer token
`admin` call function 'transfer' of contract 'token.iost'    
The last argument of the command is parameters for 'transfer' the action. They are token type, payer, receiver, amount, and additional info here.   

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

### Create Account
#### Command Line Usage

```
iwallet --server <server_addres> --account <account_name> --amount_limit  <amount_limit> account --create <new_account_name> [other flags] 
```

| Flag  | Description | Default |
| :----: | :-----: | :------ |
| create | new account name  | None, needed |
| initial_ram | ram amount bought for new account by creator| 1024 |
| initial\_gas\_pledge | IOST amount pledged for gas for new account by creator| 10 |
| initial_balance | IOST amount transferred to new account by creator| 0 |
Creating new account needs calling contracts, so besides the above flags, all [call](#command-line-usage) flags are also needed.   

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
### Publish Contract
To publish javascript contract, first step is to generate abi file, second step is to publish javascript file and abi file onto blockchain.   
#### Generate abi
Make sure node.js has been installed, and `npm install` inside iwallet/contract folder has been run.

```
# example.js.abi will be generated
iwallet compile example.js
```

Usually abi file generated needed to be adjusted, action parameter type and action amount limit may be adjusted according to your actual usage.

#### Publish Contract
```
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh

```
`ContractXXX` of last line output is the contract name, which is needed if one wants to call the new uploaded contract later.   

## Advanced features
### Query Block

```
# Get information about block at height 10
iwallet block --method num 10
# Get information about block with hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
iwallet block --method hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
```
### Query Transaction Information
#### Get Transaction Detail
`transaction` is same as [getTxByHash API](../6-reference/API#gettxbyhash-hash])

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
#### Get transaction receipt by transaction hash
`receipt` is same as [getTxReceiptByTxHash API](../6-reference/API#gettxreceiptbytxhash-hash)

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