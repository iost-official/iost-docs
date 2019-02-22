---
id: Vote
title: Vote
sidebar_label: Vote
---

# Summary

Voting is an important autonomous mechanism for blockchain systems. If a node continues to serve the IOST community, contribute code, and participate in governance, then this node will certainly win more community votes. Nodes with more votes have the opportunity to participate in the Producing of the blocks and get rewards. Active participation in voting is very important for community development, so the system will reward voters with Token

## node type
In our voting mechanism, there are three types of nodes: candidate node, partner node and servi node.  
Calling the [applyRegister](../6-reference/SystemContract.html#applyregister) method of the voting contract can make you become the candidate node. When the number of votes is more than 2.1 million and the audit is approved, the candidate node will become a partner node or a servi node (determined by the last parameter passed in when the applyRegister is called, true is a servi node, false is a partner node). The servi node needs to produce blocks, and the partner node does not.



## Voting Rules

- 1 token has 1 voting right, 1 voting right can only be voted to 1 registered node, partner node or servi node
- An account can vote for more than one node, and the node can vote for itself
- Only partner nodes and servi nodes and their voters can participate in voting reward bonuses
- Token pledged to purchase resources doesn't have voting right
- After canceling the vote, you need to wait 7 days to redeem the token

## reward
The system will issue 2% token every year. 1% tokens are block awards only for servi nodes. 1% tokens are voting awards, half of which are awarded to partners and servi nodes, and the other half to their voters.

### block award
- Block rewards are allocated according to the number of blocks a node produced. The reward for each block is about 3.3 iost, which can be calculated from the rate of issue (2% per year) and the rate of block production (1 block per 0.5 second).
- Block reward requires node to take the initiative to receive, and the way to receive it is calling [exchangeIOST](../6-reference/SystemContract.html#exchangeiost) method of system contract.


### voting award

#### node award

- The system automatically issues tokens every 24 hours. The issued tokens will go into the node reward pool and are distributed proportionally according to the number of votes received by each node at the time of issue.
- Any account can recharge the node reward pool by calling the [topupCandidateBonus](../6-reference/SystemContract.html#topupcandidatebonus) method of voting contract, and the tokens are distributed proportionally according to the number of votes received by each node at the recharging time.
- The voting reward needs the node to take the initiative to receive, and the way to receive it is calling [candidateWithdraw](../6-reference/SystemContract.html#candidatewithdraw) method of the voting contract.
- 50% of the voting reward will go into the voter reward pool when the reward is received by node.
- The rewards that have been obtained but not yet received are not affected by the changes of node attributes and votes, and they can be received at any time without expiration.

#### voter award

- When a node receives a reward, 50% of the reward will go into the voter reward pool of the node and the reward is distributed proportionally according to the voting number of each voter at that current moment.
- Any account can recharge the voter reward pool by calling the [topupVoterBonus](../6-reference/SystemContract.html#topupvoterbonus) method of voting contract, and the tokens are distributed proportionally according to the voting number of each voter at the recharging time.
- The voting reward needs the node to take the initiative to receive, and the way to receive it is calling [voterWithdraw](../6-reference/SystemContract.html#voterwithdraw) method of the voting contract.
- The awards already obtained but not yet received are not affected by the voters' additional or cancelled voting operations, and they can be received at any time without expiration.
