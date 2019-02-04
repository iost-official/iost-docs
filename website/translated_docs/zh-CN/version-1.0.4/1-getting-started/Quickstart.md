---
id: Quickstart
title: 快速开始
sidebar_label: 快速开始
---

## 1. 克隆代码库

```
git clone https://github.com/iost-official/go-iost.git
cd go-iost
```

## 2. 安装依赖环境

运行下面的指令来安装所有的依赖环境：

```
cd go-iost/iwallet/contract
npm install
```


## 3. 编写一个智能合约

IOST 智能合约支持 JavaScript。一个简单的智能合约如下：

```
class Sample {
    init() {
        //Execute once when contract is packed into a block
    }

    constructor() {
        //Execute everytime the contract class is called
    }

    transfer(from, to, amount) {
        //Function called by other
        BlockChain.transfer(from, to, amount)

    }

};
module.exports = Sample;
```

## 4. 部署智能合约

依据以下步骤部署智能合约：

- 编译 JavaScript 文档来生成 ABI 文件
- 使用 `.js` `.abi` 和 `.sc` 文件生成一个包
- 将 `.sc` 文件发送给各个签名者，他们会生成 `.sig` 文档
- 收到 `.sig` 和 `.sc` 文件之后，发布到主链上
