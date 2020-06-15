---
id: token721iost
title: 创建 IRC721 Token
sidebar_label: 创建 IRC721 Token
---

## IRC721 标准

不可替代 token 的标准接口。

## 注意
一般情况下，可以使用 [UniversalCryptoAssetToken](https://github.com/blockchainpower/UniversalCryptoAssetToken/blob/master/src/iost) 作为 IOST NFT 的实现。

## 摘要

在 IOST 上发行的不可替代 token 必须基于系统合约`token721.iost`来实现。 大多数时候，您可以直接通过`token721.iost`合约发行 token，但是如果您想通过自定义方式发行 token，则需要实现并发布自己的 token 合同。

**注意**：尽管 [`token721.iost`](6-reference/TokenContract.md#token721iost) 现在可以使用，但尚未完全完成。 我们计划在不久的将来发布功能齐全的版本，因此在此之前请勿在生产环境中使用它。

定制的不可替代的 token 合约需要实现以下接口，以支持诸如钱包和浏览器之类的应用程序。

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

## 标准规范

### token 信息

token 信息存储在 [`token721.iost`](6-reference/TokenContract.md#token721iost) 中，并且诸如钱包之类的应用程序应直接使用 [`token721.iost`](6-reference/TokenContract.md#token721iost) 合约中存储的信息以确保信息的可靠性。

### issue(tokenSymbol, acc, metaJson)

`可选: 应用程序的非必须方法`、

`所需权限: tokenSymbol 的发行者`

发行 tokenSymbol 到`acc`帐户，metaJson 是新发行 token 的 json 字符串。

### transfer（tokenSymbol，accFrom，accTo，tokenId）

`所需权限: tokenSymbol 的发行者`

使用 tokenId 将 tokenSymbol 从 accFrom 发送到 accTo，
如果合同或其他与`accFrom`不同的用户需要调用`transfer`，则`accFrom`必须首先调用`approve`，否则将触发代码异常。
如果是合同调用，您可以先调用`approve`，然后再在同一笔交易中调用合同。

成功发送的标准与`token721.iost`合约的标准一致：成功交易的前提是`tx_receipt`中`receipts`字段的`func_name`字段等于`token721.iost/transfer`。货币，帐户和 token ID 可以从此项的`content`字段中进一步解析。

### approve(tokenSymbol, accFrom, accTrans, tokenId)

`所需权限: accFrom`

允许`accTrans`发送特定`tokenId`的`tokenSymbol`token。

如果`tokenId`不属于`accFrom`，则抛出该异常。

如果合同调用`approve`时，则抛出该异常。

成功批准的标准与`token721.iost`合同的标准一致：成功交易的前提是`tx_receipt`中`receipts`字段的`func_name`字段等于`token721.iost/approve`。货币，帐户和 token ID 可以从此项的`content`字段中进一步解析。

### balanceOf（tokenSymbol，acc）

`可选: 应用程序的非必须方法`

`所需权限: 无`

查询`tokenSymbol`的账户余额。

### ownerOf（tokenSymbol，tokenId）

`可选: 应用程序的非必须方法`

`所需权限: 无`

使用`tokenId`查询特定`tokenSymbol` token 的所有者。

### tokenOfOwnerByIndex(tokenSymbol, owner, index)

`可选: 应用程序的非必须方法`

`所需权限: 无`

使用`index`来查询`owner`拥有的特定`tokenSymbol`token 的 meta 信息。

### tokenMetadata（tokenSymbol，tokenId）

`可选: 应用程序的非必须方法`

`所需权限: 无`

使用`tokenId`查询特定`tokenSymbol`token 的 meta 信息。

