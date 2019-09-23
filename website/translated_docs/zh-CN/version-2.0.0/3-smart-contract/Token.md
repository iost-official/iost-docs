---
id: Token
title: 创建 IRC20 Token
sidebar_label: 创建 IRC20 Token
---

## IRC20

IRC20 是我们在 iost 区块链上实现 Token 的标准。它包括除转账之外的几个实用功能，
例如冻结 Token，销毁 Token 并且可以详细配置。

`token.iost`是 IRC20 的实现，所有 `IRC20` Token 必须由`token.iost`创建。
`iost`也是根据基于内置系统合约`token.iost`的 IRC20 标准实现的。

如果要自定义 Token，请参阅[创建自定义 Token](3-smart-contract/Token20.1.md)以获取更多详细信息。

`token.iost`的接口表述如下：

```js
//创建tokenSymbol
create(tokenSymbol, issuer, totalSupply, configJson); // string, string, number, json
issue(tokenSymbol, to, amountStr); // string, string, string
transfer(tokenSymbol, from, to, amountStr, memo); // string, string, string, string, string
transferFreeze(tokenSymbol, from, to, amountStr, unfreezeTime, memo); // string, string, string, string, number, string
destroy(tokenSymbol, from, amountStr); // string, string, string
// query interfaces
balanceOf(tokenSymbol, from); // string, string
supply(tokenSymbol); // string
totalSupply(tokenSymbol); // string
```

### create（tokenSymbol，issuer，totalSupply，configJson）

`要求权限：发行人`

tokenSymbol 是特定 Token 的唯一标识符，也就是说，你不能在`token.iost`合约中使用重复的 tokenSymbol 创建 Token。
它是一个长度在 2 到 16 之间的字符串，只包含字符`a-z`, `0-9`和`_`.

发行人是 Token 的发行者，只有发行人才有权向任意账户发行 Token。
通常，Token 的发行者是一个帐户，但它也可以是合约。
当发行者是合约 ID 时，这意味着只有这个合约才有权调用`issue`方法向其他人发放 Token。
比如，Token`mytoken`的发行人是合约`Contractabc`，那么`Contractabc`就可以调用`issue`来发行`mytoken`,`Contractabc` 也可以调用`Contractdef`中的函数，因此`Contractdef`也有权发行`mytoken`。 也就是说，合约的许可可以传递给它所调用的合约，但是你需要使用系统函数`blockchain.callWithAuthority`而不是`blockchain.call`来传递发行权限给调用的另一个合约。

totalSupply 是一个 int64 整数，发行者不能发出数量超过 totalSupply 的 Token。

ConfigJson 是 Token 的配置 json 格式文件。以下是所有支持的配置属性：

```console
{
	"decimal": 0~19之间的数字,
	"canTransfer": true/false, 如果canTransfer为false，则无法转移Token，
	"fullName": token全名的字符串
}
```

### issue（tokenSymbol，acc，amountStr）

`所需权限：tokenSymbol的发行者`

发行 tokenSymbol 至`acc`帐户，amountStr 是发行数额的字符串，数额必须是十进制正数，比如“100”，“100.999”

### transfer（tokenSymbol，accFrom，accTo，amountStr，memo）

`所需权限：accFrom`

使用 amountStr 和 memo 将 tokenSymbol 从`accFrom`转移到`accTo`，
amount 必须是正定点十进制，memo 是此传输操作的附加字符串消息，长度不超过 512 个字节。

### transferFreeze（tokenSymbol，accFrom，accTo，amountStr，unfreezeTime，memo）

`所需权限：accFrom`

使用 amountStr 和 memo 将 tokenSymbol 从`accFrom`传送到`accTo`，并将这部分 Token 冻结到 unfreezeTime。
unfreezeTime 是 unix 时间的纳秒数，之后 Token 将被解冻。

### destroy（tokenSymbol，accFrom，amountStr）

`所需权限：accFrom`

在`accFrom`帐户中销毁 数量为 amountStr 的 Token。在销毁之后，此 Token 的供应将减少相同的数量，这意味着，
你可以通过销毁一些 Token 在现有的 totalSupply 中发出更多 Token。

### balanceOf（tokenSymbol，acc）

`所需权限：null`

查询一个账户中的特定 Token 余额。

### supply（tokenSymbol）

`所需权限：null`

查询特定 Token 的供应量。

### totalSupply（tokenSymbol）

`所需权限：null`

查询特定 Token 的 totalSupply。

## 分步示例

在 iost 区块链上创建一个`IRC20` Token 非常简单，只是调用`token.iost`合约。

下面是一个分步示例，介绍如何使用`bank`帐户创建 Token 并在帐户之间转移 Token，你需要首先创建帐户`bank`，`user0`，`user1`。

```console
iwallet call token.iost create '["mytoken", "bank", 21000000000, {"decimal": 8, "fullName": "token for test"}]' --account bank
iwallet call token.iost issue  '["mytoken", "bank", "1000"]' --account bank
iwallet call token.iost issue  '["mytoken", "user0", "100.00000001"]' --account bank
iwallet call token.iost transfer 		'["mytoken", "user0", "user1", "10", "user0 pay coffee"]' --account user0
iwallet call token.iost transferFreeze 	'["mytoken", "user1", "user0", "0.1", 1544880864601648640, "voucher"]' --account user1
iwallet call token.iost destroy '["mytoken", "bank", "1000"]' --account bank
```
