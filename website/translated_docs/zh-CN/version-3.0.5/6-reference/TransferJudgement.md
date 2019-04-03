---
id: TransferJudgement
title: 如何判断一笔转账是否成功
sidebar_label: TransferJudgement
---

## 判断转账交易是否成功

确认一笔交易包含转账且转账成功，需要判断两点：交易不可逆；交易中包含转账信息且执行成功。
### 如何判断交易不可逆
判断一个交易是否不可逆，有三种途径：

* 调用 [getTxByHash](./API.html#gettxbyhash-hash) 接口，若返回值中的 `status` 字段等于 `IRREVERSIBLE`，则此交易不可逆。
* 调用 [getTxReceiptByTxHash](./API.html#gettxreceiptbytxhash-hash) 接口（本接口只会返回不可逆交易的 TxReceipt ），若有返回值，则此交易不可逆。
* 调用 [getBlockByNumber](./API.html#getblockbynumber-number-completeh) 和 [getBlockByHash](./API.html#getblockbyhash-hash-complete) 接口，若返回值中的 `status` 字段等于 `IRREVERSIBLE`，则此区块中的所有交易都不可逆。

### 如何判断交易中包含转账且执行成功

确认一个交易中是否包含转账，**只能**判断 tx\_receipt 中的 receipts 字段。获取交易的 tx\_receipt 可以通过调用 [getTxByHash](./API.html#gettxbyhash-hash) 接口和 [getTxReceiptByTxHash](./API.html#gettxreceiptbytxhash-hash) 接口；另外，[getBlockByNumber](./API.html#getblockbynumber-number-completeh) 和 [getBlockByHash](./API.html#getblockbyhash-hash-complete) 接口返回的 block 结构中也包含交易的 tx\_receipt。 一笔成功的转账交易，包含的 receipts 如下：

```
"tx_receipt": {
    "tx_hash": "CHeKFLzzpcfZ2Fo9gHwRM7PFkZy5SoEKSda2ZrTYfHQf",
    "gas_usage": 8750,
    "ram_usage": {},
    "status_code": "SUCCESS",
    "message": "",
    "returns": [
      "[]"
    ],
    "receipts": [
      {
        "func_name": "token.iost/transfer",
        "content": "[\"iost\",\"fromacc\",\"toacc\",\"1.0000\",\"\"]"
      }
    ]
  },
```

`receipts` 字段为一个列表，若某一项的 `func_name` 字段等于 `token.iost/transfer`，则这笔交易包含转账，转账的币种、账户和金额需要进一步解析这一项的 `content` 字段。`content` 字段是一个包含 5 个字符串的数组 json 序列化后的结果。将 `content` 字段 json 反序列化后，第一个元素为代币名称，第二个元素为转出账户名，第三个元素为接收账户名，第四个元素为转账金额，第五个元素为 memo。处理第四个元素转账金额时，如果发现字符串中包含除 [0-9.] 以外的字符，应该忽略掉这笔转账，其他情况可以直接将这个字符串转为浮点数处理。

确认一个交易是否执行成功，要判断 tx_receipt 中的 `status_code` 字段等于 `SUCCESS`。

## 常见的错误

### 通过 Actions 判断转账交易是否生效
actions 为交易的动作，receipts 为交易的执行结果。若单纯根据 actions 字段中是否调用了 token.iost 合约的 transfer 方法来判断转账是否生效是不严谨的。在某些特定的情况下（比如延迟交易），即使 tx_receipt 中 `status_code` 字段为 `SUCCESS `，这笔交易也不一定被成功执行了，但如果转账交易被成功执行了，则一定有 receipts。所以判断转账成功与否，只能通过 receipts 字段，而不能通过 actions 字段。

### 直接将转账金额字符串转为浮点数处理
主网 token 合约的转账方法实现方式为：先根据代币 decimal 对转账金额进行截取，然后将截取后的结果转为浮点数处理。所以对于这样的一笔转账：

```
"receipts": [
      {
        "func_name": "token.iost/transfer",
        "content": "[\"iost\",\"aaaaa\",\"bbbbb\",\"1.20294517598E7\",\"\"]"
      }
]
```
实际转移的 token 数量是 1.20294517。若链下解析时，直接将 "1.20294517598E7" 转为浮点数，有可能出现不符合预期的结果。因此我们建议当遇到转账金额字符串包含除了 [0-9.] 以外的字符时，直接忽略掉该笔转账。

### 未判断转账的代币名称
判断转账一定要注意判断代币名称，代币名称为 content 字段中第一个元素。对于下面这样一笔转账，如果没判断代币名称，直接当成 iost token 的转账，则会出现问题。

```
"receipts": [
      {
        "func_name": "token.iost/transfer",
        "content": "[\"sometoken\",\"aaaaa\",\"bbbbb\",\"1.20294517\",\"\"]"
      }
]
```

### 未判断交易执行状态
当 ram 不足时，转账交易执行失败但依然会有 receipts，比如下面的 case:

```
"tx_receipt": {
    "tx_hash": "xxxxxxxxxxxxxxx",
    "gas_usage": 186277,
    "ram_usage": {},
    "status_code": "BALANCE_NOT_ENOUGH",
    "message": "balance not enough after executing actions: pay ram failed. id: irisye need 335, actual 115",
    "returns": [
      "[\"\"]"
    ],
    "receipts": [
      {
        "func_name": "token.iost/transfer",
        "content": "[\"iost\",\"aaaaa\",\"vote.iost\",\"10\",\"\"]"
      }
    ]
  },
```
如果不判断 `status_code` 字段会错误的认为这笔转账成功了。

## 总结
确认一笔转账是否成功到账，需要判断：

* 交易不可逆
* 交易 `tx_receipt.statud_code` 等于 `SUCCESS`
* `tx_receipt.receipts` 中，`func_name` 等于 `token.iost/transfer`
* 校验 `content` 字段第一个元素为你期望的代币名称
* 校验 `content` 字段第四个元素中没有非法字符