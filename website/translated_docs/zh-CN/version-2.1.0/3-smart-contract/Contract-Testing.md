---
id: Contract-Testing
title: 合约测试
sidebar_label: 合约测试
---

为了测试智能合约的方便性， IOST为开发者提供了可以单独造块打包合约的docker镜像。 可以供大家在自己的开发机器单独启动作为区块链RPC请求的接收端， 负责辅助在正式合约上链之前的正确性， 功能性测试。

需要注意的是， 当上传智能合约至RPC接受端时可能合约并不能直接上链。 其需要等待下次造块时间方可上链， 并且合约是否合法的检查也是在下次上链时候进行的。

## 启动docker镜像

```bash
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:2.0.0
```

在这里， 我们将docker的30002好端口与本机的30002端口进行了映射， 这样的话我们对30002端口发送的```RPC```请求将会成功发送到docker里面， 被我们的区块程序打包上链。

### 注意事项

在我们的这个镜像中， 所有的IOST都被存在了一个初始账户中。 该账户有21000000000个IOST， 我们如果需要使用其他账户发起交易， 或者发布合约， 需要先使用该账户中进行IOST转账。 因为任何的IOST交易都会消耗Gas， 而所有币都在初始账户中， 意味着一开始只有初始账户可以付得起Gas费用， 只有初始账户可以发起交易。


### 如何将 IOST 转到其他账户

#### 生成一个账户

```bash
// This will generate a private/public key pair under ~/.iwallet/ folder
./iwallet account
// Import Admin 
./iwallet account --import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```

##### 生成一笔交易

```bash
// Normally we ask the fromID to sign the transaction
./iwallet -s localhost:30002 --account admin  account --create yourAccountName --initial_balance 1000 --initial_gas_pledge 10 --initial_ram 0
// Example
./iwallet -s localhost:30002 --account admin  account --create lispczz3 --initial_balance 1000 --initial_gas_pledge 10 --initial_ram 0
```

## 检验上链是否成功

当我们发布一个交易或者合约上链时， 其实是发起了一个Transaction。 ```iWallet``` 程序会对这个Transaction返还一个Hash值， 这个Hash值即为发布的交易/合约的ID， 我们可以使用这个ID来查看这个Transaction是否成功上链。

```bash
./iwallet transaction $TxID
```

如果上链失败了， 我们可以导出docker中的log去查看具体的报错信息。

```bash
docker logs $ContainerID
```
