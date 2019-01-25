---
id: version-2.1.7-LuckyBet
title: LuckyBet Example
sidebar_label: LuckyBet Example
original_id: LuckyBet
---
The tutorial is designed to demonstrate smart contract coding and deployment.   
It will give you instructions to deploy one IOST node locally(just for development, not connecting to the actual chain). Then a smart contract(a gambling game named 'Lucky Bet') will be deployed onto the node.

## Step1: Run Local Server
You should [launch a local server](4-running-iost-node/LocalServer.md) firstly.   

## Step2: Install iWallet
You should follow [this documentation](4-running-iost-node/Building-IOST.md) to build IOST then.

## Step3: Deploy and Run the Smart Contract
```shell
# deploy and run the smart contract
git clone https://github.com/iost-official/luckybet_sample.git
cd luckybet_sample/
python3.6 luckbet.py # You will see "Congratulations! You have just run a smart contract on IOST!".
```


## Appendix: Lucky Bet Rules
Here is the game rules. You may find it useful if you want to understand the contract code
1. IOST Accounts can make a lucky bet with 1-5 IOST. Each bet is on a number of 0-9.
2. When there are 20 bets, the number is revealed. Winners split 95% of all the stakes, and the rest 5% are taken as transaction fees.
3. The Lucky Number is Block Height mod 10. If the last Lucky Number's block is not at least 16 blocks away, we requires the parent hash of the block to have 0 when modded by 16. Otherwise we do not reveal a lucky number.