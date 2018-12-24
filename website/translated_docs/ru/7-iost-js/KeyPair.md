---
id: KeyPair-class
title: Класс KeyPair
sidebar_label: Класс KeyPair
---

Класс KeyPair это основной класс, который используется для создания пар ключей аккаунта IOST.

## Метод constructor
Метод constructor это специальный метод для создания и инициализации класса KeyPair.

### Параметры
Название             |Тип       |Описание
----                |--         |--
priKeyBytes |Buffer         | приватный ключ
algType |Number         | [Algorithm](#algorithm).Secp256k1 или [Algorithm](#algorithm).Ed25519

#### Algorithm (Алгоритм)
Название             |Тип       |Описание
----                |--         |--
Secp256k1 |Number         | 1
Ed25519 |Number         | 2

### Возвращает
Экземпляр объекта KeyPair.

### Пример
```javascript
const kp = new KeyPair(bs58.decode('2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1'));
```

## Метод newKeyPair
newKeyPair создает новую пару публичный/приватный ключей

### Параметры
Название             |Тип       |Описание
----                |--         |--
algType |Number         | [Algorithm](#algorithm).Secp256k1 или [Algorithm](#algorithm).Ed25519

### Возвращает
Экземпляр объекта KeyPair.

### Пример
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
```

## Метод B58SecKey
Метод B58SecKey возвращает секретный ключ (кодированный функцией base 58) текущего экземпляра объекта KeyPair.

### Возвращает
возврат секретного ключа кодировки base58 текущего экземпляра объекта KeyPair.

### Пример
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58SecKey())
```

## Метод B58PubKey

Метод B58PubKey возвращает публичный ключ (кодированный функцией base 58) текущего экземпляра объекта KeyPair.

### Возвращает
возврат публичного ключа кодировки base58 текущего экземпляра объекта KeyPair.

### Пример
```javascript
const kp = KeyPair.newKeyPair(Algorithm.Ed25519);
console.log(kp.B58PubKey())
```
