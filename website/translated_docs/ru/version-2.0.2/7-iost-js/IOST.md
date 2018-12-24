---
id: version-2.0.2-IOST-class
title: Класс IOST
sidebar_label: Класс IOST
original_id: IOST-class
---

Класс IOST - это основной класс, который создает транзакции для отправки в блокчейн IOST и смарт-контракты IOST.
## Метод constructor
Метод constructor это специальный метод для создания и инициализации класса IOST.

### Параметры
Название            |Тип        |Описание
----                |--         |--
config |Object         | объект config для класса IOST, детализация config следующая:<br/> <b>gasRatio:</b> цена газа транзакции <br/> <b>gasLimit:</b> лимит газа транзакции <br/> <b>expiration:</b> время в секундах, когда срок действия транзакции истечет

### Возвращает
Экземпляр объекта IOST.

### Пример
```javascript
// init iost sdk
const iost = new IOST.IOST({ // will use default setting if not set
    gasRatio: 1,
    gasLimit: 100000,
    expiration: 90,
});
```

## Метод callABI
вызов функции контракта с помощью ABI

### Параметры
Имя             |Тип       |Описание
----                |--         |--
contract |String         | id контракта или домен контракта
abi 	 |String 		 | название функции в ABI контракта
args	 |Array			 | массив аргументов функции

### Возвращает
Объект транзакции.

### Пример
```javascript
const tx = iost.callABI(
	"token.iost",
	"transfer",
	["iost", "fromAccount", "toAccount", "10.000", "memo"]
);
```

## Метод newAccount
создает новый аккаунт в блокчейне IOST

### Параметры
Имя             |Тип       |Описание
----                |--         |--
name 			 |String	| имя нового аккаунта
creator 	 	 |String	| имя аккаунта создателя
ownerkey	 	 |String	| ownerKey(ключ владельца) нового аккаунта
activekey	 	 |String	| activeKey(активный ключ) нового аккаунта
initialRAM	 	 |Number	| initialRAM(первоначальная оперативная память) нового аккаунта, оплаченный создателем
initialGasPledge |Number	| initialGasPledge(первоначальный газ) нового аккаунта, оплаченный создателем

### Возвращает
Объект транзакции.

### Пример
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

## Метод transfer
перевод токенов на указанный аккаунт, обертка для метода callABI

### Параметры
Имя             |Тип       |Описание
----                |--         |--
token		|String	| название токена
from 	 	|String	| аккаунт отправителя
to			|String	| аккаунт получателя
amount	 	|String	| количество токенов
memo	 	|Number	| initialRAM, оплачиваемый отправителем

### Возвращает
Объект транзакции.

### Пример
```javascript
const tx = iost.transfer("iost", "fromAccount", "toAccount", "10.000", "memo");
```
