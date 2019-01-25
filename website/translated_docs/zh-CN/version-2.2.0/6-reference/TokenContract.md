---
id: TokenContract
title: Token Contract
sidebar_label: Token Contract
---

## token.iost
---

### 简介
代币合约, 用于代币创建,发行,转账和销毁, 支持冻结功能, 支持配置代币全称,小数位数,转账属性等。

### 基础信息
| contract_id | token.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### 接口描述

#### create (tokenSym, issuer, totalSupply, config)
创建代币.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符,合约内唯一 | string |
| issuer   | 发行者,具有发行代币权限 | string |
| totalSupply | 总发行量,整数 | number |
| config | 配置 | json |

| 返回值 | 无 |
| :----: | :------ |

tokenSym 长度应在 2~16 位, 使用 a-z, 0-9, _ 字符

config 支持的配置项举例如下:

{

   "fullName": "iost token",   // 代币全称, string
   
   "canTransfer": true,		// 是否可交易, bool
   
   "decimal": 8				// 小数位数, number

}

#### issue (tokenSym, to, amount)
发行代币.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| to  | 代币接收账户 | string |
| amount | 金额 | string |

| 返回值 | 无 |
| :----: | :------ |

amount 金额为字符串类型, 可以是整数或小数, 如 "100", "1.22" 都是合法的金额

#### transfer (tokenSym, from, to, amount, memo)
代币转账.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| from  | 代币转出账户 | string |
| to  | 代币接收账户 | string |
| amount | 金额 | string |
| memo | 附加信息 | string |

| 返回值 | 无 |
| :----: | :------ |

#### transferFreeze (tokenSym, from, to, amount, ftime, memo)
转账并冻结代币.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| from  | 代币转出账户 | string |
| to  | 代币接收账户 | string |
| amount | 金额 | string |
| ftime| 解冻时间,Unix时间戳的毫秒数 | number |
| memo | 附加信息 | string |

| 返回值 | 无 |
| :----: | :------ |

#### destroy (tokenSym, from, amount)
销毁代币.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| from  | 代币转出账户 | string |
| amount | 金额 | string |

| 返回值 | 无 |
| :----: | :------ |

#### balanceOf (tokenSym, from)
获取代币余额.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| from  | 代币账户 | string |

| 返回值 | 类型 |
| :----: | :------ |
| 账户余额 | string |

#### supply (tokenSym)
获取代币发行量,即已经issue且没有destroy的代币总额.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |

| 返回值 | 类型 |
| :----: | :------ |
| 发行量 | string |

#### totalSupply(tokenSym)
获取代币总发行量.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |

| 返回值 | 类型 |
| :----: | :------ |
| 总发行量 | string |


## token721.iost
---

### 简介
不可交换代币合约, 用于不可交换代币创建,发行,转账和销毁.

### 基础信息
| contract_id | token721.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### 接口描述

#### create (tokenSym, issuer, totalSupply)
创建代币.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符,合约内唯一 | string |
| issuer   | 发行者,具有发行代币权限 | string |
| totalSupply | 总发行量,整数 | number |

| 返回值 | 无 |
| :----: | :------ |

tokenSym 长度应在 2~16 位, 使用 a-z, 0-9, _ 字符

#### issue (tokenSym, to, metaData)
发行代币.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| to  | 代币接收账户 | string |
| metaData | 代币的meta数据 | string |

| 返回值 | 类型 |
| :----: | :------ |
| tokenID | string |

tokenID 为代币编号,在某一代币中,系统会为发行的每个代币生成一个代币编号,同种代币中编号不会重复.

#### transfer (tokenSym, from, to, tokenID)
代币转账.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| from  | 代币转出账户 | string |
| to  | 代币接收账户 | string |
| tokenID | 代币ID | string |

| 返回值 | 无 |
| :----: | :------ |

#### balanceOf (tokenSym, from)
获取代币余额.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| from  | 代币账户 | string |

| 返回值 | 类型 |
| :----: | :------ |
| 账户余额 | number |

#### ownerOf (tokenSym, tokenID)
获取某个特定代币的拥有者

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| tokenID | 代币ID | string |

| 返回值 | 类型|
| :----: | :------ |
| 拥有者账户 | string |

#### tokenOfOwnerByIndex(tokenSym, owner, index)
获取账户拥有的第index个代币

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| owner | 代币账户 | string |
| index | 代币index,整数 | number |

| 返回值 | 类型 |
| :----: | :------ |
| tokenID | string |

#### tokenMetadata(tokenSym, tokenID)
获取代币的meta数据

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| tokenSym | 代币标识符 | string |
| tokenID | 代币ID | string |

| 返回值 | 类型 |
| :----: | :------ |
| metaData | string |

