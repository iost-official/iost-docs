---
id: version-3.0.0-ContractStart
title: Smart Contract Quick Start
sidebar_label: Smart Contract Quick Start
original_id: ContractStart
---


# Getting start of DApp development

## IOST DApp Basics
A blockchain can be abstracted as a state machine that is synchronized across the network. A smart contract is code that executes on a blockchain system and changes the state in the state machine through transactions. Due to the characteristics of the blockchain, the call of the smart contract can be guaranteed to be serial and globally consistent.

The IOST Smart Contract currently supports JavaScript (ES6) development.

An IOST smart contract contains code for smart contracts and a JSON file to describe the ABI, which has its own namespace and isolated storage. External can only read its storage content

### Key words

| Keywords | Description |
| :-- | :-- |
| ABI | Smart Contract Interface, which can only be called externally via a declared interface |
Tx | transaction, the state on the blockchain must be modified by submitting tx, tx is packaged into the block |
|


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
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
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
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
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

## Smart Contract State Storage

The use of smart contract output (similar to the concept of utxo) is inconvenient, IOST does not use this mode, so IOST does not provide an index on each field in TxReceipt, and the smart contract can not access a specific TxReceipt. To maintain the blockchain state machine, we use a blockchain state database to hold the state.

The database is a pure K-V database, the key, value type is string. Each smart contract has a separate namespace.
Smart contracts can read status data from other smart contracts, but can only write their own fields.

### Coding
```
class Test {
    init() {
        storage.put("value1", "foobar")
    }
    read() {
        console.log(storage.get("value1"))
    }
    change(someone) {
        storage.put("value1", someone)
    }
}
module.exports = Test;
```
Abi skip

### Using state storage
After deploying the code, you can get the storage by the following method
```
curl -X POST \
  http://localhost:30001/getContractStorage \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "id": "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e",
    "key": "value1",
    "by_longest_chain": true
}'
```
This post will return a json
```
{
    "data": "foobar"
}
```
This value can be modified by calling change.
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e" "change" '["foobaz"]'
```

## Permission Control and Smart Contract Failure

The basis of permission control can be found at:

Example
```
if (!blockchain.requireAuth("someone", "active")) {
    throw "require auth error" // throw that is not caught will be thrown to the virtual machine, causing failure
}
```
Need to pay attention to the following points
1. requireAuth itself does not terminate the operation of the smart contract, it only returns a bool value, so you need to judge
2. requireAuth(tx.publisher, "active") is always true

When throw, the transaction fails to run, this smart contract call is completely rolled back, but will deduct the gas cost of the user running the transaction (because it is rolled back, it will not charge ram)

You can observe a failed transaction with a simple test.
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "token.iost" "transfer" '["iost", "someone", "me". "10000.00", "this is steal"]'
```
The result will be

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 6KY4h4gKHFwuovXZJEDzvPtN9YYcJ5kUFHLf84gktYYu
    Checking transaction receipt...
    running action Action{Contract: token.iost, ActionName: transfer, Data: ["iost", "someone", "me". "10000.00", "this... error: prepare contract: error in data: invalid character '.' after array element, ["iost", "someone", "me". "10000.00", "this is steal"]

## Debugging

First start the local node as described above. If you use docker, you can use the following command to print the log.
```
docker ps -f <container>
```

At this point, you can add the required log in the code by adding console.log(), the following is the log output in the storage example.

```
Info 2019-01-08 06:44:11.110 pob.go:378 Gen block - @7 id:IOSTfQFocq..., t:1546929851105164574, num:378, confirmed:377, txs:1, pendingtxs:0, et: 4ms
Info 2019-01-08 06:44:11.416 value.go:447 foobar
Info 2019-01-08 06:44:11.419 pob.go:378 Gen block - @8 id:IOSTfQFocq..., t:1546929851402828690, num:379, confirmed:378, txs:2, pendingtxs:0, et: 16ms
```
