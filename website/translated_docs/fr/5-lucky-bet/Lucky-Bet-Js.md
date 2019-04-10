---
id: Lucky-Bet-Js
title: Détails du code JavaScript de Lucky Bet
sidebar_label: Détails du code JavaScript de Lucky Bet
---

## Obtenir les infos de la blockchain

Malgré un petit risque de manipulation, l'utilisation d'informations on-chain pour générer des nombres aléatoires est simple. Lucky Bet génère un numéro aléatoire de la façon suivante :

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

Avec `BlockChain.blockInfo()`, nous pouvons obtenir des informations détaillées sur la blockchain et l'utiliser comme source aléatoire.

## Donnée de statut : Gestion et Utilisation

Les smart contracts peuvent stocker des données de deux façons :

```javascript
const maxUserNumber = 100;
```

Les constantes définies en dehors de la classe sont accessible par le document actuel et n'impliquent pas de coûts de stockage supplémentaires.

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

En accédant l'interface de stockage système, il est possible de lire/écrire des données adossées à une clé. Les valeurs ne supportent que le type string. Afin de conserver des informations de type données, nous avons besoin de les traiter dans le contrat. Cela implique des coûts de lecture/écriture.
