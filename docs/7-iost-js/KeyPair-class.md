---
id: KeyPair-class
title: KeyPair
sidebar_label: KeyPair
---

This is the main class that used to create IOST account keyPairs.

## constructor
constructor method is a special method for creating and initializing KeyPair class.

### Parameters
Name             |Type       |Description 
----                |--         |--
priKeyBytes |Buffer         | private key
algType |Number         | [Algorithm](#algorithm).Secp256k1 or [Algorithm](#algorithm).Ed25519

#### Algorithm
Name             |Type       |Description 
----                |--         |--
Secp256k1 |Number         | 1
Ed25519 |Number         | 2

### Returns
KeyPair object instance.

### Example
```javascript
const kp = new KeyPair(bs58.decode('2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1'));
```

## newKeyPair
newKeyPair create new public/private key pair

### Parameters
Name             |Type       |Description 
----                |--         |--
algType |Number         | [Algorithm](#algorithm).Secp256k1 or [Algorithm](#algorithm).Ed25519

### Returns
KeyPair object instance.

### Example
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
```

## B58SecKey
B58SecKey return current KeyPair's base 58 encode secret key.

### Returns
return current KeyPair's base 58 encode secret key.

### Example
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58SecKey())
```

## B58PubKey

B58SecKey return current KeyPair's base 58 encode public key.

### Returns
return current KeyPair's base 58 encode public key.

### Example
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58PubKey())
```