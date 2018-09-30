---
id: Lucky-Bet-Js
title: Lucky Bet Javascript Code Details
sidebar_label: Lucky Bet Javascript Code Details
---

## Obtaining On-chain Information

With small risk of being rigged, using on-chain information to generate random numbers is the easiest way. Lucky Bet generates the random number this way:

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

Using `BlockChain.blockInfo()`, we can get detailed information on the blockchain, and use it as a source of pseudo-random numbers.

## Status Data: Management and Usage

Smart contracts can store data in either of the two ways:

```javascript
const maxUserNumber = 100;
```

Constants defined outside of the class are accessible by the current document and does not incur extra storage costs.

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

By accessing the storage system interfaces, we can read/write key-value paired data. Note that values only support String type. To keep data type information, we need to process them in the contract. This will incur read/write costs.