---
id: SystemContract
title: System Contract
sidebar_label: System Contract
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

#### VoteFor
代别人投票，投票质押的 IOST 会从代理者账户扣除。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 代理者账户名| string |
| 投票者账户名| string |
| 竞选者账户名 | string |
| 投票数量 | string |

#### Vote
投票。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 投票者账户名| string |
| 竞选者账户名 | string |
| 投票数量 | string |

#### Unvote
取消投票。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 投票者账户名| string |
| 竞选者账户名 | string |
| 投票数量 | string |

#### VoterWithdraw
投票者领取分红奖励。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 投票者账户名| string |

#### CandidateWithdraw
竞选者领取分红奖励。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 竞选者账户名| string |


## auth.iost
---

### 简介
账号系统和权限管理

### 基础信息
| contract_id | auth.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### SignUp
创建账号

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| ownerKey | string |
| activeKey | string |

#### AddPermission
向账号添加权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string | 
| 权限名 | string |
| 权限阈值 | number |

#### DropPermission
删除权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限名 | string |

#### AssignPermission
指定权限给item

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限 | string |
| item | string |
| 权重 | number |


#### RevokePermission
撤销权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限 | string |
| item | string |

#### AddGroup
添加权限组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |

#### DropPermission
删除权限组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |

#### AssignGroup
指定item给权限组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |
| item | string |
| 权重 | number |

#### RevokeGroup
撤销权限组的item

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |
| item | string |


#### AssignPermissionToGroup
添加权限到组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限名 | string |
| 组名 | string |


#### RevokePermissionInGroup
删除组中的权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限名 | string |
| 组名 | string |


## bonus.iost

---

### 简介

正式节点造块奖励管理

### 基础信息

| contract_id | bonus.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### IssueContribute

发放贡献值，系统自动调用

| 参数列表 | 参数类型 |
| :----: | :------ |
| data | json |

#### ExchangeIOST

使用贡献值兑换IOST

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
| 数量 | string |
