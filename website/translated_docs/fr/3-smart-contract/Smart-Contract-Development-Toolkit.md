---
id: Smart-Contract-Development-Toolkit
title: Scaf : Un merveilleux toolkit de développement de Smart Contract
sidebar_label: Scaf : Un merveilleux toolkit de développement de Smart Contract
---

## Fonctionnalités

Scaffold est conçu afin d'aider les développeurs lorsqu'ils écrivent des smart contracts js pour la blockchain IOST. Il offre les fonctionnalités suivantes :

- Initialisation de projet dapp avec structure appropriée
- Commandes permettant l'initialisation des fichiers du contrat, l'ajout simple de fonctions et de tests pour le contrat
- Simulation de fonctions système (incluant les fonctions blockchain et de stockage) incluses afin de tester correctement le contrat
- Compilation du fichier du contrat afin de générer un contrat et un fichier abi valides qui peuvent être uploadés directement sur la blockchain
- Scénarios tests pour le contrat

## Installation et paramétrage

Avant de commencer, assurez vous d'avoir node et npm installés sur votre ordinateur.

1. `git clone git@github.com:iost-official/dapp.git`

2. `cd dapp`

3. `sudo npm install`

4. `sudo npm link`

## Commandes

`help` est affichée lors de l'utilisation de commandes spécifiques.

```console
usr@Tower [master]:~/nodecode/dapp$ scaf
Usage: scaf <cmd> [args]

Commandes :
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
### Créer un nouveau projet

```
scaf new <contract_name>
```

Le projet est généré dans le répertoire actuel, avec une structure initialisée.

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

### Ajouter un contrat

```
cd <contract_name>
scaf add contract <contract_name>
```

La commande `add <item>` devrait être exécutée dans le répertoire du projet. Le fichier projet `helloContract.js` et le fichier ABI `helloContract.json` sont générés avec les contenu initial suivant :

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
};
module.exports = helloContract;

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat abi/helloContract.json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
    ]
}
```

### Ajouter une fonction

```
scaf add func <contract_name> <function_name> [type0] [parameter0] [type1] [parameter1] ...
```

La commande ci-dessus ajoute une fonction nommée `hello` à la classe `helloContract`. `string p0` signifie que la fonction `hello` a un paramètre de type `string` nommé `p0`.

Le paramètre doit être d'un des types suivants ['string', 'number', 'bool', 'json']

La fonction `hello(p0)` et ses informations ABI correspondantes sont ajoutées à `helloContract.js` et `helloContract.json`.

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

A présent éditer `contract/helloContract.js` afin d'implémenter `hello(p0) {}`

```js
hello(p0) {
  console.log(BlockChain.transfer("a", "b", 100));
  console.log(BlockChain.blockInfo());
  console.log("hello ", p0);
}
```

Dans cette fonction `hello(p0)`, nous enregistrons le résultat de deux fonctions systèmes, `BlockChain.transfer()` et `BlockChain.blockInfo()`.

Comme les fonctions systèmes sont imitées, elles retourneront toujours des résultats valides.

### Ajouter un test

```
scaf add test <contract_name> <test_name>
```

Cette commande ajoute un test nommé test1 pour le contrat `helloContract`. `helloContract_test1.js` est créé dans `test/` avec une simple déclaration `require`.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add test helloContract test1
create file: ./test/helloContract_test1.js

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');
```
Editer test/helloContract_test1.js
```js
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');

var ins0 = new helloContract();
ins0.hello("iost");
```

### Exécuter le test

```
scaf test <contract_name>
```

Cette commande exécute tous les tests d'un contrat spécifié.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf test helloContract
test ./test/helloContract_test1.js
transfer  a b 100
0
{"parent_hash":"0x00","number":10,"witness":"IOSTwitness","time":1537000000}
hello  iost
```

### Compiler le contract

```
scaf compile <contract_name>
```

Cette commande compile le fichier contrat et le fichier ABI est créé dans `build/`. Vous pouvez uploader ces fichier sur la blockchain IOST.

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
