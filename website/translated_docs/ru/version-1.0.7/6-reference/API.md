---
id: version-1.0.7-API
title: API
sidebar_label: API
original_id: API
---

---
## /getChainInfo
Возвращает информацию о блокчейне IOST  
### Параметры  
None  
### Ответ  

| Ключ | Значение |
| netType | Это тип сети блокчейна IOST. Он может быть одним из 'debugnet', 'testnet' и 'mainnet' |
|protocolVersion|Сейчас должен быть '1.0'
|witnessList|Текущий список witness
|height|Текущая высота blockchain
|headBlock|Информация о головном блоке на самой длинной цепи.
|headBlock.head.number|Высота блока
|headBlock.head.witness|Witness(производитель) блока
|--|--|
|headBlock.hash|Base58 кодированный хэш блока
|headBlock.txs|Транзакции в блоке. Но сейчас значение пусто.
|headBlock.txhash|Base58 закодированные хеши транзакций в блоке
|headBlock.receipts|Квитанции(receipt) блока. Но сейчас значение пусто.
|headBlock.receiptHash|Base58 закодированные хеши receipt в блоке
|latestConfirmedBlock| Информация о последнем подтвержденном блоке. Структура содержимого json такая же, как и 'headBlock'

### Пример
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
Возвращает информацию узла сервера IOST  
### Параметры  
None  
### Ответ  

| Ключ | Значение |
|--|--|
|gitHash|Git hash из бинарного файла 'iserver'
|buildTime|Время сборки бинарного 'server'
|mode|Текущий режим сервера. Он может быть одним из 'ModeInit', 'ModeNormal' и 'ModeSync'
|network|Сетевая информация узла
|network.ID| ID узла в p2p сети
|network.peerCount|Количество Peer-ов  узла
|network.peerInfo|Информация о Peer-ах узла
|network.peerInfo[idx].ID|ID  idx-го peer-а
|network.peerInfo[idx].addr|Адрес idx-го peer-а

### Пример
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
Возвращает информацию узла сервера IOST  
### Параметры  

| Ключ | Значение |
|--|--|
|hash|Base58 закодированный хеш для запрошенного блока
|complete|Нужно ли возвращать полные txs и receipts, или возвращать только их хеши
### Ответ  
Такой же как и информация о блоке в 'getChainInfo' api  
### Пример  
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
Возвращает информацию узла сервера IOST  
### Параметры  

| Ключ | Значение |
|--|--|
|num|Num(высота) для запрошенного блока
|complete|(optional) Нужно ли возвращать полные txs и receipts, или возвращать только их хеши
### Ответ  
Такой же как и информация о блоке в 'getChainInfo' api  
### Пример  
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
Получает транзакцию по ее закодированному base58 хешу  
### Параметры  

| Ключ | Значение |
|--|--|
|hash|Base58 закодированный хеш транзакции
### Ответ  
Информация о транзакции  
### Пример  
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
Получает квитанцию (receipt) транзакции по закодированному base58 хешу транзакции  
### Параметры  

| Ключ | Значение |
|--|--|
|hash|Base58 закодированный хеш транзакции
### Ответ  
| Ключ | Значение |
|--|--|
|hash|Base58 закодированный хеш receipt
|txReceiptRaw.gasUsage|Газ потраченный на эту транзакцию
|txReceiptRaw.status.code|Код возврата этой транзакции. 0 означает все ОК
|txReceiptRaw.status.message|Сообщение о результате этой транзакции. Оно может быть пустое или сообщение об ошибке
### Пример  
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
Получает квитанцию (receipt) по ее закодированному base58 хешу  
### Параметры  

| Ключ | Значение |
|--|--|
|hash|Base58 закодированный хеш Квитанции
### Ответ  
Возвращает информацию о квитанции с такой же json структурой как в `getTxReceiptByTxHash`  
### Пример  
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
