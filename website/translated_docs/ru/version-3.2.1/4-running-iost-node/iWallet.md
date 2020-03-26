---
id: iWallet
title: Инструмент командной строки iWallet
sidebar_label: Инструмент командной строки iWallet
---

iwallet это инструмент командной строки для блокчейна IOST.   
Вы можете использовать этот инструмент для подключения к блокчейну для перевода монет/создания аккаунтов/запроса баланса/вызова контрактов.     
iwallet и [API](6-reference/API.md) используют RPC API внутри себя. У них есть похожий функционал.   

## Установка
Вам вначале необходимо [установить golang](4-running-iost-node/Building-IOST.md#install-golang).

После установки golang, вы можете установить iwallet с помощью следующей команды:
```
go get github.com/iost-official/go-iost/iwallet
```

Если вы планируете развертывать смарт-контракты в блокчейне, вам вначале необходимо установить [nodejs](https://nodejs.org/en/download/), а затем запускать команды.

## Базовый функционал
### Запрос аккаунта
iwallet можно использовать для запроса информации аккаунта включая баланс, RAM(количество оперативной памяти), GAS(количество доступного газа) и др.      
Формат вывода такой же как [getAccountInfo API](6-reference/API.md#getaccount-name-by-longest-chain) .     
Флаг `--server` внутри команды указывает на удаленный сервер IOST. Если вы [запускаете сервер локально](4-running-iost-node/LocalServer.md)，вы можете пропустить флаг, используя значение по умолчанию (localhost:30002).      

```
iwallet --server 127.0.0.1:30002 balance xxxx
{
    "name": "xxxx",
    "balance": 993939670,
    "createTime": "0",
    "gasInfo": {
        "currentTotal": 2994457,
        "increaseSpeed": 11,
        "limit": 3000000,
        "pledgedInfo": [            {
                "pledger": "xxxx",
                "amount": 10
            },
            {
                "pledger": "tttt",
                "amount": 10
            }
        ],
    },
    "ramInfo": {
        "available": "100000"
    },
    "permissions": ...
    "frozenBalances": [
        {
            "amount": 30,
            "time": "1543817610001412000"
        }
    ]
}
```
### Запрос информации о блокчейне
Запрос информации о блокчейне и узле сервера. Вывод в данном случае комбинация из [getNodeInfo](6-reference/API.md#getnodeinfo) и [getChainInfo](6-reference/API.md#getchaininfo).  

```
iwallet --server 127.0.0.1:30002 state
{
    "buildTime": "20181208_161822+0800",
    "gitHash": "c949172cb8063e076b087d434465ecc4f11c3000",
    "mode": "ModeNormal",
    "network": {
        "id": "12D3KooWK1ALkQ6arLJNd5vc49FLDLaPK931pggFr7X49EA5yhnr",
        "peerCount": 0,
        "peerInfo": [
        ]
    }
    "netName": "debugnet",
    "protocolVersion": "1.0",
    "headBlock": "9408",
    "headBlockHash": "FKtcg2qgUnfuXNe6Zz6p2CJMLSUjDSSK2PrvzPtpA3jp",
    "libBlock": "9408",
    "libBlockHash": "FKtcg2qgUnfuXNe6Zz6p2CJMLSUjDSSK2PrvzPtpA3jp",
    "witnessList": [
        "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
    ]
}
```

### Вызов контракта
#### Импорт аккаунта
Аккаунт должен быть импортирован до вызова каких-либо контрактов.   

```
# This command will copy private key to ~/.iwallet/YOUR_ACCOUNT_ID_ed25519. It is done locally without any interaction with blockchain.
iwallet account --import $YOUR_ACCOUNT_ID $YOUR_PRIVATE_KEY
```
#### Использование командной строки

```
iwallet --account <ACCOUNT_NAME> [other flags] call <CONTRACT_NAME> <ACTION_NAME> '["ARG1",ARG2,...]'
```

| Флаг  | Описание | По умолчанию |
| :----: | :-----: | :------ |
| server | адрес iserver для подключения  | localhost:30002 |
| account | кто вызывает контракт | None, needed |
| gas_limit | максимальное количество газа разрешенное для вызова | 1000000 |
| gas_ratio | транзакция с большим коэффицентом газа будет выполнена ранее | 1.0 |
| amount_limit | все лимиты количества токенов | None, needed. Like iost:300.0&#124;ram:2000. "*:unlimited" means no limit |

#### Пример：перевод токенов
`admin` вызывает функцию 'transfer' контракта 'token.iost'    
Последний аргумент команды это параметры функции 'transfer'. Параметры этой функции по порядку: тип токена, плательщик, получатель, сумма и дополнительная информация здесь.   

```
iwallet --account admin call 'token.iost' 'transfer' '["iost","admin","lispczz","100",""]'
sending tx Tx{
	Time: 1543559175834283000,
	Publisher: admin,
	Action:
		Action{Contract: token.iost, ActionName: transfer, Data: ["iost","admin","lispczz","100",""]}
    AmountLimit:
[],
}
send tx done
the transaction hash is: GU4EHg4zE9VHu9A13JEwxqJSVbzij1VoqWGnQR5aV3Dv
exec tx done.  {
    "txHash": "GU4EHg4zE9VHu9A13JEwxqJSVbzij1VoqWGnQR5aV3Dv",
    "gasUsage": 2172,
    "ramUsage": {
        "admin": "43"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[]"
    ],
    "receipts": [
        {
            "funcName": "token.iost/transfer",
            "content": "[\"iost\",\"admin\",\"lispczz\",\"100\",\"\"]"
        }
    ]
}
```

### Создание аккаунта
#### Использование командной строки

```
iwallet --server <server_addres> --account <account_name> --amount_limit  <amount_limit> account --create <new_account_name> [other flags]
```

| Флаг  | Описание | По умолчанию |
| :----: | :-----: | :------ |
| create | имя нового аккаунта  | None, needed |
| initial_ram | количество ram купленного для нового аккаунта создателем| 1024 |
| initial\_gas\_pledge | количество IOST заложенного для gas создателем для нового аккаунта| 10 |
| initial_balance | сумма IOST переведенная на новый аккаунт создателем| 0 |
Для создания нового аккаунта требуется вызов контрактов, поэтому помимо указанных выше флагов также необходимы все флаги [вызова](#command-line-usage).   

```
# After creating account,  random keypair is generated, and private key will be saved to ~/.iwallet/$(new_account_name)_ed25519    
iwallet --server 127.0.0.1:30002 --account admin --amount_limit "ram:1000|iost:10" account --create lispczz3 --initial_balance 0 --initial_gas_pledge 10 --initial_ram 0
...
...
    "groups": {
    },
    "frozenBalances": [
    ]
}
your account private key is saved at:
/Users/zhangzhuo/.iwallet/lispczz3_ed25519
create account done
the iost account ID is: lispczz3
owner permission key: IOSTGdkyjGmhvpM435wvSkPt2m3TVUM6npU8wbRZYcmkdprpvp92K
active permission key: IOSTGdkyjGmhvpM435wvSkPt2m3TVUM6npU8wbRZYcmkdprpvp92K
```
### Развертывание контракта
Публикация javascript контракта в два шага, первый шаг это генерация файла abi, второй шаг это публикация файла javascript и файла abi в блокчейне.   
#### Генерация abi
Убедитесь, что node.js установлен и команда `npm install` внутри директории iwallet/contract была запущена.

```
# example.js.abi will be generated
iwallet compile example.js
```

Обычно создаваемый файл abi необходимо корректировать, параметры функции тип и лимит суммы могут быть скорректированы в соответствии с актуальным для вас использованием.

#### Публикация контракта
```
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh

```
`ContractXXX` последняя строка вывода это имя контракта, которое необходимо если позже кто-нибудь захочет вызвать новозагруженный контракт.   

## Расширенные возможности
### Запрос блока

```
# Get information about block at height 10
iwallet block --method num 10
# Get information about block with hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
iwallet block --method hash 6RJtXTDPPRTP6iwK9FpG5LodeMaXofEnd8Lx2KA1kqbU
```
### Запрос информации о транзакции
#### Получите детали транзакции
`transaction` это тоже, что и [getTxByHash API](6-reference/API.md#gettxbyhash-hash])

```
iwallet transaction 3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx
{
    "status": "PACKED",
    "transaction": {
        "hash": "3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx",
        "time": "1545470082534696000",
        "expiration": "1545470382534696000",
        "gasRatio": 1,
        "gasLimit": 1000000,
        "delay": "0",
        "actions": [
            {
                "contract": "token.iost",
                "actionName": "transfer",
                "data": "[\"iost\",\"admin\",\"admin\",\"10\",\"\"]"
            }
        ],
#
```
#### Получите receipt(квитанцию) транзакции по ее хешу
`receipt` это тоже, что и [getTxReceiptByTxHash API](6-reference/API.md#gettxreceiptbytxhash-hash)

```
iwallet receipt 3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx
{
    "txHash": "3aeqKCKLTanp8Myep99BUfkdRKPj1RAGZvEesDmsjqcx",
    "gasUsage": 2577,
    "ramUsage": {
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[]"
    ],
    "receipts": [
    ]
}
```
