---
id: Economic-model
title: Economic model
sidebar_label: Economic model
---
# Summary

The two most frequently used economic models are the economic model of ownership model of ETH and the rental economic model of EOS.

The IOST's contribution economic model is dedicated to inheriting the advantages of mature economic models and avoiding their shortcomings. Implementing a free-to-use economic model suitable for large-scale commercial DAPP.

The economic model is compared as follows:
 
 System | Model | Advantages | Disadvantages |
| :---: | :----: | ----- | ----- |
ETH | Ownership | 1. Create an account for free<br>2. Compete using resources in order to balance network usage<br>3.Gas charges are finer and more precise. | 1. When the system is busy, the network usage price will be very expensive. And the price fluctuates greatly<br>2. The system performance is low, and the development, deployment and use of the network will continue to charge, it is difficult to support large-scale DAPP applications.<br>3. The storage space cannot issue a refund, and the user does not have the motivation to release the storage. Many garbage data<br>4.CPU resources and storage resources, unified payment with Gas, resulting in two resources affecting each other and low usage rate |
EOS | Rental | 1. How many tokens in the whole network, how many resources are available in the whole network?<br>2. The system needs to pledge Token, does not consume Token, supports large-scale DAPP application<br>3. Leasing RAM, users have the motivation to release space, redeem Token, and alleviate blockchain data expansion problems | 1. Create complex accounts with high fees <br>2. When large customers pledge Token to obtain resources, it will lead to the dilution of retail resources, even when the network is at low useage level, retail investors can't afford transactions on EOS network.<br>3. There are too many types of resources to rent (NET, CPU and RAM), and the threshold for normal user operations is high.
| IOST | Contribution | 1. Create an account is simple, low cost <br>2. The greater the contribution, the more system resources you can use.<br>3. The system needs to pledge Token to get GAS, it will not consume Token, really Free public chain<br>4. Using Gas pricing, it can effectively avoid EOS big pledge Token dilution of retail resources, much more fair <br>5. System resources are divided into CPU and storage, the resource division is more conducive to differentiated pricing To avoid the problem of low ETH resource usage rate | Economic model complexity is high |

# Additional Issuances

The system issue an additional inssuance every 24 hours.

The initial total token of the IOST blockchain system is 21 billion, with a fixed annual issuance of 2%, which is used to reward the producer nodes, parter nodes and voters.

### Issuance Frequency

Each additional increase = annual inflation coefficient (1.000054%) * current IOST total * two additional time intervals (in milliseconds) / total time per year (in milliseconds)

Formula for calculating annual inflation coefficient: (1+x)^n = 214.2/210

From this, x = 0.000054

x is the inflation coefficient, n is the number of additional issuances, and 21.42 billion is the total amount of Token after one year of inflation.

# Reward

The reward model is an important part of the entire economic model. There are four types of rewards: block producing reward, voting reward, mortgage reward and pledge reward.

The contribution value obtained by the block producing can be redeemed for the Token reward from the reward pool. Pledged Token can get GAS to pay for the transaction.

If the node gets votes above a certain threshold and passes the certification, then the node and the node's voter can get the reward at the same time.

The producer node can redeem the Token reward from the reward pool at any time with the contribution value.

The contribution value is 1 to 1 for Token, and half of the redemption bonus is given to the voter.

The value of the contribution is destroyed after redemption and can be redeemed once every 24 hours.

### Gas Reward
    
A normal node can obtain Gas by pledge Token, 1Token = 100,000 Gas/Day, and the pledge Token is locked and cannot be traded.

rule:

- Pledge 1 IOST, get 100,000 GAS at once, and generate 100,000 GAS per day
- The production process is smooth and the Gas production speed is 100,000 Gas/Token/Day
- The upper limit of GAS per user is 300,000 times the total number of pledge tokens, that is, 2 days of charging is completed
- When Gas is used, it is less than 300,000 times of the pledge Token, and Gas continues to be generated according to the Gas production speed.
- IOST redemption can be initiated at any time. Tokens applying for redemption no longer generate GAS. Redemption requires 72 hours.
- If the IOST is redeemed, the upper limit of the reward Gas is reduced accordingly, and the Gas exceeding the upper limit is destroyed.  
### Gas Use

- Transaction execution requires consumption of Gas
- Number of Gas consumed by the transaction = CGas (Command Gas) consumption of the command * Number of commands * Gas rate. Detailed gas tables [here](6-reference/GasChargeTable.md)
- Gas can't trade

### Gas Collection

- Each time a transaction is initiated, first calculate the amount of Gas the user currently has, and then use the latest Gas balance to pay for the transaction.
  
# Resources
    
System resources are divided into NET, CPU and RAM. We abstract the NET and CPU into GAS payment. The user buys and sells RAM with the system.

RAM:

- The system initial RAM limit is 128G
- The user buys and sells RAM with the system. Buying RAM is charged 2% of the handling fee, and the handling fee will be destroyed.
- The less RAM remaining in the system, the more expensive the price, and vice versa
- Pledge Token is to encourage users to release unused RAM space and redeem the pledge Token
- Increase the RAM by 64G per year, and add RAM every time you have an account to buy RAM.
- The RAM purchased from the system can be given to other users, and cannot be retrieved after the gift.
- The RAM that the user is given cannot be sold to the system, and cannot be given to other users again, that is, the RAM can only be traded once.
- The system preferentially uses the donated RAM. When the RAM is released, the RAM attribute (given, system purchased) remains unchanged.
- Smart contract can decide whether contract publisher or user will pay for contract RAM usage by specify `payer` parameter of [blockchain storage API](3-smart-contract/IOST-Blockchain-API.md#putkey-value-payer)

# Circulation
    
Token's liquidity reflects the prosperity of the economic system. Increasing Token mobility is one of the economic model design goals

The IOST public chain is a new generation of high-performance, free public blockchain. Users can use the system for free, which can greatly promote the prosperity of DAPP and the use of C2C transfer.

# Recycle

Token recycling is mainly to balance supply and demand

- Voting, buying RAM, and getting Gas, all need to pledge Token
- The fee for purchasing RAM will be destroyed
- Gas consumed by the execution of the transaction will be destroyed
- As the number of users using the system increases, the tokens that are pledged and destroyed will also increase, so the IOST economic model is deflationary.
