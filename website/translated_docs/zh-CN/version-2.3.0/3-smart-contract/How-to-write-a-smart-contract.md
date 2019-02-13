---
id: How-to-write-a-smart-contract
title: IOST Blockchain API
sidebar_label: IOST Blockchain API
---

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
合约中可以直接使用 ```IOSTCrypto``` Class 的对应 ```sha3(string)``` 方法来获取对应的sha3哈希值。
##### 例子

```js
IOSTCrypto.sha3(msg)
```


