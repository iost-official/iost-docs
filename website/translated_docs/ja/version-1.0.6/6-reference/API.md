---
id: version-1.0.6-API
title: API
sidebar_label: API
original_id: API
---

### /estimateGas
---
##### ***POST***
**概要:** 未サポート

**パラメータ**

| 名前 | 場所 | 説明 | 必須 | スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | はい | [rpcRawTxReq](#rpcrawtxreq) |

**レスポンス**

| コード | 説明 | スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcGasRes](#rpcgasres) |

### /getBalance/{ID}/{useLongestChain}
---
##### ***GET***
**概要:** アカウントIDにより残高を取得します。

**パラメータ**

| 名前 | 場所 | 説明 | 必須 | スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| ID | path |  | はい | string |
| useLongestChain | path |  | はい | boolean (boolean) |

**レスポンス**

| コード | 説明 | スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetBalanceRes](#rpcgetbalanceres) |

### /getBlockByHash/{hash}/{complete}
---
##### ***GET***
**概要:** ハッシュによりブロックを取得します。

**パラメータ**

| 名前 | 場所 | 説明 | 必須 | スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | はい | string |
| complete | path |  | はい | boolean (boolean) |

**レスポンス**

| コード | 説明 | スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getBlockByNum/{num}/{complete}
---
##### ***GET***
**概要:** ブロック番号でブロックを取得します。

**パラメータ**

| 名前 | 場所 | 説明 | 必須 | スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| num | path |  | はい | string (int64) |
| complete | path |  | はい | boolean (boolean) |

**レスポンス**

| コード | 説明 | スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getHeight
---
##### ***GET***
**概要:** get the current height of the blockchain

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcHeightRes](#rpcheightres) |

### /getNetID
---
##### ***GET***
**概要:** ネットIDを取得します。

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetNetIDRes](#rpcgetnetidres) |

### /getState/{key}
---
##### ***GET***
**概要:** get the value of the corresponding key in stateDB

**パラメータ**

| 名前 | 場所 | 説明 |必須 |スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| key | path |  | はい | string |
| field | query |  | いいえ | string |

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetStateRes](#rpcgetstateres) |

### /getTxByHash/{hash}
---
##### ***GET***
**概要:** get the tx by hash

**パラメータ**

| 名前 | 場所 | 説明 |必須 |スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | はい | string |

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpctxRes](#rpctxres) |

### /getTxReceiptByHash/{hash}
---
##### ***GET***
**概要:** ハッシュによりレシートを取得します。

**パラメータ**

| 名前 | 場所 | 説明 |必須 |スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | はい | string |

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /getTxReceiptByTxHash/{hash}
---
##### ***GET***
**概要:** トランザクションハッシュ(txhash)でレシートを取得します。

**パラメータ**

| 名前 | 場所 | 説明 |必須 |スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | はい | string |

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /sendRawTx
---
##### ***POST***
**概要:** エンコードしたトランザクションを送信します。

**パラメータ**

| 名前 | 場所 | 説明 |必須 |スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | はい | [rpcRawTxReq](#rpcrawtxreq) |

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 |  | [rpcSendRawTxRes](#rpcsendrawtxres) |

### /subscribe
---
##### ***POST***
**概要:** イベントをサブスクライブします。

**パラメータ**

| 名前 | 場所 | 説明 |必須 |スキーマ |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | はい | [rpcSubscribeReq](#rpcsubscribereq) |

**レスポンス**

| コード | 説明 |スキーマ |
| ---- | ----------- | ------ |
| 200 | (streaming responses) | [rpcSubscribeRes](#rpcsubscriberes) |

### モデル
---

### EventTopic  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| EventTopic | string |  |  |

### blockBlockHead  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| version | string (int64) |  | いいえ |
| parentHash | byte |  | いいえ |
| txsHash | byte |  | いいえ |
| merkleHash | byte |  | いいえ |
| info | byte |  | いいえ |
| number | string (int64) |  | いいえ |
| witness | string |  | いいえ |
| time | string (int64) |  | いいえ |

### cryptoSignatureRaw  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| algorithm | integer |  | いいえ |
| sig | byte |  | いいえ |
| pubKey | byte |  | いいえ |

### eventEvent  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| topic | [EventTopic](#eventtopic) |  | いいえ |
| data | string |  | いいえ |
| time | string (int64) |  | いいえ |

### rpcBlockInfo  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| head | [blockBlockHead](#blockblockhead) |  | いいえ |
| hash | byte |  | いいえ |
| txs | [ [txTxRaw](#txtxraw) ] |  | いいえ |
| txhash | [ byte ] |  | いいえ |
| receipts | [ [txTxReceiptRaw](#txtxreceiptraw) ] |  | いいえ |
| receiptHash | [ byte ] |  | いいえ |

### rpcGasRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| gas | string (uint64) |  | いいえ |

### rpcGetBalanceRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| balance | string (int64) |  | いいえ |

### rpcGetNetIDRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| ID | string |  | いいえ |

### rpcGetStateRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| value | string |  | いいえ |

### rpcHeightRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| height | string (int64) |  | いいえ |

### rpcRawTxReq  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| data | byte |  | いいえ |

### rpcSendRawTxRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| hash | string |  | いいえ |

### rpcSubscribeReq  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| topics | [ [EventTopic](#eventtopic) ] |  | いいえ |

### rpcSubscribeRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| ev | [eventEvent](#eventevent) |  | いいえ |

### rpctxReceiptRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| txReceiptRaw | [txTxReceiptRaw](#txtxreceiptraw) |  | いいえ |
| hash | byte |  | いいえ |

### rpctxRes  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| txRaw | [txTxRaw](#txtxraw) |  | いいえ |
| hash | byte |  | いいえ |

### txActionRaw  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| contract | string |  | いいえ |
| actionName | string |  | いいえ |
| data | string |  | いいえ |

### txReceiptRaw  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| type | integer |  | いいえ |
| content | string |  | いいえ |

### txStatusRaw  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| code | integer |  | いいえ |
| message | string |  | いいえ |

### txTxRaw  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| time | string (int64) |  | いいえ |
| expiration | string (int64) |  | いいえ |
| gasLimit | string (int64) |  | いいえ |
| gasPrice | string (int64) |  | いいえ |
| actions | [ [txActionRaw](#txactionraw) ] |  | いいえ |
| signers | [ byte ] |  | いいえ |
| signs | [ [cryptoSignatureRaw](#cryptosignatureraw) ] |  | いいえ |
| publisher | [cryptoSignatureRaw](#cryptosignatureraw) |  | いいえ |

### txTxReceiptRaw  

| 名前 | 型 | 説明 |必須 |
| ---- | ---- | ----------- | -------- |
| txHash | byte |  | いいえ |
| gasUsage | string (int64) |  | いいえ |
| status | [txStatusRaw](#txstatusraw) |  | いいえ |
| succActionNum | integer |  | いいえ |
| receipts | [ [txReceiptRaw](#txreceiptraw) ] |  | いいえ |
