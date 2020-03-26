---
id: version-3.3.3-ForExchange
title: ForExchange
sidebar_label: ForExchange
original_id: ForExchange
---

This documentation introduces IOST blockchain briefly. Target readers are developers of exchanges. The main content is the economic model of the IOST public chain, how to create an account, and send transactions, [<font color="#f00"><b>transaction confirmation</b></font>][1]。

This demo is written based on IOST's JavaScript SDK.    
[JavaScript SDK Docs](7-iost-js/IOST-class.md)   
[JavaScript SDK](https://github.com/iost-official/iost.js)

## Basic characteristics of the main network

1. The network generates a block every 0.5s, and a single node continuously builds 6 blocks.
2. The Block Production Committee has 17 seats and is renewed every 10 minutes. The 17 nodes with highest Servi values are selected into the committee each time, and the blocks are packed in turns.
3. A block is irreversible after being confirmed by 2/3 + 1 block-producing nodes, about 40 seconds or so
4. The minimum unit of IOST token is 8 digits after the decimal point.
5. The system uses an account model
6. Failed transactions will be included in the block and [Gas][2] fees will be deducted
 
## Account creation process

<b>A new IOST account must be created from an existing account.     
When creating an account, at least 10 IOSTs are pledged for new account for [Gas][3]</b>

#### How to get your first account：

If you do not have any account, you can use [Create Account Service] [14] to create your first account.   

#### Existing account, use SDK to create new account:

1. First import the existing account into SDK, the account must ensure that there are enough tokens
2. Generate a public and private key pair for the new account. The public and private key are stored in a byte array, and the output is encoded using base58.
3. Generate and sign a transaction that creates an account
4. Send the transaction to [Main Network Node][7] through rpc, and judge whether the creation is successful based on the return

[JS SDK Example](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L127)

## IOST Transfer transaction process
**Transfer transactions can only be sent between accounts, not public key addresses.**

#### Transfer steps:
  1. Import the account to send the transaction
  2. Generate a transfer transaction and sign it
  3. Send the transaction through rpc, and [Judge whether the execution was successful][8] according to the return
 
[JS SDK Example](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L135)

## Check whether transfers succeed
<font color="#f00"><b>How to judge the irreversibility and successful execution of the transfer transaction is very important to the exchange, please read the [Transaction Confirmation Document][9] carefully</b></font>


## IOST deposit and withdrawal 
IOST uses an account model. It needs to consume Token and [Gas][10] when creating an account. Therefore, it is not recommended that the exchange create a different account for each user. You can add MEMO to deposit and withdraw.

Sending an iost transfer transaction does not require the purchase of RAM. You only need to pledge IOST to obtain [Gas][11]. <b>A transaction consumes approximately 9000Gas. Each additional pledge of IOST generates an additional 100,000 GAS per day. Any IOST account has been pledged at least 10 IOST, so any IOST account can support at least about 100 transfers per day. If you need to support more transfers, you need to pledge more IOST to get GAS</b>

#### Suggested deposit process:
1. The user submits a deposit request, and the exchange <b>finds(or generates if not existed yet) a globally unique memo associated with the user</b>
2. The exchange monitors the IOST blockchain and finds the corresponding account and memo
3. [Transaction Confirmation][12]

#### Suggested withdrawal process:
The user provides an IOST mainnet account, and the exchange sends the withdrawal transaction with reference to the above IOST transfer transaction process document.   
With the help of the `txHandler` of the iost.js SDK, it is convenient to poll the information on the chain and complete the withdrawal operation after confirmed on the chain.

## IRC20, IRC21 Token
#### irc20, irc21 Token Introduction
[irc20](3-smart-contract/Token.md) and [irc21](3-smart-contract/Token20.1.md) are Two standards for issuing tokens on the iost chain.      

irc20 does not need to write a contract, just sends a transaction, and calls [create](6-reference/TokenContract.md#createtokensym-issuer-totalsupply-config) of the system contract token.iost; The irc21 token needs to write a contract to implement all the interfaces in the irc21 standard. Therefore, the irc21 token can meet some developers' customized needs for token transfer, freezing, and destruction. The irc21 token is aslo created by the `create` method of the token.iost system contract internally.      

The unique identifier of the irc20 and irc21 tokens is the token symbol. The token symbol is globally unique in the token system. For example, if there is an irc21 token with the token symbol `iet`, then others will no longer be able to create irc20 or irc21 tokens with the token symbol `iet`.     

The transfer of irc20 tokens can be done by directly calling [transfer](6-reference/TokenContract.md#transfertokensym-from-to-amount-memo) method of token.iost. The transfer of irc21 token is to call the `transfer` method of the token contract address. The transfer of irc20 and irc21 tokens may consume RAM. If you transfer tokens to an account that already owns the token, RAM is not consumed. If you transfer tokens to an account that has never owned the token, it will **consume RAM around 60 bytes**.    

You can view the token information on the chain by calling the [getTokenInfo](6-reference/API.md#gettokeninfo-symbol-by-_longest-_chain) api, an example is as follows：

```
curl https://api.iost.io/getTokenInfo/iet/1

{
	"symbol": "iet",  // token symbol, uniq globally
	"full_name": "endless token", // full name, for display。
	"issuer": "Contract8Hkb1ErxyBsHDYf3YHB7Ex9zuPkEQyNwSq1v4xEhzTqE", // issuer, can be account or contract
	"decimal": 4,     // precision
	"current_supply": "529508805248513", // Count with minimum precision. Real amount is 529508805248513 / 10000 here, divided by precision value  
	"total_supply": "1000000000000000",  // Upper limit of supply. Count with minimum precision. Generally set to a very large value.
	"can_transfer": true, // 
	"only_issuer_can_transfer": false, // Are tokens only transferable through the token contract? ERC20 is all false. ERC21 is mostly true. The issuer may need to manage the transfer logic through the token contract, prohibiting direct transfers through system contracts.
	"total_supply_float": 100000000000, // Upper limit of supply
	"current_supply_float": 52950880524.8513
}

```

You can check the balances of an account by calling the [getTokenBalance](6-reference/API.md#gettokenbalance-account-token-by-_longest-_chain) api, such as：

```
curl https://api.iost.io/getTokenBalance/onblockp1/iet/1

{
	"balance": 4292197.5628, // avaiable
	"frozen_balances": []    // all frozen balances
}

```


#### irc20, irc21 Token transfer example
[IRC 20 JS SDK Sample Code](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L57)  
[IRC 21 JS SDK Sample Code](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L68)  

### IOST, IRC20, IRC21 tokens comparison
|        |  IOST | IRC20 token| IRC21 token |
| ------ | ------ | --------- | ----------  |
| Create method | inside genisis block | users call create of token.iost | Users deploy custom contracts and calls the create method of token.iost inside the contract |
| uniq identifier | token symbol | token symbol | token symbol |
| transfer method | tranfer of token.iost | tranfer of token.iost | tranfer of token's customized contract |
| transfer resouce comsumption|  gas |  gas and ram |  gas and ram |
| Transfer Judgement | [Doc](6-reference/TransferJudgement.md) | [Doc](6-reference/TransferJudgement.md) | [Doc](6-reference/TransferJudgement.md) |

## appendix
#### other SDK
[JAVA SDK](https://github.com/iost-official/java-sdk)  
[PYTHON SDK](https://github.com/iost-official/pyost)  
[GO SDK](https://github.com/iost-official/go-iost/tree/master/sdk)


  [1]: 6-reference/TransferJudgement.md
  [2]: 2-intro-of-iost/Economic-model.md#gas-reward
  [3]: 2-intro-of-iost/Economic-model.md#gas-reward
  [4]: https://www.purewallet.org/
  [5]: https://www.tokenpocket.pro/
  [6]: https://iost.io/
  [7]: 4-running-iost-node/Deployment.md#seed-node-list
  [8]: 6-reference/TransferJudgement.md
  [9]: 6-reference/TransferJudgement.md
  [10]: 2-intro-of-iost/Economic-model.md#gas-reward
  [11]: 2-intro-of-iost/Economic-model.md#gas-reward
  [12]: 6-reference/TransferJudgement.md
  [13]: https://www.huobiwallet.com/
  [14]: https://iostaccount.io/create
          
