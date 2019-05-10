---
id: version-3.1.0-IOST-Blockchain-API
title: IOST Blockchain API
sidebar_label: IOST Blockchain API
original_id: IOST-Blockchain-API
---


# IOST Blockchain API
There objects below can be used directly inside contract codes. 

## storage object

All variables will be stored in memory in runtime. IOST provides `storage` object to help developers persist data in smart contracts. 
APIs without 'global' prefix are used to get/set storage of the calling contract. APIs with 'global' prefix are used to get storage of other contracts.

### Storage API

#### put(key, value, payer=contractOwner)

Simply put a key-value pair into storage. 

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | cannot be longer than 65536 bytes |
| value | string | cannot be longer than 65536 bytes |
| payer | string(optional) | it determines who will pay for the ram usage. This parameter is optional. If it is empty, the contract publisher will pay for the ram usage.|

Returns: none

example:

```js
// insert a k-v pair into storage and cost ram from contract owner
storage.put("test-key", "test-value");

// insert a k-v pair into storage and cost ram from transaction publisher
storage.put("test-key", "test-value", tx.publisher);
```

#### get(key)

Simply retrieve the value from storage using key.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |

Returns: value in string type if exists; `null` if not exists.

example:

```js
let v = storage.get("test-key");
if (v !== null) {
    ...
}
```

#### has(key)

Check if the key exists in the storage.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |

Returns: bool (`true` if exists, `false` if not exists)

example:

```js
if (storage.has("test-key")) {
    ...
}
```

#### del(key)

Simply delete a key-value pair from storage using key.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |

Returns: none

example:

```js
storage.del("test-key")
```

#### mapPut(key, field, value, payer=contractOwner)

Map put a (key, field, value) pair. use key+field to find value.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | cannot be longer than 65536 bytes |
| field | string | cannot be longer than 65536 bytes |
| value | string | cannot be longer than 65536 bytes |
| payer | string(optional) | it determines who will pay for the ram usage. This parameter is optional. If it is empty, the contract publisher will pay for the ram usage.|

Returns: none

example:

```js
// insert a key-field-value pair into storage and cost ram from contract owner
storage.mapPut("test-key", "test-field", "test-value");

// insert a key-field-value pair into storage and cost ram from transaction publisher
storage.mapPut("test-key", "test-field", "test-value", tx.publisher);
```

#### mapGet(key, field)

Map Get a (key, field) pair, use key + field to find value

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |
| field | string | |

Returns: value in string type if exists; `null` if not exists.

example:

```js
let v = storage.mapGet("test-key", "test-field");
if (v !== null) {
    ...
}
```

#### mapHas(key, field)

Map check a (key, field) pair existence, use key+field to check.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |
| field | string | |

Returns: bool (`true` if exists, `false` if not exists)

example:

```js
if (storage.mapHas("test-key", "test-field")) {
    ...
}
```

#### mapKeys(key)

Map Get fields inside a key.    

Attention:

**1. This API only stores 256 fields at most, and the field exceeded will not be stored and will not be returned in this API.**   
**2. If you need to get all keys of a map, it is recommended that you maintain them yourself and not use this API.**

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |


Returns: array\[string\] (array of fields)

#### mapLen(key)

Return len(mapKeys()).

**The attention is the same as [mapKeys](#mapkeyskey).**


| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |

Returns: int (number of fields)


#### mapDel(key, field)

Map Delete a (key, field, value) pair, use key+field to delete value.   

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| key | string | |
| field | string | |

Returns: none

### Global Storage API
APIs used to get storage of other contracts.

#### globalHas(contract, key)

Check if the key exists in the given contract's storage.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | the contract id |
| key | string | |

Returns: bool (`true` if exists, `false` if not exists)

example:

```js
if (storage.globalHas("Contractxxxxxx", "test-key")) {
    ...
}
```

#### globalGet(contract, key)

Get value from the given contract's storage using key.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | the contract id |
| key | string | |

Returns: string of value if exists, `null` if not exists

example:

```js
let v = storage.globalGet("Contractxxxxxx", "test-key");
if (v !== null) {
    ...
}
```

#### globalMapHas(contract, key, field)

Map check if a (key, field) pair exists in the given contract's storage, use key+field to check.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | the contract id |
| key | string | |
| field | string | |

Returns: bool (`true` if exists, `false` if not exists)

example:

```js
// read auth.iost contract's storage to judge whether an account exists
accountExists(account) {
    return storage.globalMapHas("auth.iost", "auth", account);
}
```

#### globalMapGet(contract, key, field)

Map get a (key, field) pair from global storage, use key+field to check.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | the contract id |
| key | string | |
| field | string | |

Returns: string of value if exists, `null` if not exists

example:

```js
let v = storage.globalMapGet("Contractxxxxxx", "test-key", "test-field");
if (v !== null) {
       ...
}
```

#### globalMapLen(contract, key)

Map count number of fields inside a key from global storage. 

**The attention is the same as [mapKeys](#mapkeyskey).**

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | the contract id |
| key | string | |

Returns: int (number of fields)

#### globalMapKeys(contract, key)

Map Get fields inside a key from global storage.

**The attention is the same as [mapKeys](#mapkeyskey).**

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | the contract id |
| key | string | |

Returns: array\[string\] (array of fields)

## blockchain object

blockchain object is used to call system API, and call other contract's abi.

#### transfer(from, to, amount, memo)

Transfer iost token.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| from | string | account who sends token |
| to | string | account who receives token |
| amount | string | the amount of token transferred |
| memo | string | additional information |

Returns: none

example:

```js
// transfer transaction publisher's 1.23 iost to testacc
blockchain.transfer(tx.publisher, "testacc", "1.23", "this is memo")
```

#### withdraw(to, amount, memo)

Withdraw iost token from contract. It equals to:

```blockchain.transfer(blockchain.contractName(), to, amount, memo)```

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| to | string | account who receives token |
| amount | string | the amount of token transferred |
| memo | string | additional information |

Returns: none

example:

```js
// transfer 1.23 iost to testacc from this contract
blockchain.withdraw(tx.publisher, "1.23", "this is memo")
```

#### deposit(from, amount, memo)

Deposit iost token to contract. It equals to:

```blockchain.transfer(from, blockchain.contractName(), amount, memo)```

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| from | string | account who receives token |
| amount | string | the amount of token transferred |
| memo | string | additional information |

Returns: none

example:

```js
// transfer 1.23 iost to contract from transaction publisher
blockchain.deposit(tx.publisher, "1.23", "this is memo")
```

#### contractName()

Get contract id.

Parameters: none

Returns: string of contract id

#### publisher()

Get transaction publisher.

Parameters: none

Returns: string of tx publisher

#### contractOwner()

Get contract owner.

Parameters: none

Returns: string of contract publisher


#### call(contract, abi, args)

Call contract's abi using args.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | contract id |
| abi | string | |
| args | array/string | the array of arguments, or the json string of it |

Returns: Array containing a string which is the json string of what the called contract returns.

example:

```js
// query admin's iost balance by calling balanceOf of token.iost 
let ret = blockchain.call("token.iost", "balanceOf", ["iost", "admin"])
console.log(ret[0]) // attention: ret[0] is what balanceOf returns

// get a vote result by calling getResult of vote.iost
let ret = blockchain.call("vote.iost", "getResult", ["1"])
let voteRes = JSON.parse(ret[0]) // what getResult of vote.iost returns is an array, so we have to json parse it.
```

#### callWithAuth(contract, abi, args)

Call contract's abi using args with the contract's authority. 

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| contract | string | contract id |
| abi | string | |
| args | array/string | the array of arguments, or the json string of it |

Returns: Array containing a string which is the json string of what the called contract returns.

example:

```js
// transfer 20 iost to testacc
blockchain.callWithAuth("token.iost", "transfer", ["iost", blockchain.contractName(), "testacc", "20", ""]);

// if we use call, it will throw an error since transferring contract's token needs its authority 
blockchain.call("token.iost", "transfer", ["iost", blockchain.contractName(), "testacc", "20", ""]); // throw error
```

#### requireAuth(account, permission)

Check whether a given account's given permission is provided.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | |
| permission | string | |

Returns: bool (`true` if the permission is provided, `false` if not)

example:

```js
// check whether testacc's active permission is provided
// that means whether the transaction contains the signature of testacc's active key
const ret = blockchain.requireAuth('testacc', 'active');
if (ret !== true) {
    throw new Error("require auth failed");
}
```


#### receipt(data)

Generate receipt.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| data | string | |

Returns: none

example:

```js
testReceipt() {
    blockchain.receipt("some receipt content")
}
```
After calling testReceipt of this contract, there will be a such record in TxReceipt:

```
"receipts": [
    {
        "funcName": "Contractxxxxx/testReceipt",
        "content": "some receipt content"
    }
]
```

#### event(data)

Post event.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| data | string | |

Returns: none

example:

```js
testEvent() {
    blockchain.event("some event content")
}
```

After calling testEvent of this contract, there will be event which you could get by calling [subscribe](6-reference/API.md#subscribe):

```
curl -X POST http://127.0.0.1:30001/subscribe -d '{"topics":["CONTRACT_EVENT"], "filter":{"contract_id":"Contractxxxxx"}}'

{"result":{"event":{"topic":"CONTRACT_EVENT","data":"some event content","time":"1557150634515314000"}}}

```

## tx object and block object
tx object contains current transaction information. Here's its attributes:

```js
{
	time: 1541541540000000000, // nano second
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000, // nano second
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn":2},
	publisher: "user0"
}
```  

example:

```js
console.log(tx.publisher)
```

block object contrains current block information. Here's its attributes:

```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn",
	time: 1541541540000000000 // nano second
}
```

example:

```js
console.log(block.parent_hash)
```

## IOSTCrypto object
IOSTCrypto provides hash function and signature verification function.

#### sha3(data)
Calculate sha3-256 hash.


| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| data | string | |

Returns: string which is the result of base58 encode of hash byte array. (```base58\_encode(sha3\_256(data))```)

example:

```js
IOSTCrypto.sha3("Fule will be expensive. Everyone will have a small car.") // result: EBNarfcGkAczpeiSJwtUfH9FEVd1xFhdZis83erU9WNu
```

Returns: base58\_encode(sha3\_256(data))


#### verify(algo, message, signature, pubkey)
Signature verification. Both ed25519 and secp256k1 algorithms are supported.

| Parameter List	| Parameter Type | Remark |
| :----: | :------ |:------ |
| algo | string | can only be "ed25519" or "secp256k1" |
| message | string | **base58 encoded** original text to be signed |
| signature | string | **base58 encoded** signature to be checked |
| pubkey | string | **base58 encoded** public key of the corresponding private key used for signing |

* Returns: int, 1 (succees) or 0 (failure)

example:

```js
// choose ed25519 algorithm
// the base58 encoded private key is "4PTQW2hvwZoyuMdgKbo3iQ9mM7DTzxSV54RpeJyycD9b1R1oGgYT9hKoPpAGiLrhYA8sLQ3sAVFoNuMXRsUH7zw6"
// the base58 encoded public key is "2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi"
// the origial text is "hello world"
// "StV1DL6CwTryKyV" is base58 encoded result of "hello world"
// "38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN" is base58 encoded signature signed by the private key above
// So the result of verification should be 1:
let v = IOSTCrypto.verify("ed25519", "StV1DL6CwTryKyV", "38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN", "2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi"); // v = 1
```

## Float64, Int64 and BigNumber object

In contract, we could use `Float64`, `Int64` and `BigNumber` to do high precision calculation.    
`Float64` APIs can be found [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/float64.js).  
`Int64` APIs can be found [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/int64.js).  
`BigNumber` APIs can be found [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/bignumber.js). 

example:

```js
let bonus = new Float64("1.0123456789");
let earning = bonus.div(2).toFixed(8); // earning is "0.50617283"
blockchain.withdraw("testacc", earning, "");
```

## Disabled Javascript Methods
Some functions of Javascript is forbidden for security reasons.   
[This document](6-reference/GasChargeTable.md) gives a list of allowed and forbidden APIs.