---
id: How-to-write-a-smart-contract
title: 如何编写智能合约
sidebar_label: 如何编写智能合约
---

## 基本信息

### 支持语言

当前IOST支持使用JavaScript编写的智能合约。

### 运行环境

IOST 内部使用了 [Chrome V8](https://developers.google.com/v8) 引擎来进行智能合约的运行。

## 智能合约编写规则

### 智能合约的实现

在IOST中， 智能合约会被编写成一个JavaScript中的类(```class```)。 使用时需要显示地去```export```该类。

#### 智能合约结构

智能合约编写的类必须包含 Init函数。   

- Init函数 为每个智能合约上链时被调用的函数， 一般可以用来初始化智能合约使用到的全局数据。

除了这两个函数之外， 开发者可以根据自己需要定义其他函数， 以供自己与他人使用。 下面是一个简单的智能合约的模板, 实现了 Transfer 功能。

```javascript
class Test {
    init() {
        //Execute once when contract is packed into a block
    }

    transfer(from, to, amount) {
        //Function called by other
        blockchain.transfer(from, to, amount, "");
    }

};
module.exports = Test;
```

## IOST区块链API
智能合约中可以直接使用下述对象。

### storage 对象

运行时所有的变量都会存储在内存中。 IOST 提供了```storage``` 对象来帮助开发者持久化智能合约中需要使用到的数据。

开发者可以使用该类来在多次智能合约调用之间同步数据。
storage 所有接口见[代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js)。

### blockchain 对象

blockchain 对象提供了所有的系统调用方法，帮助用户调用官方提供的一系列api。包括但不限于转账，汇款，调用其他智能合约，查询block，transaction等。   
blockchain 所有接口见[代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js)。

### tx 对象和 block 对象
合约中可直接使用这两个对象，获得交易信息和区块信息。   
这两个对象的含义见[代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29)

### encrypt 对象
合约中可以直接使用 ```_IOSTCrypto``` Class 的对应 ```sha3(string)``` 方法来获取对应的sha3哈希值。
##### 例子

```js
IOSTCrypto.sha3(msg)
```


