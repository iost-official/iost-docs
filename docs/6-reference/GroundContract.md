---
id: GroundContract
title: Ground Contract
sidebar_label: Ground Contract
---

## system.iost

---

### 简介
基础系统合约,用于发行更新合约以及其他基本系统函数.

### 基础信息
| contract_id | system.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### 接口描述

#### SetCode (code)
部署智能合约.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| code | 智能合约代码 | string |

| 返回值 | 返回值类型 |
| :----: | :------ |
| contractID | string |

智能合约代码中包括代码和智能合约信息, 如语言和接口定义, code参数支持两种格式: json格式和protobuf序列化的编码格式
对于开发者来说, 部署合约一般不需要直接调用该接口, 建议使用iwallet或相关语言的SDK实现

部署智能合约时,系统会自动调用智能合约的init()函数,开发者可以在init函数中做一些初始化工作.

返回值 contractID 是智能合约ID, 全局唯一, 由部署合约交易的hash生成,以Contract开头包含大小写字母和数字, 一个交易中只能部署一个智能合约

#### UpdateCode (code, data)
升级智能合约.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| code | 智能合约代码 | string |
| data | 升级函数参数 | string |

| 返回值 | 无 |
| :----: | :------ |

升级智能合约, code为智能合约代码, 格式与 SetCode 中参数格式相同.

升级智能合约时, 系统会自动检查升级权限, 即调用合约中的can_update(data)函数, 参数data即为UpdateCode中的第二个参数, 当且仅当can_update函数存在且调用返回结果为true时,
合约升级才会成功, 否则升级失败,判定为没有升级权限.

#### CancelDelaytx (txHash)
取消延迟交易, 在延迟交易执行前调用该函数可以取消延迟交易.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| txHash | 交易hash | string |

| 返回值 | 无 |
| :----: | :------ |

#### RequireAuth (acc, permission)
检查该交易是否有acc账户的permission权限签名.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| acc | 账户名 | string |
| permission | 权限名 | string |

| 返回值 | 类型 |
| :----: | :------ |
| ok | bool |

#### Receipt (data)
生成交易收据, 收据存放在block中, 也可通过交易hash查询到.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| data | 收据内容 | string |

| 返回值 | 无 |
| :----: | :------ |
