---
id: version-1.0.6-Lucky-Bet-Js
title: Lucky Bet Javascriptコードの詳細
sidebar_label: Lucky Bet Javascriptコードの詳細
original_id: Lucky-Bet-Js
---

## チェーン情報の取得

談合のリスクがありますが、チェーン上の情報で乱数を生成するのが最も容易です。Lucky Betは、次のようにして乱数を生成しています。

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

`BlockChain.blockInfo()`を使って、詳細の情報を取得でき、擬似乱数の種として使うことができます。

## ステータスデータ: 管理と使用法

スマートコントラクトは、２つの方法でデータを格納できます。

```javascript
const maxUserNumber = 100;
```

クラス外に定義された定数は、現在のドキュメントからアクセス可能で、追加のストレージコストは発生しません。

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

ストレージシステムにアクセスすることで、キーバリューペアを読み書きできます。値だけにString型が使えます。データ型を保持するためには、コントラクト内で処理する必要があります。これには読み書きのコストが発生します。
