---
id: version-2.0.2-Transaction-class
title: Класс Transaction
sidebar_label: Класс Transaction
original_id: Transaction-class
---

Класс Transaction это основной класс, который взаимодействует с блокчейном IOST и смарт-контрактами IOST  для отправки и получения от них транзакций.

## Метод constructor
Метод constructor это специальный метод для создания и инициализации класса Transaction.
<b>НЕТ</b> необходимости для инициализации пользователем, пользователь будет использовать класс Transaction с помощью rpc.transaction.

## Метод getTxByHash
получение tx (транзакции) из блокчейна по хешу

### Параметры
Название             |Тип       |Описание
----                |--         |--
hash 		|String          | хеш транзакции кодирован функцией base58

### Возвращает
Промис возвращает объект транзакции.
Название             |Тип       |Описание
----                |--         |--
status 		|String          | статус транзакции
transaction |Object 		 | [Объект Transaction](Blockchain-class#transaction-object)

#### Transaction Object (Объект транзакции)
Название             |Тип       |Описание
----                |--         |--
hash 			|String          | хеш транзакции
time 			|Number 		 | метка времени транзакции
expiration 		|Number          | метка времени истечения транзакции
gas_ratio 		|Number          | коэффицент газа
gas_limit  		|Number          | лимит газа
delay 			|Number          | задержка в наносекундах
actions 		|Array           | массив [Action Object](#action-object)
signers 		|Array           | массив строк подписантов
publisher 		|String          | отправитель транзакции
referred_tx 	|String          | хэш указанной транзакции
amount_limit	|Array			 | массив [AmountLimit Object](#amountlimit-object)
tx_receipt 		|Object          | [TxReceipt Object](#txreceipt-object)

#### Action Object (Объект Action)
Название             |Тип       |Описание
----                |--         |--
contract 			|String          | название контракта
action_name 			|String 		 | название функции контракта
data 		|String          | данные

#### AmountLimit Object (Объект AmountLimit)
Название             |Тип       |Описание
----                |--         |--
token 			|String          | название токена
value 			|Number 		 | лимит суммы

#### TxReceipt Object (Объект квитанция транзакции)
Название             |Тип       |Описание
----                |--         |--
tx_hash 			|String          | хеш транзакции
gas_usage 			|Number 		 | использование газа
ram_usage 		|Map          | использование ram
status_code 		|String          | статус кода
message  		|String          | сообщение
returns 			|Array          | транзакция возвращает
receipts 		|Array           | массив [Receipt Object](#receipt-object)

#### Receipt Object (Объект квитанция)
Название             |Тип       |Описание
----                |--         |--
func_name 			|String          | название функции
content 			|String 		 | содержание

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.transaction.getTxByHash("5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa").then(console.log);

/*{
	"status": "IRREVERSIBLE",
	"transaction": {
		"hash": "5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa",
		"time": "0",
		"expiration": "0",
		"gas_ratio": 1,
		"gas_limit": 1000000,
		"delay": "0",
		"actions": [
			{
				"contract": "base.iost",
				"action_name": "Exec",
				"data": "[{\"parent\":[\"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A\", \"0\"]}]"
			}
		],
		"signers": [],
		"publisher": "_Block_Base",
		"referred_tx": "",
		"amount_limit": [],
		"tx_receipt": null
	}
}*/
```

## Метод getTxReceiptByTxHash
получение квитанции транзакции по хешу транзакции

### Параметры
Название             |Тип       |Описание
----                |--         |--
hash 		|String          | хеш транзакции кодирован функцией base58  

### Возвращает
Промис возвращает [Объект TxReceipt](#txreceipt-object)

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.transaction.getTxByHash("5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa").then(console.log);

/*{
	"tx_hash": "5YdA8qPq5N6W47rZV4u31FdbQzeMt2QX9KGj4uPyERZa",
	"gas_usage": 0,
	"ram_usage": {
		"_Block_Base": "0",
		"base.iost": "284",
		"bonus.iost": "107"
	},
	"status_code": "SUCCESS",
	"message": "",
	"returns": [
		"[\"\"]"
	],
	"receipts": [
		{
			"func_name": "token.iost/issue",
			"content": "[\"contribute\",\"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A\",\"900\"]"
		}
	]
}*/
```

## sendTx
отправить транзакцию в блокчейн IOST
