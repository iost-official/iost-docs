---
id: API
title: API
sidebar_label: API
---

---
## /getChainInfo
Returns information of the IOST blockchain  
### Parameters  
None  
### Response  

| Key | Value |
|--|--|
| netType | This IOST blockchain network type. It can be one of 'debugnet', 'testnet' and 'mainnet' |
|protocolVersion|Must be '1.0' now
|witnessList|Current witness list
|height|Current blockchain height
|headBlock|Information of the head block on the longest chain.
|headBlock.head.number|Height of the block
|headBlock.head.witness|Witness(producer) of the block
|headBlock.hash|Base58 encoded hash of the block
|headBlock.txs|Transactions in the block. But the value is empty now.
|headBlock.txhash|Base58 encoded transaction hashes in the block
|headBlock.receipts|Receipts of the block. But the value is empty now.
|headBlock.receiptHash|Base58 encoded receipt hashes of the block
|latestConfirmedBlock| Information of the latest confirmed block. The json content structure is same as 'headBlock'

### Example
```
$ curl -s -X GET http://127.0.0.1:30001/getChainInfo|python -m json.tool
{
    "headBlock": {
        "hash": "62LUg4MSavYphZTpCVgJaDKgqzDt8XutvfNDebiNW97N",
        "head": {
            "info": null,
            "merkleHash": "x0H6sO25+ulV6yYIY+90lreD6LxE2YD+ks9OKbU1z/I=",
            "number": "11",
            "parentHash": "z7+vyuQUb9Bxxz7i+zE/r7LyvLu4rCYBOJ6scbsIn00=",
            "time": "513312591",
            "txsHash": "XEDPW7v09J+f3ZmLMyazw9vOzY/kGz5eyEQenRn32VQ=",
            "version": "0",
            "witness": "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
        },
        "receiptHash": [
            "43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj"
        ],
        "receipts": [],
        "txhash": [
            "4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv"
        ],
        "txs": []
    },
    "height": "11",
    "latestConfirmedBlock": {
        "hash": "62LUg4MSavYphZTpCVgJaDKgqzDt8XutvfNDebiNW97N",
        "head": {
            "info": null,
            "merkleHash": "x0H6sO25+ulV6yYIY+90lreD6LxE2YD+ks9OKbU1z/I=",
            "number": "11",
            "parentHash": "z7+vyuQUb9Bxxz7i+zE/r7LyvLu4rCYBOJ6scbsIn00=",
            "time": "513312591",
            "txsHash": "XEDPW7v09J+f3ZmLMyazw9vOzY/kGz5eyEQenRn32VQ=",
            "version": "0",
            "witness": "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
        },
        "receiptHash": [
            "43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj"
        ],
        "receipts": [],
        "txhash": [
            "4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv"
        ],
        "txs": []
    },
    "netType": "debugnet",
    "protocolVersion": "1.0",
    "witnessList": [
        "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
    ]
}
```

---
## /getNodeInfo
Returns information of the IOST server node  
### Parameters  
None  
### Response  

| Key | Value |
|--|--|
|gitHash|Git hash of the 'iserver' binary
|buildTime|Building time of the 'server' binary
|mode|Current mode of the server. It can be one of 'ModeInit', 'ModeNormal' and 'ModeSync'
|network|Network information of the node 
|network.ID|Node ID in the p2p network
|network.peerCount|Peer count of the node
|network.peerInfo|Peer information of the node
|network.peerInfo[idx].ID|ID of the idx-th peer
|network.peerInfo[idx].addr|Address of the idx-th peer

### Example
```
$ curl -s -X GET http://127.0.0.1:30001/getNodeInfo|python -m json.tool
{
    "buildTime": "20181017_101014+0000",
    "gitHash": "6248a34cd645681f09dd72eeb908398f9dc0c116",
    "mode": "ModeNormal",
    "network": {
        "ID": "12D3KooWLYmeFqkumboHoSWfSUJz7RmwfMLwg7pMYjzEiFt4EZBK",
        "peerCount": 2,
        "peerInfo": [
            {
                "ID": "12D3KooWH8yqnJ7sb1NZijiXRLrg138XgJ7bf53Lu69ve4Sq3Pm3",
                "addr": "/ip4/13.251.250.120/tcp/30000"
            },
            {
                "ID": "12D3KooWAiRUbb8rk6YLWDPUYUCEi1rCvcA7rnn3RMCnRiksqEYJ",
                "addr": "/ip4/13.237.106.39/tcp/30000"
            }
        ]
    }
}
```

---
## /getBlockByHash/{hash}/{complete}
Returns information of the IOST server node  
### Parameters  

| Key | Value |
|--|--|
|hash|Base58 encoded hash for the requested block
|complete|Whether to return full txs and receipts, or just return their hashes
### Response  
The same as the block info in 'getChainInfo' api  
### Example  
```
$ curl -s -X GET http://127.0.0.1:30001/getBlockByHash/62LUg4MSavYphZTpCVgJaDKgqzDt8XutvfNDebiNW97N/true |python -m json.tool
{
    "hash": "62LUg4MSavYphZTpCVgJaDKgqzDt8XutvfNDebiNW97N",
    "head": {
        "info": null,
        "merkleHash": "x0H6sO25+ulV6yYIY+90lreD6LxE2YD+ks9OKbU1z/I=",
        "number": "11",
        "parentHash": "z7+vyuQUb9Bxxz7i+zE/r7LyvLu4rCYBOJ6scbsIn00=",
        "time": "513312591",
        "txsHash": "XEDPW7v09J+f3ZmLMyazw9vOzY/kGz5eyEQenRn32VQ=",
        "version": "0",
        "witness": "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
    },
    "receiptHash": [
        "43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj"
    ],
    "receipts": [
        {
            "gasUsage": "2015",
            "receipts": [],
            "status": {
                "code": 0,
                "message": ""
            },
            "succActionNum": 1,
            "txHash": "MtsOqLIPqRuIkxjC7CcygaOu2m+g2lreKhz/WDqcWdU="
        }
    ],
    "txhash": [
        "4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv"
    ],
    "txs": [
        {
            "actions": [
                {
                    "actionName": "SetCode",
                    "contract": "iost.system",
                    "data": "HERE WILL A LONG DATA STRING!! OMIT NOW!!"
                }
            ],
            "expiration": "1540297771456526000",
            "gasLimit": "3000",
            "gasPrice": "1",
            "publisher": {
                "algorithm": 2,
                "pubKey": "VzGt610agH7JxDglOJ5e3/cEEuRkOpRimmUq8b/PLwg=",
                "sig": "9VTWs+KNKBda95GeamJy8UGzqW56rDh9+PKkp1B/JLQwi+suRe8ul6446IT+AW7ijkGdJ4ahw1bYgwhEDTjCDw=="
            },
            "signers": [],
            "signs": [],
            "time": "1539937771456530000"
        }
    ]
}
```

---
## /getBlockByNum/{num}/{complete}
Returns information of the IOST server node  
### Parameters  

| Key | Value |
|--|--|
|num|Num(height) for the requested block
|complete|(optional) Whether to return full txs and receipts, or just return their hashes
### Response  
The same as the block info in 'getChainInfo' api  
### Example  
```
$ curl -s -X GET http://127.0.0.1:30001/getBlockByNum/11/false |python -m json.tool
{
    "hash": "62LUg4MSavYphZTpCVgJaDKgqzDt8XutvfNDebiNW97N",
    "head": {
        "info": null,
        "merkleHash": "x0H6sO25+ulV6yYIY+90lreD6LxE2YD+ks9OKbU1z/I=",
        "number": "11",
        "parentHash": "z7+vyuQUb9Bxxz7i+zE/r7LyvLu4rCYBOJ6scbsIn00=",
        "time": "513312591",
        "txsHash": "XEDPW7v09J+f3ZmLMyazw9vOzY/kGz5eyEQenRn32VQ=",
        "version": "0",
        "witness": "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
    },
    "receiptHash": [
        "43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj"
    ],
    "receipts": [],
    "txhash": [
        "4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv"
    ],
    "txs": []
}
```

---
## /getTxByHash/{hash}
Fetches the transaction by its base58 encoded hash  
### Parameters  

| Key | Value |
|--|--|
|hash|Base58 encoded transaction hash
### Response  
The transaction information  
### Example  
```
$ curl -s -X GET http://127.0.0.1:30001/getTxByHash/4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv|python -m json.tool
{
    "hash": "4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv",
    "txRaw": {
        "actions": [
            {
                "actionName": "SetCode",
                "contract": "iost.system",
                "data": "..."
            }
        ],
        "expiration": "1540297771456526000",
        "gasLimit": "3000",
        "gasPrice": "1",
        "publisher": {
            "algorithm": 2,
            "pubKey": "VzGt610agH7JxDglOJ5e3/cEEuRkOpRimmUq8b/PLwg=",
            "sig": "9VTWs+KNKBda95GeamJy8UGzqW56rDh9+PKkp1B/JLQwi+suRe8ul6446IT+AW7ijkGdJ4ahw1bYgwhEDTjCDw=="
        },
        "signers": [],
        "signs": [],
        "time": "1539937771456530000"
    }
}
```

---
## /getTxReceiptByTxHash/{hash}
Fetches receipt of a transaction by the base58 encoded hash of the transaction  
### Parameters  

| Key | Value |
|--|--|
|hash|Base58 encoded transaction hash
### Response  
| Key | Value |
|--|--|
|hash|Base58 encoded hash of the receipt
|txReceiptRaw.gasUsage|Gas used of this transaction
|txReceiptRaw.status.code|Return code of this transaction. 0 means all things Ok
|txReceiptRaw.status.message|Result message of this transaction. It can be empty or error message
### Example  
```
$ curl -s -X GET http://127.0.0.1:30001/getTxReceiptByTxHash/4RX7yVQNDvfWHYYLr5s9Cq6fAqyka3T9XTvk7y8H9qZv|python -m json.tool
{
    "hash": "43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj",
    "txReceiptRaw": {
        "gasUsage": "2015",
        "receipts": [],
        "status": {
            "code": 0,
            "message": ""
        },
        "succActionNum": 1,
        "txHash": "MtsOqLIPqRuIkxjC7CcygaOu2m+g2lreKhz/WDqcWdU="
    }
}
```

---
## /getTxReceiptByHash/{hash}
Fetches a receipt by its base58 encoded hash  
### Parameters  

| Key | Value |
|--|--|
|hash|Base58 encoded receipt hash
### Response  
Retruns a receipt info with the same json structure as in `getTxReceiptByTxHash`  
### Example  
```
curl -s -X GET http://127.0.0.1:30001/getTxReceiptByHash/43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj|python -m json.tool
{
    "hash": "43qkJuKgaMauLTv57q1pg4j5DYxieswPZqvS6epFUZHj",
    "txReceiptRaw": {
        "gasUsage": "2015",
        "receipts": [],
        "status": {
            "code": 0,
            "message": ""
        },
        "succActionNum": 1,
        "txHash": "MtsOqLIPqRuIkxjC7CcygaOu2m+g2lreKhz/WDqcWdU="
    }
}
```


 