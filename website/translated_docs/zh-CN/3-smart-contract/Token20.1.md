---
id: Token20.1
title: 创建 IRC21 Token
sidebar_label: 创建 IRC21 Token
---

## IRC20 标准

自部署 tokens 标准接口。

## 摘要

部署在 IOST 上的标准 token 必须通过系统合约 [_token.iost_](3-smart-contract/Token.md) 来实现。
大多数情况下，您可以通过 [_token.iost_](3-smart-contract/Token.md) 合约直接创建 tokens，
但是如果要创建具有自定义功能的 token，则需要实现并发布自己的 token 合约。

自定义 token 合约需要实现以下接口，以支持钱包和交易等应用程序。

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

## 标准规范

### token 信息

token 信息存储在 _token.iost_ 中，钱包等应用程序应直接使用存储在 _token.iost_ 合同中的信息，以确保信息的可靠性。

### issue（tokenSymbol，acc，amountStr）

`可选: 应用程序的非必须方法`

`所需权限：tokenSymbol的发行者`

发行 tokenSymbol 到`acc`帐户，amountStr 是发行金额的字符串，该金额必须是确定小数点位的正数十进制，如“100”，“100.999”

### transfer（tokenSymbol，accFrom，accTo，amountStr，memo）

`所需权限：accFrom`

使用 amountStr 和 memo 将 tokenSymbol 从`accFrom`发送到`accTo`，
amount 必须是确定小数点位的正数十进制，memo 是此传输操作的附加字符串消息，长度不超过 512 个字节。

成功发送的标准与`token.iost`合约的标准一致：成功发送的前提是`tx_receipt`中`receipts`字段的`func_name`字段等于`token.iost / transfer`。货币，帐户和金额可以从此项的`content`字段中进一步解析。有关详细信息，请参阅[如何判断发送是否成功](6-reference/TransferJudgement.md) 。

### transferFreeze（tokenSymbol，accFrom，accTo，amountStr，unfreezeTime，memo）

`可选: 应用程序的非必须方法`

`所需权限：accFrom`

使用 amountStr 和 memo 将 tokenSymbol 从`accFrom`发送到`accTo`，并将这部分 token 冻结到 unfreezeTime 时段。
unfreezeTime 是 unix 时间的纳秒数，之后 token 将被解冻。

成功发送的标准与`token.iost`合约的标准一致：成功发送的前提是`tx_receipt`中`receipts`字段的`func_name`字段等于`token.iost / transferFreeze`。货币，帐户，金额和解冻时间可以从此项目的`content`字段进一步解析。有关详细信息，请参阅[如何判断发送是否成功](6-reference/TransferJudgement.md) 。

### destroy（tokenSymbol，accFrom，amountStr）

`可选: 应用程序的非必须方法`

`所需权限：accFrom`

在`accFrom`帐户中销毁数额为 amountStr 的 token。在销毁之后，此 token 的供应将减少相同的数额，这意味着，可以通过销毁一些 token 在已有的 totalSupply 中发出更多 token。

### balanceOf（tokenSymbol，acc）

`可选: 应用程序的非必须方法`

`权限要求：无`

查询特定 token 的帐户余额。

### supply（tokenSymbol）

`可选: 应用程序的非必须方法`

`权限要求：无`

查询特定 token 的供应。

### totalSupply（tokenSymbol）

`可选: 应用程序的非必须方法`

`权限要求：无`

查询特定 token 的供应总量。

## 代码实现

下面给出了一个基本实现示例，可以通过修改代码来进行定制。

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
