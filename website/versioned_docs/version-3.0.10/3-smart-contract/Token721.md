---
id: version-3.0.10-Token721
title: Create Non-Fungible Token
sidebar_label: Create Non-Fungible Token
original_id: Token721
---

# Token 721 draft standard

A standard interface for non-fungible tokens.

## Abstract

The non-fungible token issued on IOST must be implemented based on the system contract `token721.iost`. Most of the time you can issue tokens directly through the `token721.iost` contract, but if you want to issue a token with customization, you need to implement and publish your own token contract.

**Note**: Although [`token721.iost`](6-reference/TokenContract.md#token721iost) can be used now, it is not yet fully implemented. We plan to release a full-featured version in the near future, so don't use it in production environment until then.

Customized non-fungible token contracts need to implement the following interfaces to support applications such as wallets and browsers.

## ABI

```js
{
    "lang": "*",
    "version": "*",
    "abi": [
        // optional
        {
            "name": "issue",
            "args": [
                "string",   // token_symbol
                "string",   // to
                "string"    // meta
            ]
        },
        // required
        {
            "name": "transfer",
            "args": [
                "string",   // token_symbol
                "string",   // from
                "string",   // to
                "string"    // token_id
            ]
        },
        // required
        {
            "name": "approve",
            "args": [
                "string",   // token_symbol
                "string",   // from
                "string",   // operator
                "string"    // token_id
            ]
        },
        // optional
        {
            "name": "balanceOf",
            "args": [
                "string",   // token_symbol
                "string"    // owner
            ]
        },
        // optional
        {
            "name": "ownerOf",
            "args": [
                "string",   // token_symbol
                "string"    // token_id
            ]
        },
        // optional
        {
            "name": "tokenOfOwnerByIndex",
            "args": [
                "string",   // token_symbol
                "string",   // owner
                "number"    // index
            ]
        },
        // optional
        {
            "name": "tokenMetadata",
            "args": [
                "string",   // token_symbol
                "string"    // token_id
            ]
        }
    ]
}
```

## Specification

### token information

Token information is stored in *token721.iost*, and applications such as wallets should directly use the information stored in the *token721.iost* contract to ensure the reliability of the information.

### issue(tokenSymbol, acc, metaJson)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: issuer of tokenSymbol`

Issue tokenSymbol to `acc` account, metaJson is a json string of the newly issued token.

### transfer(tokenSymbol, accFrom, accTo, tokenId)

`Authority required: accFrom`

Transfer tokenSymbol from `accFrom` to `accTo` with tokenId,
If `transfer` needs to be called by a contract or other user (different from `accFrom`), `accFrom` must first call `approve`, otherwise an exception will be thrown.
In the case of a contract call, you can call `approve` and then call the contract in the same transaction.

The criteria for successful transfer are consistent with the standard of the `token721.iost` contract: on the premise of successful transaction, the `func_name` field of the `receipts` field in `tx_receipt` is equal to `token721.iost/transfer`, the transfer is made. The currency, account, and tokenId need to be further parsed from the `content` field of this item.

### approve(tokenSymbol, accFrom, accTrans, tokenId)

`Authority required: accFrom`

Allow `accTrans` to transfer the `tokenSymbol` token of a specific `tokenId`.

Throws if `tokenId` does not belong to `accFrom`.

Throws if `approve` is called by a contract.

The criteria for successful approval are consistent with the standard of the `token721.iost` contract: on the premise of successful transaction, the `func_name` field of the `receipts` field in `tx_receipt` is equal to `token721.iost/approve`, the approval is made. The currency, account, and tokenId need to be further parsed from the `content` field of this item.

### balanceOf(tokenSymbol, acc)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the balance of an account of `tokenSymbol`.

### ownerOf(tokenSymbol, tokenId)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the owner of a specific `tokenSymbol` token with `tokenId`.

### tokenOfOwnerByIndex(tokenSymbol, owner, index)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the meta info of a specific `tokenSymbol` token owned by `owner` with `index`.

### tokenMetadata(tokenSymbol, tokenId)

`Optional: applications MUST NOT expect this method to be present`

`Authority required: null`

Query the meta info of a specific `tokenSymbol` token with `tokenId`.

## Implementation

The implementation is not yet available. You can test with current [`token721.iost`](6-reference/TokenContract.md#token721iost) by now.
