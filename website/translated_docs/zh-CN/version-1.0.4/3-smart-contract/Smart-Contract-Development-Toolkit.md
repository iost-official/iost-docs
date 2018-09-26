---
id: Smart-Contract-Development-Toolkit
title: "Scaf: 优秀的智能合约开发工具包"
sidebar_label: "Scaf: 优秀的智能合约开发工具包"
---

## 主要功能

Scaffold 旨在帮助 IOST 智能合约开发者快速完成 JavaScript 编写和开发编译工作。它的主要功能包括：

- 创建一个新的智能合约项目，并自动填充必要的文档结构

- 使用命令创建智能合约文件，并轻松添加测试功能

- 模拟系统函数，包括区块链函数和存储指令函数，帮助开发者正确测试合约

- 编译合约文件，生成合法有效的合约和 ABI 文件，可以直接上传区块链

- 运行合约的测试用例

## 安装和设置

安装之前，请确保你的设备中已经安装了 node 和 npm。

1. git clone git@github.com:iost-official/dapp.git

2. cd dapp

3. sudo npm install

4. sudo npm link

## 操作指令

输入具体的指令可以获取帮助信息。

```console
usr@Tower [master]:~/nodecode/dapp$ scaf
Usage: scaf <cmd> [args]

Commands:
  scaf new <name>      create a new DApp in current directory
  scaf add <item>      add a new [contract|function]
  scaf compile <name>  compile contract
  scaf test <name>     test contract

Options:
  --version   Show version number                                      [boolean]
  -h, --help  Show help                                                [boolean]

Not enough non-option arguments: got 0, need at least 1
usr@Tower [master]:~/nodecode/dapp$ scaf add
Usage: scaf add <item> [args]

Commands:
  scaf add contract <name>                  create a smart contract class
  scaf add func <con_name> <func_name>      add a function to a contract class
  [param...]
  scaf add test <con_name> <test_name>      add a test for a contract class

Options:
  --version           Show version number                              [boolean]
  -h, --help, --help  Show help                                        [boolean]

Not enough non-option arguments: got 0, need at least 1
```

## Hello BlockChain

### 新项目

> scaf new helloBlockChain

使用上述指令在当前目录下创建新的智能合约项目，并填充必要的文档结构。

```console
usr@Tower [master]:~/nodecode/dapp$ scaf new helloBlockChain
make directory: helloBlockChain
make directory: helloBlockChain/contract
make directory: helloBlockChain/abi
make directory: helloBlockChain/test
make directory: helloBlockChain/libjs

usr@Tower [master]:~/nodecode/dapp$ ls helloBlockChain/
abi  contract  libjs  test
```

### 添加一个智能合约

> cd helloBlockChain

> scaf add contract helloContract

`add <item>` 指令应仅在项目目录内执行。

这会生成合约文件 `helloContract.js` 和 ABI 文件 `helloContract.json`，它们的初始内容如下：

```js
usr@Tower [master]:~/nodecode/dapp$ cd helloBlockChain/

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add contract helloContract
create file: ./contract/helloContract.js
create file: ./abi/helloContract.json

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat contract/helloContract.js
const rstorage = require('../libjs/storage.js');
const rBlockChain = require('../libjs/blockchain.js');
const storage = new rstorage();
const BlockChain = new rBlockChain();

class helloContract
{
    constructor() {
    }
    init() {
    }
    hello(p0) {
		console.log(BlockChain.transfer("a", "b", 100));
		console.log(BlockChain.blockInfo());
		console.log("hello ", p0);
    }
};
module.exports = helloContract;

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat abi/helloContract.json
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

### 编写新的函数

> scaf add func helloContract hello string p0

这会在 `helloContract` 合约类中添加函数 `hello`。`string p0` 表明函数 `hello` 带有一个名为 `p0` 的字符串参数。

函数 `hello(p0)` 和对应的 ABI 信息会被添加到 `helloContract.js` 和 `helloContract.json` 中。

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add func helloContract hello string p0
add function hello() to ./contract/helloContract.js
add abi hello to ./abi/helloContract.json
{
    "name": "hello",
    "args": [
        "string"
    ]
}
```

编辑 `contract/helloContract.js` 来实现函数 `hello(p0) {}`:

```js
    hello(p0) {
		console.log(BlockChain.transfer("a", "b", 100));
		console.log(BlockChain.blockInfo());
		console.log("hello ", p0);
    }
```

在函数 `hello(p0)` 中，我们使用两种区块链的方式来记录结果：`BlockChain.transfer()` 和 `BlockChain.blockInfo()`

由于系统函数是模拟实现，这些函数会一直返回相同的 “有效” 结果。

### 添加一个测试文件

> scaf add test helloContract test1

这个指令会将名为 `test1` 的测试加入到 `helloContract` 合约中。`helloContract_test1.js` 会被创建到 `test/` 目录下，并且只有一行 `require` 函数。

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add test helloContract test1
create file: ./test/helloContract_test1.js

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');
```
Now edit test/helloContract_test1.js
```js
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');

var ins0 = new helloContract();
ins0.hello("iost");
```

### 运行测试

> scaf test helloContract

`scaf test <contract_name>` 会在合约中运行所有测试指令。

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf test helloContract
test ./test/helloContract_test1.js
transfer  a b 100
0
{"parent_hash":"0x00","number":10,"witness":"IOSTwitness","time":1537000000}
hello  iost
```

### 编译合约

> scaf compile helloContract

这个指令会编译合约和 ABI 文件，并将编译结果放入 `build/` 目录中。你可以将这些文件上传到主链。

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf compile helloContract
compile ./contract/helloContract.js and ./abi/helloContract.json
compile ./abi/helloContract.json successfully
generate file ./build/helloContract.js successfully

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ find build/
build/
build/helloContract.js
build/helloContract.json
```
