---
id: version-2.1.7-How-to-write-a-smart-contract
title: Как написать смарт-контракт
sidebar_label: Как написать смарт-контракт
original_id: How-to-write-a-smart-contract
---

## Основная информация

### Поддержка языков

В настоящее время IOST смарт-контракты поддерживают JavaScript.

### Среда выполнения

Внутри IOST работает [Chrome V8](https://developers.google.com/v8) движок для выполнения контрактов.

## Руководство по программированию смарт-контрактов

### Внедрение смарт-контрактов

В IOST смарт-контракты будут закодированы в JavaScript `class`. При его использовании вам нужно `export` (экспортировать) класс.

#### Структура смарт-контракта

Класс смарт-контракта должен включать в себя функцию `Init`.

- `Init` запускается при развертывании контракта. Обычно она содержит код для инициализации свойств контракта.

Помимо этой функции, разработчики могут определять другие функции по мере необходимости. Ниже приведен шаблон простого смарт-контракта, в котором есть `transfer` функциональность.

```javascript
class Test {
    init() {
        //Execute once when contract is packed into a block
    }

    transfer(from, to, amount) {
        //Function called by other
        blockchain.transfer(from, to, amount, "");
    }

};
module.exports = Test;
```

## IOST BlockChain API
Объекты ниже могут быть доступны внутри кода контракта.

### storage object (Объект storage)

Все переменные будут храниться в памяти во время выполнения. IOST предоставляет объект `storage`, чтобы помочь разработчикам сохранять данные в смарт-контрактах.

Разработчики могут использовать этот класс для синхронизации данных во время множества вызовов контракта.
API [здесь](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js)



### blockchain object (Объект blockchain)

Объект blockchain предоставляет все методы для системных вызовов и помогает пользователю вызывать официальные API, включая, помимо прочего, перевод средств, вызов других контрактов и поиск блока или транзакции.

Подробные интерфейсы приведены [здесь](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js).


### tx object и block object (Объекты tx и block)
Объект tx содержит информацию о текущей транзакции.   
Объект block содержит информацию о текущем блоке.   
API [Здесь](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29)

### encrypt object (Объект шифрования)
Вы можете напрямую использовать Функцию ```sha3(String)``` объекта ```IOSTCrypto```для получения Хеша sha3。

##### Пример

```js
IOSTCrypto.sha3(msg)
```
