---
id: version-1.0.6-API
title: API
sidebar_label: API
original_id: API
---

### /estimateGas
---
##### ***POST***
**Summary:** еще не поддерживается

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcRawTxReq](#rpcrawtxreq) |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcGasRes](#rpcgasres) |

### /getBalance/{ID}/{useLongestChain}
---
##### ***GET***
**Summary:** получить баланс аккаунта по ID аккаунта

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| ID | path |  | Yes | string |
| useLongestChain | path |  | Yes | boolean (boolean) |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetBalanceRes](#rpcgetbalanceres) |

### /getBlockByHash/{hash}/{complete}
---
##### ***GET***
**Summary:** получить блок по хэшу

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |
| complete | path |  | Yes | boolean (boolean) |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getBlockByNum/{num}/{complete}
---
##### ***GET***
**Summary:** получить блок по номеру

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| num | path |  | Yes | string (int64) |
| complete | path |  | Yes | boolean (boolean) |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getHeight
---
##### ***GET***
**Summary:** получить текущую высоту блокчейна

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcHeightRes](#rpcheightres) |

### /getNetID
---
##### ***GET***
**Summary:** получить ID сети

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetNetIDRes](#rpcgetnetidres) |

### /getState/{key}
---
##### ***GET***
**Summary:** получить значение соответствующего ключа в базе данных stateDB

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| key | path |  | Yes | string |
| field | query |  | No | string |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetStateRes](#rpcgetstateres) |

### /getTxByHash/{hash}
---
##### ***GET***
**Summary:** получить транзакцию по хэшу

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpctxRes](#rpctxres) |

### /getTxReceiptByHash/{hash}
---
##### ***GET***
**Summary:** получить квитанцию(receipt) по хэшу

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /getTxReceiptByTxHash/{hash}
---
##### ***GET***
**Summary:** получить квитанцию(receipt) по хэшу транзакции

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /sendRawTx
---
##### ***POST***
**Summary:** отправить закодированную транзакцию

**Parameters**

| Имя | Расположение | Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcRawTxReq](#rpcrawtxreq) |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 |  | [rpcSendRawTxRes](#rpcsendrawtxres) |

### /subscribe
---
##### ***POST***
**Summary:** подписаться на событие

**Parameters**

| Имя | Расположение| Описание | Требование | Схема |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcSubscribeReq](#rpcsubscribereq) |

**Responses**

| Код | Описание | Схема |
| ---- | ----------- | ------ |
| 200 | (streaming responses) | [rpcSubscribeRes](#rpcsubscriberes) |

### Models
---

### EventTopic  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| EventTopic | string |  |  |

### blockBlockHead  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| version | string (int64) |  | No |
| parentHash | byte |  | No |
| txsHash | byte |  | No |
| merkleHash | byte |  | No |
| info | byte |  | No |
| number | string (int64) |  | No |
| witness | string |  | No |
| time | string (int64) |  | No |

### cryptoSignatureRaw  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| algorithm | integer |  | No |
| sig | byte |  | No |
| pubKey | byte |  | No |

### eventEvent  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| topic | [EventTopic](#eventtopic) |  | No |
| data | string |  | No |
| time | string (int64) |  | No |

### rpcBlockInfo  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| head | [blockBlockHead](#blockblockhead) |  | No |
| hash | byte |  | No |
| txs | [ [txTxRaw](#txtxraw) ] |  | No |
| txhash | [ byte ] |  | No |
| receipts | [ [txTxReceiptRaw](#txtxreceiptraw) ] |  | No |
| receiptHash | [ byte ] |  | No |

### rpcGasRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| gas | string (uint64) |  | No |

### rpcGetBalanceRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| balance | string (int64) |  | No |

### rpcGetNetIDRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |

### rpcGetStateRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| value | string |  | No |

### rpcHeightRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| height | string (int64) |  | No |

### rpcRawTxReq  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| data | byte |  | No |

### rpcSendRawTxRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| hash | string |  | No |

### rpcSubscribeReq  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| topics | [ [EventTopic](#eventtopic) ] |  | No |

### rpcSubscribeRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| ev | [eventEvent](#eventevent) |  | No |

### rpctxReceiptRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| txReceiptRaw | [txTxReceiptRaw](#txtxreceiptraw) |  | No |
| hash | byte |  | No |

### rpctxRes  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| txRaw | [txTxRaw](#txtxraw) |  | No |
| hash | byte |  | No |

### txActionRaw  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| contract | string |  | No |
| actionName | string |  | No |
| data | string |  | No |

### txReceiptRaw  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| type | integer |  | No |
| content | string |  | No |

### txStatusRaw  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| code | integer |  | No |
| message | string |  | No |

### txTxRaw  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| time | string (int64) |  | No |
| expiration | string (int64) |  | No |
| gasLimit | string (int64) |  | No |
| gasPrice | string (int64) |  | No |
| actions | [ [txActionRaw](#txactionraw) ] |  | No |
| signers | [ byte ] |  | No |
| signs | [ [cryptoSignatureRaw](#cryptosignatureraw) ] |  | No |
| publisher | [cryptoSignatureRaw](#cryptosignatureraw) |  | No |

### txTxReceiptRaw  

| Имя | Тип | Описание | Требование |
| ---- | ---- | ----------- | -------- |
| txHash | byte |  | No |
| gasUsage | string (int64) |  | No |
| status | [txStatusRaw](#txstatusraw) |  | No |
| succActionNum | integer |  | No |
| receipts | [ [txReceiptRaw](#txreceiptraw) ] |  | No |
