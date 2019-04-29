---
id: version-3.0.10-TokenContract
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
| version | 1.0.3 |

### API

#### create(tokenSym, issuer, totalSupply, config)
Create token.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym |  string |Token symbol, unique within the contract. Its length should be between 2 and 16 and could only contain characters in [a-z0-9_] |
| issuer | string | token issuer who has token issue permission. **Calling this interface requires this account's "token" permission** | 
| totalSupply | number | Total amount of supply |
| config | json | token configuration. It contains 4 keys: <br>fullName —— string type, full name of the token.<br> canTransfer —— bool type, whether the token can be transferred.<br> decimal —— number type, the token decimal.<br>onlyIssuerCanTransfer —— bool type, whether the token is allowed to transfer only by token issuer.|


#### issue(tokenSym, to, amount)
Issue tokens.

`Calling this interface requires token issuer's "token" permission.`

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol |
| to | string | The account who receives token |
| amount | string | The amount could be both integer and decimal, such as "100", "1.22" | 


#### transfer(tokenSym, from, to, amount, memo)
Token transfer.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| from | string | Account who sends token, **Calling this interface requires this account's "transfer" permission**|
| to | string | Account who receives token |
| amount | string | The amount of token transferred |
| memo | string | Additional information |


#### transferFreeze(tokenSym, from, to, amount, ftime, memo)
Transfer and freeze tokens.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| from | string | Account who sends token, **Calling this interface requires this account's "transfer" permission**|
| to | string | Account who receives token |
| amount | string | The amount of token transferred |
| memo | string | Additional information |

#### destroy(tokenSym, from, amount)
Destroy tokens.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| from | string | Account who destroys token, **Calling this interface requires this account's "transfer" permission**|
| amount | string | The amount of token destroyed |

#### balanceOf(tokenSym, from)
Get the token balance.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| from | string | Account name which is queried |

| Return value | Type | Remark |
| :----: | :------ | :------ |
| balance | string | account balance |

#### supply(tokenSym)
Get the token circulation, that is, the total amount of tokens that have been issued and have not been destroyed.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 

| Return value | Type |
| :----: | :------ |
| supply | string |

#### totalSupply(tokenSym)
Get the total circulation of tokens.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 

| Return value | Type |
| :----: | :------ |
| Total supply | string |


## token721.iost
---

### Description
Token721 contract is used for the creation, distribution, transfer and destruction of non-fungible tokens.

### Info
| contract_id | token721.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### create(tokenSym, issuer, totalSupply)
Create tokens.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym |  string |Token symbol, unique within the contract. Its length should be between 2 and 16 and could only contain characters in [a-z0-9_] |
| issuer | string | token issuer who has token issue permission. **Calling this interface requires this account's "token" permission** | 
| totalSupply | number | Total amount of supply |


#### issue(tokenSym, to, metaData)
Issue tokens.

`Calling this interface requires token issuer's "token" permission.`

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol |
| to | string | The account who receives token |
| metaData |string | Meta data for token | 

| Return value | Type | Remark |
| :----: | :------ |:------ |
| tokenID | string | TokenID is the token identification. In a certain token, the system will generate a specific tokenID for each token issued which won't be duplicated in a certain kind token.|


#### transfer(tokenSym, from, to, tokenID)
Token transfer.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| from | string | Account who sends token, **Calling this interface requires this account's "transfer" permission**|
| to | string | Account who receives token |
| tokenID | string | Token ID |

#### balanceOf(tokenSym, from)
Get the token balance.

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| from |  string | account name |

| Return value | Type | Remark|
| :----: | :------ |:------ |
| balance | number | Account balance|

#### ownerOf(tokenSym, tokenID)
Get the owner of a particular token

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym | string | Token symbol | 
| tokenID |  string |Token ID |

| Return value | Type|Remark|
| :----: | :------ |:------ |
| account | string |Owner account name|

#### tokenOfOwnerByIndex(tokenSym, owner, index)
Get the index token owned by the account

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym |  string |Token symbol |
| owner | string | Account name | 
| index |  number |Token index, integer |

| Return value | Type |
| :----: | :------ |
| tokenID | string |

#### tokenMetadata(tokenSym, tokenID)
Get the meta data of the token

| Parameter Name | Parameter Type | Remark |
| :----: | :----: | :------ |
| tokenSym |  string |Token symbol |
| tokenID |  string |Token ID |

| Return value | Type |
| :----: | :------ |
| metaData | string |
