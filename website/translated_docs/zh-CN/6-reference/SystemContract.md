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

#### NewVote
创建投票。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票创建者账户名| string | 创建投票需要质押 1000 IOST，会从创建者账户扣除，创建者账户拥有投票的 admin 权限|
| 投票描述| string ||
| 投票设置| json 对象 |包含 5 个 key: <br>resultNumber —— number 类型，投票结果数量，最大为 2000;<br> minVote —— number 类型，最低得票数，得票数大于这个数量的候选者才能进入投票结果集合; <br>options —— 数组类型，候选者集合，每一项为字符串，代表一个候选者，初始可以传空 []; <br>anyOption —— bool 类型，是否允许投非 options 集合中的候选项，传 false 表示用户只能投 options 集合中的候选项; <br>freezeTime —— number 类型，取消投票后 token 冻结时间，单位秒;|
调用成功会返回全局唯一的投票 ID。

#### AddOption
增加投票选项。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 选项| string ||
| 是否清除以前得票数| bool ||

#### RemoveOption
删除投票选项，但保留得票结果，删除后，再通过 AddOption 添加该选项能选择是否恢复得票数。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 选项| string ||
| 是否强制删除| bool | false 表示当该选项在结果集中时不删除，true 表示强制删除并更新结果集|

#### GetOption
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

#### VoteFor
代别人投票，投票质押的 IOST 会从代理者账户扣除。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 代理者账户名| string ||
| 投票者账户名| string ||
| 选项 | string ||
| 投票数量 | string ||

#### Vote
投票。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 投票者账户名| string ||
| 选项 | string ||
| 投票数量 | string ||

#### Unvote
取消投票。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|
| 投票者账户名| string ||
| 选项 | string ||
| 投票数量 | string ||

#### GetVote
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

#### GetResult
获取投票结果，返回得票数前 resultNumber 的选项。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| 投票 ID| string | NewVote 接口返回的 ID|

返回结果为 json 数组，每一项为下面的对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| option| string | 选项 |
| votes| string | 投票数量 |

#### DelVote
删除投票，退换创建投票时质押的 IOST 到创建者账户。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| 投票 ID| string | NewVote 接口返回的 ID|
