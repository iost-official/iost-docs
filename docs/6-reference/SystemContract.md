---
Id: SystemContract
Title: System Contract
Sidebar_label: System Contract
---

## vote_producer.iost
---

### Description
The Super Node campaigns for voting.

### Info
| contract_id | vote_producer.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### applyRegister
Apply for registration to become a super node candidate.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |
| public key base58 encoding | string |
| Location | string |
| Website url | string |
| network id | string |
| is producer | bool |

#### applyUnregister
Apply for cancellation.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |


#### unregister
To cancel the registration, you need to call ApplyUnregister first. After the audit is passed, you can call this interface.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |

#### updateProducer
Update registration information.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |
| public key base58 encoding | string |
| Location | string |
| Website url | string |
| network id | string |

#### logInProducer
Go online, indicating that the node is currently available for service.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |

#### logOutProducer
Offline means that the node is currently unable to provide services.

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |

#### vote
vote.

| Parameter List | Parameter Type |
| :----: | :------ |
| Voter Account Name | string |
| Candidate Account Name | string |
| Number of votes | string |

#### unvote
Cancel the vote.

| Parameter List | Parameter Type |
| :----: | :------ |
| Voter Account Name | string |
| Candidate Account Name | string |
| Number of votes | string |

#### voterWithdraw
Voters receive bonus awards.

| Parameter List | Parameter Type |
| :----: | :------ |
| Voter Account Name | string |

#### candidateWithdraw
The contestant receives a bonus award.

| Parameter List | Parameter Type |
| :----: | :------ |
| Candidate Account Name | string |

#### topupCandidateBonus
recharge iost to candidates' bonus pool.

| Parameter Lis | Parameter Type |
| :----: | :------ |
| Amount | string |
| Payer Account Name| string |


#### topupVoterBonus
recharge iost to voters' bonus pool.

| Parameter Lis | Parameter Type |
| :----: | :------ |
| Candidate Account Name | string |
| Amount | string |
| Payer Account Name| string |


## vote.iost
---

### Description
A universal voting contract used to create votes, collect votes, and vote on statistics. You can implement your own voting function based on this contract.

### Info
| contract_id | vote.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### newVote
Create a vote.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote creator account name | string | Create a vote that requires pledge 1000 IOST, which will be deducted from the creator account, and the creator account has the admin privilege to vote |
| Vote Description | string ||
| Voting Settings | json object| contains 5 keys: <br>resultNumber —— number type, number of voting results, maximum 2000; <br> minVote —— number type, minimum number of votes, candidates with more votes than this number In order to enter the voting result set; <br>options - array type, candidate set, each item is a string, represents a candidate, the initial can be empty []; <br>anyOption - bool type, whether to allow The candidate in the non-options collection, passing false means that the user can only cast candidates in the options collection; <br>freezeTime - number type, cancel the token freeze time, in seconds;
A successful call returns a globally unique vote ID.

#### addOption
Increase voting options.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID returned by the NewVote interface|
| Options | string ||
| Whether to clear the previous votes | bool ||

#### removeOption
Delete the voting option, but retain the result of the vote, delete it, and then add this option through AddOption to choose whether to restore the number of votes.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID returned by the NewVote interface|
| Options | string ||
Whether to force delete | bool | false means that the option is not deleted when it is in the result set, true means to force delete and update the result set |

#### getOption
Get the votes for the candidate.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID returned by the NewVote interface|
| Options | string ||

The result is a json object:

| key | type | notes |
| :----: | :------ | :------ |
| votes| string | Votes |
| deleted| bool | Is it marked as deleted |
| clearTime| number | The block number where the number of votes was last cleared |

#### voteFor
Vote on behalf of others, the IOST of the voting pledge will be deducted from the agent account.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID returned by the NewVote interface|
| Agent account name | string ||
| Voter Account Name | string ||
| Options | string ||
| Number of votes | string ||

#### vote
vote.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID returned by the NewVote interface|
| Voter Account Name | string ||
| Options | string ||
| Number of votes | string ||

#### unvote
Cancel the vote.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID returned by the NewVote interface|
| Voter Account Name | string ||
| Options | string ||
| Number of votes | string ||

#### getVote
Get an account vote record.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID returned by the NewVote interface|
| Voter Account Name | string ||

The result is a json array, each of which is the following object:

| key | type | notes |
| :----: | :------ | :------ |
| option| string | options |
| votes| string | Number of votes |
| voteTime| number | Block number of the last vote |
| clearedVotes| string | Number of votes cleared |

#### getResult
Get the voting result and return the option of resultNumber before the number of votes.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ |:------ |
| Vote ID| string | ID returned by the NewVote interface|

The result is a json array, each of which is the following object:

| key | type | notes |
| :----: | :------ | :------ |
| option| string | options |
| votes| string | Number of votes |

#### delVote
Delete the vote and return the IOST that was created during the voting to the creator account.

| Parameter List | Parameter Type | Remarks |
| :----: | :------ | :------ |
| Vote ID| string | ID returned by the NewVote interface|

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

#### signUp
Create an account

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| ownerKey | string |
| activeKey | string |

#### addPermission
Add permissions to an account

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permission name | string |
| Permission threshold | number |

#### dropPermission
Delete permission

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permission name | string |

#### assignPermission
Specify permissions for item

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permissions | string |
| item | string |
| Weight | number |


#### revokePermission
Revoke permission

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permissions | string |
| item | string |

#### addGroup
Add permission group

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |

#### dropGroup
Delete permission group

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |

#### assignGroup
Specify item to the permission group

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |
| item | string |
| Weight | number |

#### revokeGroup
Revoke the item of the permission group

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Group name | string |
| item | string |


#### assignPermissionToGroup
Add permissions to the group

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permission name | string |
| Group name | string |


#### revokePermissionInGroup
Delete permissions in a group

| Parameter List | Parameter Type |
| :----: | :------ |
| Username | string |
| Permission name | string |
| Group name | string |


## bonus.iost
---

### Description

Formal node? Building block reward? Management

### Info

| contract_id | bonus.iost |
| :----: | :------ |
| language | javascript |
| version | 1.0.0 |

### API

#### issueContribute

The contribution value is issued and the system automatically calls

| Parameter List | Parameter Type |
| :----: | :------ |
| data | json |

#### exchangeIOST

Use the contribution value to redeem IOST

| Parameter List | Parameter Type |
| :----: | :------ |
| Account Name | string |
| Quantity | string |


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

#### setCode (code)
Deploy smart contracts.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| code | Smart Contract Code | string |

| Return Value | Return Value Type |
| :----: | :------ |
| contractID | string |

The smart contract code includes code and smart contract information, such as language and interface definitions. The code parameter supports two formats: json format and protobuf serialization encoding format.
For developers, deployment contracts generally do not need to call this interface directly. It is recommended to use iwallet or related language SDK implementation.

When deploying a smart contract, the system automatically calls the init() function of the smart contract. The developer can do some initialization work in the init function.

Return value contractID is the smart contract ID, which is globally unique and generated by the hash of the deployment contract transaction. The contractID starts with "Contract" and consists of uppercase and lowercase letters and numbers. Only one smart contract can be deployed in a transaction.

#### updateCode (code, data)
Upgrade smart contracts.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| code | Smart Contract Code | string |
| data | upgrade function parameters | string |

| Return value | None |
| :----: | :------ |

Upgrade the smart contract, code is the smart contract code, the format is the same as the parameter in SetCode.

When upgrading a smart contract, the system will automatically check the upgrade permission, that is, the can_update(data) function in the contract, and the parameter data is the second parameter in the UpdateCode, if and only if the can_update function exists and the call returns true.
The contract upgrade will succeed, otherwise the upgrade will fail and it is determined that there is no upgrade permission.

#### cancelDelaytx (txHash)
Cancel a delayed transaction, call this function before the execution of the delayed transaction to cancel the delayed transaction.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| txHash | Transaction hash | string |

| Return value | None |
| :----: | :------ |

#### requireAuth (acc, permission)
Check if the transaction has the permission of the account.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| acc | account name | string |
| permission | permission name | string |

| Return value | Type |
| :----: | :------ |
| ok | bool |

#### receipt (data)
Generate a transaction receipt, the receipt is stored in the block, and can also be queried through the transaction hash.

| Parameter Name | Parameter Description | Parameter Type |
| :----: | :----: | :------ |
| data | receipt content | string |

| Return value | None |
| :----: | :------ |
