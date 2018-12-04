---
id: How-to-write-a-smart-contract
title: 스마트 컨트랙트 작성하기
sidebar_label: 스마트 컨트랙트 작성하기
---

## 기본 안내사항

### 지원되는 언어

현재 IOST 스마트 컨트랙트로 지원되는 언어는 자바스크립트입니다.

### 런타임 환경

IOST는 내부적으로 [Chrome V8] 엔진을 이용하여 컨트랙트를 실행합니다.

## 스마트 컨트랙트 프로그래밍 가이드

### 스마트 컨트랙트 구현하기

IOST에서 스마트 컨트랙트를 구현할 때에는 자바스크립트의 `class`를 사용합니다. 이 `class`는 꼭 `export`가 되어야 합니다.

#### 스마트 컨트랙트 구조

IOST 스마트 컨트랙트는 `Init`과 `Constructor` 함수(메서드)를 반드시 자바스크립트 클래스 내부에 선언해야 합니다.

- `Init` 메서드 내부에 작성되는 코드는 컨트랙트가 배포 되었을 때 불리는 코드입니다. 주로 컨트랙트의 변수들에 초기 값을 설정할 때 사용됩니다.
- `Construct` 메서드 내부에 작성되는 코드는 컨트랙트가 호출될 때마다 불리는 코드입니다. 주로 스마트 컨트랙트의 클래스를 초기화 하거나 스마트 컨트랙트의 데이터를 읽어올 때 사용됩니다.

위의 두 메서드 외에도, 사용자 정의 메서드를 작성할 수 있습니다. 아래는 `Transfer` 라는 사용자 정의 함수를 추가한 예제 코드입니다.

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

## 내부 클래스 사용하기

### IOSTContractStorage 클래스

기본적으로 모든 변수들은 런타임에 메모리에 저장되게 되는데, IOST는 `IOSTContractStorage`라는 클래스를 제공하여 데이터를 스마트 컨트랙트 내부에 영구적으로 저장(영속) 할 수 있습니다.

이 클래스는 데이터를 동기화하는데에도 사용될 수 있습니다.

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

### BlockChain 클래스

BlockChain 클래스는 IOST 블록체인과 관련된 공식 메서드를 호출 할 수 있는 기능을 제공합니다. 이러한 공식 메서드에는 돈을 전송하는 메서드나, 다른 컨트랙트를 호출하거나, 특정 블록이나 트랜잭션의 정보를 가져오는 것 등등이 포함됩니다.

BlockChain 클래스의 상세 코드는 아래와 같습니다:

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


### Int64 타입

현재 IOST는 큰 수에 대해서 `Int64`의 타입만을 지원하고 있습니다. (현재 버전에서는 다른 타입을 사용하는 것은 자제해주세요.)

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
