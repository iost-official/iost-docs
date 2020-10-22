---
id: ContractStart
title: Smart Contract Quick Start
sidebar_label: Smart Contract Quick Start
---

# 智能合约快速入门指南

## IOST DApp基础
区块链可以抽象为一个全网同步的状态机，智能合约是在区块链系统上执行的代码，通过交易改变状态机中的状态。由于区块链的特性可以保证智能合约的调用是串行的，全局一致的。

IOST智能合约目前支持JavaScript（ES6）开发。

一个IOST智能合约包含智能合约的代码和一个用以描述ABI的JSON文件，它有自己的命名空间和隔离的存储空间。外部只能读取它的存储内容

### 关键词

| 关键词 | 说明 |
| :-- | :-- |
| ABI | 智能合约接口，只有经过声明的接口才能对外被调用 |
| Tx | transaction，区块链上的状态必须要通过提交tx，tx被打包到block当中之后才能被修改 |

## Debug环境配置

### 使用iwallet和测试节点

智能合约的开发和部署需要[iwallet](4-running-iost-node/iWallet.md)，同时，[启动一个测试节点](4-running-iost-node/LocalServer.md)可以方便debug。

### 为iwallet导入初始账户```admin```

为了完成测试，需要为iwallet导入私钥。对于本地调试网络，可以直接使用默认的  admin 账号。

```
iwallet account import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```


## Hello world

### 准备代码
首先准备一个JavaScript类, 例如：HelloWorld.js

```
class HelloWorld {
	init() {} // 需要提供一个init函数，它将会在部署时被调用
    hello(someone) {
        return "hello, "+ someone
    }
}

module.exports = HelloWorld;
```

该智能合约包含一个接口，接收一个输入然后输出```hello, +输入```。为了让智能合约外部可以调用这个接口，需要准备abi文件，例如：HelloWorld.abi

```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "hello",
      "args": [
        "string"
      ]
    }
  ]
}
```

abi的name字段对应js的函数名，args列表包含了一个初步的类型检查，建议只使用string，number，bool三种类型。

## 发布到本地测试节点

发布智能合约

```
iwallet \
 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 publish helloworld.js helloworld.abi
```

示例输出

```
{
    "txHash": "96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf",
    "gasUsage": 36361,
    "ramUsage": {
        "admin": "356",
        "system.iost": "148"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf\"]"
    ],
    "receipts": [
    ]
}
The contract id is Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf  # 这就是部署的 contract id

```

测试ABI调用

```
iwallet \
 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf" "hello" '["developer"]' # contract id 需改成你所收到的id
```

输出

```
send tx done
the transaction hash is: GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
exec tx done # 以下输出tx执行后的TxReceipt
{
    "txHash": "GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc",
    "gasUsage": 33084,
    "ramUsage": {
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello, developer\"]"  # 返回了所需的字符串
    ],
    "receipts": [
    ]
}
```

之后，可以在任何时候通过以下命令获取TxReceipt

```
iwallet receipt GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

也可以通过http来获取

```
curl -X GET \
  http://localhost:30001/getTxReceiptByTxHash/GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

可以认为此次调用将会被IOST永久记录，无法篡改。

## IDE

合约开发可以采用[在线IDE](https://chainide.com/ "ide")，首先开发者需要安装[Chrome iwallet](https://chrome.google.com/webstore/detail/iwallet/kncchdigobghenbbaddojjnnaogfppfj?utm_source=chrome-ntp-icon "iwallet")，导入账号并购买资源，然后即可基于IDE开发、部署和调试合约

## 智能合约的状态存储

使用智能合约的输出（类似utxo的概念）是不方便的，IOST并没有采用这种模式，因此IOST并不提供对TxReceipt中各个字段的索引，同时智能合约内部也无法访问特定的TxReceipt。为了维护区块链状态机，我们使用一个区块链状态数据库来保存状态。

数据库是一个单纯的K-V数据库, key，value类型都是string。每个智能合约拥有一个独立的命名空间。
智能合约可以读其他智能合约的状态数据，但是只能写自己的字段。

### 代码

```
// Storage.js
class Test {
    init() {
        storage.put("value1", "foobar")
    }
    read() {
        console.log(storage.get("value1"))
    }
    change(someone) {
        storage.put("value1", someone)
    }
}
module.exports = Test;
```

abi略过

### 使用状态存储
部署代码之后，可以通过以下的方法获取storage

```
curl -X POST \
  http://localhost:30001/getContractStorage \
  -d '{
    "id": "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e",
    "key": "value1",
    "by_longest_chain": true
}'
```
这个post将会返回一个 json string:

```
{
    "data": "foobar"
}
```

调用change，就可以修改这个值。

```
iwallet \
 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e" "change" '["foobaz"]'
```

## 权限控制和智能合约的失败

权限控制的基础可以参阅：

示例

```
if (!blockchain.requireAuth("someone", "active")) {
    throw "require auth error"  // 没有被catch的throw会抛出到虚拟机，导致失败
}
```

需要注意的有以下几点:
1. requireAuth 本身不会终止智能合约的运行，它只返回一个bool值，所以需要判断。
2. requireAuth(tx.publisher, "active") 恒为 true

当 throw 时，交易运行失败，本次智能合约调用被完全回滚，但是会扣除用户运行交易的 gas 费用（因为被回滚所以不会收取ram）。

可以通过简单的测试观察运行失败的交易

```
iwallet \
 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "token.iost" "transfer" '["iost", "someone", "me". "10000.00", "this is steal"]'
```

返回结果将是

```
{
    "txHash": "GCB9UdAKyT3QdFh5WGujxsyczRLtXX3KShzRsTaVNMns",
    "gasUsage": 2864,
    "ramUsage": {
    },
    "statusCode": "RUNTIME_ERROR",
    "message": "running action Action{Contract: token.iost, ActionName: transfer, Data: [\"iost\",\"someone\",\"me\",\"10000.00\",\"trasfer ... error: invalid account someone",
    "returns": [
    ],
    "receipts": [
    ]
}
```

## 调试

首先按照上文提供的方法启动本地节点，如果使用docker，可以使用以下命令打印log

```
docker ps -f <container>
```

此时，在代码中可以加入console.log()，就可以打印出需要的log

```
Info 2019-01-08 06:44:11.110 pob.go:378 Gen block - @7 id:IOSTfQFocq..., t:1546929851105164574, num:378, confirmed:377, txs:1, pendingtxs:0, et:4ms
Info 2019-01-08 06:44:11.416 value.go:447 foobar
Info 2019-01-08 06:44:11.419 pob.go:378 Gen block - @8 id:IOSTfQFocq..., t:1546929851402828690, num:379, confirmed:378, txs:2, pendingtxs:0, et:16ms
```
