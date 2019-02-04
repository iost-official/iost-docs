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

### 创建合约

首先使用 iwallet 创建账户 update, 记录屏幕上返回的账户ID
```console
./iwallet account -n update
return:
the iost account ID is:
IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h
```

新建合约文件 helloContract.js 和相应的ABI文件 helloContract.json 并写入以下内容
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "hello block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": []
        },
		{
			"name": "can_update",
			"args": ["string"]
		}
    ]
}
```
观察合约文件中的 can_update() 函数实现, 即只有在使用 adminID 账户授权时才允许合约更新.

### 部署合约

参见 [Deployment-and-invocation](../3-smart-contract/Deployment-and-invocation)

记录部署的合约ID, 例如 ContractHDnNufJLz8YTfY3rQYUFDDxo6AN9F5bRKa2p2LUdqWVW

### 升级合约
首先编辑合约文件 helloContract.js 生成新的合约代码如下:
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "update block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```

我们修改了hello()函数的实现, 将写入数据库的"message"的内容修改为"update block chain"

使用如下命令升级智能合约:
```console
./iwallet compile -u -e 3600 -l 100000 -p 1 ./helloContract.js ./helloContract.json <合约ID> <can_update 参数> -k ~/.iwallet/update_ed25519
```
-u 表示更新合约, -k 表示用于签名和发布的私钥, 这里使用update账户授权该交易

该交易确认后, 即可通过 iwallet 调用 hello() 函数, 并检查数据库 "message" 内容, 可看到内容变化
