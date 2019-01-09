---
id: version-2.0.0-API
title: API
sidebar_label: API
original_id: API
---

---
## /getChainInfo
IOSTサーバーノードの情報を取得します。
### パラメータ  
なし  
### レスポンス  

| キー |値 |
|--|--|
| netType | IOSTブロックチェーンのネットワークタイプ。'debugnet'、'testnet'、'mainnet'のいずれか |
|protocolVersion|今の所、'1.0'
|witnessList|現在の出資リスト
|height|現在のブロック高
|headBlock|最新の先頭ブロックの情報
|headBlock.head.number|ブロック高
|headBlock.head.witness|ブロックの出資(プロデューサー)
|headBlock.hash|Base58でエンコードされたブロックのハッシュ
|headBlock.txs|Tブロック内のトランザクションですが、今は空
|headBlock.txhash|Base58でエンコードされたトランザクションのハッシュ
|headBlock.receipts|ブロックのレシートですが、今は空
|headBlock.receiptHash|Base58でエンコードされたレシートのハッシュ
|latestConfirmedBlock| 最新確認ブロックの情報で、JSONの構造は'headBlock'と同じ

### 例
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
IOSTサーバーノードの情報を取得します。
### パラメータ  
なし  
### レスポンス  

| キー |値 |
|--|--|
|gitHash|'iserver'バイナリのGitハッシュ
|buildTime|'iserver'バイナリのビルド時間
|mode|サーバーの実行中モード。 'ModeInit'、'ModeNormal'、'ModeSync'のいずれか
|network|ノードのネットワーク情報
|network.ID|P2Pネットワーク内のノードID
|network.peerCount|ノードのピア(隣接)ノード数
|network.peerInfo|ピアノードの情報
|network.peerInfo[idx].ID|idx番目のピアのID
|network.peerInfo[idx].addr|idx番目のピアのアドレス

### 例
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
ハッシュによりブロック情報を取得します。
### パラメータ  

| キー |値 |
|--|--|
|hash|リクエストされたブロックのBase58でエンコードされたハッシュ 
|complete|完全なトランザクションとレシートかハッシュだけか
### レスポンス  
'getChainInfo'APIのブロック情報と同じです。
### 例  
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
## /getBlockByNumber/{number}/{complete}
ブロック番号によりブロック情報を取得します。
### パラメータ  

| キー |値 |
|--|--|
|num|ブロック番号(ブロック高)
|complete|(オプション) 完全なトランザクションとレシートかハッシュだけか
### レスポンス  
'getChainInfo'APIのブロック情報と同じです。
### 例  
```
$ curl -s -X GET http://127.0.0.1:30001/getBlockByNumber/11/false |python -m json.tool
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
Base58でエンコードされたハッシュによりトランザクションを取得します。
### パラメータ  

| キー |値 |
|--|--|
|hash|Base58でエンコードされたハッシュ
### レスポンス  
トランザクションの情報
### 例  
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
トランザクションのハッシュによりレシートを取得します。
### パラメータ  

| キー |値 |
|--|--|
|hash|Base58でエンコードされたトランザクションのハッシュ
### レスポンス  
| キー |値 |
|--|--|
|hash|Base58エンコードされたレシートのハッシュ
|txReceiptRaw.gasUsage|トランザクションのGAS消費量
|txReceiptRaw.status.code|トランザクションコードの戻り値。0は正常終了
|txReceiptRaw.status.message|トランザクションの結果メッセージ。空かエラーメッセージ
|txReceiptRaw.receipts|トランザクションで生成されたレシート
### 例  
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
Base58エンコードされたハッシュによりレシートを取得する。
### パラメータ  

| キー |値 |
|--|--|
|hash|Base58エンコードされたレシートのハッシュ
### レスポンス  
`getTxReceiptByTxHash`と同様のJSON構造を持ったレシート
### 例  
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
