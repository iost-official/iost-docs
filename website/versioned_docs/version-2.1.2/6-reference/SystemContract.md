---
id: version-2.1.2-SystemContract
title: System Contract
sidebar_label: System Contract
original_id: SystemContract
---

## vote_producer.iost
---

### 简介
超级节点竞选投票合约。

### 基础信息
| contract_id | vote_producer.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### ApplyRegister
申请注册成为超级节点候选人。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
| 公钥base58编码 | string |
| 地理位置| string |
| 网站 url | string |
| 网络 id | string |

#### ApplyUnregister
申请取消注册。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |


#### Unregister
取消注册，需要先调用 ApplyUnregister，审核通过后，才可调用本接口。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |

#### UpdateProducer
更新注册信息。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
| 公钥base58编码 | string |
| 地理位置| string |
| 网站 url | string |
| 网络 id | string |

#### LogInProducer
上线，表示本节点目前可以提供服务。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |

#### LogOutProducer
离线，表示本节点目前无法提供服务。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
