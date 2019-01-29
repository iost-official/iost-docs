---
Id: SystemContract
Title: Contrat système
Sidebar_label: Contrat système
---

## vote_producer.iost
---

### Description
Campagne de vote de Super Node.

### Info
| contract_id | vote_producer.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### applyRegister
Se présenter en tant que candidat pour devenir un Super Node.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |
| public key base58 encoding | string |
| Location | string |
| Website url | string |
| network id | string |
| is producer | bool |

#### applyUnregister
Demande l'annulation

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |


#### unregister
Afin d'annuler l'enregistrement il faut appeler ApplyUnregister. Une fois l'audit passé, il est possible d'appeler cette interface.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |

#### updateProducer
Mettre à jour les informations enregistrées.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |
| public key base58 encoding | string |
| Location | string |
| Website url | string |
| network id | string |

#### logInProducer
Se mettre en ligne, indiquant que le nœud est disponible pour utilisation.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |

#### logOutProducer
Offline signifie que le nœud n'est pas en capacité d'offrir ses services.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |

#### vote
voter.

| Parameter List | Parameter Type |
| :----: | :------ |
| Voter Account Name | string |
| Candidate Account Name | string |
| Number of votes | string |

#### unvote
Annuler un vote.

| Parameter List | Parameter Type |
| :----: | :------ |
| Voter Account Name | string |
| Candidate Account Name | string |
| Number of votes | string |

#### voterWithdraw
Les voteurs obtiendront des récompenses.

| Parameter List | Parameter Type |
| :----: | :------ |
| Voter Account Name | string |

#### candidateWithdraw
Le candidat reçoit une récompense bonus.

| Parameter List | Parameter Type |
| :----: | :------ |
| Candidate Account Name | string |

## vote.iost
---

### Description
Un contrat de vote universel utilisé pour créer des votes, recueillir des votes et voter sur des statistiques. Vous pouvez implémenter votre propre fonction de vote sur la base de ce contrat.

### Info
| contract_id | vote.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### newVote
Créer un vote.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Nom du compte créateur du vote | string | Créer un vote qui nécessite un gage de 1000 IOST, qui sera déduit du compte du créateur, qui obtient les droits d'admin sur le vote |
| Description du vote | string ||
| Paramètres de vote | json object| contient 5 clés : <br>resultNumber —— type nombre, nombre de votes, maximum 2000; <br> minVote —— type nombre, mnombre mini de votes, le candidat avec a besoin de plus de votes que le mini pour entrer dans les résultats du vote ; <br>options - array type, candidats, chaque item est un string, représente un candidat, l'initial peut être vide []; <br>anyOption - type booléen, autorise ou non le choix d'un candidat absent de la liste, false signifie qu'il n'est possible de voter que pour un membre de la liste établie.; <br>freezeTime - type nombre, annule le temps de gel des tokens, en secondes;
Un appel successif retourne un ID de vote unique.

#### addOption
Ajouter une option de vote.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID retourné par l'interface NewVote |
| Options | string ||
| Supprimer ou non les votes précédents | bool ||

#### removeOption
Supprime une option de vote tout en gardant le résultat du vote, puis permet d'ajouter l'option via AddOption de nouveau avec le choix de restaurer le nombre de votes ou non.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID retourné par l'interface NewVote |
| Options | string ||
Forcer la suppression ou non | bool | false signifie que l'option n'est pas supprimée si elle fait partie des résultats. True signifie que la suppression aura lieu |

#### getOption
Obtenir le nombre de votes pour un candidat donné.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID retourné par l'interface NewVote |
| Options | string ||

Le résultat est un objet json :

| key | type | notes |
| :----: | :------ | :------ |
| votes| string | Votes |
| deleted| bool | Marqué comme supprimé |
| clearTime| number | Le numéro de bloc où les votes ont été supprimés la dernière fois |

#### voteFor
Vote par procuration, le montant mis en gage sera déduit du compte.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID retourné par l'interface NewVote |
| Auteur de la procuration | string ||
| Votant | string ||
| Options | string ||
| Numbre de votes | string ||

#### getVote
Obtenir un vote.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID retourné par l'interface NewVote |
| Nom du votant | string ||

Le résultat est un objet json :

| key | type | notes |
| :----: | :------ | :------ |
| option| string | options |
| votes| string | Numbre de votes |
| voteTime| number | Bloc du dernier vote |
| clearedVotes| string | Numbre de votes supprimés |

#### getResult
Obtenir le résultat et retourne l'option resultNumber avant le nombre de votes.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID retourné par l'interface NewVote |

Le résultat est un objet json :

| key | type | notes |
| :----: | :------ | :------ |
| option| string | options |
| votes| string | Nombre de votes |

#### delVote
Supprime le vote et retourne l'IOST mis en gage au créateur

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID retourné par l'interface NewVote |

## auth.iost
---

### Description
Système de gestion de droits et de comptes

### Info
| contract_id | auth.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### signUp
créer un compte

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| ownerKey | string |
| activeKey | string |

#### addPermission
Ajouter des autorisations à un compte

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Nom de l'autorisation | string |
| Seuil de l'autorisation | number |

#### dropPermission
Supprimer l'autorisation

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Nom de l'autorisation | string |

#### assignPermission
Specifier les autorisation pour un objet

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permissions | string |
| item | string |
| Weight | number |


#### revokePermission
Annuler une autorisation

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permissions | string |
| item | string |

#### addGroup
Ajouter un groupe d'autorisations

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |

#### dropGroup
Supprimer un groupe d'autorisations

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |

#### assignGroup
Spécifier un objet au groupe d'autorisations

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |
| item | string |
| Weight | number |

#### revokeGroup
Révoquer l'objet du groupe d'autorisations

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |
| item | string |


#### assignPermissionToGroup
Ajouter des autorisations au groupe

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permission name | string |
| Group name | string |


#### revokePermissionInGroup
Supprimer des autorisations du groupe

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permission name | string |
| Group name | string |


## bonus.iost
---

### Description

Nœud formel ? Récompense de bloc ? Gestion

### Info

| contract_id | bonus.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### issueContribute

La valeur de contribution value est créée et le système appelle automatiquement

| Parameter List | Parameter Type |
| :----: | :------ |
| data | json |

#### exchangeIOST

Utilise la valeur de contribution pour échanger les IOST

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |
| Quantité | string |


## system.iost

---

### Description
Contrat système de base pour l'émission et la mise à jour des contrats et autres fonctions de base du système.

### Info
| contract_id | system.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### setCode (code)
Déployer des smart contracts.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| code | Smart Contract Code | string |

| Return Value | Return Value Type |
| :----: | :------ |
| contractID | string |

Le code du smart contract comprend du code et des informations sur le smart contract, telles que la langue et les définitions d'interface. Le paramètre code prend en charge deux formats : format json et format d'encodage de sérialisation de protobuf.
Pour les développeurs, les contrats de déploiement n'ont généralement pas besoin d'appeler directement cette interface. Il est recommandé d'utiliser iwallet ou un langage d'implémentation du SDK associé.

Lors du déploiement d'un smart contract, le système appelle automatiquement la fonction init() du smart contract. Le développeur peut faire du travail d'initialisation dans la fonction init.

La valeur de retour contractID est l'ID de smart contract, qui est globalement unique et généré par le hash de la transaction du contrat de déploiement. Le contractID commence par "Contract" et se compose de lettres majuscules et minuscules et de chiffres. Un seul smart contract peut être déployé dans une transaction.

#### updateCode (code, data)
Mise à niveau de smart contracts.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| code | Smart Contract Code | string |
| data | paramètres de mise à jour de fonction | string |

| Return value | None |
| :----: | :------ |

Mettre à jour le smart contract, le code est le code du smart contract, le format est le même que le paramètre dans SetCode.

Lors de la mise à niveau d'un smart contract, le système vérifie automatiquement l'autorisation de mise à niveau, c'est-à-dire la fonction can_update(data) du contrat, et les données paramètres sont le deuxième paramètre du UpdateCode, si et seulement si la fonction can_update existe et l'appel renvoie True.
Soit la mise à niveau du contrat sera réussie, soit la mise à niveau échouera et il est déterminé qu'il n'y a pas d'autorisation de mise à niveau.

#### cancelDelaytx (txHash)
Annule une transaction retardée. Appeler cette fonction avant l'exécution de la transaction retardée afin de l'annuler.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| txHash | Transaction hash | string |

| Return value | None |
| :----: | :------ |

#### requireAuth (acc, permission)
Vérifie si la transaction à l'autorisation du compte.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| acc | account name | string |
| permission | permission name | string |

| Return value | Type |
| :----: | :------ |
| ok | bool |

#### receipt (data)
Génère un reçu de transaction, le reçu est stocké sur le bloc, et peut être appelé via le hash de transaction.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| data | receipt content | string |

| Return value | None |
| :----: | :------ |
