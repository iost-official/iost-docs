---
id: version-2.0.2-Blockchain-class
title: Класс Blockchain
sidebar_label: Класс Blockchain
original_id: Blockchain-class
---

Класс Blockchain это основной класс, который взаимодействует с блокчейном IOST и смарт-контрактами IOST для получения информации от них.

## Метод constructor
Метод constructor это специальный метод для создания и инициализации класса Blockchain.
<b>НЕТ</b> необходимости для инициализации пользователем, пользователь будет использовать класс Blockchain с помощью rpc.blockchain。

## Метод getChainInfo
получение информации о цепочке из блокчейна

### Возвращает
Промис возвращает объект chainInfo.
Название             |Тип       |Описание
----                |--         |--
net_name 			|String          | название сети, такое как mainnet или testnet
protocol_version 	|String 		 | версия протокола iost
head_block	 		|Number			 | высота головного блока
head_block_hash		|String			 | хеш головного блока
lib_block	 		|Number			 | номер последнего необратимого блока
lib_block_hash	 	|String			 | хеш последнего необратимого блока
witness_list	 	|Array			 | текущий список производелей блоков

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getChainInfo().then(console.log);

/*{
	"net_name": "debugnet",
	"protocol_version": "1.0",
	"head_block": "142",
	"head_block_hash": "ryj9qWvbypFd1VJeUiyxmyNiav9E8ZHH1t47zSbMmGk",
	"lib_block": "142",
	"lib_block_hash": "ryj9qWvbypFd1VJeUiyxmyNiav9E8ZHH1t47zSbMmGk",
	"witness_list": [
		"IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
	]
}*/
```

## Метод getBlockByHash
получение информации о блоке из блокчейна по его хешу

### Параметры
Название             |Тип       |Описание
----                |--         |--
hash 		|String          | хеш блока
complete 	|Boolean 		 | complete означает будут ли включены все транзакции и квитанции транзакций

### Возвращает
Промис возвращает объект блока.
Название             |Тип       |Описание
----                |--         |--
status 		|String          | статус транзакции
block 	|Object 		 | [Объект Блока](#block-object)

#### Block Object (Объект блока)
Название             |Тип       |Описание
----                |--         |--
hash 					|String          | хеш блока
version 				|Number 		 | версия блока
parent_hash 			|String          | родительский хеш блока
tx_merkle_hash 			|String          | единый хеш - корень дерева Меркла транзакций
tx_receipt_merkle_hash  |String          | единый хеш - корень дерева Меркла квитанций транзакций
number 					|String          | номер блока
witness 				|String          | производитель блока
time 					|String          | отметка времени блока
gas_usage 				|String          | количество газа использованного в блоке
tx_count 				|String          | число транзакции
transactions			|Array			 | массив [Объектов Транзакций](Transaction-class#transaction-object)
info 					|Object          | [Информация об Объекте](#info-object)

#### AmountLimit Object (Объект лимит суммы)
Название             |Тип       |Описание
----                |--         |--
token 			|String          | название токена
value 			|Number 		 | ограничение количества токенов

#### Info Object (Объект инфо)
Название             |Тип       |Описание
----                |--         |--
mode 					|Number          | режим упаковки
thread 				|Number 		 | номер потока выполнения транзакции
batch_index 			|Array          | индекс каждого пакетного выполнения транзакции

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getBlockByNum(1, true).then(console.log);

/*{
	"status": "IRREVERSIBLE",
	"block": {
		"hash": "HSSXypC9GwRowiG6e1FG9qGbvVZFjT9mR7RY8mGZzoLJ",
		"version": "0",
		"parent_hash": "CyoyPDfRM8a4HWwSbDBRv3UbFoUUQxWu4T5JuaJsmLvs",
		"tx_merkle_hash": "7thvoWaULNdrXVYR6wRTfWYSpJDFj6vKX1jitCsh7KRj",
		"tx_receipt_merkle_hash": "GvjAbjP9c626UPSMFjPMERyVDxqwvdu5uziqyiZdmoox",
		"number": "1",
		"witness": "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C",
		"time": "1545384717001253745",
		"gas_usage": 0,
		"tx_count": "1",
		"info": null,
		"transactions": [
			{
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
				"tx_receipt": {
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
				}
			}
		]
	}
}*/
```

## Метод getBlockByNum
получение информации о блоке из блокчейна по номеру блока

### Параметры
Название             |Тип       |Описание
----                |--         |--
num 		|Number          | номер блока
complete 	|Boolean 		 | complete означает будут ли включены все транзакции и квитанции транзакций

### Возвращает
Промис возвращает объект блока. Проверьте [getBlockByHash](#getBlockByHash)

## Метод getBalance
получение баланса аккаунта

### Параметры
Название             |Тип       |Описание
----                |--         |--
name 		|String          |имя аккаунта
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект баланса.

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getBalance('myaccount', true).then(console.log);

/*{
	balance: 12000,
	frozen_balances: null
}*/
```

## Метод getToken721Balance
получение баланса token721(токенов стандарта 721) аккаунта

### Параметры
Название             |Тип       |Описание
----                |--         |--
name 		|String          | название аккаунта
tokenSymbol |String 		 | символ token721
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект баланса.

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Balance('myaccount', 'my721Token', true).then(console.log);

/*{
	balance: 12000,
	tokenIDs: null
}*/
```

## Метод getToken721Metadata
получение метаданных token721 (токена стандарта 721)

### Параметры
Название             |Тип       |Описание
----                |--         |--
token 		|String          | название токена
token_id |String 		 | id токена
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект метаданных.
Название             |Тип       |Описание
----                |--         |--
metadata 		|String          | метаданные

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Metadata('symbol', 'id', true).then(console.log);

/*{
	metadata: ''
}*/
```

## Метод getToken721Owner
получение владельца token721 (токена стандарта 721)

### Параметры
Название             |Тип       |Описание
----                |--         |--
token 		|String          | название токена
token_id |String 		 | id токена
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект владелец.
Название             |Тип       |Описание
----                |--         |--
owner 		|String          | метаданные

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getToken721Owner('symbol', 'id', true).then(console.log);

/*{
	owner: 'theowner'
}*/
```

## Метод getContract
получение контракта из блокчейна

### Параметры
Название             |Тип       |Описание
----                |--         |--
id 		|String          | id контракта
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект контракта.
Название             |Тип       |Описание
----                |--         |--
id 			|String          | id контракта
code 		|String 		 | код контракта
language 	|String 		 | язык программирования контракта
version 	|String 		 | версия контракта
abis | Array | массив [Объектов ABI](#abi-object)

#### ABI Object (Объект ABI)
Название             |Тип       |Описание
----                |--         |--
name 			|String          | id контракта
args 		|Array 		 | аргументы abi
amount_limit 	|Array 		 | массив [Объектов AmountLimit](#amountlimit-object)

## Метод getContractStorage
получение хранилища контракта из блокчейна

### Параметры
Название             |Тип       |Описание
----                |--         |--
id 		|String          | id контракта
key |String 		 | ключ в StateDB
field 	|String 		 | получить значение из StateDB, поле необходимо, если StateDB[key] это map (соответствие).(в этом случае, мы получаем StateDB[key][field])
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект результата контракта.
Название             |Тип       |Описание
----                |--         |--
data 		|String          | данные

## Метод getAccountInfo
получить информацию об аккаунте из блокчейна

### Параметры
Название             |Тип       |Описание
----                |--         |--
name 		|String          | имя аккаунта
by_longest_chain 	|Boolean 		 | получить аккаунт по головному блоку самой длинной цепи или последнему необратимому блоку

### Возвращает
Промис возвращает объект аккаунта.
Название             |Тип       |Описание
----                |--         |--
name 		|String          | имя аккаунта
balance 		|Number          | баланс аккаунта
gas_info 		|Object          | [Объект GasInfo](#gasinfo-object)
ram_info 		|Object          | [Объект RAMInfo](#raminfo-object)
permissions 		|Map          | map<String, [Объект Permission](#permission-object)>
groups | Map | map<String, [Объект Group](#group-object)>
frozen_balances | Array | массив [Объект FrozenBalance](#frozenbalance-object)

#### GasInfo Object (Объект GasInfo)
Название             |Тип       |Описание
----                |--         |--
current_total 		|Number          | текущее общее количество газа
transferable_gas 		|Number          | текущий переносимый газ
pledge_gas 		|Number          | текущий залоговый газ
increase_speed 		|Number          | скорость увеличения газа
limit 		|Number          | имя аккаунта
pledged_info | Array | массив [Объект PledgeInfo](#pledgeinfo-object)

#### PledgeInfo Object (Объект PledgeInfo)
Название             |Тип       |Описание
----                |--         |--
pledger 		|String          | аккаунт, который предоставляет залог
amount 		|Number          | залоговая сумма

#### RAMInfo Object (Объект RAMInfo)
Название             |Тип       |Описание
----                |--         |--
available 		|Number          | доступные байты оперативной памяти

#### Permission Object (Объект разрешений)
Название             |Тип       |Описание
----                |--         |--
name 		|String          | имя разрешения
groups 		|Array          | массив групп разрешений
items 		|Array          | массив [Item Object](#item-object)
threshold 		|Number          | пороговое значение разрешения

#### Item Object (Объект элемента)
Название             |Тип       |Описание
----                |--         |--
id 		|String          | имя разрешения или id пары ключей
is_key_pair 		|Boolen          | будь то пара ключей
weight 		|Number          | вес разрешения
permission 		|String          | разрешение

#### Group Object (Объект группы разрешений)
Название             |Тип       |Описание
----                |--         |--
name 		|String          | название группы
items 		|Array          | массив [Item Object](#item-object)

#### FrozenBalance Object (Объект замороженный баланс)
Название             |Тип       |Описание
----                |--         |--
amount 		|Number          | сумма баланса
time 		|Number          | время заморозки

### Пример
```javascript
const rpc = new IOST.RPC(new IOST.HTTPProvider('http://127.0.0.1:30001'));
rpc.blockchain.getAccountInfo("myaccount").then(console.log);

/*{
	"name": "myaccount",
	"balance": 993939700,
	"gas_info": {
		"current_total": 3000000,
		"transferable_gas": 0,
		"pledge_gas": 3000000,
		"increase_speed": 11,
		"limit": 3000000,
		"pledged_info": [
			{
				"pledger": "myaccount",
				"amount": 100
			}
		]
	},
	"ram_info": {
		"available": "100000"
	},
	"permissions": {
		"active": {
			"name": "active",
			"groups": [],
			"items": [
				{
					"id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
					"is_key_pair": true,
					"weight": "1",
					"permission": ""
				}
			],
			"threshold": "1"
		},
		"owner": {
			"name": "owner",
			"groups": [],
			"items": [
				{
					"id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
					"is_key_pair": true,
					"weight": "1",
					"permission": ""
				}
			],
			"threshold": "1"
		}
	},
	"groups": {},
	"frozen_balances": []
}*/
```
