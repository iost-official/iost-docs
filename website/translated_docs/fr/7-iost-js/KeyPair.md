---
id: KeyPair-class
title: KeyPair
sidebar_label: KeyPair
---

Ceci est la classe principale pour la création de paires de clé IOST.

## constructor
La méthode constructor est spécifique à la création et à l'initialisation de la classe KeyPair.

### Paramètres
Name             |Type       |Description
----                |--         |--
priKeyBytes |Buffer         | private key
algType |Number         | [Algorithm](#algorithm).Secp256k1 or [Algorithm](#algorithm).Ed25519

#### Algorithm
Name             |Type       |Description
----                |--         |--
Secp256k1 |Number         | 1
Ed25519 |Number         | 2

### Retourne
Instance d'objet KeyPair.

### Exemple
```javascript
const kp = new KeyPair(bs58.decode('2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1'));
```

## newKeyPair
newKeyPair créé une nouvelle paire de clés publique/privée

### Paramètres
Name             |Type       |Description
----                |--         |--
algType |Number         | [Algorithm](#algorithm).Secp256k1 or [Algorithm](#algorithm).Ed25519

### Retourne
L'instance d'objet KeyPair.

### Exemple
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
```

## B58SecKey
B58SecKey retourne la clé secrète actuelle en base 58.

### Retourne
retourne la clé secrète actuelle en base 58.

### Exemple
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58SecKey())
```

## B58PubKey

B58SecKey retourne la clé publique actuelle en base 58.

### Retourne
retourne la clé publique actuelle en base 58.

### Exemple
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58PubKey())
```
