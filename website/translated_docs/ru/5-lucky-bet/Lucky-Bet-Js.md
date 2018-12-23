---
id: Lucky-Bet-Js
title: Удачная ставка подробности кода Javascript
sidebar_label: Удачная ставка подробности кода Javascript
---

## Получение информации о блокчейне

Самый простой способ генерации случайных чисел это использовать информацию о блоках (существует небольшой риск фальсификации этой информации плохими участниками). Удачная ставка генерирует случайное число таким образом:

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

Используя `BlockChain.blockInfo()`, мы можем получить подробную информацию о блокчейне и использовать ее в качестве источника псевдослучайных чисел.

## Данные состояния (Status Data): Управление и использование

Смарт-контракты могут хранить данные одним из двух способов:

```javascript
const maxUserNumber = 100;
```

Константы, определенные за пределами класса, доступны в текущем документе и не требуют дополнительных затрат на хранение.

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

Получая доступ к интерфейсам системы хранения, мы можем читать/записывать парные данные как ключ-значение(key-value). Обратите внимание, что значения поддерживают только тип String. Чтобы сохранить информацию о типе данных, нам необходимо обработать их в контракте. Это приведет к расходам на чтение и запись.
