---
id: version-3.1.0-ContractStart
title: Smart Contract Quick Start
sidebar_label: Smart Contract Quick Start
original_id: ContractStart
---


# Getting Start of Smart Contract development

## IOST Smart Contract Basics
A blockchain can be abstracted as a state machine that is synchronized across the network. A smart contract is code that executes on a blockchain system and changes the state in the state machine through transactions. Due to the characteristics of the blockchain, the call of the smart contract can be guaranteed to be serial and globally consistent. 

Smart contracts receive and execute transactions within the block, in order to maintain the variables of smart contract insides blockchain and produce irreversible proof. 

IOST achieved multi-language smart contracts. Currently, we are opening JavaScript(ES6) with v8 engine, and there are native golang VM modules to handle high-performance transactions but only for system contracts now.

An IOST smart contract contains code for smart contracts and a JSON file to describe the ABI, which has its own namespace and isolated storage. External can only read its storage content. 

Every transaction includes multiple transactional actions, and each action is a call to an ABI. All transactions will generate a strict serial on the chain, preventing double-spend attacks.

### Key words

| Keywords | Description |
| :-- | :-- |
| ABI | Smart Contract Interface, which can only be called externally via a declared interface |
Tx | transaction, the state on the blockchain must be modified by submitting tx, tx is packaged into the block |


## Debug environment configuration

### Setup iwallet and local test node

The development and deployment of smart contracts requires [iwallet](4-running-iost-node/iWallet.md). At the same time, [starting a local test node](4-running-iost-node/LocalServer.md) can facilitate debugging. 

### Importing the initial account ```admin``` for iwallet

In order to complete the test, you need to import an accouunt for iwallet.   
You can import the 'admin' account for the local test node.

```
iwallet account import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```


## Hello world

### Preparing the code
First prepare a JavaScript class. e.g HelloWorld.js

```
class HelloWorld {
    init() {} // needs to provide an init function that will be called during deployment
    hello(someone) {
        return "hello, "+ someone
    }
}

module.exports = HelloWorld;
```

The smart contract contains an interface that receives an input and then outputs ```hello, + enter ```. In order to allow this interface to be called outside the smart contract, you need to prepare the abi file. e.g HelloWorld.abi

```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "hello",
      "args": [
        "string"
      ]
    }
  ]
}
```

The name field of abi corresponds to the function name of js, and the args list contains a preliminary type check. It is recommended to use only three types: string, number, and bool.

## Publish to local test node

Publish smart contracts

```
iwallet \
 --server localhost:30002 \
 --account admin \
 publish helloworld.js helloworld.abi
```

Sample output

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa
    Checking transaction receipt...
    SUCCESS!
    The contract id is: Contract2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa

Test ABI call

```
iwallet \
 --server localhost:30002 \
 --account admin \
 call "Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf" "hello" '["developer"]' # contract id needs to be changed to the id you received
```

Output

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: CzQi1ro44E6ysVq6o6c6UEqYNrPbN7HruAjewoGfRTBy
    Checking transaction receipt...
    SUCCESS!

After that, you can get TxReceipt at any time by the following command.

```
iwallet receipt GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

Can also be obtained through http

```
curl -X GET \
  http://localhost:30001/getTxReceiptByTxHash/GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

It can be considered that this call will be permanently recorded by IOST and cannot be tampered with.

## IDE

Contract development can use an [online IDE](https://chainide.com/ "ide"). First, developers need to install [Chrome iwallet](https://chrome.google.com/webstore/detail/iwallet/kncchdigobghenbbaddojjnnaogfppfj?utm_source=chrome-ntp-icon "iwallet"), import accounts and purchase resources, and then develop, deploy and debug contracts based on IDE.

## Smart Contract State Storage

The use of smart contract output (similar to the concept of utxo) is inconvenient, IOST does not use this mode, so IOST does not provide an index on each field in TxReceipt, and the smart contract can not access a specific TxReceipt. To maintain the blockchain state machine, we use a blockchain state database to hold the state.

The database is a pure K-V database, the key, value type is string. Each smart contract has a separate namespace.
Smart contracts can read status data from other smart contracts, but can only write their own fields. 

Full APIs here: [Blockchain API](3-smart-contract/IOST-Blockchain-API.md)

### Coding
```
class Test {
    init() {
        storage.put("value1", "foobar")
    }
    get() {
        return storage.get("value1")
    }
    change(someone) {
        storage.put("value1", someone)
    }
}
module.exports = Test;
```

### Using state storage
After deploying the code, you can get the storage by the following method

```
curl -X POST \
  http://localhost:30001/getContractStorage \
  -d '{
    "id": "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e",
    "key": "value1",
    "by_longest_chain": true
}'
```

This post will return a json string:  

```
{
    "data": "foobar"
}
```

This value can be modified by calling change.

```
iwallet \
 --server localhost:30002 \
 --account admin \
 call "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e" "change" '["foobaz"]'
```

## Permission Control and Smart Contract Failure

The basis of permission control can be found at:

Example

```
if (!blockchain.requireAuth("someone", "active")) {
    throw "require auth error" // throw will be thrown to the virtual machine, causing failure
}
```

Need to pay attention to the following points. 

1. requireAuth itself does not terminate the operation of the smart contract, it only returns a bool value, so you need to judge it.
2. requireAuth(tx.publisher, "active") always returns true.

When throw, the transaction fails to run, this smart contract call is completely rolled back, but will deduct the gas cost of the user publishing the transaction (because it is rolled back, it will not cost ram).

You can observe a failed transaction with a simple test.

```
iwallet \
 --server localhost:30002 \
 --account admin \
 call "token.iost" "transfer" '["iost","someone","me","10","this is steal"]'
```

The result will be

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 6KY4h4gKHFwuovXZJEDzvPtN9YYcJ5kUFHLf84gktYYu
    Checking transaction receipt...
    ERROR: running action Action{Contract: token.iost, ActionName: transfer, Data: ["iost","someone","me","10","this is st... error: transaction has no permission

## Debugging

First start the local node as described above. If you use docker, you can use the following command to print the log.
```
docker ps -f <container>
```

At this point, you can add the required log in the code by adding console.log(). The argument passed to console.log() will be printed to stdout of the server process.

## ABI Interface Definition

IOST smart contracts interacts with the network through ABIs.

ABIs are JSON-defined information, including the name, parameter types, etc. The supported basic types are `string`, `number`, and `bool`.

More complicated data structures can be parsed to JSON string. When calling functions in a smart contract, ABI parameter types should be strictly followed. Otherwise the execution will halt and transaction fees will incur.

```json
// example luckybet.js.abi
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "bet",
            "args": [
                "string",
                "number",
                "number",
                "number"
            ],
            "amountLimit": [
            {
                "token": "iost",
                "val": "unlimited"
            },
            {
                "token": "sometoken",
                "val": "1000"
            }
            ]
        }
    ]
}
```

`amountLimit` indicates how many tokens can be spent by this ABI. In the above example, the ABI may cost unlimited `iost` token and at most 1000 `sometoken` token, and it cannot cost any other token or else the tx will be rolled back.

## Blockchain API
[Blockchain API](3-smart-contract/IOST-Blockchain-API.md) is provided. They can be used to interact with the blockchain. 

## Resource Limitation
Executing contract costs gas. Gas is charged according to [this table](6-reference/GasChargeTable.md).  
Every transaction must finish executing with 200ms, or else it will be killed and rolled back.


## Calling Other Contracts

In a smart contract you can use `blockchain.call()` to call an ABI interface, and obtain the return value.    

Calls between smart contracts can relay signature authorizations. For example, if `A.a` calls `B.b` using `blockchain.callWithAuth`, authorization to `B.b` from a user is implied when `A.a` is called. On the other hand, if `blockchain.call` is used, then the permissions will not passed. 

Smart contracts can check the stack of calling, and answer questions such as "Who invoked this ABI." This allows for certain operations to exist.

## System Contracts
[Econ Contracts](6-reference/EconContract.md) can be used to manage ram/gas.   
[Token Contracts](6-reference/TokenContract.md) can be used to issue/transfer tokens.   
[System Contracts](6-reference/SystemContract.md) includes contracts related to vote, account, contracts.


## Contract Update

Smart contracts can be updated if `can_update()` is defined. More details [here](3-smart-contract/Update-Contract.md)

## TxReceipt

After execution, the smart contract will generate a `TxReceipt` into the block and seek consensus. More details [here](3-smart-contract/Generate-Receipt)


