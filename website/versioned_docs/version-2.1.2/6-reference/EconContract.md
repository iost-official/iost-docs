---
id: version-2.1.2-EconContract
title: Econ Contract
sidebar_label: Econ Contract
original_id: EconContract
---

## gas.iost
---

### 简介
质押获取 GAS 相关的合约。包括质押 IOST 获得 GAS，取消质押，转让 GAS。   
具体经济模型细节可以参考 [GAS经济模型](../2-intro-of-iost/Economic-model/#gas奖励)。

### 基础信息
| contract_id | gas.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### 接口描述

#### pledge
质押 IOST 获得 GAS。最小质押数量为 1 IOST。     
##### 举例
\["user1","user1","100"\]：user1 给自己质押 100 IOST。user1 减少 100 个 IOST，并获得 GAS。   
\["user1","user2","100"\]：user1 给 user2 质押 100 IOST。user1 减少 100 个 IOST，user2 获得 GAS。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 质押 IOST 的账户。合约需要本账号权限 | string |
| 获得 GAS 的账户 | string |
| 质押 IOST 的数量 | string |

#### unpledge
取消质押，返还 IOST。最小取消质押数量为 1 IOST。      
##### 举例
\["user1","user1","100"\]：user1 从之前给自己质押的 IOST 中，赎回 100 IOST。
\["user1","user2","100"\]：user1 从之前给 user2 质押的 IOST 中，赎回 100 IOST。

| 参数列表 | 参数类型 |
| :----: | :------ |
| 取消质押的账户。 合约需要本账号权限| string |
| 获得 GAS 的账户 | string |
| 赎回 IOST 的数量 | string | 


#### transfer
转让 GAS。最小转让单位为 100 GAS。   
注意，质押获得的 GAS 不能转让。只有流通 GAS 才可以转让。流通 GAS 转让一次后，不再可流通。   
流通 GAS 的获得方法见 [流通gas奖励](../Economic-model/#流通gas奖励)

##### 举例
\["user1","user2","100"\]: user1 把自己的 100 个流通 GAS 转让给 user2。
 

| 参数列表 | 参数类型 |
| :----: | :------ |
| 转让出 GAS 的账户。合约需要本账号权限 | string |
| 接收 GAS 的账户| string |
| 转让 GAS 的数量 | string |

## ram.iost
---
### 简介
RAM相关的系统合约。包括 RAM 买卖，RAM 转让。   
具体经济模型细节可以参考 [RAM经济模型](../Economic-model/#资源)。
买卖少量 RAM 时，用户可以使用 [RPC 中的接口](../6-reference/API/#getraminfo) 来估算最终的价格。 

### 基础信息
| contract_id | ram.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### 接口描述

#### buy
向系统购买 RAM。最小购买数量 10 bytes。   
合约返回值为花费的 IOST 数量。
##### 举例
\["user1","user1",1024\]:  user1 给自己购买 1024 bytes 的 RAM
\["user1","user2",1024\]:  user1 给 user2 购买 1024 bytes 的 RAM

| 参数列表 | 参数类型 |
| :----: | :------ |
| 购买时支付的账号。合约需要本账号权限 | string |
| 获得 RAM 的账户| string |
| 购买 RAM 的数量，单位 byte | int |

#### sell
向系统出售未使用 RAM。最小购买数量 10 bytes。  
合约返回值为出售得到的 IOST 数量。
##### 举例
\["user1","user1",1024\]:  user1 从自己之前购买但未使用的 RAM 中出售 1024 bytes 给系统，自己获得出售得到的 IOST
。  
\["user1","user2",1024\]:  user1 从自己之前购买但未使用的 RAM 中出售 1024 bytes 给系统，user2 获得出售得到的 IOST

| 参数列表 | 参数类型 |
| :----: | :------ |
| 出售 RAM 的账号。合约需要本账号权限 | string |
| 接收出售价的账号 | string |
| 出售 RAM 的数量，单位 byte | int |

#### lend
转让 RAM。    
只有自己购买的 RAM 才可以转让给其他账户。转让来的 RAM，不得二次转让出去或者卖回给系统。   
最小转让数量 10 bytes。  
##### 举例
\["user1","user2",1024\]: user1 从自己之前购买但未使用的 RAM 中转让 1024 bytes 给  user2

| 参数列表 | 参数类型 |
| :----: | :------ |
| 转让出 RAM 的账户。合约需要本账号权限 | string |
| 接收 RAM 的账户| string |
| 转让 RAM 的数量 | int |


