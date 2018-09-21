---
id: iWallet
title: iWallet
sidebar_label: iWallet
---

# iwallet instructions
**IOSBlockchain** 由两个程序组成，`iserver`是核心程序，多个`iserver`组成了区块链网络。`iwallet`是命令行工具，用于与区块链（iserver）交互。

系统`build`成功后，`iwallet`在工程的`target/`目录中

![iwallet1](assets/4-running-iost-node/iWallet/iwallet.png)


## 命令介绍 

|Command      |Contents                                |Description
|:-----------:|:--------------------------------------:|:--------------------------------------------|
|help         |Help about any command                  |  using iwallet -h to get further infomation
|account      |Account manage                          |  ./iwallet account -n id
|balance      |check balance of specified account      |  ./iwallet balance ~/.iwallet/id_ed25519.pub
|block        |print block info, default find by block number   |  
|call         |Call a method in some contract          |  ./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' -k SecKeyPath --expiration 50
|compile      |Compile contract files to smart contract|  ./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
|net          |Get network id                          |  ./iwallet net
|publish      |sign to a .sc file with .sig files, and publish it        |./iwallet publish -k ~/.iwallet/id_ed25519 ./dashen.sc ./dashen.sig0 ./dashen.sig1
|sign         |Sign to .sc file                        |  ./iwallet sign -k ~/.iwallet/id_ed25519 ./test.sc
|transaction  |find transaction by transaction hash    |  ./iwallet transaction HUVdKWhstUHbdHKiZma4YRHGQZwVXerh75hKcXTdu39t

## 命令实例
### help:

查看`iwallet`帮助信息

```
./iwallet -h
```

### account:

创建IOST账户，账号ID对应的公钥和私钥默认保存在~/.iwallet/目录

```
./iwallet account -n id
return:
the iost account ID is:
IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW

```

### balance:

查询账户余额

```
./iwallet balance IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
return:
1000 iost
```

### block:

通过block号或者hash，查询block

```
# 查询0号block数据
./iwallet block -m num 0
return:
{"head":{"txsHash":"bG7L/GLaF4l8AhMCzdl9r7uVvK6BwqBq/sMMuRqbUH0=","merkleHash":"cv7EfVzjHCzieYStfEm61Ew4zbNFYN80i/6J8Ijhbos=","witness":"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A"},"hash":"9NzDz2iueLZ4e8YDotIieJRZrlTMddbjaJAvSV23TFU=","txhash":["3u12deEbLcyP7kI5k+WIuxUrskAOu8UKUOPV+H51bjE="]}
```

### call:

call命令用于调用链上合约中的方法


```
# 调用iost.system合约中的Transfer方法，账号IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP转给账号IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk 100token，
# -k为指定私钥地址，--expiration为指定交易超时时间
./iwallet call "iost.system" "Transfer" '["IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP", "IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk", 100]' -k ~/.iwallet/id_ed25519 --expiration 50
return:
ok
8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
```

### net:

net命令用于获取iserver的网络地址

```
./iwallet net
return:
netId: 12D3KooWNdJgdRAAYoHvrYgCHhNEXS9p7LshjmJWJhDApMXCfahk

```

### transaction:

transaction命令用于查询

```
./iwallet transaction 8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
return:
txRaw:<time:1537540108548894481 expiration:1537540158548891677 gasLimit:1000 gasPrice:1 actions:<contract:"iost.system" actionName:"Transfer" data:"[\"IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP\", \"IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk\", 100]" > publisher:<algorithm:2 sig:"\224iI\0300\317;\337N\030\031)'\277/xO\231\325\277\022\217M\017k.\260\205+*$\235\017}\353\007\206\352\367N(\203\343\333\017\374\361\230\313,\231\313* oK\270.f;6\371\332\010" pubKey:"_\313\236\251\370\270:\004\\\016\312\300\2739\304\317Jt\330\344P\347s\2413!\3725\3126\246\247" > > hash:"m\005\2613%\371\234\233\315\377@\016\253Aw\024\214IX@\0368\330\370T\241\267\342\256\252\354P"

```

### compile/publish/sign:

命令使用请参照[Deployment-and-invocation](../3-smart-contract/Deployment-and-invocation)
