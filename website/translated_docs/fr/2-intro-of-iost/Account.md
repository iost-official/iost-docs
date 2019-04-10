---
id: Account
title: Compte
sidebar_label: Compte
---


# Système d'autorisations de comptes

## Vue d'ensemble

Le système d'autorisation des comptes IOST repose sur le mécanisme des paires de clés publique-privée. En configurant la clé propriétaire et la clé active, les utilisateurs peuvent facilement gérer plusieurs systèmes de comptes et, en même temps, configurer de nouvelles autorisations à volonté. Ceci permet une gestion entièrement personnalisée.

## Notions de base

Un compte IOST est créé avec un ID et des autorisations. Un compte peut avoir des autorisations multiples, et a au moins des autorisations `owner` et `active`. Chaque autorisation contient plusieurs objets, l'un étant l'ID publique, ou une paire d'autorisations d'un autre compte.

La clé publique est un string avec le préfixe `IOST` + une clé publique encodée Base58 + digit de validation crc32.

Chaque objet à un certain poids ; de même manière, chaque autorisation a un seuil. Quand une transaction a un poids supérieur au seuil, elle présume cette autorisation.

La méthode de vérification de propriété est réalisée en contrôlant si la signature de la transaction contient la signature de la clé publique d'un certain objet (quand l'objet est une clé publique), ou en vérifiant de façon récursive si la transaction contient la paire d'autorisation du compte (quand l'objet est une paire d'autorisation de compte).

Généralement les smart contracts présenteront leur ID de compte et leur ID d'autorisation lors de la demande d'autorisations. Le système vérifiera les signatures de la transaction, calculera le poids de l'objet, et si la signature répond aux exigences minimales, validera la transaction. Dans le cas contraire la validation échoue.

L'autorisation `active` peut octroyer toutes les autorisations hormis `owner`. L'autorisation `owner` donne le même set d'autorisations et autorise la modification d'objets sous des autorisations `owner` et `active`. L'autorisation `active` est requise lors de la transmission d'une transaction.

Les autorisations peuvent fonctionner avec des groupes. Vous pouvez ajouter des autorisations à un groupe, et ajouter des éléments à ce groupe. De cette façon, les objets bénéficieront de toutes les autorisations du groupe.

## Utilisation de compte System

Avec un smart contract il faut appeler une simple API.

```
BlockChain.requireAuth(id, permission_string)
```

Ceci va retourner une valeur booléenne qui permet de décider si l'opération doit continuer ou pas.

Généralement lors de l'utilisation de Ram et de Tokens, il faut d'abord contrôler l'autorisation `active` de l'utilisateur, sinon le smart contract peut se suspendre de façon inattendue. Choisissez un string unique `permission_string` afin de minimiser l'autorisation.

Normalement l'autorisation  `owner` ne doit pas être requise, les utilisateurs ne devant pas avoir a donner leurs clés de propriété sauf en cas de modification des autorisations `owner` et `active`.

Il n'est pas nécessaire de demander un expéditeur, ceux-ci ayant toujours l'autorisation `active`.

Au niveau utilisateur nous ne verrons les ajouts d'autorisations qu'en donnant la signature. Prenons deux comptes (avec des poids et des seuils de 1 pour les clés) :

```
User0
├── Groups
│   └── grp0: key3
└── Permissions
    ├── owner: key0
    ├── active: key1
    ├── perm0: key2, grp0
    ├── perm1: User1@active, grp0
    ├── perm2(threshold = 2): key4, key5, grp0
    ├── perm3: key8
    └── perm4(threshold = 2): User@perm3, key9

User1
└── Permissions
    ├── owner: key6
    └── active: key7
```

RequireAuth form

Parameters	|Sig key	  |Returns    |Notes
-----	      |----				|------	    |-------
User0, perm0		|key2			|true			|Autorisation accordée lorsque la signature pour la clé publique est fournie
User0, perm0		|key3			|true			|Autorisation accordée lorsque la signature du groupe est fournie
User0, perm0		|key1			|true			|Autorisation accordée quand la clé `active` est fournie
User0, perm1		|key7			|true			|key7 donne l'autorisation User1@active, accordant donc perm1
User0, owner		|key1			|false		|`active` ne donne pas l'autorisation `owner`
User0, active		|key0			|true			|`owner` donne toutes les autorisations
User0, perm2		|key4			|false		|Les signatures n'ont pas atteint le seuil
User0, perm2		|key4,key5	|true			|Les signatures ont atteint le seuil
User0, perm2		|key3			|true			|Le groupe d'autorisation ne se calcule pas et vérifie le seuil
User0, perm2		|key1			|true			|`active` ne vérifie pas le seuil
User0, perm4		|key8			|false		|Peut être implémenté lors du calcul du poids du groupe d'autorisations

## Creation et gestion de compte

La gestion de comptes est basée sur le contrat de `account.iost`. L'ABI est comme suit :

```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "SignUp", // Create account
      "args": ["string", "string", "string"] // Username, ownerKey ID, activeKey ID
    },
    {
      "name": "AddPermission", // Add permission
      "args": ["string", "string", "number"] // Username, permission name, threshold
    },
    {
      "name": "DropPermission", // Drop permission
      "args": ["string", "string"] // Username, permission name
    },
    {
      "name": "AssignPermission", // Assign permission to an item
      "args": ["string", "string", "string","number"] // Username, permission, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokePermission",    // Revoke permission
      "args": ["string", "string", "string"] // Username, permission, public key ID or account_name@permission_name
    },
    {
      "name": "AddGroup",   // Add permission group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "DropGroup",   // Drop group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "AssignGroup", // Assign objet to group
      "args": ["string", "string", "string", "number"] // Username, group name, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokeGroup",    // Revoke group
      "args": ["string", "string", "string"] // Username, group name, public key ID or account_name@permission_name
    },
    {
      "name": "AssignPermissionToGroup", // Assign permission to group
      "args": ["string", "string", "string"] // Username, permission name, group name
    },
    {
      "name": "RevokePermissionInGroup", // Revoke permissions from a group
      "args": ["string", "string", "string"] // Username, permission name, group name
    }
  ]
}
```

Les noms valides sont `[a-z0-9_]`, avec une longueur entre 5 and 11. Les noms de groupes et d'autorisations sont composés de `[a-zA-Z0-9_]` avec une longueur entre 1 et 32.

Normalement les comptes auront besion de déposer des IOST sur demande, ou le compte ne pourra pas être utilisé. Utiliser `iost.js` :

```
newAccount(name, ownerkey, activekey, initialRAM, initialGasPledge) {
    const t = new Tx(this.config.gasPrice, this.config.gasLimit, this.config.delay);
    t.addAction("iost.auth", "SignUp", JSON.stringify([name, ownerkey, activekey]));
    t.addAction("iost.ram", "buy", JSON.stringify([this.publisher, name, initialRAM]));
    t.addAction("iost.gas", "pledge", JSON.stringify([this.publisher, name, initialGasPledge]));
    return t
}
```

Pour optimiser le processus de création de compte, les frais de création de compte sont déduits comme suit : la création de compte déduit du GAS chez le compte à l'origine de la création, et la Ram du nouveau compte est payée par le créateur. Lorsque le Ram s'accumule jusqu'à atteindre le même montant, le créateur est remboursé de la Ram. Le compte créé "payera" alors pour la création de compte.

Lorsque vous créez un compte, vous pouvez choisir d'acheter de la Ram et de déposer des tokens pour le compte créé. Nous recommandons de déposer au moins 10 tokens afin que le nouveau compte dispose de suffisamment de gas pour utiliser le réseau. Le gas déposé ne devrait pas être inférieur à 10 tokens pour assurer suffisamment de gas pour acheter des ressources.
