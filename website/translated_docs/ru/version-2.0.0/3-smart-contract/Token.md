---
id: version-2.0.0-Token
title: Создать токен
sidebar_label: Создать токен
original_id: Token
---
## Token20

Token20 это наш стандарт для реализации токена на блокчейне IOST. Он включает в себя несколько практических функций помимо перевода токенов, такие как замораживание токенов, уничтожение токенов и может быть тщательно настроен.

`iost` также реализован в соответствии со стандартом Token20 на основе встроенного системного контракта `token.iost`.
Интерфейсы `token.iost` описываются следующим образом:

```js
// create tokenSymbol
create(tokenSymbol, issuer, totalSupply, configJson);	// string, string, number, json
issue(tokenSymbol, to, amountStr);						// string, string, string
transfer(tokenSymbol, from, to, amountStr, memo);		// string, string, string, string, string
transferFreeze(tokenSymbol, from, to, amountStr, unfreezeTime, memo);		// string, string, string, string, number, string
destroy(tokenSymbol, from, amountStr);					// string, string, string
// query interfaces
balanceOf(tokenSymbol, from);							// string, string
supply(tokenSymbol);									// string
totalSupply(tokenSymbol);								// string
```
### create(tokenSymbol, issuer, totalSupply, configJson)
`Authority required: issuer`

TokenSymbol это уникальный идентификатор конкретного токена, то есть вы не можете создать токен в контракте `token.iost` с ранее использованным tokenSymbol.
Это строка длинной от 2 до 16, состоящая только из символов `a-z`, `0-9` и `_`.

Issuer является эмитентом токена, только эмитент имеет разрешение на выдачу токенов на произвольный аккаунт.
Обычно эмитент токена это аккаунт, но также может быть и контракт.
Когда issuer(эмитентом) является ID контракта, это означает, что только у этого контракта есть разрешение на вызов метода `issue` для выдачи(выпуска) токенов другим.
Допустим, эмитентом токена `mytoken` является контракт `Contractabc`, тогда `Contractabc` может вызвать `issue` для выпуска в обращение `mytoken`,
`Contractabc` также может вызвать функцию в контракте `Contractdef`, и таким образом `Contractdef` будет иметь разрешение на выпуск в обращение `mytoken`.
То есть, разрешение контракта может быть передано в вызываемый контракт, вам нужно использовать системную функцию `blockchain.callWithAuthority` вместо `blockchain.call` при вызове другого контракта для передачи разрешения.

TotalSupply это число типа int64, эмитент не может выпустить в обращение больше токенов, чем  totalSupply.

ConfigJson это формат json, содержащий конфигурации для токена. Вот все поддерживаемые свойства конфигурации:
```console
{
	"decimal": number between 0~19,
	"canTransfer": true/false, the token can not be transferd if canTransfer is false,
	"fullName": string describes the full name of the token
}
```

### issue(tokenSymbol, acc, amountStr)
`Authority required: issuer of tokenSymbol`

Выдача tokenSymbol для аккаунта `acc`, amountStr это строка содержащая сумму выпуска, сумма должна быть положительным десятичным числом с фиксированной запятой, такой как "100", "100.999"

### transfer(tokenSymbol, accFrom, accTo, amountStr, memo)
`Authority required: accFrom`

Перевод токенов tokenSymbol с аккаунта `accFrom` на аккаунт `accTo` с amountStr и memo,
сумма должна быть положительным десятичным числом с фиксированной запятой, а memo - это дополнительное строковое сообщение этой операции перевода токенов длиной не более 512 байт.

### transferFreeze(tokenSymbol, accFrom, accTo, amountStr, unfreezeTime, memo)
`Authority required: accFrom`

Перевод токенов tokenSymbol с аккаунта `accFrom` на аккаунт `accTo` с amountStr и memo, и заморозка этой части токенов до unfreezeTime (времени разморозки).
unfreezeTime это наносекунды времени unix по истечению которых, токены будут разморожены.

### destroy(tokenSymbol, accFrom, amountStr)
`Authority required: accFrom`

Уничтожение amountStr количества токенов в аккаунте `accFrom`. После уничтожения, запас токенов на этом аккаунте уменьшиться, что означает, вы можете выпустить больше токенов при наличии totalSupply путем уничтожения некоторого количества токенов.

### balanceOf(tokenSymbol, acc)
`Authority required: null`

Запрос баланса аккаунта (количества определенного токена - tokenSymbol, которым владеет данный аккаунт - acc).

### supply(tokenSymbol)
`Authority required: null`

Запрос запаса определенного токена.

### totalSupply(tokenSymbol)
`Authority required: null`

Запрос общего объема поставки определенного токена.


## Пошаговый пример
Создать `Token20` в блокчейне iost можно необыкновенно просто, вам достаточно только вызвать контракт `token.iost`, без реализации интерфейсов Token20 и развертывания смарт-контракта самостоятельно.

Ниже приведен пошаговый пример того, как создать токен с помощью `bank` аккаунта и переводить токены между аккаунтами, вначале вам нужно создать аккаунты `bank`, `user0`, `user1`.

```console
iwallet call token.iost create '["mytoken", "bank", 21000000000, {"decimal": 8, "fullName": "token for test"}]' --account bank
iwallet call token.iost issue  '["mytoken", "bank", "1000"]' --account bank
iwallet call token.iost issue  '["mytoken", "user0", "100.00000001"]' --account bank
iwallet call token.iost transfer 		'["mytoken", "user0", "user1", "10", "user0 pay coffee"]' --account user0
iwallet call token.iost transferFreeze 	'["mytoken", "user1", "user0", "0.1", 1544880864601648640, "voucher"]' --account user1
iwallet call token.iost destroy '["mytoken", "bank", "1000"]' --account bank
```
