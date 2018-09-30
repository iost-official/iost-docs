---
id: Design-Tech-data
title: Lucky Bet Smart Contract
sidebar_label: Lucky Bet Smart Contract
---

## 教程说明

本教程将带领读者在本地搭建一个 IOST 节点（开发用节点，不连接 IOST 主网），在上面通过 javascript 智能合约代码实现一个博彩小游戏，用以展示 IOST 测试网络下智能合约的编写和部署。

本教程分为3部分。第一部分将会给出具体执行的指令。第二部分讲解智能合约的javascript代码。第三部分详细解读合约到底是怎么一步一步部署运行的。  

本教程假设读者有基本的编程和区块链知识。  

本教程使用的OS是Ubuntu 16.04。  

## Lucky Bet游戏规则

1. iost账户可以自由投注lucky bet，投注额为1~5iost，可以投注0~9；
2. 当投注人数到达100时开奖，中奖者根据投注额得到这一轮所有投注的95%的奖励，剩余5%将会作为手续费收走
3. 中奖号码为开奖时block高度取模10，如果上一次开奖的block与这一次的距离小于16个block，则要求这次
block的parent hash取模16为0，不合格则不开奖


