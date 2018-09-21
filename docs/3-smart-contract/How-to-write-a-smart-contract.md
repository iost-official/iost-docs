---
id: How-to-write-a-smart-contract
title: How to write a smart contract
sidebar_label: How to write a smart contract
---


### 基本信息
#### 支持语言
当前IOST支持使用JavaScript编写的智能合约。 

#### 运行环境
IOST 内部使用了 [Chrome V8](https://developers.google.com/v8/) 引擎来进行智能合约的运行。

### 智能合约编写规则

#### 智能合约的实现
在IOST中， 智能合约会被编写成一个JavaScript中的类(```class```)。 使用时需要显示地去```export```该类。

##### 智能合约结构
智能合约编写的类必须包含 Init函数 与 Constructor函数。

- Init函数 为每个智能合约上链时被调用的函数， 一般可以用来初始化智能合约使用到的全局数据。
- Construct函数 为每个智能合约被调用时会首先执行的函数， 一般用来初始化智能合约类， 读取被持久化的智能合约数据。

除了这两个函数之外， 开发者可以根据自己需要定义其他函数， 以供自己与他人使用。 下面是一个简单的智能合约的模板, 实现了 Transfer 功能。

```javascript
class Test {
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
module.exports = Test;
```
### 内部类使用
#### IOSTContractStorage 类
运行时所有的变量都会存储在内存中。 IOST 提供了```IOSTContractStorage``` 类来帮助开发者持久化智能合约中需要使用到的数据。 

开发者可以使用该类来在多次智能合约调用之间同步数据。

```javascript
let IOSTContractStorage = (function () {

    let storage = new IOSTStorage;

    let simpleStorage = function () {
        this.put = function (k, v) {
            if (typeof v !== 'string') {
                throw new Error("storage put must be string");
            }
            return storage.put(k, v);
        };
        this.get = function (k) {
            return storage.get(k);
        };
        this.del = function (k) {
            return storage.del(k);
        }
    };
    let simpleStorageObj = new simpleStorage;

    let mapStorage = function () {
        this.mapPut = function (k, f, v) {
            if (typeof v !== 'string') {
                throw new Error("storage mapPut must be string");
            }
            return storage.mapPut(k, f, v);
        };
        this.mapHas = function (k, f) {
            return storage.mapHas(k, f);
        };
        this.mapGet = function (k, f) {
            return storage.mapGet(k, f);
        };
        this.mapKeys = function (k) {
            return JSON.parse(storage.mapKeys(k));
        };
        this.mapDel = function (k, f) {
            return storage.mapDel(k, f);
        }
    };
    let mapStorageObj = new mapStorage;

    let globalStorage = function () {
        this.get = function (key) {
            return storage.globalGet(c, k);
        }
    };
    let globalStorageObj = new globalStorage;

    return {
        // simply put a k-v pair, value must be string!
        // put(key, value)
        put: simpleStorageObj.put,
        // simply get a value using key.
        // get(key)
        get: simpleStorageObj.get,
        // simply del a k-v pair using key.
        // del(key)
        del: simpleStorageObj.del,
        // map put a (k, f, value) pair. use k + f to find value.
        // mapPut(key, field, value)
        mapPut: mapStorageObj.mapPut,
        // map check a (k, f) pair existence. use k + f to check.
        // mapHas(key, field)
        mapHas: mapStorageObj.mapHas,
        // map Get a (k, f) pair. use k + f to find value.
        // mapGet(key, field)
        mapGet: mapStorageObj.mapGet,
        // map Get fields inside a key.
        // mapKeys(key)
        mapKeys: mapStorageObj.mapKeys,
        // map Delete a (k, f) pair. use k + f to delete value.
        // mapDel(key, field)
        mapDel: mapStorageObj.mapDel,
        // currently not suportted, dont't use. 
        globalGet: globalStorageObj.get,
    }
})();

module.exports = IOSTContractStorage;

```

#### BlockChain 类
BlockChain 类提供了所有的系统调用方法， 帮助用户调用官方提供的一系列api。 包括但不限于转账， 汇款， 调用其他智能合约， 查询block， transaction等。 

详细接口列表如下: 

```javascript
let BlockChain = (function () {
    let bc = new IOSTBlockchain;
    return {
        // transfer IOSToken
        transfer: function (from, to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.transfer(from, to, amount.toString());
        },
        // withdraw IOSToken
        withdraw: function (to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.withdraw(to, amount.toString());
        },
        // deposit IOSToken
        deposit: function (from, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.deposit(from, amount.toString());
        },
        // put IOSToken into contract
        topUp: function (contract, from, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.topUp(contract, from, amount.toString());
        },
        // get IOSToken from contract
        countermand: function (contract, to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.countermand(contract, to, amount.toString());
        },
        // get blockInfo
        blockInfo: function () {
            return bc.blockInfo();
        },
        // get transactionInfo
        txInfo: function () {
            return bc.txInfo();
        },
        // call contract's api using args
        call: function (contract, api, args) {
            return bc.call(contract, api, args);
        },
        // call contract's api using args with receipt
        callWithReceipt: function (contract, api, args) {
            return bc.callWithReceipt(contract, api, args);
        },
        // 
        requireAuth: function (pubKey) {
            return bc.requireAuth(pubKey);
        },
        // not supportted
        grantServi: function (pubKey, amount) {
            return bc.grantServi(pubKey, amount.toString());
        }
    }
})();

module.exports = BlockChain;
```


#### Int64 类
当前 IOST 仅支持Int64类型的大数。 请尽量不要绕过IOST官方接口实现其他大数类型。 

```javascript
'use strict';

const MaxInt64 = new BigNumber('9223372036854775807');
const MinInt64 = new BigNumber('-9223372036854775808');

class Int64 {
    constructor(n, base) {
        this.number = new BigNumber(n, base);
        this._validate();
    }

    // Check is int64 (Interger that greater than MinInt64, less than MaxInt64)
    _validate() {
        if (!this.number.isInteger()) {
            throw new Error('Int64: ' + this.number + ' is not an integer');
        }

        if (this.number.gt(MaxInt64)) {
            throw new Error('Int64: ' + this.number + ' overflow int64');
        }

        if (this.number.lt(MinInt64)) {
            throw new Error('Int64: ' + this.number + ' underflow int64');
        }
    }

    // Check is argument int64
    _checkArgument(arg) {
        if (typeof arg === 'undefined' || arg == null) {
            throw new Error('Int64 argument: ' + arg + ' is empty');
        }

        if (!(arg instanceof Int64) || arg.constructor !== this.constructor) {
            arg = new this.constructor(arg);
        }

        arg._validate();

        return arg
    }

    // plus n
    plus(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.plus(arg.number);
        return new this.constructor(rs);
    }

    // minus n
    minus(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.minus(arg.number);
        return new this.constructor(rs);
    }

    // Multi n
    multi(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.times(arg.number);
        return new this.constructor(rs);
    }
    
    // Div n
    div(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.idiv(arg.number);
        return new this.constructor(rs);
    }

    // Mod n
    mod(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.mod(arg.number);
        return new this.constructor(rs);
    }

    // Power n
    pow(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.pow(arg.number);
        return new this.constructor(rs);
    }

    // Check equal n
    eq(n) {
        this._checkArgument(n);
        return this.number.eq(n.number);
    }

    // Check greater than n
    gt(n) {
        this._checkArgument(n);
        return this.number.gt(n.number);
    }

    // Check less than n
    lt(n) {
        this._checkArgument(n);
        return this.number.lt(n.number);
    }

    // Check is Zero
    isZero() {
        return this.number.isZero();
    }

    // convert to String
    toString() {
        return this.number.toString();
    }
}

module.exports = Int64;
```
