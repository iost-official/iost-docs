---
id: ForExchange
title: ForExchange
sidebar_label: ForExchange
---

本文介绍了交易所如何映射IOST主网和IRC代币接入，阅读目标人群为交易所研发人员，主要内容是IOST公链的经济模型、创建账号、发送交易和[<font color="#f00"><b>交易确认</b></font>][1]。

本文demo基于IOST的JavaScript SDK编写.  
[JavaScript SDK文档](7-iost-js/IOST-class.md)   
[JavaScript SDK代码库](https://github.com/iost-official/iost.js)

## 主网基本特性

 1. 网络每0.5s出一个块，单节点连续造6个块
 2. 区块生产委员会拥有17个席位，每10分钟换届一次。每次换届时Servi值最高的17个节点入选委员会，轮流打包区块
 2. 一个区块被2/3+1个出块节点确认后不可逆，大约40秒左右
 3. IOST token最小单位为小数点后8位
 4. 系统采用账户模型
 5. 失败的交易会包含在区块里，并扣除[Gas][2]费用
 
## 创建账户流程

<b>IOST新账号必须由已有账号创建，创建账号时至少质押10个IOST用于新账号获取[Gas][3]</b>

#### 如何得到第一个账号：

如果您没有任何账号，可以使用 [创建账户服务][14] 来创建您的第一个账号。

#### 已有账号，使用SDK通过创建新账号：
 1. 首先把已有账户导入sdk，该账户必须保证有足够的Token
 2. 生成新账户的公私钥对，公私钥链上使用字节数组存储，输出的时候使用base58编码
 3. 生成创建账户的交易，并签名
 4. 通过rpc发送交易到[主网节点][7]，根据返回判断是否创建成功

[JS SDK示例代码](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L127)

## IOST 转账交易流程
**转账交易只能账号之间发送，不能对公钥地址发送。**

####转账步骤:
 1. 导入要发送转账交易的账户
 2. 生成转账交易，并签名
 3. 通过rpc发送交易，根据返回[判断是否执行成功][8]
 
[JS SDK示例代码](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L135)

## 转账交易判断
<font color="#f00"><b>如何判断转账交易不可逆和执行成功，对交易所十分重要，请仔细阅读[交易确认文档][9]</b></font>


## IOST 充提币方案
IOST采用账号模型，创建账号时需要消耗Token和[Gas][10]，因此不推荐交易所为每一个用户创建不同的账号，可以在冲币的时候，添加MEMO的方式实现充提币。

发送 iost 转账交易不需要购买RAM，只需要质押IOST获得[Gas][11]即可，<b>一次交易大概消耗9000Gas。每多质押一个 IOST，每天多生成 10万 GAS。任何IOST账户至少了质押了10 IOST，因此任何IOST账户每天都至少可以支持100笔左右转账。如果需要支持更多转账，需要质押更多IOST获取GAS</b>

####建议充币流程：
 1. 用户提交充币请求，交易所<b>生成跟用户相关的当前全局唯一的memo</b>
 2. 交易所监控IOST区块链，找到对应账号和memo
 3. [交易确认][12]

####建议提币流程：
用户提供IOST主网账户，交易所发送提币交易参考上面的IOST转账交易流程文档。
借助iost.js SDK的txHandler，可以方便实现轮询链上信息，确认上链后完成提币操作。

## IRC20, IRC21 代币接入
#### irc20, irc21 代币简介
[irc20](3-smart-contract/Token.md) 和 [irc21](3-smart-contract/Token20.1.md) 是 iost 链上发行代币的两个标准。   

irc20 不需要写合约，只需发一个交易，调用系统合约 token.iost 的 [create](6-reference/TokenContract.md#createtokensym-issuer-totalsupply-config) 方法即可；irc21 代币需要写合约，实现 irc21 标准中的所有接口，因此 irc21 代币可以满足一些开发者对代币转账、冻结、销毁等行为的定制化需求，irc21 代币仍然是通过调用 token.iost 系统合约的 create 方法创建。   

irc20 和 irc21 代币的唯一标识是 token symbol，token symbol 在代币系统中是全局唯一的，比如若存在一个 token symbol 为 iet 的 irc21 代币，那么其他人将无法再创建 token symbol 为 iet 的 irc20 或者 irc21 代币。    

irc20 代币的转账是直接调用 token.iost 的 [transfer](https://developers.iost.io/docs/en/6-reference/TokenContract.md#transfertokensym-from-to-amount-memo) 方法，irc21 代币的转账是调用代币合约地址的 transfer 方法。irc20 和 irc21 代币的转账可能会消耗 ram，若转账代币给一个已经拥有该代币的账户，不消耗 ram，若转账代币给一个从未拥有过该代币的账户，**会消耗 60 左右的 ram**。    

可以通过调用 [getTokenInfo](https://developers.iost.io/docs/en/6-reference/API.md#gettokeninfo-symbol-by-_longest-_chain) 接口查看链上的代币信息，示例如下：

```
curl https://api.iost.io/getTokenInfo/iet/1

{
	"symbol": "iet",  // token symbol, 全局唯一
	"full_name": "endless token", // 代币全称，可以做展示用。
	"issuer": "Contract8Hkb1ErxyBsHDYf3YHB7Ex9zuPkEQyNwSq1v4xEhzTqE", // 代币发行者，可能是账户或者合约
	"decimal": 4,     // 代币精度
	"current_supply": "529508805248513", // 代币已发行数量, 按最小精度计数。这里真实数量是 529508805248513 / 10000。因为需要除以精度大小。
	"total_supply": "1000000000000000",  // 代币发行上限, 按最小精度计数。一般设为一个很大的值即可。
	"can_transfer": true,
	"only_issuer_can_transfer": false, // 是否只能由代币发行合约转账. ERC20都是false。ERC21多是true，发行者可能需要自己管理转账逻辑，禁止了通过系统合约直接转账。
	"total_supply_float": 100000000000, // 代币发行上限
	"current_supply_float": 52950880524.8513 // 代币已发行数量
}

```

可以通过调用 [getTokenBalance](6-reference/API.md#gettokenbalance-account-token-by-_longest-_chain) 接口查看某账户的某代币余额，如：

```
curl https://api.iost.io/getTokenBalance/onblockp1/iet/1

{
	"balance": 4292197.5628, // 可用余额
	"frozen_balances": []    // 被冻结余额
}

```


#### irc20, irc21 代币转账示例
[IRC 20 JS SDK示例代码](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L57)  
[IRC 21 JS SDK示例代码](https://github.com/iost-official/iost.js/blob/master/examples/e2e_create_and_transfer.js#L68)  

### IOST, IRC20 代币, IRC21 代币的对比
|        |  IOST | IRC20 token| IRC21 token |
| ------ | ------ | --------- | ----------  |
| 创建方式 | 创世块中调用系统合约 token.iost 的 create 方法创建 | 普通账户直接调用 token.iost 的 create 方法创建 | 账户部署自定义合约，并在合约中调用 token.iost 的 create 方法创建|
| 唯一标识 | token symbol | token symbol | token symbol |
| 转账方式 | 调用系统合约 token.iost 的 tranfer 方法转账 | 调用系统合约 token.iost 的 tranfer 方法转账 | 调用代币合约的 transfer 方法转账|
| 转账消耗 | 仅消耗 gas | 消耗 gas 和 ram | 消耗 gas 和 ram |
| 入账交易判断 | [文档](6-reference/TransferJudgement.md) | [文档](6-reference/TransferJudgement.md) | [文档](6-reference/TransferJudgement.md) |

## 附录
#### 其他SDK
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
