---
id: KeyPair-class
title: KeyPair
sidebar_label: KeyPair
---

IOST账户中的秘钥对

## constructor
构造函数


### Parameters
Name             |Type       |Description 
----                |--         |--
priKeyBytes |Buffer         | 私钥
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
新建一个秘钥对

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
获取当前私钥的base58编码字符串

### Returns
当前私钥的base58编码字符串

### Example
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58SecKey())
```

## B58PubKey
获取当前公钥的base58编码字符串

### Returns
当前公钥的base58编码字符串

### Example
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58PubKey())
```
