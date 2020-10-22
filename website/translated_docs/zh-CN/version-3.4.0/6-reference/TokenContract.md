---
id: TokenContract
title: Token Contract
sidebar_label: Token Contract
---

## token.iost
---

### 简介
代币合约，用于代币创建，发行，转账和销毁，支持冻结功能，支持配置代币全称，小数位数，转账属性等。

### 基础信息
| contract_id | token.iost |
| :----: | :------ |
| language | native |
| version | 1.0.3 |

### 接口描述

#### create(tokenSym, issuer, totalSupply, config)
创建代币。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符，合约内唯一，长度为 2-16 位的字符串，字符只能包含 [a-z0-9_] |
| issuer   | string | 代币发行者，具有发行代币权限，**调用此接口需要该账户的 "token" 权限** | 
| totalSupply | number | 总发行量，整数 |
| config | json | 代币设置，包含 4 个 key: <br> fullName —— string 类型，代币全称；<br> canTransfer —— bool 类型，是否可转账；<br> decimal —— number 类型，代币小数位数；<br> onlyIssuerCanTransfer —— bool 类型，是否只能由代币发行者转账；|


#### issue(tokenSym, to, amount)
发行代币。

`调用此接口需要代币发行者的 "token" 权限。`

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| to | string | 代币接收账户 |
| amount | string | 金额，可以是整数或小数, 如 "100", "1.22" 都是合法的金额 |


#### transfer(tokenSym, from, to, amount, memo)
代币转账。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| from  | string | 代币转出账户，**调用此接口需要该账户的 "transfer" 权限** |
| to  | string | 代币接收账户 |
| amount | string | 金额 |
| memo | string | 附加信息 |


#### transferFreeze(tokenSym, from, to, amount, ftime, memo)
转账并冻结代币。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| from  | string | 代币转出账户，**调用此接口需要该账户的 "transfer" 权限** |
| to  | string | 代币接收账户 |
| amount | string | 金额 |
| memo | string | 附加信息 |


#### destroy(tokenSym, from, amount)
销毁代币。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| from  | string | 代币转出账户，**调用此接口需要该账户的 "transfer" 权限** |
| amount | string | 金额 |


#### balanceOf(tokenSym, from)
获取代币余额。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| from  | string | 账户名 |

| 返回值 | 类型 | 备注 |
| :----: | :------ | :------ |
| balance | string | 账户余额 |

#### supply(tokenSym)
获取代币发行量，即已经 issue 且没有 destroy 的代币总额。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |

| 返回值 | 类型 | 备注 |
| :----: | :------ | :------ |
| amount | string | 发行量 |

#### totalSupply(tokenSym)
获取代币总发行量，即发行代币时配置的 totalSupply 值。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |

| 返回值 | 类型 | 备注 |
| :----: | :------ | :------ |
| amount | string | 发行量 |


## token721.iost
---

### 简介
不可交换代币合约，用于不可交换代币创建，发行，转账和销毁。

### 基础信息
| contract_id | token721.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### 接口描述

#### create(tokenSym, issuer, totalSupply)
创建代币。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符，合约内唯一，长度为 2-16 位的字符串，字符只能包含 [a-z0-9_] |
| issuer   | string | 代币发行者，具有发行代币权限，**调用此接口需要该账户的 "token" 权限** | 
| totalSupply | number | 总发行量，整数 |

#### issue(tokenSym, to, metaData)
发行代币。

`调用此接口需要代币发行者的 "token" 权限。`

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| to | string | 代币接收账户 |
| metaData | 代币的 meta 数据 | string |

| 返回值 | 类型 | 备注 |
| :----: | :------ |:------ |
| tokenID | string | 代币编号，在某一代币中，系统会为发行的每个代币生成一个代币编号，同种代币中编号不会重复。|


#### transfer (tokenSym, from, to, tokenID)
代币转账。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| from  | string | 代币转出账户，**调用此接口需要该账户的 "transfer" 权限** |
| to  | string | 代币接收账户 |
| tokenID | string | 代币 ID |

#### balanceOf(tokenSym, from)
获取代币余额。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| from  | string | 账户名 |

| 返回值 | 类型 | 备注 |
| :----: | :------ | :------ |
| balance | string | 账户余额 |


#### ownerOf(tokenSym, tokenID)
获取某个特定代币的拥有者。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| tokenID | string | 代币 ID |

| 返回值 | 类型| 备注
| :----: | :------ |:------ |
| account | string |拥有者账户 |

#### tokenOfOwnerByIndex(tokenSym, owner, index)
获取账户拥有的第 index 个代币。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym |string | 代币标识符 |
| owner | string | 账户名 |
| index | number | 代币 index，整数 |

| 返回值 | 类型|
| :----: | :------ |
| tokenID | string |

#### tokenMetadata(tokenSym, tokenID)
获取代币的 meta 数据。

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| tokenID | string | 代币ID |

| 返回值 | 类型 |
| :----: | :------ |
| metaData | string |

