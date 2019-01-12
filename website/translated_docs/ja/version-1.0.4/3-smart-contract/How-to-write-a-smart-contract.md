---
id: version-1.0.4-How-to-write-a-smart-contract
title: スマートコントラクトの書き方
sidebar_label: スマートコントラクトの書き方
original_id: How-to-write-a-smart-contract
---

## 基本情報

### 言語サポート

現在IOSTは、JavaScriptで書かれたスマートコントラクトをサポートしています。

### R実行環境

IOSTはコントラクトの実行のために[Chrome V8](https://developers.google.com/v8)エンジンを内部で使っています。

## スマートコントラクトプログラミングガイド

### Implementing smart contracts

IOST内では、スマートコントラクトはJavaScriptの`class`としてコーディングされています。それを使うには、そのクラスを`export`する必要があります。

#### スマートコントラクトの構造

スマートコントラクトのクラスは、`Init`関数と`Constructor`関数を持たなければいけません。

- `Init`は、コントラクトがデプロイされたときに実行されます。それはコントラクトのプロパティを初期化するのに使います。
- `Construct`は、コントラクトが呼び出されたときに最初に実行されます。スマートコントラクトのクラスを初期化し、スマートコントラクトの永続化されたデータを読み出すのに使います。

これらの２つの関数とは別に、必要であれば開発者は他の関数も定義できます。`Transfer`関数を使ったシンプルなスマートコントラクトのテンプレートを次に示します。

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

## 内部クラスの利用

### IOSTContra
ctStorage Class

すべての変数はラインタイム上のメモリに格納されます。IOSTは、`IOSTContractStorage`クラスで、スマートコントラクト内でデータを永続化できます。

開発者はこのクラスを使用して、複数のコントラクト呼び出し中にデータを同期できます。

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

### BlockChainクラス

BlockChainクラスは、 システムを呼び出すメソッドを提供し、転送やメモリへの書き込み、他のコントラクトの呼び出し、ブロックやトランザクションの検索を含む公式APIを呼び出せますが、これらに限定されません。 

詳細のインターフェースは次のとおりです。

```javascript
let BlockChain = (function () {
    let bc = new IOSTBlockchain;
    return {
        // transfer IOS
        transfer: function (from, to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.transfer(from, to, amount.toString());
        },
        // withdraw IOST
        withdraw: function (to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.withdraw(to, amount.toString());
        },
        // deposit IOST
        deposit: function (from, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.deposit(from, amount.toString());
        },
        // put IOST into contract
        topUp: function (contract, from, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.topUp(contract, from, amount.toString());
        },
        // get IOST from contract
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


### Int64型

現在のところ、IOSTではビッグナンバーとして、`Int64`型だけが使えます。他の数値型を使わないようにしてください。

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
