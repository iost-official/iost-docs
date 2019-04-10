---
id: Smart-contract
title: Smart Contract
sidebar_label: Smart Contract
---

Les smart contracts reçoivent et exécutent des transactions à l'intérieur du bloc, afin de maintenir les variables de la chaîne interne du smart contract et de produire des preuves irréversibles. IOST implémente des interfaces ABI générales, un support multilingue plug-and-play et peut générer le résultat du consensus. Cela a considérablement amélioré la facilité d'utilisation de la blockchain.

## Interface ABI

Les smart contracts IOST interagissent avec le réseau via des ABIs.

Les ABIs sont des information sous format JSON incluant le nom, le type de paramètre etc. Les types de base supportés sont `string`, `number`, et `bool`.

Des structures plus complexes peuvent être converties en JSON. Lors d'appel de fonction dans un smart contract, les types de paramètres ABI doivent être strictement respectés. Autrement l'exécution sera suspendue et les frais de transaction seront prélevés.

```json
// example luckybet.js.abi
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "bet",
            "args": [
                "string",
                "number",
                "number",
                "number"
            ]
        }
    ]
}
```

Chaque transaction comprend plusieurs actions transactionnelles et chaque action est un appel à un ABI. Toutes les transactions génèrent une série stricte sur la chaîne, évitant ainsi les attaques à double dépense.

```golang
type Action struct {
	Contract   string  
	ActionName string
	Data       string  // A JSON Array of args
}
```

Dans un smart contract il est possible d'utiliser `BlockChain.call()` pour appeler une interface ABI, et obtenir la valeur en retour. Le système enregistrera l'appel et interdira la double dépense.

## Support Multilingue

IOST a conçu des smart contracts multilingues. Pour le moment nous ouvrons JavaScript avec le moteur v8, et il y a des modules VM golan natifs pour réaliser des transactions hautes performances.

Le moteur de smart contract d'IOST est en trois parties : monitor, VM, hôte. Le monitor est l'entité de contrôle globale que les ABI passerelles dirigent vers la bonne VM.La VM est une implémentation sur machine virtuelle des smart contracts. L'höte package l'environnement d'exécution et s'assure que le contrat s'exécute dans le bon contexte.

## Système d'autorisations du Smart Contract

Les transactions supportent les signatures multiples. Au sein d'un contrat, on peut utiliser `RequireAuth()` pour vérifier si le contexte actuel porte la signature d'un ID. Les appels entre Smart Contracts reposeront sur les autorisations par signature. Par exemple si `A.a` appelle `B.b`, l'autorisation pour `B.b` d'un utilisateur est implicite lors `A.a` est appelée.

Les smart contracts peuvent vérifier les appels, et répondre à des questions telles que "Qui a appelé cet ABI ?" Ceci permet à certaines opérations d'exister.

Les smart contracts ont des autorisations spécifiques telles que la mise à jour ou la suppression. Celles-ci peuvent être implémentées avec `can_update()` et `can_destroy()`.

## Résultat d'un appel

Après on exécution, le smart contract vé générer un `TxReceipt` dans le block et chercher le consensus. Il est possible d'utiliser RPC pour suivre les TxReceipts de transactions on-chain.

```sh
$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/G62UQbq9u8MP8cNLD9HUpMFtstTvRUAJ4avzKiAJc86f \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: 2442fe9c-0c80-4459-a9e6-0001bbde3dbb'l
{
    "txReceiptRaw": {
        "txHash": "4CjfeOvtjmhdZep9WG5pPoEoLPu90avQkbGKefTKNaw=",
        "gasUsage": "1129",
        "status": {},
        "succActionNum": 1
    },
    "hash": "eU9xHGM15gfDInAG7Y8q3RB9mMm1Pekmj4RUUHWFkqU="
}

```
