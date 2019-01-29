---
id: EconContract
title: Contrat Economique
sidebar_label: Contrat Economique
---

## gas.iost
---

Contrat lié au GAS, incluant le paiement en IOST pour le gas et le transfert de GAS.
Les détails du modèle économique sont introduits ici [Modèle économique](2-intro-of-iost/Economic-model.md#gas奖励)。

### Info
| contract_id | gas.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### engager
Engager des IOST pour obtenir du GAS. Quantité minimale a verrouiller de 1 IOST.      
##### Exemple
\["user1","user1","100"\]：user1 engage 100 IOSTs pour lui même. Il ne peut donc plus utiliser 100 IOST mais obtient du GAS.   
\["user1","user2","100"\]：user1 engage 100 IOSTs pour user2. Il perd donc l'utilisation de 100 IOST, et user2 obtient du GAS.

| Arg Meaning | Arg Type |
| :----: | :------ |
| qui engage les IOST. L'autorisation du compte est nécessaire. | string |
| qui obtient le GAS | string |
| quantité engagée | string |

#### désengager
désengager. Les IOST engagés plus tôt sont retournés au propriétaire. Montant minimal de désengagement de 1 IOST.
##### Example
\["user1","user1","100"\]：user1 désengage 100 IOSTs de l'engagement précédent pour lui-même.
\["user1","user2","100"\]：user1 désengage 100 IOSTs de l'engagement précédent pour user2.

| Arg Meaning | Arg Type |
| :----: | :------ |
| qui désengage les IOST. L'autorisation du compte est nécessaire. | string |
| Personne a qui étaient destinés le gas. | string |
| Quantité désengagée | string |


#### transfert
transfert de GAS. quantité transférée minimale de 1 GAS.   
__Notice__: Le GAS obtenu par engagement ne peut pas être transféré. Seul le `GAS transférable` peut être transféré. De plus le `GAS transferable` n'est transférable qu'une seule fois.
Il est possible d'obtenir du GAS de [récompenses en gas transférable](2-intro-of-iost/Economic-model.md#流通gas奖励)

##### Exemple
\["user1","user2","100"\]: user1 transfère 100 GAS à user2


| Arg Meaning | Arg Type |
| :----: | :------ |
| qui transfère le GAS. L'autorisation du compte est nécessaire. | string |
| qui obtient le gas | string |
| Quantité transférée | string |

## ram.iost
---
Contrat lié à la RAM, incluant achat/vente/transfert.    
Les détails du modèle économique sont introduits ici [Modèle économique](2-intro-of-iost/Economic-model.md#资源).  
Afin d'acheter/vendre de la RAM au bon prix il est possible d'estimer le prix via [RPC](6-reference/API.md#getraminfo).

### Info
| contract_id | ram.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### acheter
Acheter de la RAM du système. Montant minimum de 10 bytes.        
Le contrat retournera le montant en IOST.
##### Exemple
\["user1","user1",1024\]:  user1 achète 1024 bytes de RAM pour lui-même   
\["user1","user2",1024\]:  user1 achète 1024 bytes de RAM pour user2

| Arg Meaning | Arg Type |
| :----: | :------ |
| Qui achète la RAM. L'autorisation du compte est nécessaire. | string |
| Qui obtient la RAM | string |
| Montant de RAM acheté | int |

#### vendre
Vendre de la RAM inutilisée au système. Montant minimum de 10 bytes.   
Le contrat retournera le montant en IOST.
##### Exemple
\["user1","user1",1024\]:  user1 vend 1024 bytes de RAM au système, il obtient des IOST en échange
。  
\["user1","user2",1024\]:  user1 vend 1024 bytes de RAM au système, user2 obtient des IOST en échange

| Arg Meaning | Arg Type |
| :----: | :------ |
| Qui vend la RAM. L'autorisation du compte est nécessaire. | string |
| Qui obtient les IOST retournés | string |
| Montant de RAM vendu | int |

#### prêt
transférer de la RAM à d'autres utilisateurs.
Seule de le RAM `achetée` peut être transférée à d'autres. De la RAM transférée ne peut ni être vendue au système ni transférée à d'autres.
Montant minimum de 10 bytes.  
##### Example
\["user1","user2",1024\]: user1 transfère 1024 buytes de RAM inutilisée à user2

| Arg Meaning | Arg Type |
| :----: | :------ |
| Qui transfère de la RAM. L'autorisation du compte est nécessaire. | string |
| Qui obtient la RAM transférée | string |
| Montant transféré | int |
