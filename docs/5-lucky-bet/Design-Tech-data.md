---
id: Design-Tech-data
title: Lucky Bet Smart Contract
sidebar_label: Lucky Bet Smart Contract
---

## Summary

The tutorial is designed to demonstrate smart contract coding and deployment. 

It will give you instructions to deploy one IOST node locally(just for development, not connecting to the actual chain). Then a smart contract(a gambling game named 'Lucky Bet') will be deployed onto the node.

The tutorials contains 3 parts. Part1 lists the step-by-step commands to deploy and run the smart contract. Part2 explains the contract javascript code. Part3 will give some details about the deployment and running instructions.

The readers are assumed to have basic knowledge of programming and blockchain.
Following instructions are all run on Ubuntu 16.04.  

## Lucky Bet Rules

1. IOST Accounts can make a lucky bet with 1-5 IOST. Each bet is on a number of 0-9.
2. When there are 100 bets, the number is revealed. Winners split 95% of all the stakes, and the rest 5% are taken as transaction fees.
3. The Lucky Number is Block Height mod 10. If the last Lucky Number's block is not at least 16 blocks away, we requires the parent hash of the block to have 0 when modded by 16. Otherwise we do not reveal a lucky number.


