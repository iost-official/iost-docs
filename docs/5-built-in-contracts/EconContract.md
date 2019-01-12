---
id: EconContract
title: Economic Contract
sidebar_label: Economic Contract
---

## gas.iost
---

GAS related contract, including pledging IOST for gas, unpleding, transferring GAS.      
Details of economic model are introduced on [GAS economic model](2-intro-of-iost/Economic-model.md#gas奖励)。

### Info
| contract_id | gas.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### pledge
pledge IOST for GAS. minimum pledging amount is 1 IOST.      
##### Example
\["user1","user1","100"\]：user1 pledge 100 IOSTs for himslef. So user1 costs 100 IOSTs, and obtains some GAS.   
\["user1","user2","100"\]：user1 pledge 100 IOSTs for user2. So user1 costs 100 IOSTs, and user2 obtains some GAS.

| Arg Meaning | Arg Type |
| :----: | :------ |
| who pledges IOST. Permission of this account is needed. | string |
| who gets GAS | string |
| IOST amount for pledging | string |

#### unpledge
undo pledge. IOST pledged earlier will be returned. minimum unpledging amount is 1 IOST.        
##### Example
\["user1","user1","100"\]：user1 unpledge 100 IOSTs from his earlier pledgement for himself.   
\["user1","user2","100"\]：user1 unpledge 100 IOSTs from his earlier pledgement for user2.

| Arg Meaning | Arg Type |
| :----: | :------ |
| who unpledge IOST. Permission of this account is needed. | string |
| unpledge IOST out of who's current pledgement | string |
| IOST amount for unpledging | string | 


#### transfer
transfer GAS. minimum transferring amount is 1 IOST.   
__Notice__: GAS obtained from pledgement cannot be transferred. Only `transferable GAS` can be transferred. Besides, `transferable GAS` after being transferred once will not be transferable any longer.      
You can obtain transferable GAS from [transferable gas reward](2-intro-of-iost/Economic-model.md#流通gas奖励)

##### Example
\["user1","user2","100"\]: user1 transfers 100 GAS to user2
 

| Arg Meaning | Arg Type |
| :----: | :------ |
| who transfers GAS. Permission of this account is needed. | string |
| who gets GAS| string |
| IOST amount for transferring | string |

## ram.iost
---
RAM related contract, including buying/selling/transferring.    
Details of economic model are introduced on [RAM economic model](2-intro-of-iost/Economic-model.md#资源).  
Buying/Selling RAM not too much, you can get price estimate in [RPC](6-reference/API.md#getraminfo). 

### Info
| contract_id | ram.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### buy
buy RAM from system. minimum buying amount is 10 bytes.        
contract will return IOST costed.  
##### Example
\["user1","user1",1024\]:  user1 buys 1024 bytes RAM for himself   
\["user1","user2",1024\]:  user1 buys 1024 bytes RAM for user2   

| Arg Meaning | Arg Type |
| :----: | :------ |
| who buys ram. Permission of this account is needed. | string |
| who gets the bought ram| string |
| RAM byte to buy | int |

#### sell
Sell unused RAM to system. minimum selling amount is 10 bytes.   
contract will return IOST returned.
##### Example
\["user1","user1",1024\]:  user1 sells unused 1024 bytes RAM to system, he himself gets IOST returned
。  
\["user1","user2",1024\]:  user1 sells unused 1024 bytes RAM to system, user2 gets IOST returned

| Arg Meaning | Arg Type |
| :----: | :------ |
| who sells RAM. Permission of this account is needed. | string |
| who gets IOST returned | string |
| RAM byte to sell | int |

#### lend
transfer RAM to others.      
Only RAM one `bought` can be transferred to others. So RAM others transferred to you cannot be sold to system nor transferred to others.      
minimum transferring amount is 10 bytes.   
##### Example
\["user1","user2",1024\]: user1 transfers unused 1024 buytes RAM to user2

| Arg Meaning | Arg Type |
| :----: | :------ |
| who transfers RAM. Permission of this account is needed. | string |
| who gets transferred RAM| string |
| RAM byte to transfer | int |


