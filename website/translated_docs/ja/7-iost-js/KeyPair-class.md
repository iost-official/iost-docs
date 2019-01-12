---
id: KeyPair-class
title: KeyPair
sidebar_label: 
---

KeyPairクラスは、IOSTアカウントを作成するためのクラスです。

## constructor
constructorメソッドは、特殊なメソッドで、KeyPairクラスを作成し、初期化します。

### パラメータ
名前             |型       |説明 
----                |--         |--
priKeyBytes |Buffer         | 秘密鍵
algType |Number         | [Algorithm](#algorithm).Secp256k1 または [Algorithm](#algorithm).Ed25519

#### Algorithm
名前             |型       |説明 
----                |--         |--
Secp256k1 |Number         | 1
Ed25519 |Number         | 2

### 戻り値
KeyPairオブジェクトインスタンス

### 例
```javascript
const kp = new KeyPair(bs58.decode('2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1'));
```

## newKeyPair
newKeyPairは、新規に公開鍵、秘密鍵ペアを作成します。

### パラメータ
名前             |型       |説明 
----                |--         |--
algType |Number         | [Algorithm](#algorithm).Secp256k1 または [Algorithm](#algorithm).Ed25519

### 戻り値
KeyPairオブジェクトインスタンス

### 例
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
```

## B58SecKey
B58SecKeyは、現在のKeyPairのBase58エンコードした秘密鍵を取得します。

### 戻り値
現在のKeyPairのBase58エンコードした秘密鍵

### 例
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58SecKey())
```

## B58PubKey
B58SecKeyは、現在のKeyPairのBase58エンコードした公開鍵を取得します。

### 戻り値
現在のKeyPairのBase58エンコードした公開鍵

### 例
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58PubKey())
```