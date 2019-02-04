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

A smart contract class must include `init` functions.

- `init` is run when a contract is deployed. It usually contains code to initialize properties of the contract.

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

Developers may use this class to synchronize data during multiple contract calls. Here list API of this object, you can also find details [in the code](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js).

#### put(key, value, payer)

Simply put a key-value pair into storage.
* Parameters:
	* key: string
	* value: string
	* payer: string
* Returns: none

#### get(key)

Simply retrieve the value from storage using key.
* Parameters:
	* key: string
* Returns: string of value if exists; `null` if non exists

#### has(key)

Check if the key exists in the storage.
* Parameters:
	* key: string
* Returns: bool (`true` if exists, `false` if non exists)

#### del(key)

Simply delete a key-value pair from storage using key.
* Parameters:
	* key: string
* Returns: none

#### mapPut(key, field, value, payer)

Map put a (key, field, value) pair. use key + field to find value.
* Parameters:
	* key: string
	* field: string
	* value: string
	* payer: string
* Returns: none

#### mapGet(key, field)

Map Get a (key, field) pair, use key + field to find value
* Parameters:
	* key: string
	* field: string
* Returns: string of value if exists; `null` if non exists

#### mapHas(key, field)

Map check a (key, field) pair existence, use key + field to check.
* Parameters:
	* key: string
	* field: string
* Returns: bool (`true` if exists, `false` if non exists)

#### mapKeys(key)

Map Get fields inside a key. If the number of fields is larger than 256, this function does not promise to return correct result, and will return at most 256 results.
* Parameters:
	* key: string
* Returns: array\[string\] (array of fields)

#### mapLen(key)

Map count number of fields inside a key. If the number of fields is larger than 256, this function does not promise to return correct result, and will return at most 256.
* Parameters:
	* key: string
* Returns: int (number of fields)

#### mapDel(key, field)

Map Delete a (key, field, value) pair, use key + field to delete value.
* Parameters:
	* key: string
	* field: string
* Returns: none

#### globalHas(contract, key)

Check if the key exists in global storage.
* Parameters:
	* contract: string
	* key: string
* Returns: bool (`true` if exists, `false` if non exists)

#### globalGet(contract, key)

Get value from global storage using key.
* Parameters:
	* contract: string
	* key: string
* Returns: string of value if exists, `null` if non exists

#### globalMapHas(contract, key, field)

Map check if a (key, field) pair exists in global storage, use key + field to check.
* Parameters:
	* contract: string
	* key: string
	* field: string
* Returns: bool (`true` if exists, `false` if non exists)

#### globalMapGet(contract, key, field)

Map get a (key, field) pair from global storage, use key + field to check.
* Parameters:
	* contract: string
	* key: string
	* field: string
* Returns: string of value if exists, `null` if non exists

#### globalMapLen(contract, key)

Map count number of fields inside a key from global storage. If the number of fields is larger than 256, this function does not promise to return correct result, and will return at most 256.
* Parameters:
	* contract: string
	* key: string
* Returns: int (number of fields)

#### globalMapKeys(contract, key)

Map Get fields inside a key from global storage. If the number of fields is larger than 256, this function does not promise to return correct result, and will return at most 256 results.
* Parameters:
	* contract: string
	* key: string
* Returns: array\[string\] (array of fields)

### blockchain object

blockchain object provides all methods for the system to call, and helps the user to call official APIs, including but not limited to transfering money, calling other contracts, and looking up a block or transaction.

The following is the API of blockchain object, you can also find detailed interfaces [in the code](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js).

#### transfer(from, to, amount, memo)

Transfer IOSToken.
* Parameters:
	* from: string
	* to: string
	* amount: string/number
	* memo: string
* Returns: none

#### withdraw(to, amount, memo)

Withdraw IOSToken.
* Parameters:
	* to: string
	* amount: string/number
	* memo: string
* Returns: none

#### deposit(from, amount, memo)

Deposit IOSToken.
* Parameters:
	* from: string
	* amount: string/number
	* memo: string
* Returns: none

#### blockInfo()

Get block info.
* Parameters: none
* Returns: JSONString of block info

#### txInfo()

Get transaction info.
* Parameters: none
* Returns: JSONString of transaction info

#### contextInfo()

Get context info.
* Parameters: none
* Returns: JSONString of context info

#### contractName()

Get contract name.
* Parameters: none
* Returns: string of contract name

#### publisher()

Get publisher.
* Parameters: none
* Returns: string of publisher

#### call(contract, api, args)

Call contract's api using args.
* Parameters:
	* contract: string
	* api: string
	* args: JSONString
* Returns: string

#### callWithAuth(contract, api, args)

Call contract's api using args with auth.
* Parameters:
	* contract: string
	* api: string
	* args: JSONString
* Returns: string

#### requireAuth(pubKey, permission)

Check account's permission.
* Parameters:
	* pubKey: string
	* permission: string
* Returns: bool (`true` if account has the permission, `false` if account doesn't)

#### receipt(data)

Generate receipt.
* Parameters:
	* data: string
* Returns: none

#### event(content)

Post event.
* Parameters:
	* content: string
* Returns: none


### tx object and block object
tx object contains current transaction information. Example:
```js
{
	time: 1541541540000000000,
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000,
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn":2},
	publisher: "user0"
}
```  

block object contrains current block information. Example:
```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn",
	time: 1541541540000000000
}
```

You can also find details [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29).

### encrypt object
You can directly use ```IOSTCrypto``` object's ```sha3(String)``` Function to get the sha3 Hash。

##### Example

```js
IOSTCrypto.sha3(msg)
```
