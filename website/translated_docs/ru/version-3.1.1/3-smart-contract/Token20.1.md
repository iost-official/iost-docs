---
id: version-3.1.1-Token20.1
title: Create IRC21 Token
sidebar_label: Create IRC21 Token
original_id: Token20.1
---

# IRC21 standard

A standard interface for self-deployed tokens.

## Abstract

The standard token deployed on IOST must be implemented based on the system contract *token.iost*.
Most of the time you can create tokens directly through the [*token.iost*](3-smart-contract/Token.md) contract,
but if you want to create a token with customization, you need to implement and publish your own token contract.

Customized token contracts need to implement the following interfaces to enable support for applications such as wallets and exchanges.

## ABI

```js
{
    "lang": "javascript",
    "version": "1.0.0", // or any other version
    "abi": [
        // optional
        {
            "name": "issue",
            "args": [
                "string",   // token_symbol
                "string",   // to
                "string"    // amount
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        // required
        {
            "name": "transfer",
            "args": [
                "string",   // token_symbol
                "string",   // from
                "string",   // to
                "string",   // amount
                "string"    // memo
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        // optional
        {
            "name": "transferFreeze",
            "args": [
                "string",   // token_symbol
                "string",   // from
                "string",   // to
                "string",   // amount
                "number",   // timestamp in nanosecond
                "string"    // memo
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        // optional
        {
            "name": "destroy",
            "args": [
                "string",   // token_symbol
                "string",   // from
                "string"    // amount
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        // optional
        {
            "name": "supply",
            "args": [
                "string"    // token_symbol
            ]
        },
        // optional
        {
            "name": "totalSupply",
            "args": [
                "string"    // token_symbol
            ]
        },
        // optional
        {
            "name": "balanceOf",
            "args": [
                "string",   // token_symbol
                "string"    // owner
            ]
        }
    ]
}
```

## Specification

### token information

Token information is stored in *token.iost*, and applications such as wallets should directly use the information stored in the *token.iost* contract to ensure the reliability of the information.

### issue(tokenSymbol, acc, amountStr)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: issuer of tokenSymbol`

Issue tokenSymbol to `acc` account, amountStr is a string refers to the amount to issue, the amount must be a positive fixed-point decimal like "100", "100.999"

### transfer(tokenSymbol, accFrom, accTo, amountStr, memo)

`Authority required: accFrom`

Transfer tokenSymbol from `accFrom` to `accTo` with amountStr and memo,
amount must be a positive fixed-point decimal, and memo is an additional string message of this transfer operation with length no more than 512 bytes.

The criteria for successful transfer are consistent with the standard of the `token.iost` contract: on the premise of successful transaction, the `func_name` field of the `receipts` field in `tx_receipt` is equal to `token.iost/transfer`, the transfer is made. The currency, account, and amount need to be further parsed from the `content` field of this item. See [How to judge the success of a transfer](6-reference/TransferJudgement.md) for details.

### transferFreeze(tokenSymbol, accFrom, accTo, amountStr, unfreezeTime, memo)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: accFrom`

Transfer tokenSymbol from `accFrom` to `accTo` with amountStr and memo, and freeze this part of token until unfreezeTime.
The unfreezeTime is the nanoseconds of unix time after which the token will be unfreezed. 

The criteria for successful transfer are consistent with the standard of the `token.iost` contract: on the premise of successful transaction, the `func_name` field of the `receipts` field in `tx_receipt` is equal to `token.iost/transferFreeze`, the transfer is made. The currency, account, amount and unfreezeTime need to be further parsed from the `content` field of this item. See [How to judge the success of a transfer](6-reference/TransferJudgement.md) for details.

### destroy(tokenSymbol, accFrom, amountStr)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: accFrom`

Destroy amountStr of token in `accFrom` account. After destroy, the supply of this token will decrease a same account, that means,
you can issue more token in the presense of the totalSupply by destroying some tokens.

### balanceOf(tokenSymbol, acc)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the balance of an account of a specific token.

### supply(tokenSymbol)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the supply of a specific token.

### totalSupply(tokenSymbol)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the totalSupply of a specific token.

## Implementation

The following gives a basic implementation, the customization can be made by modifying the code.

```js
// ABI:
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "can_update",
            "args": [
                "string"
            ]
        },
        {
            "name": "issue",
            "args": [
                "string",
                "string",
                "string"
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        {
            "name": "transfer",
            "args": [
                "string",
                "string",
                "string",
                "string",
                "string"
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        {
            "name": "transferFreeze",
            "args": [
                "string",
                "string",
                "string",
                "string",
                "number",
                "string"
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        {
            "name": "destroy",
            "args": [
                "string",
                "string",
                "string"
            ],
            "amountLimit": [{
                "token": "*",
                "val": "unlimited"
            }]
        },
        {
            "name": "supply",
            "args": [
                "string"
            ]
        },
        {
            "name": "totalSupply",
            "args": [
                "string"
            ]
        },
        {
            "name": "balanceOf",
            "args": [
                "string",
                "string"
            ]
        }
    ]
}

// code:
const name = "your_token";
const fullName = "YTK"; //It is recommended that the wallet and browser display the name of the currency as "fullName(name)", for example: YTK(your_token)
const decimal = 8;
const totalSupply = 90000000000;
const admin = "your_admin";

class Token {
    init() {
        blockchain.callWithAuth("token.iost", "create", [
            name,
            blockchain.contractName(),
            totalSupply,
            {
                fullName,
                decimal,
                canTransfer: true,
                onlyIssuerCanTransfer: true,
            }
        ]);
    }

    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }

    _amount(amount) {
        return new BigNumber(new BigNumber(amount).toFixed(decimal));
    }

    _checkToken(token_name) {
        if (token_name !== name) {
            throw "token not exist";
        }
    }

    issue(token_name, to, amount) {
        if (!blockchain.requireAuth(admin, "active")) {
            throw "permission denied";
        }
        this._checkToken(token_name);
        amount = this._amount(amount);
        blockchain.callWithAuth("token.iost", "issue", [token_name, to, amount]);
    }

    transfer(token_name, from, to, amount, memo) {
        this._checkToken(token_name);
        amount = this._amount(amount);
        blockchain.callWithAuth("token.iost", "transfer", [token_name, from, to, amount, memo])
    }

    transferFreeze(token_name, from, to, amount, timestamp, memo) {
        this._checkToken(token_name);
        amount = this._amount(amount);
        blockchain.callWithAuth("token.iost", "transferFreeze", [token_name, from, to, amount, timestamp, memo]);
    }

    destroy(token_name, from, amount) {
        this._checkToken(token_name);
        amount = this._amount(amount);
        blockchain.callWithAuth("token.iost", "destroy", [token_name, from, amount]);
    }

    // call abi and parse result as JSON string
    _call(contract, api, args) {
        const ret = blockchain.callWithAuth(contract, api, args);
        if (ret && Array.isArray(ret) && ret.length >= 1) {
            return ret[0];
        }
        return null;
    }

    balanceOf(token_name, owner) {
        this._checkToken(token_name);
        return this._call("token.iost", "balanceOf", [token_name, owner]);
    }

    supply(token_name) {
        this._checkToken(token_name);
        return this._call("token.iost", "supply", [token_name]);
    }

    totalSupply(token_name) {
        this._checkToken(token_name);
        return this._call("token.iost", "totalSupply", [token_name]);
    }
}

module.exports = Token;
```
