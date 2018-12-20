---
id: How-to-write-a-smart-contract
title: Как написать смарт-контракт
sidebar_label: Как написать смарт-контракт
---

## Основная информация

### Поддержка языков

В настоящее время IOST смарт-контракты поддерживают JavaScript.

### Среда выполнения

Внутри IOST работает [Chrome V8](https://developers.google.com/v8/) движок для выполнения контрактов.

## Руководство по программированию смарт-контрактов

### Внедрение смарт-контрактов

В IOST смарт-контракты будут закодированы в JavaScript `class`. При его использовании вам нужно `export` (экспортировать) класс.

#### Структура смарт-контракта

Класс смарт-контракта должен включать в себя функции `Init` и `Constructor`.

- `Init` запускается при развертывании контракта. Обычно он содержит код для инициализации свойств контракта.
- `Construct` запускается при вызове контракта. Обычно он используется для инициализации классов смарт-контракта и чтения постоянных данных смарт-контракта.

Помимо этих двух функций, разработчики могут определять другие функции по мере необходимости. Ниже приведен шаблон простого смарт-контракта, в котором есть `Transfer` функциональность.

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

## Использование внутреннего класса

### Класс IOSTContractStorage

Все переменные будут сохранены в памяти во время выполнения. IOST предоставляет `IOSTContractStorage` класс, чтобы помочь разработчикам сохранить данные в смарт-контрактах.

Разработчики могут использовать этот класс для синхронизации данных во время нескольких вызовов контракта.

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

### Класс BlockChain

Класс BlockChain предоставляет все методы для вызова системных функций и помогает пользователю вызывать официальные API-интерфейсы, включая, помимо прочего, передачу, перевод средств, вызов других контрактов и поиск блока или транзакции.

Подробные интерфейсы перечислены ниже:

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


### Тип Int64

В настоящее время IOST поддерживает только целые числа типа данных `Int64`. Пожалуйста, воздержитесь от использования других типов чисел.

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
