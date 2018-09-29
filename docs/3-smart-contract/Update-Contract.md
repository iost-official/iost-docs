---
id: Update-Contract
title: Update Contract
sidebar_label: Update Contract
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

### Create Contract

First create an account update using `iwallet` command, record the account ID returned on the screen
```console
./iwallet account -n update
return:
the iost account ID is:
IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h
```

Create a new contract file helloContract.js and its corresponding ABI file helloContract.json with following content
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "hello block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": []
        },
		{
			"name": "can_update",
			"args": ["string"]
		}
    ]
}
```
Look at the can_update() function implementation in the contract file, which allows the contract to be updated only when using the adminID account authorization.

### Deploy Contract

Please refer to [Deployment-and-invocation](../3-smart-contract/Deployment-and-invocation)

Remember to record contractID like ContractHDnNufJLz8YTfY3rQYUFDDxo6AN9F5bRKa2p2LUdqWVW

### Update Contract
First edit the contract file helloContract.js to generate a new contract code as follows:
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "update block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
We modified the implementation of the hello() function to change the contents of the "message" written to the database to "update block chain".

Use the following command to upgrade your smart contract:

```console
./iwallet compile -u -e 3600 -l 100000 -p 1 ./helloContract.js ./helloContract.json <合约ID> <can_update 参数> -k ~/.iwallet/update_ed25519
```
-u indicates to update contract, -k indicates the private key used for signing and publishing, here the account `update` is used to authorize the transaction

After the transaction is confirmed, you can call the hello() function via iwallet and check the contents of the database "message" to see the content changes.
