---
id: Update-Contract
title: Обновление контракта
sidebar_label: Обновление контракта
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

При получении запроса на обновление контракта система сначала вызовет can_update(data) функцию контракта. data является необязательным входным параметром типа string. Если функция возвращает true, выполняется обновление контракта. В противном случае `Update Refused` ошибка возвращается.

Правильно написав эту функцию, вы можете реализовать любые требования к управлению разрешениями, такие как: только обновление, когда одновременно разрешают два человека, или некоторые люди голосуют, чтобы решить, следует ли обновлять контракт и т.д.

Если функция не реализована в контракте, контракт не разрешается обновлять по умолчанию.

## Hello BlockChain

Ниже мы берем простой смарт-контракт в качестве примера, чтобы проиллюстрировать процесс обновления контракта.

### Создать контракт

Сначала создайте обновление аккаунта с помощью комманды `iwallet`, запишите ID аккаунта, который будет отображаться на экране
```console
./iwallet account -n update
return:
the iost account ID is:
IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h
```

Создайте новый файл контракта helloContract.js и его соответствующий ABI файл helloContract.json со следующим содержимым
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "hello block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": []
        },
		{
			"name": "can_update",
			"args": ["string"]
		}
    ]
}
```
Посмотрите на реализацию функции can_update() в файле контракта, который позволяет обновлять контракт только при использовании авторизации аккаунта adminID.

### Развертывание контракта

Пожалуйста, обратитесь к [Развертывание-и-вызов](../3-smart-contract/Deployment-and-invocation)

Не забудьте записать contractID как ContractHDnNufJLz8YTfY3rQYUFDDxo6AN9F5bRKa2p2LUdqWVW

### Обновление контракта
Сначала отредактируйте файл контракта helloContract.js для создания нового кода контракта следующим образом:
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "update block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
Мы внесли изменения в функцию hello() для изменения содержимого «message», записанного в базу данных, на «update block chain».

Используйте следующую команду для обновления смарт-контракта:

```console
./iwallet compile -u -e 3600 -l 100000 -p 1 ./helloContract.js ./helloContract.json <合约ID> <can_update 参数> -k ~/.iwallet/update_ed25519
```
-u указывает на обновление контракта, -k указывает закрытый ключ, используемый для подписания и публикации, здесь аккаунт `update` используется для авторизации транзакции

После подтверждения транзакции вы можете вызвать функцию hello() с помощью iwallet и проверить содержимое «message» базы данных, чтобы увидеть изменения содержимого.
