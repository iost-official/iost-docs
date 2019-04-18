---
id: version-3.0.6-IOST-Blockchain-API
title: IOST Blockchain API
sidebar_label: IOST Blockchain API
original_id: IOST-Blockchain-API
---


# IOST Blockchain API
There objects below can be accessed inside contract codes. 
  
**Note: Strings cannot be longer than 65536 bytes**

## storage object

All variables will be stored in memory in runtime. IOST provides `storage` object to help developers persist data in smart contracts. 
APIs without 'global' prefix are used to get/set storage of the calling contract. APIs with 'global' prefix are used to get storage of other contracts.


Developers may use this class to synchronize data during multiple contract calls. Here list API of this object, you can also find details [in the code](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js).

### Contract Storage API

#### put(key, value, payer)

Simply put a key-value pair into storage. 

* Parameters:
	* key: string
	* value: string.
	* payer: string. Defines who will pay for the ram usage. This parameter is optional. If it is empty, the contract publisher will pay for the ram usage.
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
	* payer: string. Similar to `payer` of `put`   
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

Map Get fields inside a key.    

Attention:

**1. The maximum number of fields returned is 256, and the field exceeded is still there, but it will not be returned in this function.**  
**2. If "mapDel" is called, then later mapKeys may be wrong! If both mapDel and mapKeys are required in the contract, it is recommended that all fields be of the same length, in which case mapKeys will not make a mistake.**  
**3. If you need to get all keys of a map, it is recommended that you maintain them yourself and not use this API.**

* Parameters:
	* key: string
* Returns: array\[string\] (array of fields)

#### mapLen(key)

Return len(mapKeys()).

**The attention is the same as [mapKeys](#mapkeyskey).**


* Parameters:
	* key: string
* Returns: int (number of fields)

#### mapDel(key, field)

Map Delete a (key, field, value) pair, use key + field to delete value.   
**mapDel can make mapKeys return incorrect result, so do not rely mapKeys if you need to call mapDel**

* Parameters:
	* key: string
	* field: string
* Returns: none

### Global Storage API
APIs used to get storage of other contracts.

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

**The attention is the same as [mapKeys](#mapkeyskey).**

* Parameters:
	* contract: string
	* key: string
* Returns: int (number of fields)

#### globalMapKeys(contract, key)

Map Get fields inside a key from global storage. If the number of fields is larger than 256, this function does not promise to return correct result, and will return at most 256 results.

**The attention is the same as [mapKeys](#mapkeyskey).**

* Parameters:
	* contract: string
	* key: string
* Returns: array\[string\] (array of fields)

## blockchain object

blockchain object provides all methods for the system to call, and helps the user to call official APIs, including but not limited to transfering coins, calling other contracts, and looking up a block or transaction.

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
* Returns: JSONString of block info. Same to the global `block` object

#### txInfo()

Get transaction info.

* Parameters: none
* Returns: JSONString of transaction info. Same to the global `tx` object

#### contextInfo()

Get context info.

* Parameters: none
* Returns: JSONString of context info

Example: 

```js
{
	"abi_name":"contextinfo",
	"contract_name":"ContractHYtPky2PHTAgweBw262jBZcj241ejUqweS7rcfQibn5t",
	"publisher":"admin"
}
```

#### contractName()

Get contract name.

* Parameters: none
* Returns: string of contract name

#### publisher()

Get publisher.

* Parameters: none
* Returns: string of tx publisher

#### contractOwner()

Get contract owner.

* Parameters: none
* Returns: string of contract publisher


#### call(contract, api, args)

Call contract's api using args.

* Parameters:
	* contract: string
	* api: string
	* args: JSONString
* Returns: string

#### callWithAuth(contract, api, args)

Call contract's api using args with the tx publisher's permissions. 

* Parameters:
	* contract: string
	* api: string
	* args: JSONString
* Returns: string

Example:

```js
// make the tx sender to transfer 20 IOST to contract publisher
blockchain.callWithAuth("token.iost", "transfer", ["iost", tx.publisher, blockchain.contractOwner(), "20", ""]);
```

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


## tx object and block object
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

## IOSTCrypto object

Source code [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/crypto.go)

#### sha3(data)
Calculate sha3-256 hash.


* Parameters:
	* data: string
* Returns: base58\_encode(sha3\_256(data))

##### Example

```js
IOSTCrypto.sha3("Fule will be expensive. Everyone will have a small car.") // result: EBNarfcGkAczpeiSJwtUfH9FEVd1xFhdZis83erU9WNu
```

#### verify(algo, message, signature, pubkey)
Signature verification

* Parameters:
	* algo: algorithm used, can be one of 'ed25519' or 'secp256k1'
	* message: **base58 encoded** original text of the signature. 
	* signature: **base58 encoded** signature to be checked
	* pubkey: **base58 encoded** public key of the corresponding private key used for signing
* Returns: 1 (succees) or 0 (failure)

```js
// StV1D.. is base58 encoded "hello world"
// 2vSjK.. is base58 encoded pubkey of private key '4PTQW2hvwZoyuMdgKbo3iQ9mM7DTzxSV54RpeJyycD9b1R1oGgYT9hKoPpAGiLrhYA8sLQ3sAVFoNuMXRsUH7zw6'
// 38V8b.. is base58 encoded signature
IOSTCrypto.verify("ed25519","StV1DL6CwTryKyV","38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN","2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi") // result: 1
```

## Float64 and Int64 class

`Float64` and `Int64` classes are provided to do high precision calculation.   
Float64 APIs [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/float64.js) and Int64 APIs [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/int64.js)

# Disabled Javascript Methods
Some functions of Javascript is forbidden for security reasons.   
[This document](6-reference/GasChargeTable.md) gives a list of allowed and forbidden APIs.