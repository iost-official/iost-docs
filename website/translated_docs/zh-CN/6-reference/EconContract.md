---
id: EconContract
title: Econ Contract
sidebar_label: Econ Contract
---

## gas.iost
---

### 简介
质押获取 GAS 相关的合约。包括质押 IOST 获得 GAS，取消质押，转让 GAS。   
具体经济模型细节可以参考 [GAS经济模型](2-intro-of-iost/Economic-model.md#gas奖励)。

### 基础信息
| contract_id | gas.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### 接口描述

#### pledge(pledgor, to, amount)
质押 iost 获得 gas。最小质押数量为 1 iost。     
##### 举例
\["user1", "user1", "100"\]：user1 给自己质押 100 iost。user1 减少 100 个 iost，并获得 gas。   
\["user1", "user2", "100"\]：user1 给 user2 质押 100 iost。user1 减少 100 个 iost，user2 获得 gas。

| 参数列表 | 参数类型 | 备注 | 
| :----: | :------ | :------ |
| pledgor | string | 质押 iost 的账户。**调用此接口需要该账户的 "transfer" 权限** |
| to | string | 获得 gas 的账户 |
| amount | string |质押 iost 的数量 |

#### unpledge(pledgor, to, amount)
取消质押，返还 iost。最小取消质押数量为 1 iost。      
##### 举例
\["user1", "user1", "100"\]：user1 从之前给自己质押的 iost 中，赎回 100 iost。   
\["user1", "user2", "100"\]：user1 从之前给 user2 质押的 iost 中，赎回 100 iost。

| 参数列表 | 参数类型 | 备注 | 
| :----: | :------ | :------ |
| pledgor | string | 质押 iost 的账户。**调用此接口需要该账户的 "transfer" 权限** |
| to | string | 获得 gas 的账户 |
| amount | string | 质押 iost 的数量 |


<!--#### transfer
转让 GAS。最小转让单位为 100 GAS。   
注意，质押获得的 GAS 不能转让。只有流通 GAS 才可以转让。流通 GAS 转让一次后，不再可流通。   
流通 GAS 的获得方法见 [流通gas奖励](2-intro-of-iost/Economic-model.md#流通gas奖励)

##### 举例
\["user1","user2","100"\]: user1 把自己的 100 个流通 GAS 转让给 user2。
 

| 参数列表 | 参数类型 |
| :----: | :------ |
| 转让出 GAS 的账户。合约需要本账号权限 | string |
| 接收 GAS 的账户| string |
| 转让 GAS 的数量 | string |-->

## ram.iost
---
### 简介
ram 相关的系统合约。包括 ram 买卖，ram 转让。   
具体经济模型细节可以参考 [RAM经济模型](2-intro-of-iost/Economic-model.md#资源)。   
买卖少量 ram 时，用户可以使用 [RPC 中的接口](6-reference/API.md#getraminfo) 来估算最终的价格。 

### 基础信息
| contract_id | ram.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### buy(payer, receiver, amount)
向系统购买 ram。最小购买数量 10 bytes。   
合约返回值为花费的 iost 数量。
##### 举例
\["user1","user1",1024\]:  user1 给自己购买 1024 bytes 的 ram   
\["user1","user2",1024\]:  user1 给 user2 购买 1024 bytes 的 ram

| 参数列表 | 参数类型 | 备注|
| :----: | :------ |:------ |
| payer | string |购买时支付的账号。**调用此接口需要该账户的 "transfer" 权限** |
| receiver | string |获得 ram 的账户|
| amount | int | 购买 RAM 的数量，单位 byte | 

#### sell(account, receiver, amount)
向系统出售未使用 RAM。最小出售数量 10 bytes。  
合约返回值为出售得到的 iost 数量。
##### 举例
\["user1","user1",1024\]:  user1 从自己之前购买但未使用的 ram 中出售 1024 bytes 给系统，自己获得出售得到的 iost
。  
\["user1","user2",1024\]:  user1 从自己之前购买但未使用的 ram 中出售 1024 bytes 给系统，user2 获得出售得到的 iost

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| account | string | 出售 ram 的账号。**调用此接口需要该账户的 "transfer" 权限** |
| receiver | string | 接收出售所得的账号 |
| amount | int | 出售 ram 的数量，单位 byte |

#### lend(from, to, amount)
转让 ra,。    
只有自己购买的 ram 才可以转让给其他账户。转让来的 ram，不得二次转让出去或者卖回给系统。   
最小转让数量 10 bytes。  
##### 举例
\["user1","user2",1024\]: user1 从自己之前购买但未使用的 ram 中转让 1024 bytes 给  user2

| 参数列表 | 参数类型 | 备注 |
| :----: | :------ |:------ |
| from | string | 转让出 ram 的账户。**调用此接口需要该账户的 "transfer" 权限** |
| to | string | 接收 ram 的账户|
| amount | int | 转让 ram 的数量 |


