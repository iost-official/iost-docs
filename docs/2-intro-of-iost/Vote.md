---
id: Vote
title: Vote
sidebar_label: Vote
---

# Summary

Voting is an important autonomous mechanism for blockchain systems. If a node continues to serve the IOST community, contribute code, and participate in governance, then this node will certainly win more community votes. Nodes with more votes have the opportunity to participate in the Producing of the blocks and get rewards. Active participation in voting is very important for community development, so the system will reward voters with Token

## Rules

- 1 token has 1 voting right
- 1 voting right can only be awarded to 1 registered node, partner node or formal node
- Token pledged to purchase resources doesn't have voting rights
- After canceling the vote, you need to wait 7 days to redeem the token

## reward

### Official node

- 2% Token is issued every year, rewarded to official nodes, partner nodes and voters
- The system automatically issues a token inssuance every 24 hours.
- 50% of each additional token is awarded to an authenticated node that has received more than 0.01% (2.1 million votes) of votes on the entire network, depending on the node's voting ratio.
- Nodes with votes less than 0.01% do not produce blocks and has no voting rewards
- The remaining 50% token, according to the number of blocks every node produced, the partner node does not participate in the block producing
- 50% of the voting revenue of the official node and partner nodes goes to the voter reward pool
- Awards already earned are not affected by changes in node attributes and votes, and has no expiration time
- The node needs to actively call the contract to receive the producing and voting rewards. The reward token will not be automatically accumulated into the voting
- The proportion of votes obtained by all official nodes is the same as the proportion of the number of blocks every official nodes produced

### Voter

- 50% of the voting points for the official node and the partner node will be distributed to the user who voted for the node ticket
- Users can only vote for registered nodes, formal nodes and partner nodes, and can vote multiple nodes at the same time
- Voters gets node rewards according to the proportion of votes, and can only get rewards generated after the vote
- Any account can be used to recharge a node's reward pool (used to give voters more rewards), the distribution logic is the same as the official node voting bonus
- Voters need to actively call the contract to receive the voting reward. The reward token will not be automatically accumulated in the voting.
- Vote awards already received are not affected by cancellation of voting and have no expiration date