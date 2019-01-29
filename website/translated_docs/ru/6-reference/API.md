---
id: API
title: API
sidebar_label: API
---



## /getNodeInfo
##### GET

Возвращает информацию об серверном узле IOST  

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getNodeInfo
```

### Ответ  

Успешный ответ может выглядеть так:

```
200 OK

{
    "build_time": "20181208_161822+0800",
    "git_hash": "1f540ec5b619812cb01b7bbc3dd89dbd3849c6fb",
    "mode": "ModeNormal",
    "network": {
        "id": "12D3KooWGGauAVW7vQw33kAAttbyTVf81Urpi2f4LYBAXTYzhwqj",
        "peer_count": 1,
        "peer_info": [{
            "id": "12D3KooWPSPLPyDFtcbKUvQGWM7pCXWEhRAjA1A5nAAFEvnce1Dm",
            "addr": "/ip4/127.0.0.1/tcp/50004"
        }]
    }
}
```

Ключ             |Тип  данных       |Описание
----                |--         |--
build\_time |string         |Время создания бинарного 'server'
git\_hash       |string     |Git хеш бинарного 'iserver'
mode            |string     |Текущий режим сервера. Это может быть 'ModeInit', 'ModeNormal' и 'ModeSync'
network     |[NetworkInfo](#network)|Сетевая информация об узле

### NetworkInfo (Информация о сети)

Ключ             |Тип данных      |Описание
----                |--         |--
id                  |string         |ID узла в p2p сети
peer\_count |int32      |Количество пиров узла
peer\_info      |[PeerInfo]|Информация о пирах узла

### PeerInfo (Информация о пирах)

Ключ             |Тип данных       |Описание
----                |--         |--
id                  |string     |ID пира
addr                |struct     |Адрес idx-го пира




## /getChainInfo
##### GET

Возвращает информацию о блокчейне IOST

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getChainInfo
```

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "net_name": "debugnet",
    "protocol_version": "1.0",
    "chain_id": 1024,
    "head_block": "16041",
    "head_block_hash": "DLJVtko6nQnAdvQ7y6dXHo3WMdG324yRLz8tPKk9tGHu",
    "lib_block": "16028",
    "lib_block_hash": "8apn7vCvQ6s9PFBzGfaXrvyL5eAaLNc4mEAgnTMoW8tC",
    "witness_list": ["IOST2K9GKzVazBRLPTkZSCMcyMayKv7dWgdHD8uuWPzjfPdzj93x6J", "IOST2YKPmRDGy5xLR7Gv65CN5nQ3vMmVhRjAsEM7Gj9xcB1LWgZUAd", "IOST7E4T5rG9wjPZXDeM1zjhhWU3ZswtPQ1heeRUFUxntr65sYRBi"]
}
```

Ключ                     |Тип данных       |Описание
----                        |--         |--
net\_name           |string     |Название сети, такие как "mainnet" или "testnet"
protocol\_version   |string     |версия протокола iost
chain\_id   | uint32     | id блокчейна iost
head\_block         |int64      |высота последнего блока
head\_block\_hash|string        |хеш последнего блока
lib\_block              |int64      |высота необратимых блоков
lib\_block\_hash    |int64      |хеш необратимых блоков
witness\_list           |repeated string|список pubkeys (публичных ключей) для узлов производящих блоки

## /getGasRatio
##### GET

Получите информацию о коэффиценте GAS(газа), чтобы пользователи могли устанавливать желаемые торговые коэффиценты GAS(газа). Мы рекомендуем более высокий коэффицент использования газа, чем lowest_gas_ratio, чтобы транзакции были проведены своевременно.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getGasRatio
```

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "lowest_gas_ratio": 1.5,
    "median_gas_ratio": 1.76
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
lowest\_gas\_ratio|double|самый низкий коэффицент газа из последних упакованных блоков
median\_gas\_ratio|double|средний коэффицент газа самых последних упакованных блоков


## /getRAMInfo
##### GET

Получить информацию об RAM (оперативной памяти) для текущего состояния блокчейна, включая использование и цену.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getRAMInfo
```

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "available_ram": "96207067431",
    "buy_price": 0.04227129323234719,
    "sell_price": 0.00014551844642842057,
    "total_ram": "137438953472",
    "used_ram": "41231886041"
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
available\_ram  |int64      |RAM (оперативной памяти) доступно, в байтах
used\_ram       |int64      |Количество проданной RAM, в байтах
total\_ram          |int64      |Общее количество RAM системы, в байтах
buy\_price      |double |Цена покупки RAM, в IOST/байт
sell\_price         |double |Цена продажи RAM, в IOST/байт






## /getTxByHash
##### GET

Выбирает транзакцию по ее хешу (кодирован функцией base58)

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getTxByHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

Ключ                 |Тип       |Описание
----                    |--         |--
hash                |string     |хеш транзакции

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "status": "IRREVERSIBLE",
    "transaction": {
        "hash": "6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR",
        "time": "1544269519362042000",
        "expiration": "1544279519362041000",
        "gas_ratio": 1,
        "gas_limit": 50000,
        "delay": "0",
        "chain_id": 1024,
        "actions": [{
            "contract": "ContractTBv8ZDKUhTyeS4MomdcHRrXnJMELa5usSMHP6QJntFQ",
            "action_name": "transfer",
            "data": "[\"admin\",\"i1544269477\",1]"
        }],
        "signers": [],
        "publisher": "admin",
        "referred_tx": "",
        "amount_limit": [],
        "tx_receipt": null
    }
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
status              |enum       |PENDING(ожидание)- транзакция кэшируется, PACKED(упакована) - транзакция в обратимых блоках, IRREVERSIBLE(необратимо) - транзакция в необратимых блоках
transaction     |Transaction|Данные транзакции

### Transaction (Транзакция)

Ключ                 |Тип       |Описание
----                    |--         |--
hash                |string     |хеш транзакции
time                    |int64      |метка времени транзакции
expiration      |int64      |время истечения транзакции
gas_ratio           |double |коэффицент GAS, мы рекомендуем выставлять 1.00 (1.00 – 100.00). Увеличьте коэффицент, чтобы позволить сети "упаковать" транзакцию быстрее
gas_limit           |double |Верхний предел GAS. Эта транзакция никогда не будет стоить больше GAS, чем эта сумма
delay               |int64      |Транзакции будут задерживаться на столько, в наносекундах
chain_id               |uint32      | id блокчейна, на котором может быть выполнена транзакция
actions         |repeated Action|наименьшая единица выполнения транзакции - вызовы транзакции (например, выполнение функции)
signers         |repeated string|список подписей транзакции
publisher           |string     |отправитель транзакции, ответственный за оплату комиссии
referred_tx     |string     |зависимость генерации транзакций; используется для отложенных транзакций
amount_limit    |repeated AmountLimit|Пользователи могут устанавливать ограничения на токены. Например, {"iost": 100} указывает, что каждый подписавшийся не потратит более 100 IOST на транзакцию
tx_receipt      |TxReceipt|квитанция совершенной транзакции

### Action (Действие - вызовы транзакции)

Ключ                 |Тип       |Описание
----                    |--         |--
contract            |string     |название контракта
action_name |string     |название функции контракта
data                    |string     |Специальные параметры вызова. Поместите каждый параметр в массив и JSON-сериализует этот массив(преобразование массива в формат JSON). Это может выглядеть как  `["a_string", 13]`

### AmountLimit (Ограничения на токены)

Ключ                 |Тип       |Описание
----                    |--         |--
token               |string     |название токена
value               |double |соответствующий токен лимит

### TxReceipt (Квитанция транзакции)

Ключ                 |Тип       |Описание
----                    |--         |--
tx_hash         |string     |хеш транзакции
gas_usage       |double |потребление GAS(газа) транзакцией
ram_usage       |map\<string, int64\>|потребление RAM транзакцией. map-key это имя аккаунта, а значение это количество RAM
status_code |enum       |Статус транзакции. SUCCESS(успешна); GAS_RUN_OUT - недостаточно GAS(газа); BALANCE_NOT_ENOUGH - недостаточный баланс; WRONG_PARAMETER(неверный параметр); RUNTIME_ERROR - ошибка во время выполнения; TIMEOUT; WRONG_TX_FORMAT(неверный формат транзакции); DUPLICCATE_SET_CODE - заданный код неожиданно дублируется; UNKNOWN_ERROR
message         |string     |сообщение описывает status_code(статус транзакции)
returns         |repeated string    |возвращает значение для каждого Action(действия)
receipts            |repeated Receipt|для функций event(событий)

### Receipt

Ключ                 |Тип       |Описание
----                    |--         |--
func_name       |string     |ABI название функции
content         |string     |контент

<!-- CONTINUE HERE: http://developers.iost.io/docs/zh-CN/next/6-reference/API/#gettxreceiptbytxhash-hash -->


## /getTxReceiptByTxHash/{hash}
##### GET

Получите данные квитанции транзакции по хешу транзакции.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getTxReceiptByTxHash/6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR
```

Ключ                 |Тип       |Описание
----                    |--         |--
hash                |string     |хеш квитанции

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "tx_hash": "6eGkZoXPQtYXdh7dBSXe2L1ckUCDj4egRn4fXtS2ACnR",
    "gas_usage": 6633,
    "ram_usage": {
        "admin": "0",
        "issue.iost": "0"
    },
    "status_code": "SUCCESS",
    "message": "",
    "returns": ["[\"\"]"],
    "receipts": [{
        "func_name": "token.iost/transfer",
        "content": "[\"iost\",\"admin\",\"i1544269477\",\"1\",\"\"]"
    }]
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
                        |TxReceipt|квитанция транзакции




## /getBlockByHash/{hash}/{complete}
##### GET

Получить информацию о блоке по хешу блока.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getBlockByHash/4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY/false
```

Ключ                 |Тип       |Описание
----                    |--         |--
hash                |string     |хеш блока
complete            |bool       |true - показать подробные транзакции в блоке; false - не показывать.

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "status": "IRREVERSIBLE",
    "block": {
        "hash": "4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY",
        "version": "0",
        "parent_hash": "G4njPLnYskU4DcuTz5CwpLPETcfH6yN78V8emge8t21f",
        "tx_merkle_hash": "HHKAG2D7Kon2on5SqV66ZsfdNk9Wus8yhWqdTb86wgPJ",
        "tx_receipt_merkle_hash": "FXr8Mf7hr568MP23BFWJiBUej2xSj3M7416WAKJpswzx",
        "number": "2",
        "witness": "IOST2YKPmRDGy5xLR7Gv65CN5nQ3vMmVhRjAsEM7Gj9xcB1LWgZUAd",
        "time": "1544262978309033000",
        "gas_usage": 0,
        "tx_count": "1",
        "info": null,
        "transactions": []
    }
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
status              |enum       |PENDING - блок находится в кеше; IRREVERSIBLE - блок необратим.
block               |Block      |структура Block (блока)

### Block (Блок)

Ключ                 |Тип       |Описание
----                    |--         |--
hash                |string     |хеш блока
version         |int64      |номер версии блока
parent\_hash    |string     |хеш родительского блока этого блока
tx\_merkle\_hash    |string |единый хеш - корень дерева Меркла всех транзакций
tx\_receipt\_merkle\_hash   |string |единый хеш - корень дерева Меркла всех квитанций
number          |int64      |номер блока
witness         |string     |публичный ключ производителя блока
time                    |int64      |время производства блока
gas\_usage      |double |общее потребление GAS(газа) в блоке
tx\_count           |int64      |число транзакций в блоке
info           | Info      |(Этот ключ зарезервирован.)
transactions    |repeated Transaction   |все транзакции.

### Info (Информация)

Ключ                 |Тип       |Описание
----                    |--         |--
mode                |int32      |режим параллелизма; 0 - неконкурирующий; 1 - параллельный
thread              |int32      |количество потоков параллельного выполнения транзакции
batch_index |repeated int32 |индексы транзакции


## /getBlockByNumber/{number}/{complete}
##### GET

Получить информацию о блоке, используя номер блока.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getBlockByNumber/3/false
```

Ключ                 |Тип       |Описание
----                    |--         |--
number          |int64      |номер блока
complete            |bool       |true - отображать транзакции блока; false - не отображать.


### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "status": "IRREVERSIBLE",
    "block": {
        "hash": "HPZyoPQ44vsyLDRspjgrySyHnpuiGwckPx8uNtHZugJW",
        "version": "0",
        "parent_hash": "4c9GHyGLi6hUqB4d6zGFcywycYKucsmWsbgvhPe31GaY",
        "tx_merkle_hash": "HHKAG2D7Kon2on5SqV66ZsfdNk9Wus8yhWqdTb86wgPJ",
        "tx_receipt_merkle_hash": "62pESNUGDVsH4B1BCymJvmjGxPu5bb4R3u4x45K9Ybdq",
        "number": "3",
        "witness": "IOST2YKPmRDGy5xLR7Gv65CN5nQ3vMmVhRjAsEM7Gj9xcB1LWgZUAd",
        "time": "1544262978609003000",
        "gas_usage": 0,
        "tx_count": "1",
        "info": null,
        "transactions": []
    }
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
status              |enum       |PENDING - блок находится в кеше; IRREVERSIBLE - блок необратим
block               |Block      |структура блока







## /getAccount/{name}/{by_longest_chain}
##### GET

Получить информацию об аккаунте.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getAccount/admin/true
```

Ключ                 |Тип       |Описание
----                    |--         |--
name                |string     |номер блока
by\_longest\_chain  |bool   |true - получить данные из самой длинной цепочки; false - получить данные из необратимых блоков


### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "name": "admin",
    "balance": 982678652,
    "gas_info": {
        "current_total": 53102598634,
        "transferable_gas": 60000,
        "pledge_gas": 53102538634,
        "increase_speed": 330011,
        "limit": 90003000000,
        "pledged_info": [{
            "pledger": "admin",
            "amount": 3000100
        }]
    },
    "ram_info": {
        "available": "99000"
    },
    "permissions": {
        "active": {
            "name": "active",
            "group_names": [],
            "items": [{
                "id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
                "is_key_pair": true,
                "weight": "1",
                "permission": ""
            }],
            "threshold": "1"
        },
        "owner": {
            "name": "owner",
            "group_names": [],
            "items": [{
                "id": "IOST2mCzj85xkSvMf1eoGtrexQcwE6gK8z5xr6Kc48DwxXPCqQJva4",
                "is_key_pair": true,
                "weight": "1",
                "permission": ""
            }],
            "threshold": "1"
        }
    },
    "groups": {},
    "frozen_balances": [],
    "vote_infos": []
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
name                |string     |имя аккаунта
balance         |double |баланс аккаунта
gas\_info           |GasInfo    |информация о Gas
ram\_info           |RAMInfo    |информация о Ram
permissions |map<string, Permission>    |разрешения
groups              |map<string, Group>         |группы разрешений
frozen\_balances    |repeated FrozenBalance |информация о замороженном балансе
vote\_infos    |repeated VoteInfo |информация о голосовании

### GasInfo (Информация о газе)

Ключ                 |Тип       |Описание
----                    |--         |--
current\_total  |double |Всего газа на данный момент
transferable\_gas   |double |Gas доступный для торговли
pledge\_gas     |double |Gas полученный из депозитов
increase\_speed |double |скорость увеличения газа, в газе в секунду
limit                   |double |Верхний предел газа для депозита токенов
pledged\_info   |repeated PledgeInfo    |Информация о депозите(залоге), сделанном другими аккаунтами, от имени запрашиваемого аккаунта

### PledgeInfo (Информация о депозите)

Ключ                 |Тип       |Описание
----                    |--         |--
pledger         |string     |аккаунт, получающий депозит
amount          |double |сумма депозита

### RAMInfo (Информация об оперативной памяти)

Ключ                 |Тип       |Описание
----                    |--         |--
available           |int64      |количество байт RAM доступное для использования
used           |int64      |использовано байтов RAM
total           |int64      |всего байтов RAM

### Permission (Разрешения)

Ключ                 |Тип       |Описание
----                    |--         |--
name                |string     |название разрешения
group_names              |repeated string    |имена групп разрешений
items               |repeated Item  |информация о разрешении
threshold           |int64      |порог разрешения

### Item (Элемент разрешения)

Ключ                 |Тип       |Описание
----                    |--         |--
id                      |string     |имя разрешения или ID пары ключей
is_key_pair     |bool       |true - id это пара ключей; false - id это имя разрешения
weight              |int64      |вес разрешения
permission      |string     |разрешение

### Group (Группа разрешений)

Ключ                 |Тип       |Описание
----                    |--         |--
name                |string     |название группы
items               |repeated Item  |информация о группе разрешений

### FrozenBalance (Замороженный баланс)

Ключ                 |Тип       |Описание
----                    |--         |--
amount          |double |количество
time                    |int64      |время размораживания суммы

### VoteInfo

Ключ                 |Тип       |Описание
----                    |--         |--
option          |string |кандидат
votes                    |string      |число голосов
cleared_votes                    |string      |число очищенных голосов



## /getTokenBalance/{account}/{token}/{by_longest_chain}
##### GET

Получить баланс аккаунта указанных токенов.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getTokenBalance/admin/iost/true
```

Ключ                 |Тип       |Описание
----                    |--         |--
account         |string     |название аккаунта
token               |string     |название токена
by\_longest\_chain  |bool   |true - получить информацию от самой длинной цепи; false - получить данные из необратимых блоков

### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "balance": 982678652,
    "frozen_balances": []
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
balance             |double |баланс
frozen\_balances    |repeated FrozenBalance |информация о замороженном балансе





## /getContract/{id}/{by_longest_chain}
##### GET

Получить информацию о контракте, используя ID контракта.

### Запрос

Запрос может выглядеть так:

```
curl http://127.0.0.1:30001/getContract/base.iost/true
```

Ключ                 |Тип       |Описание
----                    |--         |--
id                      |string     |ID контракта
by\_longest\_chain  |bool   |true - получить данные из самой длинной цепочки; false - получить данные из необратимых блоков


### Ответ

Успешный ответ может выглядеть так:

```
200 OK

{
    "id": "base.iost",
    "code": "const producerPermission = 'active';\nconst voteStatInterval = 200;\nclass Base {\n    constructor() {\n    }\n    init() {\n        _IOSTInstruction_counter.incr(12);this._put('execBlockNumber', 0);\n    }\n    InitAdmin(adminID) {\n        _IOSTInstruction_counter.incr(4);const bn = block.number;\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(bn, 0, '!==')) {\n            _IOSTInstruction_counter.incr(14);throw new Error('init out of genesis block');\n        }\n        _IOSTInstruction_counter.incr(12);this._put('adminID', adminID);\n    }\n    can_update(data) {\n        _IOSTInstruction_counter.incr(12);const admin = this._get('adminID');\n        _IOSTInstruction_counter.incr(12);this._requireAuth(admin, producerPermission);\n        return true;\n    }\n    _requireAuth(account, permission) {\n        _IOSTInstruction_counter.incr(12);const ret = BlockChain.requireAuth(account, permission);\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(ret, true, '!==')) {\n            _IOSTInstruction_counter.incr(22);throw new Error(_IOSTBinaryOp('require auth failed. ret = ', ret, '+'));\n        }\n    }\n    _get(k) {\n        _IOSTInstruction_counter.incr(12);const val = storage.get(k);\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(val, '', '===')) {\n            return null;\n        }\n        _IOSTInstruction_counter.incr(12);return JSON.parse(val);\n    }\n    _put(k, v) {\n        _IOSTInstruction_counter.incr(24);storage.put(k, JSON.stringify(v));\n    }\n    _vote() {\n        _IOSTInstruction_counter.incr(12);BlockChain.callWithAuth('vote_producer.iost', 'Stat', `[]`);\n    }\n    _bonus(data) {\n        _IOSTInstruction_counter.incr(24);BlockChain.callWithAuth('bonus.iost', 'IssueContribute', JSON.stringify([data]));\n    }\n    _saveBlockInfo() {\n        _IOSTInstruction_counter.incr(12);let json = storage.get('current_block_info');\n        _IOSTInstruction_counter.incr(36);storage.put(_IOSTBinaryOp('chain_info_', block.parentHash, '+'), JSON.stringify(json));\n        _IOSTInstruction_counter.incr(24);storage.put('current_block_info', JSON.stringify(block));\n    }\n    Exec(data) {\n        _IOSTInstruction_counter.incr(12);this._saveBlockInfo();\n        _IOSTInstruction_counter.incr(4);const bn = block.number;\n        _IOSTInstruction_counter.incr(12);const execBlockNumber = this._get('execBlockNumber');\n        if (_IOSTInstruction_counter.incr(8),_IOSTBinaryOp(bn, execBlockNumber, '===')) {\n            return true;\n        }\n        _IOSTInstruction_counter.incr(12);this._put('execBlockNumber', bn);\n        if (_IOSTInstruction_counter.incr(16),_IOSTBinaryOp(_IOSTBinaryOp(bn, voteStatInterval, '%'), 0, '===')) {\n            _IOSTInstruction_counter.incr(12);this._vote();\n        }\n        _IOSTInstruction_counter.incr(12);this._bonus(data);\n    }\n}\n_IOSTInstruction_counter.incr(7);module.exports = Base;",
    "language": "javascript",
    "version": "1.0.0",
    "abis": [{
        "name": "Exec",
        "args": ["json"],
        "amount_limit": []
    }, {
        "name": "can_update",
        "args": ["string"],
        "amount_limit": []
    }, {
        "name": "InitAdmin",
        "args": ["string"],
        "amount_limit": []
    }, {
        "name": "init",
        "args": [],
        "amount_limit": []
    }]
}
```

Ключ                 |Тип       |Описание
----                    |--         |--
id                      |string     |ID контракта
code                |string     |код контракта
language            |string     |язык написания контракта
version         |string     |версия контракта
abis                    |repeated ABI   | ABIs контракта

### ABI (application binary interface - бинарный интерфейс приложения)

Ключ                 |Тип       |Описание
----                    |--         |--
name                |string     |имя интерфейса
args                    |repeated string    |аргументы интерфейса
amount\_limit   |repeated AmountLimit   |Ограничения по сумме





## /getContractStorage
##### POST

Получить данные storage (хранилища) контракта локально.

### Запрос

Запрос может выглядеть так:

```
curl -X POST http://127.0.0.1:30001/getContractStorage -d '{"id":"vote_producer.iost","field":"producer00001","key":"producerTable","by_longest_chain":true}'
```

Ключ                 |Тип       |Описание
----                    |--         |--
id                      |string     |ID смарт-контракта
field                   |string     |значения из StateDB; если StateDB\[key\] это map, то необходимо настроить поле для получения значений StateDB\[key\]\[field\]
key                 |string     |ключ к StateDB
by\_longest\_chain  |bool   |true - получить данные из самой длинной цепочки; false - получить данные из необратимых блоков

### Ответ

Успешный ответ может выглядеть так:

```
200 OK
{"data":"
    {
        "pubkey": "IOST2K9GKzVazBRLPTkZSCMcyMayKv7dWgdHD8uuWPzjfPdzj93x6J",
        "loc": "",
        "url": "",
        "netId": "",
        "online": true,
        "registerFee": "200000000"
    }
"}
```

## /getContractStorageFields
##### POST

Получить поля в ключе отображения из хранилища контракта, возвращается до 256

### Запрос

Запрос может выглядеть так:

```
curl -X POST http://127.0.0.1:30001/getContractStorageFields -d '{"id":"token.iost","key":"TIiost","by_longest_chain":true}'
```

Ключ                 |Тип       |Описание
----                    |--         |--
id                      |string     |ID смарт-контракта
key                 |string     |ключ StateDB
by\_longest\_chain  |bool   |true - получить данные из самой длиной цепи; false - получить данные из необратимых блоков

### Ответ

Успешный ответ может выглядеть так:

```
200 OK
{
	"fields": ["issuer","totalSupply","supply","canTransfer","onlyIssuerCanTransfer","defaultRate","decimal","fullName"]
}
```


## /sendTx
##### POST

Опубликуйте транзакцию на узле. Когда узел получает транзакцию, он выполнит проверку работоспособности и вернет ошибки, если проверка не удалась. Если проверка пройдена, транзакция будет добавлена в пул транзакций и вернет Hash (хеш) транзакции.

Пользователи могут использовать хеш в качестве аргумента `getTxByHash` API или `getTxReceiptByTxHash` API, чтобы посмотреть состояние транзакции и проверить, успешно ли прошло выполнение.

**Примечания:**

Этот API требует хеша транзакции и подписи, и его сложно вызвать напрямую.

<!-- 可能需要更新以下链接 -->

Мы рекомендуем пользователям отправлять транзакции с помощью наших [инструментов CLI](4-running-iost-node/iWallet.md).

Разработчики могут отправлять транзакции с [JavaScript SDK](https://github.com/iost-official/iost.js).

### Параметры запроса

Ключ                 |Тип       |Описание
----                    |--         |--
time                    |int64      |Время генерации транзакции в наносекундах от UnixEpoch-zero.
expiration      |int64      |Время истечения транзакции в наносекундах с UnixEpoch-zero. Если узел, производящий блоки, получает транзакцию после истечения срока действия, он не будет выполнять транзакцию.
gas\_ratio          |double |коэффицент GAS(газа). Эта транзакция будет выполнена с коэффициентом по умолчанию, умноженным на этот параметр. Чем выше коэффициент, тем быстрее выполняется транзакция. Значение может быть выбрано разумно от 1.0 до 100.0
gas\_limit          |double |Максимальное потребление GAS разрешеное этой транзакцией. Не должно быть ниже 50,000
delay               |int64      |Наносекунды задержки транзакции. Установите 0 для транзакции без задержек.
chain_id               |uint32      |id блокчейна
actions         |repeated Action    |Конкретные вызовы транзакции
amount\_limit   |repeated AmountLimit   |Ограничения на токены в транзакции. Можно указать более одного ограничения токена; если транзакция превысит эти пределы, выполнение будет остановлено.
publisher           |string     |ID создателя(отправителя) транзакции
publisher\_sigs |repeated Signature |Подписи создателя(отправителя), [как описано здесь](/MISSING_URL_HERE.md). Создатель(отправитель) может предоставить несколько подписей для разных разрешений. Обратитесь к документации по системе разрешений.
signers         |repeated string    | IDs подписантов помимо создателя(отправителя). Может быть оставлено пустым.
signatures      |repeated Signature |Подписи подписавших. Каждый подписант должен иметь одну или несколько подписей, поэтому длина подписей не должна быть меньше длины подписантов.

<!-- 上表中需要提供 URL -->

### Signature (Подпись)

Ключ                 |Тип данных       |Описание
----                    |--         |--
algorithm                |string     | "ED25519" или "SECP256K1"
signature                    | string    |подпись транзакции
public\_key   |string   |Публичный ключ соответствующий подписи




### Ответ

Ключ                 |Тип       |Описание
----                    |--         |--
hash                |string     |хеш транзакции


### Signing a transaction (Подписание транзакции)

Три шага для подписания транзакции: преобразовать структуру транзакции в byte array (байтовый массив), вычислить хеш этого byte array(байтового массива) функцией sha3, и подписать этот хеш своим приватным ключом.

* **Конвертация структуры транзакции в байтовый массив**

    Алгоритм действий: в декларативном порядке конвертировать каждое поле транзакции в байтовый массив, а затем добавить длину перед неопределенным типом (такими как строки и структуры) и срастить. Способы конвертации полей с различными типами данных в байтовые массивы показаны в таблице ниже.

    Тип данных    |Метод конвертации                          |Пример
    ---     |--------------                                 |--------------------
    int     |Конвертировать сетевым порядком байтов в байтовый массив  |int64(1023) конвертируется в \[0 0 0 0 0 0 3 255\]
    string  |Сращивание байта каждого символа в строке и впереди добавление длины  |"iost" конвертируется в \[0 0 0 4 105 111 115 116\]
    array   |Конвертировать каждый элемент массива в байтовый массив, добавить длину перед каждым массивом, собрать их вместе      |\["iost" "iost"\] конвертируется в \[0 0 0 2 0 0 0 4 105 111 115 116 0 0 0 4 105 111 115 116\]
    map     |Каждая пара ключей: значения в словаре конвертируются в байтовый массив и сращиваются, затем каждая пара сращивается в порядке возрастания ключей, и длина map добавляется к передней части каждой пары.    |\["b":"iost", "a":"iost"\] конвертируется в \[0 0 0 2 0 0 0 1 97 0 0 0 4 105 111 115 116 0 0 0 1 98 0 0 0 4 105 111 115 116\]

    Параметры транзакции декларируются в следующем порядке: "time", "expiration", "gas\_ratio", "gas\_limit", "delay", "chain_id", "reserved", "signers", "actions", "amount\_limit", и "signatures", таким образом псевдокод, преобразующий структуру транзакции в байтовый массив выглядит следующим образом:

    ```
  	func TxToBytes(t transaction) []byte {
  			return Int64ToBytes(t.time) + Int64ToBytes(t. expiration) +
  			 		Int64ToBytes(int64(t.gas_ratio * 100)) + Int64ToBytes(int64(t.gas_limit * 100)) +     // Node that gas_ratio and gas_limit need to be multiplied by 100 and convert to int64
  		 			Int64ToBytes(t.delay) + Int32ToBytes(t.chain_id) +
            BytesToBytes(t.reserved) + // reserved это зарезервированое поле. Оно нужно только для написания пустого байтового массива при сериализации. Не отправляйте запрос RPC с этим полем в параметрах.
  		 			ArrayToBytes(t.signers) + ArrayToBytes(t.actions)  +
  		 			ArrayToBytes(t.amount_limit) + ArrayToBytes(t.signatures)
  		}
  	```

    Обратитесь к [go-iost](https://github.com/iost-official/go-iost/blob/master/iwallet/sdk.go#L686) для реализации golang; обратитесь к [iost.js](https://github.com/iost-official/iost.js/blob/master/lib/structs.js#L73) для реализации JavaScript.

* **Вычислить хеш byte array(байтового массива) с помощью алгоритма sha3**

    Используйте библиотеки sha3 на вашем языке программирования для вычисления хеша байтового массива, полученного в предыдущем шаге.

* **Подпишите хеш приватным ключом**

    IOST поддерживает два алгоритма асимметричного шифрования: Ed25519 и Secp256k1. Эти два алгоритма используют один и тот же процесс подписи: сгенерируйте пару публичный-приватный ключ и подпишите хеш из предыдущего шага.

    Приватный ключ "publisher\_sigs" должен соответствовать аккаунту "publisher" транзакции. Приватные ключи "signatures" должны соответствовать "signers" аккаунтам. "signatures" используються для многоуровневой подписи и не обязательны; "publisher\_sigs" обязателен. Комиссия за совершение транзакции будет снята с аккаунта создателя(отправителя).

### Пример запроса

Предположим, что аккаунт "testaccount" хочет отправить транзакцию, которая переведет 100 iost на аккаунт с именем "anothertest".

* **Конструируем транзакцию**

    ```
    {
      "time": 1544709662543340000,
      "expiration": 1544709692318715000,
      "gas_ratio": 1,
      "gas_limit": 500000,
      "delay": 0,
      "chain_id": 1024,
      "signers": [],
      "actions": [
        {
          "contract": "token.iost",
          "action_name": "transfer",
          "data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
        },
      ],
      "amount_limit": [
        {
          "token": "*",
          "value": "unlimited",
        },
      ],
      "signatures": [],
    }
    ```

* **Вычисляем хеш**

    После сериализации и хеширования транзакции получаем хеш "/gB8TJQibGI7Kem1v4vJPcJ7vHP48GuShYfd/7NhZ3w=".

* **Подписываем транзакцию**

    Предположим "testaccount" имеет публичный ключ с алгоритмом  ED25519, публичный ключ - "lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=", и приватный ключ - "gkpobuI3gbFGstgfdymLBQAGR67ulguDzNmLXEJSWaGUNL5J0z5qJUdsPJdqm+uyDIrEWD2Ym4dY9lv8g0FFZg==". Подписываем хеш приватным ключом и получаем  "/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA=="

* **Публикуем транзакцию**

    Окончательные параметры транзакции:

    ```
    {
      "time": 1544709662543340000,
      "expiration": 1544709692318715000,
      "gas_ratio": 1,
      "gas_limit": 500000,
      "delay": 0,
      "chain_id": 1024,
      "signers": [],
      "actions": [
        {
          "contract": "token.iost",
          "action_name": "transfer",
          "data": "[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]",
        },
      ],
      "amount_limit": [
        {
          "token": "*",
          "value": "unlimited",
        },
      ],
      "signatures": [],
      "publisher": "testaccount",
      "publisher_sigs": [
        {
          "algorithm": "ED25519",
          "public_key": "lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=",
          "signature": "/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA==",
        },
      ],
    }
    ```

    После того, как мы JSON-сериализовали структуру, мы можем отправить следующий RPC:

    ```
    curl -X POST http://127.0.0.1:30001/sendTx -d '{"actions":[{"action_name":"transfer","contract":"token.iost","data":"[\"iost\", \"testaccount\", \"anothertest\", \"100\", \"this is an example transfer\"]"}],"amount_limit":[{"token":"*","value":"unlimited"}],"delay":0,"chain_id":1024, "expiration": 1544709692318715000,"gas_limit":500000,"gas_ratio":1,"publisher":"testaccount","publisher_sigs":[{"algorithm":"ED25519","public_key":"lDS+SdM+aiVHbDyXapvrsgyKxFg9mJuHWPZb/INBRWY=","signature":"/K1HM0OEbfJ4+D3BmalpLmb03WS7BeCz4nVHBNbDrx3/A31aN2RJNxyEKhv+VSoWctfevDNRnL1kadRVxSt8CA=="}],"signatures":[],"signers":[],"time": 1544709662543340000}'
    ```


## /execTx
##### POST

Отправьте транзакцию на узел и немедленно выполните. Это действие не будет стремиться к консенсусу в блокчейне, и эта транзакция не будет продолжаться.

Этот API-интерфейс используется для проверки того, выполняется ли контракт на тестирование надлежащим образом. Очевидно, что execTx не может гарантировать одинаковое поведение при выполнении в блокчейне из-за разного времени вызова.

### Запрос

Этот API имеет тот же набор параметров, что и /sendTx.

### Ответ

Этот API использует тот же формат ответа, что и /getTxReceiptByTxHash.

## /subscribe
##### **POST**
Подписка на события, включая события с тригерами в смарт-контрактах и совершенные транзакции.

### Запрос

Запрос может выглядеть так:

```
curl -X POST http://127.0.0.1:30001/subscribe -d '{"topics":["CONTRACT_RECEIPT"], "filter":{"contract_id":"token.iost"}}'
```
| Ключ | Тип | Описание |
| :----: | :-----: | :------ |
| topics |repeated enum  | темы，enum это CONTRACT\_EVENT или CONTRACT\_RECEIPT|
| filter | [Filter](#filter)  | Получаемые события фильтруются в соответствии с полями фильтра. Если поле не пропущено, данные о событиях по всем темам будут получены. |
### Filter (Фильтр)
| Ключ | Тип | Описание |
| :----: | :-----: | :------ |
| contract_id | string | id контракта|



### Ответ

Успешный ответ может выглядеть так:

```
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646637413936000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646637711757000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646638013188000"}}}
{"result":{"event":{"topic":"CONTRACT_RECEIPT","data":"[\"contribute\",\"producer00001\",\"900\"]","time":"1545646638317840000"}}}
...
```
| Ключ | Тип | Описание |
| :----: | :--------: | :------ |
| topic | enum  | тема, enum это CONTRACT\_EVENT или CONTRACT\_RECEIPT|
| data | string  |данные события|
| time | int64  | метка времени события|
