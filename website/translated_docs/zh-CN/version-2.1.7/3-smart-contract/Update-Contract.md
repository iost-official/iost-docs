---
id: Update-Contract
title: 合约更新
sidebar_label: 合约更新
---

## 主要功能

合约部署到区块链后, 开发者可能会面临需要更新合约的需求, 如修复错误, 版本升级等

我们提供了一套完整的合约更新机制, 使开发者可以方便地通过发送交易完成合约更新的过程,
更重要的是, 我们提供非常灵活完善的更新权限控制, 可以满足任意的权限需求

为更新智能合约, 需要在第一次发布合约的代码中实现函数:
```js
can_update(data) {
}
```
收到更新该合约的请求时, 系统会首先调用该合约的 can_update(data) 函数, data为可选的类型为字符串的输入参数, 若该函数返回 true 则执行合约更新, 否则返回 Update Refused 错误.

通过适当编写该函数, 可以实现任意的权限管理需求, 如A,B两人同时授权时允许更新, N个人投票决定是否合约更新等.

若合约中未实现该函数, 则默认该合约不允许更新.

## Hello BlockChain

下面我们以一个简单的智能合约为例, 说明合约更新的过程

新建合约文件 helloContract.js 并写入以下内容
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello world";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.publisher(), "active");
    }
};
module.exports = helloContract;
```
观察合约文件中的 can_update() 函数实现, 即只有在使用合约拥有者账户授权时才允许合约更新.

### 部署合约
参见 [发布合约](4-running-iost-node/iWallet.md#发布合约)

```
$ export IOST_ACCOUNT=admin # replace with your own account name here
$ iwallet compile hello.js
$ iwallet --account $IOST_ACCOUNT publish hello.js hello.js.abi
...
The contract id is ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```


### 第一次调用
第一次调用返回 'hello world'   
```
$ iwallet --account $IOST_ACCOUNT call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello world\"]"
    ],
    "receipts": [
    ]
}
```
### 升级合约
首先编辑合约文件 helloContract.js 生成新的合约代码如下:
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello iost";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.publisher(), "active");
    }
};
module.exports = helloContract;
```

我们修改了hello()函数的实现, 将hello函数返回值从 hello world 改成 hello iost。   

使用如下命令升级智能合约:
```console
iwallet --account $IOST_ACCOUNT publish --update hello.js hello.js.abi ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### 第二次调用
第二次调用，看到返回值从 'hello world' 变成 'hello iost'
```
$ iwallet --account $IOST_ACCOUNT call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello iost\"]"
    ],
    "receipts": [
    ]
}
```
