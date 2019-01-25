---
id: version-2.1.7-Update-Contract
title: Update Contract
sidebar_label: Update Contract
original_id: Update-Contract
---

## Features

After the contract is deployed to the blockchain, developers may face the need to update the contract, such as fixing bugs, version upgrades, etc.

We provide a complete contract update mechanism that allows developers to easily update smart contract by sending a transaction.
More importantly, we provide very flexible update permission control to meet any permission requirements.

In order to update the smart contract, you need to implement a function in the smart contract:
```js
can_update(data) {
}
```

When receiving a request to update the contract, the system will first call the can_update(data) function of the contract. data is an optional input parameter of type string. If the function returns true, the contract update is executed. Otherwise, a `Update Refused` error is returned.

By properly writing this function, you can implement any permission management requirements, such as:only update when two people authorize at the same time, or some people vote to decide whether to update the contract, etc.

If the function is not implemented in the contract, the contract is not allowed to update by default.

## Hello BlockChain

Below we take a simple smart contract as an example to illustrate the process of contract update.

Create a new contract file helloContract.js with following content
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello world";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }
};
module.exports = helloContract;
```
Look at the can_update() function implementation in the contract file, which allows the contract to be updated only when using the contract owner account authorization.

### Publish Contract

Please refer to [Publish Contract](4-running-iost-node/iWallet.md#publish-contract) for more explanation.
```
$ export IOST_ACCOUNT=admin # replace with your own account name here
$ iwallet compile hello.js
$ iwallet --account $IOST_ACCOUNT publish hello.js hello.js.abi
...
The contract id is ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### Call the Contract First Time
Now you call the `hello` function inside the contract you just uploaded, you will get 'hello world' as return.   
```
$ iwallet --account $IOST_ACCOUNT call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello world\"]"
    ],
    "receipts": [
    ]
}
```

### Update Contract
First edit the contract file helloContract.js to generate a new contract code as follows:
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello iost";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }
};
module.exports = helloContract;
```
We modified the implementation of the hello() function to change the return from 'hello world' to 'hello iost'.   

Use the following command to upgrade your smart contract:

```console
iwallet --account $IOST_ACCOUNT publish --update hello.js hello.js.abi ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### Call the Contract Second Time
After the transaction is confirmed, you can call the hello() function via iwallet again and find that the return changes from 'hello world' to 'hello iost'
```
$ iwallet --account $IOST_ACCOUNT call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello iost\"]"
    ],
    "receipts": [
    ]
}
```







