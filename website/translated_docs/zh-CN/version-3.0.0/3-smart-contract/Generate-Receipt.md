---
id: 生成收据
title: 在智能合约中生成收据
sidebar_label: 在智能合约中生成收据
---

## 特征

收据用于证明或提醒某些操作的发生，典型的应用是记录从A到B的转账以及附加备忘录。

智能合约可以通过调用区块链基础设施提供的系统功能`blockchain.receipt`来生成收据。 收据存储在与交易相关的区块数据中，当然这将由区块链网络中的所有节点验证。 请记住，在合约中无法查询收据，只能通过解析区块数据或通过rpc界面使用交易哈希值来查询收据。
收据比合约存储便宜得多。 它只需要gas，不同于合约存储，既需要gas也需要ram。

## 生成收据

智能合约通过调用系统功能 `blockchain.receipt` 生成收据。 下面是一个例子，当调用此合约的 receiptf 函数时，将生成三个收据。

```js
class Contract {
    init() {
    }

    receiptf() {
        blockchain.receipt(JSON.stringify(["from", "to", "100.01"]));
        blockchain.receipt('{"name": "Cindy", "amount": 1000}');
        blockchain.receipt("transfer accepted");
    }
}

module.exports = Contract;
```

`blockchain.receipt` 接受一个字符串参数，该参数指的是收据的内容，并且没有返回值。 如果未成功执行，将抛出运行时错误，这在正常情况下不应发生。 我们强烈建议开发人员使用 json 格式字符串作为内容，这样便于后续解析。

生成的收据还包含合约名称和操作名称，表明那个函数对收据负责。 上面生成的三张收据如下所示：

```console
# first
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"[\"from\",\"to\",\"100.01\"]"}
# second
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"{\"name\": \"Cindy\", \"amount\": 1000}"}
# third
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"transfer accepted"}
```
`ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLM` 是此合约的ID。

## 查询收据

### 按转账哈希值查询收据

可以通过rpc界面使用转账哈希查询特定转账生成的收据。

请参阅 [/getTxReceiptByHash](6-reference/API.md#gettxreceiptbyhash-hash)


### 按区块数据查询收据

完整的区块数据包含所有转账和相应的收据，可以下载并解析区块数据以获取此块中生成的所有收据。A complete block data contains all the transactions and the corresponding receipts, one can download the block data and
parse to get all the receipts generated in this block.

请参阅 [ /getBlockByHash](6-reference/API.md#getblockbyhash-hash-complete) 和 [/getBlockByNumber](6-reference/API.md#getblockbynumber-number-complete)
并将请求参数中的 `complete` 设置为 `true`
