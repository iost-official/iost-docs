---
id: version-2.1.6-Update-Contract
title: Обновление контракта
sidebar_label: Обновление контракта
original_id: Update-Contract
---

## Характеристики

После того как контракт будет развернут в блокчейне, разработчики могут столкнуться с необходимостью обновления контракта, например, исправления ошибок, обновлений версий и т.д.

Мы предоставляем полный механизм обновления контрактов, который позволяет разработчикам легко обновлять смарт-контракт, отправляя транзакцию.
Что еще более важно, мы предоставляем очень гибкий контроль разрешения обновлений для удовлетворения любых требований к разрешению.

Чтобы обновить смарт-контракт, вам нужно реализовать функцию в смарт-контракте:
```js
can_update(data) {
}
```

При получении запроса на обновление контракта система сначала вызовет can_update(data) функцию контракта. data является необязательным входным параметром типа string. Если функция возвращает true, выполняется обновление контракта. В противном случае возвращается ошибка `Update Refused`.

Правильно написав эту функцию, вы можете реализовать любые требования к управлению разрешениями, такие как: только обновление, когда одновременно разрешают два человека, или некоторые люди голосуют, чтобы решить, следует ли обновлять контракт и т.д.

Если функция не реализована в контракте, контракт не разрешается обновлять по умолчанию.

## Hello BlockChain

Ниже мы берем простой смарт-контракт в качестве примера, чтобы проиллюстрировать процесс обновления контракта.

Создайте новый файл контракта helloContract.js со следующим содержимым
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello world";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.publisher(), "active");
    }
};
module.exports = helloContract;
```
Посмотрите на реализацию функции can_update() в файле контракта, которая позволяет обновлять контракт только при использовании авторизации аккаунта владельца контракта.

### Публикация контракта

Пожалуйста, обратитесь к [Publish Contract](../4-running-iost-node/iWallet#publish-contract), где объяснено больше.
```
$ export IOST_ACCOUNT=admin # replace with your own account name here
$ iwallet compile hello.js
$ iwallet --account $IOST_ACCOUNT publish hello.js hello.js.abi
...
The contract id is ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### Вызов контракта в первый раз
Теперь при вызове функции `hello` внутри только что загруженного вами контракта, вы получите в качестве возвращаемого значения 'hello world'.   
```
$ iwallet --account $IOST_ACCOUNT call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello world\"]"
    ],
    "receipts": [
    ]
}
```

### Обновление контракта
Сначала отредактируйте файл контракта helloContract.js для создания нового кода контракта следующим образом:
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello iost";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.publisher(), "active");
    }
};
module.exports = helloContract;
```
Мы изменили реализацию функции hello (), чтобы изменить возвращаемое значение с «hello world» на «hello iost».

Используйте следующую команду для обновления смарт-контракта:

```console
iwallet --account $IOST_ACCOUNT publish --update hello.js hello.js.abi ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### Вызов контракта во второй раз
После подтверждения транзакции вы можете снова вызвать функцию hello() с помощью iwallet и обнаружить, что возвращаемое значение меняется с 'hello world' на 'hello iost'
```
$ iwallet --account $IOST_ACCOUNT call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello iost\"]"
    ],
    "receipts": [
    ]
}
```
