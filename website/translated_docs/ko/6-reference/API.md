---
id: API
title: API
sidebar_label: API
---

### /estimateGas
---
##### ***POST***
**Summary:** 현재 지원되지 않습니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcRawTxReq](#rpcrawtxreq) |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcGasRes](#rpcgasres) |

### /getBalance/{ID}/{useLongestChain}
---
##### ***GET***
**Summary:** account ID로 주어진 계정의 잔액을 조회합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| ID | path |  | Yes | string |
| useLongestChain | path |  | Yes | boolean (boolean) |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetBalanceRes](#rpcgetbalanceres) |

### /getBlockByHash/{hash}/{complete}
---
##### ***GET***
**Summary:** 블록해쉬로 블록 정보를 가져옵니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |
| complete | path |  | Yes | boolean (boolean) |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getBlockByNum/{num}/{complete}
---
##### ***GET***
**Summary:** 블록넘버로 블록 정보를 가져옵니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| num | path |  | Yes | string (int64) |
| complete | path |  | Yes | boolean (boolean) |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcBlockInfo](#rpcblockinfo) |

### /getHeight
---
##### ***GET***
**Summary:** 현재 블록체인의 높이를 가져옵니다. (가장 마지막 블록넘버)

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcHeightRes](#rpcheightres) |

### /getNetID
---
##### ***GET***
**Summary:** 네트워크 아이디(net id)를 가져옵니다.

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetNetIDRes](#rpcgetnetidres) |

### /getState/{key}
---
##### ***GET***
**Summary:** 파라미터로 주어진 key로 stateDB에 저장된 값을 조회합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| key | path |  | Yes | string |
| field | query |  | No | string |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcGetStateRes](#rpcgetstateres) |

### /getTxByHash/{hash}
---
##### ***GET***
**Summary:** 트랜잭션 해시로 트랜잭션 정보를 조회합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpctxRes](#rpctxres) |

### /getTxReceiptByHash/{hash}
---
##### ***GET***
**Summary:** 해시로 트랜잭션 영수증(receipt)을 조회합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /getTxReceiptByTxHash/{hash}
---
##### ***GET***
**Summary:** 트랜잭션 해시를 통해 트랜잭션 영수증(receipt)을 조회합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| hash | path |  | Yes | string |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpctxReceiptRes](#rpctxreceiptres) |

### /sendRawTx
---
##### ***POST***
**Summary:** 인코드 된 트랜잭션을 전송합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcRawTxReq](#rpcrawtxreq) |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 |  | [rpcSendRawTxRes](#rpcsendrawtxres) |

### /subscribe
---
##### ***POST***
**Summary:** 이벤트를 구독합니다.

**Parameters**

| 이름 | 위치 | 설명 | 필수 파라미터 여부 | 스키마 |
| ---- | ---------- | ----------- | -------- | ---- |
| body | body |  | Yes | [rpcSubscribeReq](#rpcsubscribereq) |

**Responses**

| 코드 | 설명 | 스키마 |
| ---- | ----------- | ------ |
| 200 | (streaming responses) | [rpcSubscribeRes](#rpcsubscriberes) |

### Models
---

### EventTopic  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| EventTopic | string |  |  |

### blockBlockHead  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
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

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| algorithm | integer |  | No |
| sig | byte |  | No |
| pubKey | byte |  | No |

### eventEvent  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| topic | [EventTopic](#eventtopic) |  | No |
| data | string |  | No |
| time | string (int64) |  | No |

### rpcBlockInfo  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| head | [blockBlockHead](#blockblockhead) |  | No |
| hash | byte |  | No |
| txs | [ [txTxRaw](#txtxraw) ] |  | No |
| txhash | [ byte ] |  | No |
| receipts | [ [txTxReceiptRaw](#txtxreceiptraw) ] |  | No |
| receiptHash | [ byte ] |  | No |

### rpcGasRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| gas | string (uint64) |  | No |

### rpcGetBalanceRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| balance | string (int64) |  | No |

### rpcGetNetIDRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| ID | string |  | No |

### rpcGetStateRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| value | string |  | No |

### rpcHeightRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| height | string (int64) |  | No |

### rpcRawTxReq  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| data | byte |  | No |

### rpcSendRawTxRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| hash | string |  | No |

### rpcSubscribeReq  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| topics | [ [EventTopic](#eventtopic) ] |  | No |

### rpcSubscribeRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| ev | [eventEvent](#eventevent) |  | No |

### rpctxReceiptRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| txReceiptRaw | [txTxReceiptRaw](#txtxreceiptraw) |  | No |
| hash | byte |  | No |

### rpctxRes  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| txRaw | [txTxRaw](#txtxraw) |  | No |
| hash | byte |  | No |

### txActionRaw  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| contract | string |  | No |
| action이름 | string |  | No |
| data | string |  | No |

### txReceiptRaw  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| type | integer |  | No |
| content | string |  | No |

### txStatusRaw  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| code | integer |  | No |
| message | string |  | No |

### txTxRaw  

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
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

| 이름 | 타입 | 설명 | 필수 파라미터 여부 |
| ---- | ---- | ----------- | -------- |
| txHash | byte |  | No |
| gasUsage | string (int64) |  | No |
| status | [txStatusRaw](#txstatusraw) |  | No |
| succActionNum | integer |  | No |
| receipts | [ [txReceiptRaw](#txreceiptraw) ] |  | No |
