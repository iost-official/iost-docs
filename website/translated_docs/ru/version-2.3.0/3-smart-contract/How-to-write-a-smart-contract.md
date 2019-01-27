---
id: version-2.3.0-How-to-write-a-smart-contract
title: Как написать смарт-контракт
sidebar_label: Как написать смарт-контракт
original_id: How-to-write-a-smart-contract
---

## Основная информация

### Поддержка языков

В настоящее время смарт-контракты IOST поддерживают JavaScript.

### Среда выполнения

Внутри IOST работает [Chrome V8](https://developers.google.com/v8) движок для выполнения контрактов.

## Руководство по программированию смарт-контрактов

### Внедрение смарт-контрактов

В IOST смарт-контракты будут закодированы в JavaScript `class`. При его использовании вам нужно `export` (экспортировать) класс.

#### Структура смарт-контракта

Класс смарт-контракта должен включать в себя функцию `init`.

- `init` запускается при развертывании контракта. Обычно она содержит код для инициализации свойств контракта.

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

Разработчики могут использовать этот класс для синхронизации данных во время множества вызовов контракта. Ниже список API этого объекта, вы также можете просмотреть детали [в коде](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js).

#### put(key, value, payer)

Помещение пары ключ-значение в простое хранилище.
* Параметры:
	* key: string
	* value: string
	* payer: string
* Возвращает: none

#### get(key)

Получение значения из простого хранилища с помощью ключа.
* Параметры:
	* key: string
* Возвращает: если существует строку со значением; если не существует `null`

#### has(key)

Проверка существует ли ключ в хранилище.
* Параметры:
	* key: string
* Возвращает: булевые (`true` если существует, `false` если не существует)

#### del(key)

Удаление пары ключ-значение из простого хранилища с помощью ключа.
* Параметры:
	* key: string
* Возвращает: none

#### mapPut(key, field, value, payer)

Помещение пары (key, field, value) в отображение. используйте key + field, чтобы найти value.
* Параметры:
	* key: string
	* field: string
	* value: string
	* payer: string
* Возвращает: none

#### mapGet(key, field)

Получение пары (key, field) в отображении, используйте key + field, чтобы найти value
* Параметры:
	* key: string
	* field: string
* Возвращает: строку со значением, если существует; `null` если не существует

#### mapHas(key, field)

Проверка существования пары (key, field) в отображении, используйте key + field для проверки.
* Параметры:
	* key: string
	* field: string
* Возвращает: булевые (`true` если существует, `false` если не существует)

#### mapKeys(key)

Получение полей в ключе отображения. Эта функция не гарантирует возврат корректного результата, если число полей больше 256, будет возвращено максимум 256 результатов.
* Параметры:
	* key: string
* Возвращает: array\[string\] (массив полей)

#### mapLen(key)

Подсчет числа полей в ключе отображения. Эта функция не гарантирует возврат корректного результата, если число полей больше 256, будет возвращено 256.
* Параметры:
	* key: string
* Возвращает: int (число полей)

#### mapDel(key, field)

Удаление пары (key, field, value) отображения, используйте key + field, чтобы удалить value.
* Параметры:
	* key: string
	* field: string
* Возвращает: none

#### globalHas(contract, key)

Проверка существует ли ключ в глобальном хранилище смарт-контракта.
* Параметры:
	* contract: string
	* key: string
* Возвращает: булевые (`true` если существует, `false` если не существует)

#### globalGet(contract, key)

Получение значения из глобального хранилища с помощью ключа.
* Параметры:
	* contract: string
	* key: string
* Возвращает: строку со значением, если существует; `null` если не существует

#### globalMapHas(contract, key, field)

Проверка существует ли пара (key, field) в отображении в глобальном хранилище, используйте key + field для проверки.
* Параметры:
	* contract: string
	* key: string
	* field: string
* Возвращает: булевые (`true` если существует, `false` если не существует)

#### globalMapGet(contract, key, field)

Получение пары (key, field) в отображении из глобального хранилища, используйте key + field для получения значения.
* Параметры:
	* contract: string
	* key: string
	* field: string
* Возвращает: строку со значением, если существует; `null` если значение не существует

#### globalMapLen(contract, key)

Подсчет числа полей в ключе отображение из глобального хранилища. Эта функция не гарантирует возврат корректного результата, если число полей больше 256, она вернет 256.
* Параметры:
	* contract: string
	* key: string
* Возвращает: int (число полей)

#### globalMapKeys(contract, key)

Получение полей в ключе отображения из глобального хранилища. Эта функция не гарантирует возврат корректного результата, если число полей больше 256, будет возвращено максимум 256 результатов.
* Параметры:
	* contract: string
	* key: string
* Возвращает: array\[string\] (массив полей)

### blockchain object (Объект blockchain)

Объект blockchain предоставляет все методы для системных вызовов и помогает пользователю вызывать официальные API, включая, помимо прочего, перевод средств, вызов других контрактов и поиск блока или транзакции.

Ниже приведен API объекта blockchain, вы также можете найти подробные интерфейсы [в коде](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js).

#### transfer(from, to, amount, memo)

Перевод IOSToken.
* Параметры:
	* from: string
	* to: string
	* amount: string/number
	* memo: string
* Возвращает: none

#### withdraw(to, amount, memo)

Вывод IOSToken.
* Параметры:
	* to: string
	* amount: string/number
	* memo: string
* Возвращает: none

#### deposit(from, amount, memo)

Депозит IOSToken.
* Параметры:
	* from: string
	* amount: string/number
	* memo: string
* Возвращает: none

#### blockInfo()

Получение информации о блоке.
* Параметры: none
* Возвращает: JSONString с информацией о блоке

#### txInfo()

Получение информации о транзакции.
* Параметры: none
* Возвращает: JSONString с информацией о транзакции

#### contextInfo()

Получение контекстной информации.
* Параметры: none
* Возвращает: JSONString с контекстной информацией

#### contractName()

Получение названия контракта.
* Параметры: none
* Возвращает: строка с названием контракта

#### publisher()

Получение аккаунта издателя.
* Параметры: none
* Возвращает: строка с издателем

#### call(contract, api, args)

Вызов api контракта используя args.
* Параметры:
	* contract: string
	* api: string
	* args: JSONString
* Возвращает: строку

#### callWithAuth(contract, api, args)

Вызов api контракта используя args с аутентификацией.
* Параметры:
	* contract: string
	* api: string
	* args: JSONString
* Возвращает: строка

#### requireAuth(pubKey, permission)

Проверка разрешений аккаунта.
* Параметры:
	* pubKey: string
	* permission: string
* Возвращает: булевые (`true` если у аккаунта есть разрешения, `false` если их нет)

#### receipt(data)

Генерация квитанции.
* Параметры:
	* data: string
* Возвращает: none

#### event(content)

Публикация события.
* Параметры:
	* content: string
* Возвращает: none


### tx object и block object (Объекты tx и block)
Объект tx содержит информацию о текущей транзакции. Пример:
```js
{
	time: 1541541540000000000,
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000,
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn":2},
	publisher: "user0"
}
```  

Объект block содержит информацию о текущем блоке. Пример:
```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn",
	time: 1541541540000000000
}
```

Вы также можете найти подробности [здесь](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29).

### encrypt object (Объект шифрования)
Вы можете напрямую использовать Функцию ```sha3(String)``` объекта ```IOSTCrypto```для получения Хеша sha3。

##### Пример

```js
IOSTCrypto.sha3(msg)
```
