---
id: Lucky-Bet-Js
title: Lucky Bet 智能合约代码详解
sidebar_label: Lucky Bet 智能合约代码详解
---

## 获取链上信息

虽然有被人操纵的可能性，但获取链上信息作为随机数源依然是目前最方便，并且有足够有效性的做法。luckybet
智能合约采取了链上的信息来生成中奖号码：

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

通过`BlockChain.blockInfo()`，我们可以获得区块链的详细信息，也可以将其作为一个不准确的随机数源来使用

## 状态数据的管理和存储

智能合约可以用两种方法存储数据：

```javascript
const maxUserNumber = 100;
```

定义在class外的常数可以被当前文件访问到，并且不需要支付额外的存储开销。

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

调用storage系列接口，可以存取kv数据，注意value目前只能使用string来存储，为了保持数据类型的信息，需要在智能合约内进行处理。

同时，也需要支付存取的费用。