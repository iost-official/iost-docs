---
id: Token
title: Créer un Token
sidebar_label: Créer un Token
---
## Token20

Token20 est notre standard pour l'implémentation de tokens sur la blockchain IOST. Il inclut plusieurs fonctions pratiques en plus du transfert,
comme le gel, la destruction et doit être configuré avec attention.

`iost` est aussi implémenté selon le standard Token20, basé sur notre contrat système intégré `token.iost`.
Les interfaces de `token.iost` sont décrites comme suit :

```js
// créer tokenSymbol
create(tokenSymbol, issuer, totalSupply, configJson);	// string, string, number, json
issue(tokenSymbol, to, amountStr);						// string, string, string
transfer(tokenSymbol, from, to, amountStr, memo);		// string, string, string, string, string
transferFreeze(tokenSymbol, from, to, amountStr, unfreezeTime, memo);		// string, string, string, string, number, string
destroy(tokenSymbol, from, amountStr);					// string, string, string
// Appeler interfaces
balanceOf(tokenSymbol, from);							// string, string
supply(tokenSymbol);									// string
totalSupply(tokenSymbol);								// string
```
### create(tokenSymbol, issuer, totalSupply, configJson)
`Authority required: issuer`

TokenSymbol est l'identifiant unique d'un token spécifique, c'est à dire qu'il n'est pas possible de créer un token dans le contrat `token.iost` avec un tokenSymbol déjà utilisé.
Il s'agit d'un string d'une longueur entre 2 et 16 qui accepte les caractères `a-z`, `0-9` et `_`.

Issuer est l'émetteur du token. Seul l'émetteur à l'autorisation d'émettre des tokens vers un compte arbitraire.
Normalement l'émetteur d'un token est un compte, mais il peut aussi s'agir d'un contrat.
Lorsque l'émetteur est un ID de contrat, cela signifie quel seul le contrat a la possibilité d'appeler la méthode  `issue` afin d'émettre des tokens vers un tiers.
Disons que l'émetteur du token `mytoken` est le contrat `Contractabc`, alors `Contractabc` peut appeler `issue` afin d'émettre `mytoken`,
`Contractabc` peut donc appeler une fonction dans `Contractdef`, et `Contractdef` et peut donc émettre des tokens `mytoken`.
Pour que l'autorisation d'un contrat puisse être donnée par le contrat appelé, il faut utiliser la fonction système `blockchain.callWithAuthority` au lieu de
`blockchain.call` lors de l'appel du contrat pour permettre l'autorisation.

TotalSupply est un nombre int64, l'émetteur ne peut pas émettre plus de tokens que TotalSupply.

ConfigJson est un fichier json qui constitue la configuration du token. Voici les propriétés supportées :
```console
{
	"decimal": number between 0~19,
	"canTransfer": true/false, the token can not be transferd if canTransfer is false,
	"fullName": string describes the full name of the token
}
```

### issue(tokenSymbol, acc, amountStr)
`Authority required: issuer of tokenSymbol`

Emettre tokenSymbol vers le compte `acc`, amountStr est un string qui réfère à la quantité à émettre, le montant doit être un nombre positif à décimale fixe comme "100", "100.999"

### transfer(tokenSymbol, accFrom, accTo, amountStr, memo)
`Authority required: accFrom`

Le transfert de token tokenSymbol de `accFrom` vers `accTo` avec amountStr et memo,
amount doit être un nombre positif à décimale fixe, et memo est un message string additionnel pour le transfert d'une longueur maximale de 512 bytes.

### transferFreeze(tokenSymbol, accFrom, accTo, amountStr, unfreezeTime, memo)
`Authority required: accFrom`

Transférer le token tokenSymbol de `accFrom` vers `accTo` avec amountStr and memo, et le geler jusque unfreezeTime.
unfreezeTime est le nombre de nanosecondes en temps unix après lesquelles le token sera degelé.

### destroy(tokenSymbol, accFrom, amountStr)
`Authority required: accFrom`

Détruire amountStr du token dans le compte `accFrom`. Après la destruction, le supply de ce token sera réduit du montant équivalent, cela signifie
qu'il est possible d'émettre de nouveaux tokens par rapport au totalsupply en en ayant détruit.

### balanceOf(tokenSymbol, acc)
`Authority required: null`

S'enquérir du solde d'un token spécifique.

### supply(tokenSymbol)
`Authority required: null`

S'enquérir du supply d'un token spécifique.

### totalSupply(tokenSymbol)
`Authority required: null`

S'enquérir du totalsupply d'un token spécifique.


## Exemple étape par étape
Créer un `Token20` sur la blockchain iost est très simple, il suffit d'appeler le contrat `token.iost` sans implémenter d'interfaces Token20et de déployer vous même le smart contract.

Ci-dessous un exemple détaillé de comment créer un token en utilisant le compte `bank` et transférer le token entre comptes. Il faut pour cela d'abord créer les comptes `bank`, `user0`, `user1`.

```console
iwallet call token.iost create '["mytoken", "bank", 21000000000, {"decimal": 8, "fullName": "token for test"}]' --account bank
iwallet call token.iost issue  '["mytoken", "bank", "1000"]' --account bank
iwallet call token.iost issue  '["mytoken", "user0", "100.00000001"]' --account bank
iwallet call token.iost transfer 		'["mytoken", "user0", "user1", "10", "user0 pay coffee"]' --account user0
iwallet call token.iost transferFreeze 	'["mytoken", "user1", "user0", "0.1", 1544880864601648640, "voucher"]' --account user1
iwallet call token.iost destroy '["mytoken", "bank", "1000"]' --account bank
```
