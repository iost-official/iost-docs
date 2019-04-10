---
id: IOST-class
title: IOST
sidebar_label: IOST
---

Il s'agit de la classe principale pour créer les transactions à envoyer sur la blockchain IOST et les les smart contracts.
## constructor
La méthode constructor est spécifique à la création et à l'initialisation de la classe IOST.

### Paramètres
Name             |Type       |Description
----                |--         |--
config |Object         | config object for IOST class, config details as as follows:<br/> <b>gasRatio:</b> transaction gas price <br/> <b>gasLimit:</b> transaction gas limit <br/> <b>expiration:</b> time in seconds that transaction will be expired

### Retourne
L'instance d'objet IOST

### Exemple
```javascript
// init iost sdk
const iost = new IOST.IOST({ // will use default setting if not set
    gasRatio: 1,
    gasLimit: 100000,
    expiration: 90,
});
```

## callABI
appelle la fonction abi du contrat

### Paramètres
Name             |Type       |Description
----                |--         |--
contract |String         | contract id or contract domain
abi 	 |String 		 | contract abi function name
args	 |Array			 | function args array

### Retourne
L'objet transaction

### Exemple
```javascript
const tx = iost.callABI(
	"token.iost",
	"transfer",
	["iost", "fromAccount", "toAccount", "10.000", "memo"]
);
```

## newAccount
créé un nouveau compte IOST

### Paramètres
Name             |Type       |Description
----                |--         |--
name 			 |String	| new account name
creator 	 	 |String	| creator account name
ownerkey	 	 |String	| creator account ownerKey
activekey	 	 |String	| creator account activeKey
initialRAM	 	 |Number	| new account initialRAM, paid by creator
initialGasPledge |Number	| new account initialGasPledge, paid by creator

### Retourne
l'objet transaction

### Exemple
```javascript
// first create KeyPair for new account
const newKP = KeyPair.newKeyPair();
// then create new Account transaction
const newAccountTx = iost.newAccount(
    "test1",
    "admin",
    newKP.id,
    newKP.id,
    1024,
    10
);
```

## transfer
transfère  tokens to designated account, wrapper for callABI

### Paramètres
Name             |Type       |Description
----                |--         |--
token		|String	| new account name
from 	 	|String	| creator account name
to			|String	| creator account ownerKey
amount	 	|String	| creator account activeKey
memo	 	|Number	| new account initialRAM, paid by creator

### Retourne
Transaction Object.

### Exemple
```javascript
const tx = iost.transfer("iost", "fromAccount", "toAccount", "10.000", "memo");
```
