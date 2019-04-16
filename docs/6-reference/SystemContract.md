---
id: SystemContract
title: System Contract
sidebar_label: System Contract
---

## vote_producer.iost
---

### Description
The Super Node campaigns for voting.

### Info
| contract_id | vote_producer.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.6 |

### API

#### applyRegister(applicant, pubkey, location, url, netid, isProducer)
Apply for registration to become a node candidate.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| applicant | string | The applicant account name. **Calling this interface requires this account's "vote" permission**|
| pubkey | string | Node public key, encoding with base58. The corresponding seckey of this pubkey is used to sign blocks by block producer node. The partner node can pass any value to this parameter.|
| location | string | The team location |
| url | string | The team homepage |
| netid | string | The network id of block producer node.  The partner node doesn't need to pass this parameter. |
| isProducer | bool | Whether it's a block producer node.|

#### applyUnregister(applicant)
Apply for cancellation.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| applicant | string | The applicant account name. **Calling this interface requires this account's "vote" permission**|


#### unregister(applicant)
Cancel the registration. If you are an approved producer node, you need to call ApplyUnregister first, after the audit is passed, you can call this interface.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| applicant | string | The applicant account name. **Calling this interface requires this account's "vote" permission**|

#### updateProducer(account, pubkey, location, url, netid)
Update registration information.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| applicant | string | The applicant account name. **Calling this interface requires this account's "vote" permission**|
| pubkey | string | Node public key, encoding with base58. The corresponding seckey of this pubkey is used to sign blocks by block producer node. The partner node can pass any value to this parameter.|
| location | string | The team location |
| url | string | The team homepage |
| netid | string | The network id of block producer node.  The partner node doesn't need to pass this parameter. |

#### logInProducer(account)
Go online, indicating that the node is currently available for service.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| account | string | The applicant account name. **Calling this interface requires this account's "vote" permission**|

#### logOutProducer(account)
Offline means that the node is currently unable to provide services.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| account | string | The applicant account name. **Calling this interface requires this account's "vote" permission**|

#### vote(voter, nodeAccount, amount)
vote for a node.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| voter | string | Voter account name. **Calling this interface requires this account's "active" permission** |
| nodeAccount | string | Node account name. |
| amount | string | Amount of votes |

#### unvote(voter, nodeAccount, amount)
Cancel the vote.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| voter | string | Voter account name. **Calling this interface requires this account's "active" permission** |
| nodeAccount | string | Node account name. |
| amount | string | Amount of votes |

#### voterWithdraw(voter)
Voters receive bonus awards.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| voter | string | Voter account name. **Calling this interface requires this account's "operate" permission** |

#### candidateWithdraw(candidate)
The contestant receives a bonus award.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| candidate | string | Candidate account name. **Calling this interface requires this account's "operate" permission** |

#### getVoterBonus(voter)
Calculate voter's available bonus awards.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| voter | string | Voter account name. |

#### getCandidateBonus(candidate)
Calculate contestant's available bonus award.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| candidate | string | Candidate account name. |

#### topupCandidateBonus(amount, payer)
Recharge iost to candidates' bonus pool.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| amount | string | The recharge amount. |
| payer | string | The payer account name.  **Calling this interface requires this account's "transfer" permission** |

#### topupVoterBonus(candidate, amount, payer)
Recharge iost to voters' bonus pool.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------|
| candidate | string | Candidate account name. |
| amount | string | The recharge amount. |
| payer | string | The payer account name. **Calling this interface requires this account's "transfer" permission** |


## vote.iost
---

### Description
A universal voting contract used to create votes, collect votes, and vote on statistics. You can implement your own voting function based on this contract.

### Info
| contract_id | vote.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.1 |

### API

#### newVote(owner, description, config)
Create a vote.

| Parameter List | Parameter Type | Remark |
| :----: | :------ | :------ |
| owner | string | The vote creator account name. Creating a vote requires pledge 1000 IOST, which will be deducted from the creator account. **Calling this interface requires this account's "transfer" permission** |
| description | string | Vote Description |
| config | json object | The vote configuration. It contains 6 keys: <br>resultNumber —— number type, number of voting results, maximum 2000; <br> minVote —— number type, minimum number of votes, candidates with more votes than this number In order to enter the voting result set; <br>options —— array type, candidate set, each item is a string, represents a candidate, the initial can be empty []; <br>anyOption —— bool type, whether to allow The candidate in the non-options collection, passing false means that the user can only cast candidates in the options collection; <br>freezeTime —— number type, cancel the token freeze time, in seconds;<br>canVote —— bool type, whether use who isn't voter creator is allowed to vote| 
A successful call returns a globally unique vote ID.

#### setCanVote(voteID, canVote)
Set whether use who isn't voter creator is allowed to vote.

`Calling this interface requires the vote creator's "active" permission.`

| Parameter List | Parameter Type | Remark |
| :----: | :------ | :------ |
| voteID| string | ID returned by the NewVote interface|
| canVote | bool | Whether use who isn't voter creator is allowed to vote.|

#### addOption(voteID, option, clearVotes)
Increase voting options.

`Calling this interface requires the vote creator's "active" permission.`

| Parameter List | Parameter Type | Remark |
| :----: | :------ | :------ |
| voteID| string | ID returned by the NewVote interface|
| option | string | Option |
| clearVotes | bool | Whether to clear the previous votes |

#### removeOption(voteID, option, forceDelete)
Delete the voting option, but retain the result of the vote, delete it, and then add this option through AddOption to choose whether to restore the number of votes.

`Calling this interface requires the vote creator's "active" permission.`

| Parameter List | Parameter Type | Remark |
| :----: | :------ | :------ |
| voteID| string | ID returned by the NewVote interface|
| option | string | Option |
| forceDelete | bool | Whether to force delete, false means that the option is not deleted when it is in the result set, true means to force delete and update the result set |

#### getOption(voteID, option)
Get the votes for the candidate.

| Parameter List | Parameter Type | Remark |
| :----: | :------ | :------ |
| voteID| string | ID returned by the NewVote interface|
| option | string | Option |

The result is a json object:

| key | type | notes |
| :----: | :------ | :------ |
| votes| string | Votes |
| deleted| bool | Is it marked as deleted |
| clearTime| number | The block number where the number of votes was last cleared |

#### voteFor(voteID, payer, voter, option, amount)
Vote on behalf of others, the IOST of the voting pledge will be deducted from the agent account.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| voteID| string | ID returned by the NewVote interface|
| payer| string | Agent account name, **Calling this interface requires this account's "active" permission.** |
| voter | string | Voter account name |
| option | string | Option |
| amount | string | The amount of votes |

#### vote(voteID, voter, option, amount)
Vote.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| voteID| string | ID returned by the NewVote interface|
| voter| string | Voter account name, **Calling this interface requires this account's "active" permission.** |
| option | string | Option |
| amount | string | The amount of votes |

#### unvote(voteID, voter, option, amount)
Cancel the vote.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| voteID| string | ID returned by the NewVote interface|
| voter| string | Voter account name, **Calling this interface requires this account's "active" permission.** |
| option | string | Option |
| amount | string | The amount of votes |

#### getVote(voteID, voter)
Get an account vote record.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| voteID| string | ID returned by the NewVote interface|
| voter| string | Voter account name |

The result is a json array, each of which is the following object:

| key | type | notes |
| :----: | :------ | :------ |
| option| string | options |
| votes| string | Number of votes |
| voteTime| number | Block number of the last vote |
| clearedVotes| string | Number of votes cleared |

#### getResult(voteID)
Get the voting result and return the option of resultNumber before the number of votes.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| voteID| string | ID returned by the NewVote interface|

The result is a json array, each of which is the following object:

| key | type | notes |
| :----: | :------ | :------ |
| option| string | options |
| votes| string | Number of votes |

#### delVote(voteID)
Delete the vote and return the iost to the creator account that was pledged when creating the vote.

`Calling this interface requires the vote creator's "active" permission.`

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| voteID| string | ID returned by the NewVote interface|

## auth.iost
---

### Description
Account system and rights management

### Info
| contract_id | auth.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### signUp(accountName, ownerKey, activeKey)
Create an account.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| accountName | string | Account name, whose length should be between 5 and 11 and can only contain characters in [a-z0-9_] |
| ownerKey | string | the pubkey of owner permission, base58 encoded|
| activeKey | string | the pubkey of active permission, base58 encoded |

#### addPermission(account, permission, weight)
Add permissions to an account.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| permission | string | Permission name |
| weight | number | Permission threshold |

#### dropPermission(account, permission)
Delete permission

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| permission | string | Permission name |

#### assignPermission(account, permission, item, weight)
Assign permission to item.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| permission | string | permission name |
| item | string | permission owner, could be pubkey of another account name |
| Weight | number | permission weight|


#### revokePermission(account, permission, item)
Revoke permission

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| permission | string | permission name |
| item | string | permission owner, could be pubkey of another account name |

#### addGroup(account, group)
Add permission group

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| group | string | group name |

#### dropGroup(account, group)
Delete permission group

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| group | string | group name |

#### assignGroup(account, group, item, weight)
Assign item to a permission group

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| group | string | group name |
| item | string | permission owner, could be pubkey of another account name |
| Weight | number | permission weight|

#### revokeGroup(account, group, item)
Revoke the item of the permission group

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| group | string | group name |
| item | string | permission owner, could be pubkey of another account name |

#### assignPermissionToGroup(account, permission, group)
Add permissions to the group

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| permission| string | permission name|
| group | string | group name |


#### revokePermissionInGroup(account, permission, group)
Delete permissions in a group

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "owner" permission.**|
| permission| string | permission name|
| group | string | group name |

## bonus.iost
---

### Description

This smart contract is for block reward sending and receiving.

### Info

| contract_id | bonus.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.2 |

### API

#### exchangeIOST(account, amount)

Use the contribution value to exchange iost.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| account | string | account name. **Calling this interface requires this account's "active" permission.**|
| amount | string | the amount of iost to exchange, "0" represents all |


## system.iost

---

### Description
Base system contract for issuing and updating contracts and other basic system functions.

### Info
| contract_id | system.iost |
| :----: | :------ |
| language | native |
| version | 1.0.0 |

### API

#### setCode(code)
Deploy smart contracts.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| code | string | Smart contract code |

| Return Value | Return Value Type |
| :----: | :------ |
| contractID | string |

The smart contract code includes code and smart contract information, such as language and interface definitions. The code parameter supports two formats: json format and protobuf serialization encoding format.
For developers, deployment contracts generally do not need to call this interface directly. It is recommended to use iwallet or related language SDK implementation.

When deploying a smart contract, the system automatically calls the init() function of the smart contract. The developer can do some initialization work in the init function.

Return value contractID is the smart contract ID, which is globally unique and generated by the hash of the deployment contract transaction. The contractID starts with "Contract" and consists of uppercase and lowercase letters and numbers. Only one smart contract can be deployed in a transaction.

#### updateCode(code, data)
Upgrade smart contracts.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| code | string | Smart contract code |
| data |  string | Upgrade function parameters |


Upgrade the smart contract, code is the smart contract code, the format is the same as the parameter in setCode.

When upgrading a smart contract, the system will automatically check the upgrade permission, that is, the can\_update(data) function in the contract, and the parameter data is the second parameter in the updateCode, if and only if the can\_update function exists and the call returns true.
The contract upgrade will succeed, otherwise the upgrade will fail and it is determined that there is no upgrade permission.

#### cancelDelaytx(txHash)
Cancel a delayed transaction, call this function before the execution of the delayed transaction to cancel the delayed transaction.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| txHash | string | Transaction hash | 


#### requireAuth(acc, permission)
Check if the transaction has the permission of the account.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| acc |  string | account name |
| permission | string | permission name | 

| Return value | Type |
| :----: | :------ |
| ok | bool |

#### receipt(data)
Generate a transaction receipt, the receipt is stored in the block, and can also be queried through the transaction hash.

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| data |  string | receipt content |


## exchange.iost
---

### Description

Mainly used to sign up an account and transfer to this account, also can be used to transfer to an existing account.

### Info

| contract_id | exchange.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### transfer(tokenSym, to, amount, memo)

create account and transfer

| Parameter List | Parameter Type | Remark |
| :----: | :------ |:------ |
| tokenSym | string | Token symbol |
| to |string| Token receiving account, set to empty if create account | 
| amount | string| Transfer amount |
| memo |string| Additional Information, set to create:{UserName}:{OwnerPublicKey}:{ActivePublicKey} if create account |


When creating an account, the transfer amount must be at least 100 iost. By default, the newly created account will be pledged with 10 iost of the gas, and 1K bytes of ram will be purchased. The remaining amount will be transferred to the newly created account.
