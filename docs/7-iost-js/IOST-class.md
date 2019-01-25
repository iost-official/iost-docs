---
id: IOST-class
title: IOST
sidebar_label: IOST
---

This is the main class that create transactions to send to IOST blockchain and IOST smart contracts.
## constructor
constructor method is a special method for creating and initializing IOST class.

### Parameters
Name             |Type       |Description 
----                |--         |--
config |Object         | config object for IOST class, config details as as follows:<br/> <b>gasRatio:</b> transaction gas price <br/> <b>gasLimit:</b> transaction gas limit <br/> <b>expiration:</b> time in seconds that transaction will be expired

### Returns
IOST object instance.

### Example
```javascript
// init iost sdk
const iost = new IOST.IOST({ // will use default setting if not set
    gasRatio: 1,
    gasLimit: 100000,
    expiration: 90,
});
```

## callABI
call contract abi function

### Parameters
Name             |Type       |Description 
----                |--         |--
contract |String         | contract id or contract domain
abi 	 |String 		 | contract abi function name
args	 |Array			 | function args array

### Returns
Transaction Object.

### Example
```javascript
const tx = iost.callABI(
	"token.iost",
	"transfer",
	["iost", "fromAccount", "toAccount", "10.000", "memo"]
);
```

## newAccount
create new IOST blockchain account

### Parameters
Name             |Type       |Description 
----                |--         |--
name 			 |String	| new account name
creator 	 	 |String	| creator account name
ownerkey	 	 |String	| creator account ownerKey
activekey	 	 |String	| creator account activeKey
initialRAM	 	 |Number	| new account initialRAM, paid by creator
initialGasPledge |Number	| new account initialGasPledge, paid by creator

### Returns
Transaction Object.

### Example
```javascript
// first create KeyPair for new account
const newKP = KeyPair.newKeyPair();
// then create new Account transaction
const newAccountTx = iost.newAccount(
    "test1",
    "admin",
    newKP.id,
    newKP.id,
    1024,
    10
);
```

## transfer
transfer tokens to designated account, wrapper for callABI

### Parameters
Name             |Type       |Description 
----                |--         |--
token		|String	| new account name
from 	 	|String	| creator account name
to			|String	| creator account ownerKey
amount	 	|String	| creator account activeKey
memo	 	|Number	| new account initialRAM, paid by creator

### Returns
Transaction Object.

### Example
```javascript
const tx = iost.transfer("iost", "fromAccount", "toAccount", "10.000", "memo");
```
