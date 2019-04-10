---
id: TokenContract
title: Contrat Token
sidebar_label: Contrat Token
---

## token.iost
---

### Description
Le contrat de token est utilisé pour la création, la distribution, le transfert et la destruction des tokens, peut geler les tokens et configurer les paramètres nom, décimales, attributs de transfert.

### Info
| contract_id | token.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### create (tokenSym, issuer, totalSupply, config)
Création du token

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token, unique within the contract | string |
| issuer | issuer with issuing token permission | string |
| totalSupply | Total supply, integer | number |
| config | configuration | json |

| Return value | None |
| :----: | :------ |

tokenSym devrait avoir une longueur de 2~16 caractères, consister de a-z, 0-9 et _ .

Exemples d'objets de configuration autorisés :

{

   "fullName": "iost token", // full name of the token, string

   "canTransfer": true, // if tradable, bool

   "decimal": 8 // decimal places, number

}

#### issue (tokenSym, to, amount)
Emission de tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| to | Destinataire | string |
| amount | quantité | string |

| Return value | None |
| :----: | :------ |

La paramètre quantité est un string, qui peut être un integer ou un décimal, comme "100", "1.22"

#### transfer (tokenSym, from, to, amount, memo)
Transfert de tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| from | Expéditeur | string |
| to | Destinataire | string |
| amount | quantité | string |
| memo | Information additionnelle | string |

| Return value | None |
| :----: | :------ |

#### transferFreeze (tokenSym, from, to, amount, ftime, memo)
Transfert et gel de tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| from | Expéditeur | string |
| to | Destinataire | string |
| amount | quantité | string |
| ftime| date de dégel, millisecondes de timestamp Unix | number |
| memo | Information additionnelle | string |

| Return value | None |
| :----: | :------ |

#### destroy (tokenSym, from, amount)
Destruction de tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| from | Compte sur lequel détruire les tokens | string |
| amount | quantité | string |

| Return value | None |
| :----: | :------ |

#### balanceOf (tokenSym, from)
Obtenir le solde de tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| from | Compte | string |

| Return value | Type |
| :----: | :------ |
| Account Balance | string |

#### supply (tokenSym)
Obtenir le nombre de tokens en circulation, c'est à dire la quantité créée moins la quantité détruite.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |

| Return value | Type |
| :----: | :------ |
| supply | string |

#### totalSupply(tokenSym)
Obtenir le totalsupply du token

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |

| Return value | Type |
| :----: | :------ |
| Total supply | string |


## token721.iost
---

### Description
Le contrat token721 est utilisé pour la création, distribution, transfert et destruction de tokens non-échangeables.

### Info
| contract_id | token721.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### create (tokenSym, issuer, totalSupply)
Création de tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token, unique within the contract | string |
| issuer | émetteurs avec droits d'émission | string |
| totalSupply | Nombre de tokens en circulation, integer | number |

| Return value | None |
| :----: | :------ |

tokenSym doit être composé de 2~16 caractères et consister de a-z, 0-9 et _

#### issue (tokenSym, to, metaData)
Emettre des tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| to | Destinataire | string |
| metaData | Metadonnées du token | string |

| Return value | Type |
| :----: | :------ |
| tokenID | string |

tokenID  est l'identifiant du token. Pour un token donné, le système va générer un tokenID spécifique pour chaque token émis qui ne sera pas répliqué pour ce type de token.

#### transfer (tokenSym, from, to, tokenID)
Transfert de tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| from | Expéditeur | string |
| to | Destinataire | string |
| tokenID | Token ID | string |

| Return value | None |
| :----: | :------ |

#### balanceOf (tokenSym, from)
Obtenir le solde en tokens

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| from | Compte | string |

| Return value | Type |
| :----: | :------ |
| Account Balance | number |

#### ownerOf (tokenSym, tokenID)
Obtenir le propriétaire d'un token donné

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| tokenID | Token ID | string |

| Return value | Type|
| :----: | :------ |
| Owner Account | string |

#### tokenOfOwnerByIndex(tokenSym, owner, index)
Obtenir l'index token appartenant à un compte

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| owner | Token account | string |
| index | Token index, integer | number |

| Return value | Type |
| :----: | :------ |
| tokenID | string |

#### tokenMetadata(tokenSym, tokenID)
Obtenir les metadonnées d'un token

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Identifiant du token | string |
| tokenID | Token ID | string |

| Return value | Type |
| :----: | :------ |
| metaData | string |
