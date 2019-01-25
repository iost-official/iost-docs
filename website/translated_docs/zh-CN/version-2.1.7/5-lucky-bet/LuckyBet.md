---
id: Lucky-Bet-Operation
title: Step-by-Step Commands to Deploy and Run
sidebar_label: Step-by-Step Commands to Deploy and Run
---

本教程将带领读者在本地搭建一个 IOST 节点（开发用节点，不连接 IOST 主网），在上面通过 javascript 智能合约代码实现一个博彩小游戏，用以展示 IOST 测试网络下智能合约的编写和部署。


## 步骤一 启动网络
首先[启动本地节点](4-running-iost-node/LocalServer.md)。   

## 步骤二 安装命令行工具
按照[编译文档](4-running-iost-node/Building-IOST.md) 来编译安装命令行工具。

## 步骤三 部署运行智能合约
```shell
# 运行智能合约代码
git clone https://github.com/iost-official/luckybet_sample.git
cd luckybet_sample/
python3.6 luckbet.py # 此时正确运行后，应该最后会输出 "Congratulations! You have just run a smart contract on IOST!"。意味着本合约部署运行成功了！
```
## 附录 游戏规则

1. iost账户可以自由投注lucky bet，投注额为1~5iost，可以投注0~9；
2. 当投注人数到达100时开奖，中奖者根据投注额得到这一轮所有投注的95%的奖励，剩余5%将会作为手续费收走
3. 中奖号码为开奖时block高度取模10，如果上一次开奖的block与这一次的距离小于16个block，则要求这次
block的parent hash取模16为0，不合格则不开奖