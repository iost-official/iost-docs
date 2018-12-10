---
id: iwallet-example
title: iwallet-example
sidebar_label: iwallet-example
---

## 命令行工具
### 说明 
iwallet 是 IOST 的客户端命令行工具。可以使用本工具连接IOST节点，进行区块链操作，和查询余额，创建账号，转账，调用合约等。
### 安装工具
首先需要安装 golang 环境。可以参考 [环境配置文档](../5-lucky-bet/Lucky-Bet-Operation#step1-安装-golang-环境) 中的 安装 golang 部分。   
之后 clone 代码，并且编译 iwallet。

```
go get -d github.com/iost-official/go-iost   
cd $GOPATH/src/github.com/iost-official/go-iost  
make iwallet   
go install ./cmd/iwallet/  
```

### 配置账号
如果你已经有一个账号，那么你可以按照下面的命令导入账号。    
本命令实际上是会把私钥复制到 ~/.iwallet/YOUR_ACCOUNT\_ID\_ed25519 文件中。不会和区块链有交互。   
```
iwallet account --import $YOUR_ACCOUNT_ID $YOUR_PRIVATE_KEY 
```  
如果你还没有账户，那么需要别人帮你创建一个账户，再导入。这是因为新账号需要使用系统RAM，因此创建新账号必须由已有的账号来完成。  
创建时，既可以创建者随机生成公私钥对，创建完成后返回给申请人。也可以申请人自己生成公私钥对，仅把公钥交给创建者来建账号。  
具体的创建账号方法见后文。  
### 查询余额
使用 iwallet 可以查看本账户目前的 余额，可用RAM数量，GAS总量。注意，由于GAS是不断产生的，因此，不同时刻得到的GAS量可能是不同的。   
注意，iwallet 后面的 server 参数，可以指定连接的 IOST server。如果你在本地搭建了全节点，那么直接不指定这个参数，令其使用默认值（本地）即可。在后面的命令展示中，会省略这个参数。   

```
iwallet --server 127.0.0.1:30002 balance xxxx
{
    "name": "xxxx",
    "balance": 993939670, #用户目前的余额
    "createTime": "0", #账户创建的时间
    "gasInfo": { #GAS相关信息。如果需要增加用户的GAS存量，增速，上限，需要进一步质押GAS。关于经济模型的设计可以参考其他文档。具体如何质押见后文。
        "currentTotal": 2994457,#目前账户拥有的GAS
        "increaseSpeed": 11,#用每秒新增的GAS
        "limit": 3000000,#用户的GAS上限。用户的GAS在小于上限时，会持续增长。
        "pledgedInfo": [ #这里记录了谁为该账户质押了IOST换GAS，每个质押者质押了多少。
            {
                "pledger": "xxxx",
                "amount": 10
            },
            {
                "pledger": "tttt",
                "amount": 10
            }
        ],
    },
    "ramInfo": {
        "available": "100000" #用户还有多少剩余RAM可用。
    },
    "permissions": ...
    "frozenBalances": [ #这里记录了用户每笔目前处于冻结状态的余额，和解冻时间。给他人转账时可以指定解冻时间。另外，为GAS质押的IOST赎回时，也是需要3天才能解冻。
        {
            "amount": 30,
            "time": "1543817610001412000"
        }
    ]
}
```
### 调用合约
#### 转账
使用admin这个账户，调用 'token.iost' 这个合约的 'transfer' 方法。在调用的参数中，依次是 token 类型，付款方，收款方，金额，和附加信息。

```
iwallet --account admin call 'token.iost' 'transfer' '["iost","admin","lispczz","100",""]' 
sending tx Tx{
	Time: 1543559175834283000,
	Publisher: admin,
	Action:
		Action{Contract: token.iost, ActionName: transfer, Data: ["iost","admin","lispczz","100",""]}
    AmountLimit:
[],
}
send tx done
the transaction hash is: GU4EHg4zE9VHu9A13JEwxqJSVbzij1VoqWGnQR5aV3Dv
exec tx done.  {
    "txHash": "GU4EHg4zE9VHu9A13JEwxqJSVbzij1VoqWGnQR5aV3Dv",
    "gasUsage": 2172, #本次调用消耗的GAS
    "ramUsage": {#每个账户或合约本次调用消耗的RAM
        "admin": "43", 
        "issue.iost": "0"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[]"
    ],
    "receipts": [
        {
            "funcName": "token.iost/transfer",
            "content": "[\"iost\",\"admin\",\"lispczz\",\"100\",\"\"]"
        }
    ]
}
```
#### 质押GAS
三个参数依次是质押者，接受GAS的人，质押的IOST数量。  
每个IOST立刻可以得到10000GAS，GAS上限提升30000。  
GAS持续增长，如果不进一步使用，48小时后预计达到上限。  
一旦GAS不到上限，则GAS持续产生。  
用户可以为别人质押。无论为自己质押，还是为别人质押，都可以赎回。72小时后赎回到账。  

```
iwallet --account lispczz call 'gas.iost' 'pledge' '["lispczz","lispczz","10"]'
sending tx Tx{
	Time: 1543559224067770000,
	Publisher: lispczz,
	Action:
		Action{Contract: gas.iost, ActionName: pledge, Data: ["lispczz","lispczz","10"]}
    AmountLimit:
[],
}
send tx done
the transaction hash is: HswL4HbX3nRmGQrGqcc1Q9t7MQ9g2Q9bFb1djPyEBu93
exec tx done.  {
    "txHash": "HswL4HbX3nRmGQrGqcc1Q9t7MQ9g2Q9bFb1djPyEBu93",
    "gasUsage": 3968,
    "ramUsage": {
        "admin": "0",
        "gas.iost": "54",
        "lispczz": "0"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[]"
    ],
    "receipts": [
        {
            "funcName": "token.iost/transfer",
            "content": "[\"iost\",\"lispczz\",\"gas.iost\",\"10\",\"\"]"
        }
    ]
}
```
#### 赎回GAS
```
iwallet --account admin call 'gas.iost' 'unpledge' '["admin","admin","30"]'
```
#### 购买RAM
购买 1024 byte 的RAM。三个参数依次为购买者，获得RAM的人，和字节数。价格由系统实时决定。现阶段价格在44 IOST/KiB 左右。

```
iwallet --account lispczz call 'ram.iost' 'buy' '["lispczz","lispczz",1024]' 
sending tx Tx{
	Time: 1543561875422185000,
	Publisher: lispczz,
	Action:
		Action{Contract: ram.iost, ActionName: buy, Data: ["lispczz","lispczz",1024]}
    AmountLimit:
[],
}
send tx done
the transaction hash is: FMraysr2H7T3uwQzWZrvmG73C6iJD5cff4PxgwNhNR4t
exec tx done.  {
    "txHash": "FMraysr2H7T3uwQzWZrvmG73C6iJD5cff4PxgwNhNR4t",
    "gasUsage": 9809,
    "ramUsage": {
        "admin": "0",
        "lispczz": "0",
        "ram.iost": "0",
        "token.iost": "10"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"44\"]" # 这个是每个合约调用的返回值。RAM合约的buy调用会返回花费的IOST数量。
    ],
    "receipts": [
        {
            "funcName": "token.iost/transfer",
            "content": "[\"iost\",\"lispczz\",\"ram.iost\",\"44\",\"\"]"
        },
        {
            "funcName": "token.iost/transfer",
            "content": "[\"ram\",\"ram.iost\",\"lispczz\",\"1024\",\"\"]"
        }
    ]
}
```
### 创建账号
后三个参数指定了创建者给新账号转多少IOST，创建者给新账号质押多少IOST换GAS，创建者给新账号购买多少RAM。  
注意这个调用即使 --initial_ram 为 0，实际上创建者也需要消耗RAM。因为新用户的账户信息储存用了创建者的空间。目前创建一个新账户需要创建者400多的byte。  
初始创建账号时，GAS有最小质押10。因此，下面的 --initial_balance 0 --initial_gas_pledge 10 --initial_ram 0 是创建一个新账号时最小的资源消耗参数配置。  

```
# 创建账号后，iwallet会随机生成公私钥对，私钥会保存到 ~/.iwallet/$(NEW_USER_ID)_ed25519 文件中。
iwallet --account admin account --create lispczz3 --initial_balance 0 --initial_gas_pledge 10 --initial_ram 0 
```
### 测试网
目前的测试网中，创始块中创建了一个叫 admin 的账户。初始的状态如下。这个账号初始IOST，GAS，RAM都较多，方便用来做一些简单测试。

```
$ iwallet balance admin
balance:"999988976" gas:<currentTotal:"9000000" increaseSpeed:"23" limit:"9000000" pledgedCoin:"10000" > ram:<available:1024 >
$ iwallet account --import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```
### 完整Demo
[这份文档](http://developers.iost.io/docs/en/5-lucky-bet/Design-Tech-data/) 和 [样例代码](https://github.com/iost-official/luckybet_sample/tree/master) 给出了相对较大的Demo。
其中包含了创建账号，购买RAM，质押GAS，发布合约，调用合约，获取余额等等多种操作。
