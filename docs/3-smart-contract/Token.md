---
id: Token
title: Create Token
sidebar_label: Create Token
---
## Token20

Token20 is our standard for implementing token on iost blockchain. It includes several practical features beyond transfer,
such as freeze token, destroy token and can be configured carefully.

`iost` is also implemented according to Token20 standard based on out build-in system contract `token.iost`.
The interfaces of `token.iost` are described as follows:

```js
// create tokenSymbol
create(tokenSymbol, issuer, totalSupply, configJson);	// string, string, number, json
issue(tokenSymbol, to, amountStr);						// string, string, string
transfer(tokenSymbol, from, to, amountStr, memo);		// string, string, string, string, string
transferFreeze(tokenSymbol, from, to, amountStr, unfreezeTime, memo);		// string, string, string, string, number, string
destroy(tokenSymbol, from, amountStr);					// string, string, string
// query interfaces
balanceOf(tokenSymbol, from);							// string, string
supply(tokenSymbol);									// string
totalSupply(tokenSymbol);								// string
```
### create(tokenSymbol, issuer, totalSupply, configJson)
`Authority required: issuer`

TokenSymbol is the unique identifier of a specific token, that is, you can't create a token in `token.iost` contract with a tokenSymbol used before.
It's a string with length between 2 and 16, and only consists of character `a-z`, `0-9` and `_`.

Issuer is the issuer of the token, only issuer has permission to issue token to arbitrary account.
Normally issuer of a token is an account, but it also can be a contract. 
When the issuer is a contract ID, that means, only this contract has permission to call `issue` method to issue token to others.
Let's say, token `mytoken`'s issuer is contract `Contractabc`, then `Contractabc` can call `issue` to issue `mytoken`,
`Contractabc` can also call a function in `Contractdef`, and `Contractdef` thus has permission to issue `mytoken`.
That is it, permission of a contract can be deliveried to the contract it called, you need to use system function `blockchain.callWithAuthority` instead of
`blockchain.call` when calling another contract to delivery the permission.

TotalSupply is a int64 number, issuer can not issue token more than totakSupply.

ConfigJson is a json consists of the config for the token. Here is all the supported config properties:
```console
{
	"decimal": number between 0~19,
	"canTransfer": true/false, the token can not be transferd if canTransfer is false,
	"fullName": string describes the full name of the token
}
```

### issue(tokenSymbol, acc, amountStr)
`Authority required: issuer of tokenSymbol`

Issue tokenSymbol to `acc` account, amountStr is a string refers to the amount to issue, the amount must be a positive fixed-point decimal like "100", "100.999"

### transfer(tokenSymbol, accFrom, accTo, amountStr, memo)
`Authority required: accFrom`

Transfer tokenSymbol from `accFrom` to `accTo` with amountStr and memo,
amount must be a positive fixed-point decimal, and memo is an additional string message of this transfer operation with length no more than 512 bytes.

### transferFreeze(tokenSymbol, accFrom, accTo, amountStr, unfreezeTime, memo)
`Authority required: accFrom`

Transfer tokenSymbol from `accFrom` to `accTo` with amountStr and memo, and freeze this part of token until unfreezeTime.
The unfreezeTime is the nanoseconds of unix time after which the token will be unfreezed. 

### destroy(tokenSymbol, accFrom, amountStr)
`Authority required: accFrom`

Destroy amountStr of token in `accFrom` account. After destroy, the supply of this token will decrease a same account, that means,
you can issue more token in the presense of the totalSupply by destroying some tokens.

### balanceOf(tokenSymbol, acc)
`Authority required: null`

Query the balance of an account of a specific token.

### supply(tokenSymbol)
`Authority required: null`

Query the supply of a specific token.

### totalSupply(tokenSymbol)
`Authority required: null`

Query the totalSupply of a specific token.


## Step-by-Step Example
Creating a `Token20` on iost blockchain is remarkably simple, you can just call `token.iost` contract without implementing Token20 interfaces and deploying smart contract yourself.

Below is a step-by-step example describes how to create a token using `bank` account and transfer token between accounts, you need to create account `bank`, `user0`, `user1` first.

```console
iwallet call token.iost create '["mytoken", "bank", 21000000000, {"decimal": 8, "fullName": "token for test"}]' --account bank
iwallet call token.iost issue  '["mytoken", "bank", "1000"]' --account bank
iwallet call token.iost issue  '["mytoken", "user0", "100.00000001"]' --account bank
iwallet call token.iost transfer 		'["mytoken", "user0", "user1", "10", "user0 pay coffee"]' --account user0
iwallet call token.iost transferFreeze 	'["mytoken", "user1", "user0", "0.1", 1544880864601648640, "voucher"]' --account user1
iwallet call token.iost destroy '["mytoken", "bank", "1000"]' --account bank
```
