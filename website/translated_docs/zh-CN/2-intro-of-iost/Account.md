---
id: Account
title: 账号
sidebar_label: 账号
---

# 账户权限系统
## 总述
IOST的账户-权限系统是基于公私钥的身份认证机制。通过设置owner key和active key，用户可以很方便地使用账户系统，
同时，也可以自由地设置新的权限和秘钥权重，从而可以实现很多自定义的管理功能。

## 账户系统基础
IOST的账户由账户名（ID）和权限（permission）组成。一个账户中拥有若干权限，至少包含owner和active权限。每个权限中会登记若干条目（item）
， item可以是 base58 编码的公钥，也可以是另一个账户的权限对。

而 item 是另一个账户的权限对时，表示方式为 用户名@权限名

每个item都拥有一定的权重，而对应的，每个权限有一个阈值。当一笔交易中包含的item的权重之和大于阈值时，就认为这笔交易拥有这个权限。

判断是否拥有这个item的标准就是交易的签名是否包含这个item中公钥对应的签名（当这个item是一个公钥时），或迭代地判断该交易是否包含这个item
所记录的账户-权限对（当这个item是一个账户-权限对时）。

总的来说，智能合约验证权限时，会给出账户名和权限名，系统将检查该笔交易的签名，计算签名当中包含的item权重，如果签名足以提供这个权限，
则认为可以验证通过，否则将会拒绝这此权限验证。

active权限可以提供除了owner之外的所有权限，owner权限同样可以提供这些权限，而且只有具备了owner权限才能修改owner和active权限下的item。
同时，发送一笔交易需要提供active权限。

权限可以通过组(group)进行操作。可以将权限加入一个组，然后将在组内添加item。这样，一个item就能拥有这个组里所有的权限。

## 账户系统的使用

在智能合约层面，有非常简单的API可供使用
```
blockchain.requireAuth(id, permission_string)
```
它将返回一个bool，需要判断是否成立来进行下一步操作。

通常来说，使用用户的ram和token时，应当先检查用户是否提供active权限，否则智能合约可能在开发者不希望的地方throw，
其他时候，permission_string应当设置为一个不与其他地方重复的名字。这样可以最小化权限。

原则上说不应当require "owner"，用户没有义务在不需修改owner，active秘钥的情况下提供owner key

不需要require某笔交易的发起者，因为他总是拥有active权限。

在用户层面，只有提供签名这个动作可以为交易添加权限。假设有如下两个账户：
（注，示例账户中所有key默认weight=1，所有permission默认threshold=1）

```
User0
├── Groups
│   └── grp0: key3
└── Permissions
    ├── owner: key0
    ├── active: key1
    ├── perm0: key2, grp0
    ├── perm1: User1@active, grp0
    ├── perm2(threshold = 2): key4, key5, grp0
    ├── perm3: key8
    └── perm4(threshold = 2): User@perm3, key9

User1
└── Permissions
    ├── owner: key6
    └── active: key7

```
以下是requireAuth的表格

| 参数          | 签名的key |  返回  | 说明  |
| --------     | -------- | ----   | ---- |
| User0, perm0 | key2     | true | 提供权限对应的公钥的签名即拥有权限 |
| User0, perm0 | key3     | true | 提供权限组对应的公钥可以拥有组下所有权限 |
| User0, perm0 | key1     | true | 提供active权限即可拥有用户名下除了owner之外的所有权限 |
| User0, perm1 | key7     | true | key7提供了User1@active权限，因此也提供了perm1 |
| User0, owner | key1     | false | active不能提供owner权限 |
| User0, active | key0     | true | owner提供该用户一切权限 |
| User0, perm2 | key4     | false | 没有提供足够threshold的签名 |
| User0, perm2 | key4,key5 | true | 提供足够threshold的签名 |
| User0, perm2 | key3     | true | 权限组不计算threshold |
| User0, perm2 | key1     | true | active不计算threshold |
| User0, perm4 | key8     | false | 如需要计算权限组的weight，可以这样实现 |

## 账户的创建和管理

账户的管理基于智能合约```auth.iost```，其ABI如下：

```javascript
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "signUp", // 创建账号
      "args": ["string", "string", "string"] // 用户名，ownerKey ID，activeKey ID
    },
    {
      "name": "addPermission", // 添加权限
      "args": ["string", "string", "number"] // 用户名，权限名，权限的阈值
    },
    {
      "name": "dropPermission", // 删除权限
      "args": ["string", "string"] // 用户名，权限名
    },
    {
      "name": "assignPermission", // 指定权限给item
      "args": ["string", "string", "string","number"] // 用户名，权限，公钥ID或账户名@权限名，权重
    },
    {
      "name": "revokePermission",	 // 撤销权限
      "args": ["string", "string", "string"] // 用户名，权限，公钥ID或账户名@权限名
    },
    {
      "name": "addGroup",	// 添加权限组
      "args": ["string", "string"] // 用户名，组名
    },
    {
      "name": "dropGroup",	 // 删除权限组
      "args": ["string", "string"] // 用户名，组名
    },
    {
      "name": "assignGroup", // 指定item给权限组
      "args": ["string", "string", "string", "number"] // 用户名，组名，公钥ID或账户名@权限名，权重
    },
    {
      "name": "revokeGroup",	// 撤销权限组的item
      "args": ["string", "string", "string"] // 用户名，组名，公钥ID或账户名@权限名
    },
    {
      "name": "assignPermissionToGroup", // 添加权限到组
      "args": ["string", "string", "string"] // 用户名，权限名，组名
    },
    {
      "name": "revokePermissionInGroup", // 删除组中的权限
      "args": ["string", "string", "string"] // 用户名，权限名，组名
    }
  ]
}
```

账户名的命名只可以使用[a-z0-9\_]，长度不小于5，不大于11。权限名，组名也只能使用[a-zA-Z0-9\_]，长度不小于1，不大于32。

通常，账户在申请时就需要质押IOST，否则账户将无法使用，例如，iost.js的做法如下：

```js
newAccount(name, ownerkey, activekey, initialRAM, initialGasPledge) {
    const t = new Tx(this.config.gasPrice, this.config.gasLimit, this.config.delay);
    t.addAction("iost.auth", "signUp", JSON.stringify([name, ownerkey, activekey]));
    t.addAction("iost.ram", "buy", JSON.stringify([this.publisher, name, initialRAM]));
    t.addAction("iost.gas", "pledge", JSON.stringify([this.publisher, name, initialGasPledge]));
    return t
}
```

为了优化账户创建的流程，目前的扣费是这样的：创建账户的交易，其gas是由交易的publisher付费，其ram（就是新账户产生需要的ram）也由publisher代付。
当被创建的账户增加了账户的ram大小时，由之前publisher代付的ram将会退回给其拥有者，然后被创建账户将会为自己的账户ram付费。

创建账号时，可以选择为被创建的账户购买ram和质押token，建议为被创建账户质押最少10个token，以便被创建账户有足够的Gas使用网络。
账号的Gas质押至少要剩余10个Token，保证账号在任何情况下，都有足够的Gas来购买资源。

