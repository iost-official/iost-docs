---
id: version-3.0.0-TokenContract
title: Token Contract
sidebar_label: Token Contract
original_id: TokenContract
---

## token.iost
---

### Description
Token contract is used for token creation, distribution, transfer and destruction, can freeze token for some time, and also with support for configuring the full name of tokens, decimal places, transfer attributes

### Info
| contract_id | token.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### create (tokenSym, issuer, totalSupply, config)
Create token.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token identifier, unique within the contract | string |
| issuer | issuer with issuing token permission | string |
| totalSupply | Total supply, integer | number |
| config | configuration | json |

| Return value | None |
| :----: | :------ |

tokenSym should be 2~16 characters long, consists of a-z, 0-9 and _ characters

Examples of configuration items supported by config are as follows:

{

   "fullName": "iost token", // full name of the token, string

   "canTransfer": true, // if tradable, bool

   "decimal": 8 // decimal places, number

}

#### issue (tokenSym, to, amount)
Issue tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| to | Token receiving account | string |
| amount | amount | string |

| Return value | None |
| :----: | :------ |

The amount parameter is a string, which can be an integer or a decimal, such as "100", "1.22" are legal amounts

#### transfer (tokenSym, from, to, amount, memo)
Token transfer.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| from | Token Transfer Account | string |
| to | Token receiving account | string |
| amount | amount | string |
| memo | Additional Information | string |

| Return value | None |
| :----: | :------ |

#### transferFreeze (tokenSym, from, to, amount, ftime, memo)
Transfer and freeze tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| from | Token transfer Account | string |
| to | Token receiving account | string |
| amount | amount | string |
| ftime| Unfreeze time, milliseconds of Unix timestamp | number |
| memo | Additional Information | string |

| Return value | None |
| :----: | :------ |

#### destroy (tokenSym, from, amount)
Destroy tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| from | Token destroy account | string |
| amount | amount | string |

| Return value | None |
| :----: | :------ |

#### balanceOf (tokenSym, from)
Get the token balance.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| from | Token account | string |

| Return value | Type |
| :----: | :------ |
| Account Balance | string |

#### supply (tokenSym)
Get the token circulation, that is, the total amount of tokens that have been issued and have not been destroyed.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |

| Return value | Type |
| :----: | :------ |
| supply | string |

#### totalSupply(tokenSym)
Get the total circulation of tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |

| Return value | Type |
| :----: | :------ |
| Total supply | string |


## token721.iost
---

### Description
Token721 contract is used for the creation, distribution, transfer and destruction of non-exchangeable tokens.

### Info
| contract_id | token721.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### create (tokenSym, issuer, totalSupply)
Create tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token identifier, unique within the contract | string |
| issuer | issuer with issuing token rights | string |
| totalSupply | Total circulation, integer | number |

| Return value | None |
| :----: | :------ |

tokenSym should be 2~16 characters long, consists of a-z, 0-9 and _ characters

#### issue (tokenSym, to, metaData)
Issue tokens.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| to | Token receiving account | string |
| metaData | Meta data for tokens | string |

| Return value | Type |
| :----: | :------ |
| tokenID | string |

tokenID is the token identification. In a certain token, the system will generate a specific tokenID for each token issued which won't be duplicated in a certain kind token.

#### transfer (tokenSym, from, to, tokenID)
Token transfer.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| from | Token Transfer Account | string |
| to | Token receiving account | string |
| tokenID | Token ID | string |

| Return value | None |
| :----: | :------ |

#### balanceOf (tokenSym, from)
Get the token balance.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| from | Token account | string |

| Return value | Type |
| :----: | :------ |
| Account Balance | number |

#### ownerOf (tokenSym, tokenID)
Get the owner of a particular token

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| tokenID | Token ID | string |

| Return value | Type|
| :----: | :------ |
| Owner Account | string |

#### tokenOfOwnerByIndex(tokenSym, owner, index)
Get the index token owned by the account

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| owner | Token account | string |
| index | Token index, integer | number |

| Return value | Type |
| :----: | :------ |
| tokenID | string |

#### tokenMetadata(tokenSym, tokenID)
Get the meta data of the token

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| tokenSym | Token Identifier | string |
| tokenID | Token ID | string |

| Return value | Type |
| :----: | :------ |
| metaData | string |
