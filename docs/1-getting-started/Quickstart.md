---
id: Quickstart
title: Quickstart
sidebar_label: Quickstart
---

This page provides a guide for different kinds of users to find out which parts in the documentations to look at.

## If you want to know IOST basic concepts

Before you get into IOST technical details or developing smart contract on IOST, it is helpful to know IOST basic concepts at first and have a thorough understanding about IOST. You can learn some basic concepts about IOST's [account system](2-intro-of-iost/Account.md), [economic model](2-intro-of-iost/Economic-model.md), [vote process](2-intro-of-iost/Vote.md).



## If you are an ordinary user

You can join IOST community and contribute to IOST daily operation even if you are *NOT* a developer.  
You can [have a look at the browser](https://www.iostabc.com).

### Wallet

#### Chrome Extension Wallet
You can use one of these two wallet: [iWallet](https://chrome.google.com/webstore/detail/iwallet/kncchdigobghenbbaddojjnnaogfppfj?utm_source=chrome-ntp-icon) or [Jetstream](https://chrome.google.com/webstore/detail/jetstream/ijancdlmlahmfgcimhocmpibadokcdfc). 

#### App Wallet
You can use wallets like [TOKEN POCKET](https://www.tokenpocket.pro/).

## If you are a developer

For developers, there're a lot of materials to help you.

### Run and play with IOST

You can choose to [run local single-node net](4-running-iost-node/LocalServer.md) or [join IOST net](4-running-iost-node/Deployment.md).   
You can use [command line tool](4-running-iost-node/iWallet.md) to play with IOST Blockchain.

### Smart contracts development

For smart contract developers, you can refer to [smart contract development quick start](3-smart-contract/ContractStart.md) for details.   

There's also some examples provided for smart contract developers, which introduce how to write/deploy/run contracts.

#### Pumpkin Example
This a Defi-like full featured DAPP. You can use chrome IOST wallet extension to stake IOST coin, and then you can farm the 'Pumpkin' token. This is a great example including both contract code / frontend code. [Pumpkin](http://pumpkindefi.com/)

#### Bet Example
This example includes a bet contract writing in javascript, and a script demonstrating deploying/calling the contract from command line. You can learn how to use the command line tool.

* [doc](5-lucky-bet/LuckyBet.md)
* [code](https://github.com/iost-official/luckybet_sample)

#### Go Game Example
It is go game webpage using the IOST blockchain backend.   

* [contract code](https://github.com/iost-official/contracts/tree/master/demos)
* [frontend code](https://github.com/iost-official/gobang)

There're also some contract provided by IOST you can get use of, including [Economic Contract](6-reference/EconContract.md) and [System Contract](6-reference/SystemContract.md). You can also refer to [gas charge table](6-reference/GasChargeTable.md) to estimate contract running costs.

### SDK and API

There are also SDK and API provided for developers:

* Javascript SDK
	* [code](https://github.com/iost-official/iost.js)
	* Documentation on [IOST](7-iost-js/IOST-class.md), [blockchain](7-iost-js/Blockchain-class.md), [keypair](7-iost-js/KeyPair-class.md), and [transaction](7-iost-js/Transaction-class.md)
* Java SDK
	* [code](https://github.com/iost-official/java-sdk)
* Python SDK
	* [code](https://github.com/iost-official/pyost) 
* JSON RPC API
	* [Documentation](6-reference/API.md)
* Chrome Extension
	* [code](https://github.com/lispc/iost-extension)

## If you are interested in tech details

For those of you who are interested in technical details, you can learn about [database infrastructure](2-intro-of-iost/Database.md), [network layer](2-intro-of-iost/Network-layer.md), and [virtual machine](2-intro-of-iost/VM.md). You will be able to understand the internal logic of IOST through these documentations.
