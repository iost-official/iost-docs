---
id: API
title: API
sidebar_label: API
---

### /estimateGas
---
##### ***POST***
**Summary:** not supported yet

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcRawTxReq](#rpcrawtxreq) |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcGasRes](#rpcgasres) |

### /getBalance/{ID}/{useLongestChain}
---
##### ***GET***
**Summary:** get the balance of some account by account ID

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| ID | path |  | Yes | string |
| useLongestChain | path |  | Yes | boolean (boolean) |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetBalanceRes](#rpcgetbalanceres) |

### /getBlockByHash/{hash}/{complete}
---
##### ***GET***
**Summary:** get the block by hash

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |
| complete | path |  | Yes | boolean (boolean) |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getBlockByNum/{num}/{complete}
---
##### ***GET***
**Summary:** get the block by number

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| num | path |  | Yes | string (int64) |
| complete | path |  | Yes | boolean (boolean) |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getHeight
---
##### ***GET***
**Summary:** get the current height of the blockchain

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcHeightRes](#rpcheightres) |

### /getNetID
---
##### ***GET***
**Summary:** get the Net ID

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetNetIDRes](#rpcgetnetidres) |

### /getState/{key}
---
##### ***GET***
**Summary:** get the value of the corresponding key in stateDB

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| key | path |  | Yes | string |
| field | query |  | No | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetStateRes](#rpcgetstateres) |

### /getTxByHash/{hash}
---
##### ***GET***
**Summary:** get the tx by hash

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpctxRes](#rpctxres) |

### /getTxReceiptByHash/{hash}
---
##### ***GET***
**Summary:** get receipt by hash

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /getTxReceiptByTxHash/{hash}
---
##### ***GET***
**Summary:** get receipt by txhash

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /sendRawTx
---
##### ***POST***
**Summary:** send encoded tx

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcRawTxReq](#rpcrawtxreq) |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 |  | [rpcSendRawTxRes](#rpcsendrawtxres) |

### /subscribe
---
##### ***POST***
**Summary:** subscribe an event

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcSubscribeReq](#rpcsubscribereq) |

**Responses**

| Code | Description | Schema |
| ---- | ----------- | ------ |
| 200 | (streaming responses) | [rpcSubscribeRes](#rpcsubscriberes) |

### Models
---

### EventTopic  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| EventTopic | string |  |  |

### blockBlockHead  

| Name | Type | Description | Required |
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

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| algorithm | integer |  | No |
| sig | byte |  | No |
| pubKey | byte |  | No |

### eventEvent  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| topic | [EventTopic](#eventtopic) |  | No |
| data | string |  | No |
| time | string (int64) |  | No |

### rpcBlockInfo  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| head | [blockBlockHead](#blockblockhead) |  | No |
| hash | byte |  | No |
| txs | [ [txTxRaw](#txtxraw) ] |  | No |
| txhash | [ byte ] |  | No |
| receipts | [ [txTxReceiptRaw](#txtxreceiptraw) ] |  | No |
| receiptHash | [ byte ] |  | No |

### rpcGasRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| gas | string (uint64) |  | No |

### rpcGetBalanceRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| balance | string (int64) |  | No |

### rpcGetNetIDRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |

### rpcGetStateRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| value | string |  | No |

### rpcHeightRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| height | string (int64) |  | No |

### rpcRawTxReq  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| data | byte |  | No |

### rpcSendRawTxRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| hash | string |  | No |

### rpcSubscribeReq  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| topics | [ [EventTopic](#eventtopic) ] |  | No |

### rpcSubscribeRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| ev | [eventEvent](#eventevent) |  | No |

### rpctxReceiptRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| txReceiptRaw | [txTxReceiptRaw](#txtxreceiptraw) |  | No |
| hash | byte |  | No |

### rpctxRes  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| txRaw | [txTxRaw](#txtxraw) |  | No |
| hash | byte |  | No |

### txActionRaw  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| contract | string |  | No |
| actionName | string |  | No |
| data | string |  | No |

### txReceiptRaw  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| type | integer |  | No |
| content | string |  | No |

### txStatusRaw  

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| code | integer |  | No |
| message | string |  | No |

### txTxRaw  

| Name | Type | Description | Required |
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

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| txHash | byte |  | No |
| gasUsage | string (int64) |  | No |
| status | [txStatusRaw](#txstatusraw) |  | No |
| succActionNum | integer |  | No |
| receipts | [ [txReceiptRaw](#txreceiptraw) ] |  | No |
