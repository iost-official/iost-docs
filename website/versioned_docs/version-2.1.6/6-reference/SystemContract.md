---
id: version-2.1.6-SystemContract
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

#### applyRegister
申请注册成为超级节点候选人。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
| 公钥base58编码 | string |
| 地理位置| string |
| 网站 url | string |
| 网络 id | string |

#### applyUnregister
申请取消注册。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |


#### unregister
取消注册，需要先调用 ApplyUnregister，审核通过后，才可调用本接口。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |

#### updateProducer
更新注册信息。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
| 公钥base58编码 | string |
| 地理位置| string |
| 网站 url | string |
| 网络 id | string |

#### logInProducer
上线，表示本节点目前可以提供服务。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |

#### logOutProducer
离线，表示本节点目前无法提供服务。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |

#### voteFor
代别人投票，投票质押的 IOST 会从代理者账户扣除。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 代理者账户名| string |
| 投票者账户名| string |
| 竞选者账户名 | string |
| 投票数量 | string |

#### vote
投票。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 投票者账户名| string |
| 竞选者账户名 | string |
| 投票数量 | string |

#### unvote
取消投票。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 投票者账户名| string |
| 竞选者账户名 | string |
| 投票数量 | string |

#### voterWithdraw
投票者领取分红奖励。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 投票者账户名| string |

#### candidateWithdraw
竞选者领取分红奖励。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 竞选者账户名| string |

## vote.iost
---

### 简介
通用投票合约，用于创建投票、收集投票、统计投票。可以基于本合约实现你自己想要的投票功能。

### 基础信息
| contract_id | vote.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### newVote
创建投票。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票创建者账户名| string | 创建投票需要质押 1000 IOST，会从创建者账户扣除，创建者账户拥有投票的 admin 权限|
| 投票描述| string ||
| 投票设置| json 对象 |包含 5 个 key: <br>resultNumber —— number 类型，投票结果数量，最大为 2000;<br> minVote —— number 类型，最低得票数，得票数大于这个数量的候选者才能进入投票结果集合; <br>options —— 数组类型，候选者集合，每一项为字符串，代表一个候选者，初始可以传空 []; <br>anyOption —— bool 类型，是否允许投非 options 集合中的候选项，传 false 表示用户只能投 options 集合中的候选项; <br>freezeTime —— number 类型，取消投票后 token 冻结时间，单位秒;|
调用成功会返回全局唯一的投票 ID。

#### addOption
增加投票选项。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 选项| string ||
| 是否清除以前得票数| bool ||

#### removeOption
删除投票选项，但保留得票结果，删除后，再通过 AddOption 添加该选项能选择是否恢复得票数。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 选项| string ||
| 是否强制删除| bool | false 表示当该选项在结果集中时不删除，true 表示强制删除并更新结果集|

#### getOption
获取候选项的得票情况。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 选项| string ||

返回结果为 json 对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| votes| string | 得票数|
| deleted| bool | 是否被标记为删除 |
| clearTime| number | 票数上次被清零的区块号 |

#### voteFor
代别人投票，投票质押的 IOST 会从代理者账户扣除。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 代理者账户名| string ||
| 投票者账户名| string ||
| 选项 | string ||
| 投票数量 | string ||

#### vote
投票。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 投票者账户名| string ||
| 选项 | string ||
| 投票数量 | string ||

#### unvote
取消投票。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 投票者账户名| string ||
| 选项 | string ||
| 投票数量 | string ||

#### getVote
获取某账户投票记录。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 投票者账户名| string ||

返回结果为 json 数组，每一项为下面的对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| option| string | 选项 |
| votes| string | 投票数量 |
| voteTime| number | 上次投票的区块号 |
| clearedVotes| string | 被清零的投票数量 |

#### getResult
获取投票结果，返回得票数前 resultNumber 的选项。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|

返回结果为 json 数组，每一项为下面的对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| option| string | 选项 |
| votes| string | 投票数量 |

#### delVote
删除投票，退换创建投票时质押的 IOST 到创建者账户。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|

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

#### signUp
创建账号

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| ownerKey | string |
| activeKey | string |

#### addPermission
向账号添加权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string | 
| 权限名 | string |
| 权限阈值 | number |

#### dropPermission
删除权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限名 | string |

#### assignPermission
指定权限给item

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限 | string |
| item | string |
| 权重 | number |


#### revokePermission
撤销权限

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限 | string |
| item | string |

#### addGroup
添加权限组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |

#### dropPermission
删除权限组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |

#### assignGroup
指定item给权限组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |
| item | string |
| 权重 | number |

#### revokeGroup
撤销权限组的item

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 组名 | string |
| item | string |


#### assignPermissionToGroup
添加权限到组

| 参数列表 | 参数类型 |
| :----: | :------ |
| 用户名 | string |
| 权限名 | string |
| 组名 | string |


#### revokePermissionInGroup
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

#### issueContribute

发放贡献值，系统自动调用

| 参数列表 | 参数类型 |
| :----: | :------ |
| data | json |

#### exchangeIOST

使用贡献值兑换IOST

| 参数列表 | 参数类型 |
| :----: | :------ |
| 账户名 | string |
| 数量 | string |


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

#### setCode (code)
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

#### updateCode (code, data)
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

#### cancelDelaytx (txHash)
取消延迟交易, 在延迟交易执行前调用该函数可以取消延迟交易.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| txHash | 交易hash | string |

| 返回值 | 无 |
| :----: | :------ |

#### requireAuth (acc, permission)
检查该交易是否有acc账户的permission权限签名.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| acc | 账户名 | string |
| permission | 权限名 | string |

| 返回值 | 类型 |
| :----: | :------ |
| ok | bool |

#### receipt (data)
生成交易收据, 收据存放在block中, 也可通过交易hash查询到.

| 参数名称 | 参数描述 | 参数类型 |
| :----: | :----: | :------ |
| data | 收据内容 | string |

| 返回值 | 无 |
| :----: | :------ |
