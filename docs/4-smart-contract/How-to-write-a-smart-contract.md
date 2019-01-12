---
id: How-to-write-a-smart-contract
title: How to Write a Smart Contract
sidebar_label: How to Write a Smart Contract
---

## Basic Information

### Language supported

Currently, IOST smart contracts supports JavaScript.

### Runtime environment

Internally, IOST employs [Chrome V8](https://developers.google.com/v8) engine to run the contracts.

## Smart Contract Programming Guides

### Implementing smart contracts

In IOST, smart contracts will be coded into a JavaScript `class`. When using it, you need to explicitly `export` the class.

#### Structure of a smart contract

A smart contract class must include `Init` functions.

- `Init` is run when a contract is deployed. It usually contains code to initialize properties of the contract.

Apart from these functions, developers can define other functions as needed. Below is a template of a simple smart contract that has `transfer` functionalities.

```javascript
class Test {
    init() {
        //Execute once when contract is packed into a block
    }

    transfer(from, to, amount) {
        //Function called by other
        blockchain.transfer(from, to, amount, "");
    }

};
module.exports = Test;
```

## IOST BlockChain API
There objects below can be accessed inside contract codes.

### storage object

All variables will be stored in memory in runtime. IOST provides `storage` object to help developers persist data in smart contracts.

Developers may use this class to synchronize data during multiple contract calls.
API [Here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js)



### blockchain object

blockchain object provides all methods for the system to call, and helps the user to call official APIs, including but not limited to transfering money, calling other contracts, and looking up a block or transaction.

Detailed interfaces are listed [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js).


### tx object and block object
tx object contains current transaction information.   
block object contrains current block information.   
API [Here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29)