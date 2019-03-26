---
id: TransferJudgement
title: How to judge the success of a transfer
sidebar_label: TransferJudgement
---

## Judging the success of transfer transactions


To confirm that a transaction contains a transfer and the transfer is successful, we need to judge two points: the transaction is irreversible; the transaction contains transfer information.

### How to judge the irreversibility of a transaction

There are three ways to judge whether a transaction is irreversible：

* Call the [getTxByHash](./API.html#gettxbyhash-hash) API, and if the `status` field in the return value equals `IRREVERSIBLE`, the transaction is irreversible.
* Call the [getTxReceiptByTxHash](./API.html#gettxreceiptbytxhash-hash) API (this API only returns TxReceipt for irreversible transactions), and if there is a return value, the transaction is irreversible.
* Call the [getBlockByNumber](./API.html#getblockbynumber-number-completeh) and [getBlockByHash](./API.html#getblockbyhash-hash-complete) API. If the `status` field in the return value is equal to `IRREVERSIBLE`, all transactions in this block are irreversible.



### How to judge a transaction including transfer

The **only** way to judge whether a transaction contains a transfer is to check the receipts field in tx\_receipt. The tx\_receipt can be obtained by calling the [getTxByHash](./API.html#gettxbyhash-hash) API and the [getTxReceiptByTxHash](./API.html#gettxreceiptbytxhash-hash) API; in addition, the block structure returned by [getBlockByNumber](./API.html#getblockbynumber-number-completeh) and [getBlockByHash](./API.html#getblockbyhash-hash-complete) API also contains the tx\_receipt of transactions. A successful transfer transaction includes receipts as follows:

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

The `receipts` field is a list. If the `func_name` field of an item equals to `token.iost/transfer`, the transaction contains a transfer. The token symbol, account and amount of the transfer need to be further resolved in the `content` field of the item. The `content` field is the result of JSON serialization of an array containing five strings. After the `content` field is JSON deserialized, the first element is token symbol, the second element is transfer account name, the third element is receive account name, the fourth element is transfer amount, and the fifth element is memo. When dealing with the fourth element transfer amount, if it is found that the string contains characters other than [0-9.], the transfer should be ignored. In other cases, the string can be directly converted to float for further processing.


## Common mistakes

### Judging the success of transfer by actions


Actions are the actions of a transaction, and receipts are the execution results of the transaction. It is not rigorous to judge the success of a transfer purely by checking the actions field of a transaction. In some special cases (e.g. delay transactions), even if the `status_code` field in tx\_receipt is `SUCCESS', the transaction may not be successfully executed, but if a transfer transaction is successfully executed, there must be receipts. So to judge whether the transfer is successful or not, we can only use the receipts field, not the actions field.


### Converting the transfer amount string to float directly

The transfer of mainnet token contract is realized by intercepting the transfer amount according to token decimal, and then converting the intercepted result to float. So for such a transfer


```
"receipts": [
      {
        "func_name": "token.iost/transfer",
        "content": "[\"iost\",\"aaaaa\",\"bbbbb\",\"1.20294517598E7\",\"\"]"
      }
]
```

The actual amount of token transferred is 1.20294517. If the "1.20294517598E7" is converted to float directly, the result may not meet the expectation. Therefore, we recommend that when encountering a transfer amount string containing characters other than [0-9.], the transfer should be ignored directly.



### Not judge token symbol

When judging a transfer, we must pay attention to the name of the token, which is the first element in the content field. For such a transfer as the following, if the name of the token is not judged and it is directly treated as an iost token transfer, problems will arise.


```
"receipts": [
      {
        "func_name": "token.iost/transfer",
        "content": "[\"sometoken\",\"aaaaa\",\"bbbbb\",\"1.20294517\",\"\"]"
      }
]
```
