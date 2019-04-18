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
| version | 1.0.6 |

### 接口描述

#### applyRegister(applicant, pubkey, location, url, netid, isProducer)
申请注册成为节点候选人。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------|
| applicant | string |申请者账户名， **调用此接口需要该账户的 "vote" 权限** |
| pubkey | string | 节点公钥，出块节点用于签名区块的私钥的对应公钥，base58 编码；非出块节点本参数可以传任意值|
| location | string | 团队地理位置 |
| url | string | 团队主页 |
| netid | string |出块节点的 networkid；非出块节点不需要传本参数|
| isProducer | bool | 是否成为出块节点 |

#### applyUnregister(applicant)
申请取消注册。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| applicant | string | 申请者账户名，**调用此接口需要该账户的 "vote" 权限** |


#### unregister(applicant)
取消注册，如果你是一个已经通过审核的造块节点，需要先调用 ApplyUnregister，审核通过后，才可调用本接口。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| applicant  | string |申请者账户名，**调用此接口需要该账户的 "vote" 权限** |

#### updateProducer(account, pubkey, location, url, netid)
更新注册信息。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| account | string | 账户名，**调用此接口需要该账户的 "vote" 权限** |
| pubkey | string | 节点公钥，出块节点用于签名区块的私钥的对应公钥，base58 编码；非出块节点本参数可以传任意值|
| location | string | 团队地理位置 |
| url | string | 团队主页 |
| netid | string |出块节点的 networkid；非出块节点不需要传本参数|

#### logInProducer(account)
上线，表示本节点目前可以提供服务。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| account | string |节点账户名，**调用此接口需要该账户的 "vote" 权限** |

#### logOutProducer(account)
离线，表示本节点目前无法提供服务。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| account | string |节点账户名，**调用此接口需要该账户的 "vote" 权限** |

#### vote(voter, nodeAccount, amount)
投票。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| voter | string |投票者账户名，**调用此接口需要该账户的 "active" 权限**|
| nodeAccount | string | 节点账户名 |
| amount | string | 投票数量 |

#### unvote(voter, nodeAccount, amount)
取消投票。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| voter | string |投票者账户名，**调用此接口需要该账户的 "active" 权限**|
| nodeAccount | string | 节点账户名 |
| amount | string | 投票数量 |

#### voterWithdraw(voter)
投票者领取分红奖励。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| voter | string |投票者账户名，**调用此接口需要该账户的 "operate" 权限**|

#### candidateWithdraw(candidate)
竞选者领取分红奖励。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| candidate | string |竞选者账户名，**调用此接口需要该账户的 "operate" 权限**|

#### getVoterBonus(voter)
计算投票者的分红奖励。

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:----|
| voter | string |投票者账户名|

#### getCandidateBonus(candidate)
计算竞选者的分红奖励。

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| candidate | string |竞选者账户名|

#### topupCandidateBonus(amount, payer)
向节点奖励池充值 iost。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| amount | string | 充值金额 |
| payer | string |付款账户名，**调用此接口需要该账户的 "transfer" 权限**|


#### topupVoterBonus(candidate, amount, payer)
向投票者奖励池充值 iost。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| candidate | string | 竞选者账户名 |
| amount | string | 充值金额 |
| payer | string |付款账户名，**调用此接口需要该账户的 "transfer" 权限**|

## vote.iost
---

### 简介
通用投票合约，用于创建投票、收集投票、统计投票。可以基于本合约实现你自己想要的投票功能。

### 基础信息
| contract_id | vote.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.1 |

### 接口描述

#### newVote(owner, description, config)
创建投票。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| owner | string | 投票创建者，创建投票需要质押 1000 IOST，会从创建者账户扣除，**调用此接口需要该账户的 "active" 权限**|
| description | string |投票描述|
| config| json 对象 |投票设置，包含 6 个 key: <br>resultNumber —— number 类型，投票结果数量，最大为 2000;<br> minVote —— number 类型，最低得票数，得票数大于这个数量的候选者才能进入投票结果集合; <br>options —— 数组类型，候选者集合，每一项为字符串，代表一个候选者，初始可以传空 []; <br>anyOption —— bool 类型，是否允许投非 options 集合中的候选项，传 false 表示用户只能投 options 集合中的候选项; <br>freezeTime —— number 类型，取消投票后 token 冻结时间，单位秒; <br> canVote —— bool 类型，是否允许非投票创建者投票；|
调用成功会返回全局唯一的投票 ID。

#### setCanVote(voteID, canVote)
设置是否允许非投票创建者投票。

`调用此接口需要合约创建者的 "active" 权限。`

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| canVote | bool |是否允许非投票创建者投票|


#### addOption(voteID, option, clearVotes)
增加投票选项。

`调用此接口需要合约创建者的 "active" 权限。`

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| option | string |选项|
| clearVotes | bool |是否清除以前得票数|

#### removeOption(voteID, option, forceDelete)
删除投票选项，但保留得票结果，删除后，再通过 AddOption 添加该选项能选择是否恢复得票数。

`调用此接口需要合约创建者的 "active" 权限。`

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| option | string |选项|
| forceDelete | bool | 是否强制删除，false 表示当该选项在结果集中时不删除，true 表示强制删除并更新结果集|

#### getOption(voteID, option)
获取候选项的得票情况。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| option | string |选项|

返回结果为 json 对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| votes| string | 得票数|
| deleted| bool | 是否被标记为删除 |
| clearTime| number | 票数上次被清零的区块号 |

#### voteFor(voteID, payer, voter, option, amount)
代别人投票，投票质押的 IOST 会从代理者账户扣除。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| payer | string |代理者账户名，**调用此接口需要该账户的 "active" 权限**|
| voter| string |投票者账户名|
| option | string |选项|
| amount | string |投票数量|

#### vote(voteID, voter, option, amount)
投票。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| voter | string |投票者账户名，**调用此接口需要该账户的 "active" 权限**|
| option | string |选项|
| amount | string |投票数量|

#### unvote(voteID, voter, option, amount)
取消投票。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| voter | string |投票者账户名，**调用此接口需要该账户的 "active" 权限**|
| option | string |选项|
| amount | string |投票数量|

#### getVote(voteID, voter)
获取某账户投票记录。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|
| voter | string | 投票者账户名 |

返回结果为 json 数组，每一项为下面的对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| option| string | 选项 |
| votes| string | 投票数量 |
| voteTime| number | 上次投票的区块号 |
| clearedVotes| string | 被清零的投票数量 |

#### getResult(voteID)
获取投票结果，返回得票数前 resultNumber 的选项。

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|

返回结果为 json 数组，每一项为下面的对象：

| key | 类型 | 备注 |
| :----: | :------ | :------ |
| option| string | 选项 |
| votes| string | 投票数量 |

#### delVote(voteID)
删除投票，退换创建投票时质押的 IOST 到创建者账户。

`调用此接口需要合约创建者的 "active" 权限。`

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ | :------ |
| voteID | string | 投票 ID，NewVote 接口返回的 ID|

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

#### signUp(accountName, ownerKey, activeKey)
创建账号

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| accountName | string | 账户名，长度为 5-11 位的字符串，字符只能包含 [a-z0-9_]|
| ownerKey | string |owner 权限的公钥，base58 编码|
| activeKey | string |active 权限的公钥，base58 编码|

#### addPermission(account, permission, weight)
向账号添加权限

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| permission | string |权限名|
| weight | number |权限阈值|

#### dropPermission(account, permission)
删除权限

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| permission | string |权限名|

#### assignPermission(account, permission, item, weight)
指定权限。

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| permission | string |权限名|
| item | string | 权限拥有者，可以为公钥，或者为另一个账户 |
| weight| number |权重|


#### revokePermission(account, permission, item)
撤销权限。

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| permission | string |权限名|
| item | string | 权限拥有者，可以为公钥，或者为另一个账户 |

#### addGroup(account, group)
添加权限组

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| group | string | 组名 |

#### dropGroup(account, group)
删除权限组

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| group | string | 组名 |

#### assignGroup(account, group, item, weight)
指定item给权限组

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| group | string | 组名 |
| item | string | 权限拥有者，可以为公钥，或者为另一个账户 |
| weight| number |权重|

#### revokeGroup(account, group, item)
撤销权限组的item

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| group | string | 组名 |
| item | string | 权限拥有者，可以为公钥，或者为另一个账户 |


#### assignPermissionToGroup(account, permission, group)
添加权限到组

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| permission | string | 权限名 |
| group | string | 组名 |


#### revokePermissionInGroup(account, permission, group)
删除组中的权限

| 参数列表 | 参数类型 |备注|
| :----: | :------ |:------ |
| account | string |用户名，**调用此接口需要该账户的 "owner" 权限**|
| permission | string | 权限名 |
| group | string | 组名 |


## bonus.iost
---

### 简介

正式节点造块奖励管理

### 基础信息

| contract_id | bonus.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.2 |

### 接口描述

#### exchangeIOST(account, amount)

使用贡献值兑换 IOST

| 参数列表 | 参数类型 | 备注|
| :----: | :------ |:------ |
| account | string |账户名，**调用此接口需要该账户的 "active" 权限**|
| amount | string | 兑换数量，"0" 为兑换全部|


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

| 参数名称 | 参数类型 | 备注|
| :----: | :------ |:------ |
| code | string |智能合约代码|

| 返回值 | 返回值类型 |
| :----: | :------ |
| contractID | string |

智能合约代码中包括代码和智能合约信息, 如语言和接口定义, code 参数支持两种格式:  json 格式和 protobuf 序列化的编码格式
对于开发者来说, 部署合约一般不需要直接调用该接口, 建议使用 iwallet 或相关语言的SDK实现。

部署智能合约时,系统会自动调用智能合约的 init() 函数,开发者可以在 init() 函数中做一些初始化工作.

返回值 contractID 是智能合约 ID, 全局唯一, 由部署合约交易的 hash 生成,以Contract 开头包含大小写字母和数字, 一个交易中只能部署一个智能合约。

#### updateCode (code, data)
升级智能合约.

| 参数名称 |  参数类型 | 备注 |
| :----: | :----: | :------ |
| code | string | 智能合约代码 |
| data | string | 升级函数参数 |


升级智能合约, code 为智能合约代码, 格式与 setCode 中参数格式相同.

升级智能合约时, 系统会自动检查升级权限, 即调用合约中的 can\_update(data) 函数, 参数 data 即为 updateCode 中的第二个参数, 当且仅当 can\_update 函数存在且调用返回结果为 true 时,
合约升级才会成功, 否则升级失败, 判定为没有升级权限.

#### cancelDelaytx (txHash)
取消延迟交易, 在延迟交易执行前调用该函数可以取消延迟交易.

| 参数名称 | 参数类型 | 备注 | 
| :----: | :----: | :------ |
| txHash | string | 交易 hash |


#### requireAuth (acc, permission)
检查该交易是否有acc账户的permission权限签名.

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| acc | string | 账户名 |
| permission | string | 权限名 |

| 返回值 | 类型 |
| :----: | :------ |
| ok | bool |

#### receipt (data)
生成交易收据, 收据存放在 block 中, 也可通过交易 hash 查询到.

| 参数名称 |  参数类型 | 备注 |
| :----: | :----: | :------ |
| data | string | 收据内容 |

## exchange.iost
---

### 简介

主要用于封装创建账户并转账功能, 也可用于向已存在账户转账

### 基础信息

| contract_id | exchange.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### transfer(tokenSym, to, amount, memo)

创建账户并转账接口

| 参数名称 | 参数类型 | 备注 |
| :----: | :----: | :------ |
| tokenSym | string | 代币标识符 |
| to |  string | 代币接收账户，若要创建账户则填空 |
| amount | string | 转账金额 |
| memo | string | 附加信息, 若要创建账户则格式应为 create:账户名:owner公钥:active公钥 |


创建帐号时要求转账金额至少为 100 iost，默认会帮新创建的帐号质押 10 iost 的gas, 并且购买 1K bytes 的 ram, 剩余的金额会转入新创建的账户
