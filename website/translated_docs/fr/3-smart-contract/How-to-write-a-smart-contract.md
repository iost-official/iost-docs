---
id: How-to-write-a-smart-contract
title: Comment écrire un Smart Contract
sidebar_label: Comment écrire un Smart Contract
---

## Informations de base

### Langages supportés

Pour l'instant, les smart contracts IOST supportent le JavaScript.

### Environnement

En interne, IOST le moteur [Chrome V8](https://developers.google.com/v8/) pour exécuter les contrats.

## Guides de programmation de smart contracts

### Implémentation de smart contracts

Chez IOST, les smart contracts seront codés à l'intérieur d'une `classe` JavaScript. Lors de son utilisation il est nécessaire d'explicitement `exporter` la classe.

#### Structure d'un smart contract

Une classe de smart contract doit inclure les fonctions `Init` et `Constructor`.

- `Init` est exécutée quand un contrat est déployé. Elle contient généralement le code nécessaire à l'initialisation des propriétés du contrat.
- `Constructor` est exécutée quand un contrat est appelé. Elle est généralement utilisée pour initialiser les classes d'un smart contract, et pour lire les données persistentes d'un smart contract.

En dehors de ces deux fonctions, les développeurs peuvent définir toutes les autres fonctions selon leurs besoins. Vous trouverez ci-dessous un template de smart contract simple qui a une fonction `Transfert`.

```javascript
class Test {
    init() {
        //S'exécute une fois que le contrat est intégré dans un block
    }

    constructor() {
        //S'exécute une fois que le contrat est appelé
    }

    transfert(from, to, amount) {
        //Fonction appelée par une autre
        BlockChain.transfer(from, to, amount)

    }

};
module.exports = Test;
```

## Utiliser une classe interne

### Classe IOSTContractStorage

Toutes les variables seront stockées en mémoire pendant l'exécution. IOST offre la classe `IOSTContractStorage` afin d'aider les développeurs à intégrer des données persistentes dans leurs smart contracts.

Les développeurs peuvent utiliser cette classe pour synchroniser des données lors de l'appel de multiples contrats.

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
        // currently not suportted, don't use.
        globalGet: globalStorageObj.get,
    }
})();

module.exports = IOSTContractStorage;

```

### Classe BlockChain

La classe BlockChain propose toutes les méthodes d'appel système et aide l'utilisateur à appeler des APIs officielles, y compris celles de transfert, virement d'argent, appel d'autres contrats, recherche d'un bloc ou d'une transaction.

Les interfaces détaillées sont listées ci-dessous :

```javascript
let BlockChain = (function () {
    let bc = new IOSTBlockchain;
    return {
        // transférer des IOST
        transfer: function (from, to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.transfer(from, to, amount.toString());
        },
        // retirer des IOST
        withdraw: function (to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.withdraw(to, amount.toString());
        },
        // déposer IOST
        deposit: function (from, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.deposit(from, amount.toString());
        },
        // mettre des IOST dans un contrat
        topUp: function (contract, from, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.topUp(contract, from, amount.toString());
        },
        // récupérer les IOST d'un contrat
        countermand: function (contract, to, amount) {
            if (!(amount instanceof Int64)) {
                amount = new Int64(amount);
            }
            return bc.countermand(contract, to, amount.toString());
        },
        // obtenir blockInfo
        blockInfo: function () {
            return bc.blockInfo();
        },
        // obtenir transactionInfo
        txInfo: function () {
            return bc.txInfo();
        },
        // appeler l'api d'un contrat à l'aide d'arguments
        call: function (contract, api, args) {
            return bc.call(contract, api, args);
        },
        // appeler l'api d'un contrat à l'aide d'arguments et d'un reçu
        callWithReceipt: function (contract, api, args) {
            return bc.callWithReceipt(contract, api, args);
        },
        //
        requireAuth: function (pubKey) {
            return bc.requireAuth(pubKey);
        },
        // non supportée
        grantServi: function (pubKey, amount) {
            return bc.grantServi(pubKey, amount.toString());
        }
    }
})();

module.exports = BlockChain;
```


### Type Int64

Pour l'instant, IOST ne supporte que les grands nombres de type `Int64`. Veuillez vous abstenir d'utiliser d'autres types.

```javascript
'use strict';

const MaxInt64 = new BigNumber('9223372036854775807');
const MinInt64 = new BigNumber('-9223372036854775808');

class Int64 {
    constructor(n, base) {
        this.number = new BigNumber(n, base);
        this._validate();
    }

    // Vérifie si int64 (Integer plus grand que MinInt64, plus petit que MaxInt64)
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

    // Vérifie si l'argument est int64
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

    // moins n
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

    // Puissance n
    pow(n) {
        let arg = this._checkArgument(n);
        let rs = this.number.pow(arg.number);
        return new this.constructor(rs);
    }

    // égal a n
    eq(n) {
        this._checkArgument(n);
        return this.number.eq(n.number);
    }

    // plus grand que n
    gt(n) {
        this._checkArgument(n);
        return this.number.gt(n.number);
    }

    // plus petit que n
    lt(n) {
        this._checkArgument(n);
        return this.number.lt(n.number);
    }

    // vérifie si nul
    isZero() {
        return this.number.isZero();
    }

    // conversion en string
    toString() {
        return this.number.toString();
    }
}

module.exports = Int64;
```
