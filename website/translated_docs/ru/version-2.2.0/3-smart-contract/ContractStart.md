---
id: version-2.2.0-ContractStart
title: Смарт-контракт Быстрый старт
sidebar_label: Смарт-контракт Быстрый старт
original_id: ContractStart
---


# Начало разработки DApp (Decentralized Application - Децентрализованное Приложение)

## Основы IOST DApp
Абстрагируясь блокчейн можно представить как машину состояний, которая синхронизируется через сеть. Смарт-контракт это код, который исполняется в системе блокчейна и изменяет состояние в машине состояний вследствие транзакций. Благодаря характеристикам блокчейна вызов смарт-контракта может быть гарантированно последовательным и глобально согласованным.

Смарт-контракты IOST в настоящее время разрабатываются на языке JavaScript (ES6).

Смарт-контракт IOST содержит код для смарт-контрактов и файл JSON для описания ABI, который имеет собственное пространство имен и изолированное хранилище. Внешне можно только читать контент хранилища.

### Ключевые слова

| Ключевое слово | Описание |
| :-- | :-- |
| ABI | Интерфейс смарт-контракта, который может быть вызван только внешне через объявленный интерфейс |
Tx | транзакция, состояние в блокчейне должно быть изменено путем отправки tx, tx упаковывается в блок |
|


## Конфигурация среды отладки

### Использование iwallet и тестовых узлов

Разработка и развертывание смарт-контрактов требует iwallet. В то же время запуск тестового узла может облегчить отладку. Вы можете сделать это, выбрав любой из двух методов ниже.

#### среда докера (рекомендуется)

Запустите докер и войдите в среду докера. Локальный тестовый узел также будет запущен.

```
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:2.1.0-29b893a5
docker ps # the last column of the output is the docker container name, which will be used in next command
docker exec -it <container_name> /bin/bash # you will enter docker
./iwallet -h
```

#### Компиляция исходного кода

Необходим go версии 1.11 или выше

```
go get -u iost-official/go-iost
cd $GOPATH/src/github.com/iost-official/go-iost
make install
# Check the configuration config/
iserver -f config/iserver.yml # Start the test node, no need
iwallet -h
```
### Импорт исходного аккаунта ```admin``` для iwallet

Для завершения теста вам необходимо импортировать секретный ключ для iwallet. Соответствующий ключ находится в поле admininfo в config/genesis.yml.
```
iwallet account --import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```
В докере вам необходимо использовать "./iwallet" вместо "iwallet", который не установлен внутри образа докера.


## Hello world

### Подготовка кода
Сначала подготовьте класс JavaScript, например HelloWorld.js
```
class HelloWorld {
init() {} // needs to provide an init function that will be called during deployment
    hello(someone) {
        return "hello, "+ someone
    }
}

module.exports = HelloWorld;
```
Смарт-контракт содержит интерфейс, который получает входные данные и затем выводит ```hello, + веденные данные ```. Для того, чтобы этот интерфейс вызывался вне смарт-контракта, вам необходимо подготовить файл abi. Например, HelloWorld.abi
```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "hello",
      "args": [
        "string"
      ]
    }
  ]
}
```
Поле name abi соответствует имени функции js, а список аргументов содержит предварительную проверку типа данных. Рекомендуется использовать только три типа данных: string(строка), number(число), и bool(булевые).

## Публикация(Развертывание) на локальном тестовом узле

Опубликуйте смарт-контракты
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 publish helloworld.js helloworld.abi
```
Пример вывода
```
{
    "txHash": "96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf",
    "gasUsage": 36361,
    "ramUsage": {
        "admin": "356",
        "system.iost": "148"
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf\"]"
    ],
    "receipts": [
    ]
}
The contract id is Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf # This is the contract id of the deployment

```

Тестовый вызов ABI

```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf" "hello" '["developer"]' # contract id needs to be changed to the id you received
```

Выходные данные
```
Send tx done
The transaction hash is: GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
Exec tx done # The following output Tx is executed after TxReceipt
{
    "txHash": "GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc",
    "gasUsage": 33084,
    "ramUsage": {
    },
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello, developer\"]" # returned the required string
    ],
    "receipts": [
    ]
}
```

После этого вы можете получить TxReceipt в любое время с помощью следующей команды.
```
iwallet receipt GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```
Также TxReceipt может быть получена через http
```
curl -X GET \
  http://localhost:30001/getTxReceiptByTxHash/GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

Можно считать, что этот вызов будет постоянно записываться IOST и не может быть подделан.

## State Storage смарт-контракта (Хранилище состояний)

IOST не использует режим использования вывода смарт-контракта (аналогичный концепции utxo) так как это неудобно, поэтому IOST не предоставляет индексы к каждому полю в TxReceipt, и смарт-контракт не может получить доступ к конкретному TxReceipt. Мы используем базу данных состояний блокчейна для хранения состояний, чтобы поддерживать машину состояний блокчейна.


База данных является чистой базой данных K-V, тип данных key(ключа) и value(значения) это string(строка). Каждый смарт-контракт имеет отдельное пространство имен.
Смарт-контракты могут считывать данные о состояниях других смарт-контрактов, но записывать данные могут только в свои собственные поля.

### Пишем код
```
class Test {
    init() {
        storage.put("value1", "foobar")
    }
    read() {
        console.log(storage.get("value1"))
    }
    change(someone) {
        storage.put("value1", someone)
    }
}
module.exports = Test;
```
Abi пропустим

### Использование state storage
После развертывания кода вы можете получить хранилище следующим способом
```
curl -X POST \
  http://localhost:30001/getContractStorage \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
    "id": "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e",
    "key": "value1",
    "by_longest_chain": true
}'
```
Этот post вернет json
```
{
    "data": "foobar"
}
```
Это значение можно изменить, вызвав change.
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e" "change" '["foobaz"]'
```

## Контроль разрешений и невыполнение(отказ) смарт-контракта

Основу контроля разрешений можно увидеть на:

Примере
```
if (!blockchain.requireAuth("someone", "active")) {
    throw "require auth error" // throw that is not caught will be thrown to the virtual machine, causing failure
}
```
Необходимо обратить внимание на следующие моменты
1. requireAuth само по себе не прекращает работу смарт-контракта, оно только возвращает значение bool, поэтому вам нужно определить действие для выполнения
2. requireAuth(tx.publisher, "active") всегда true

При сбросе транзакция не выполняется, этот вызов смарт-контракта полностью откатывается, но вычитается стоимость газа для пользователя, выполняющего транзакцию (поскольку откат выполняется, он не будет взимать ram)

Вы можете наблюдать неудачную транзакцию с помощью простого теста.
```
iwallet \
 --expiration 10000 --gas_limit 1000000 --gas_ratio 1 \
 --server localhost:30002 \
 --account admin \
 --amount_limit '*:unlimited' \
 call "token.iost" "transfer" '["iost", "someone", "me". "10000.00", "this is steal"]'
```
Результат будет
```
{
    "txHash": "GCB9UdAKyT3QdFh5WGujxsyczRLtXX3KShzRsTaVNMns",
    "gasUsage": 2864,
	"ramUsage": {
     },
     "statusCode": "RUNTIME_ERROR",
     "message": "running action Action{Contract: token.iost, ActionName: transfer, Data: [\"iost\",\"someone\",\"me\",\"10000.00\",\"trasfer . .. error: invalid account someone",
     "returns": [
     ],
     "receipts": [
     ]
}
```

## Отладка

Сначала запустите локальный узел, как описано выше. Если вы используете докер, вы можете использовать следующую команду для печати логов.
```
docker ps -f <container>
```

На этом этапе вы можете добавить требуемый лог в код, добавив console.log(), ниже приведен вывод лога в примере хранилища.

```
Info 2019-01-08 06:44:11.110 pob.go:378 Gen block - @7 id:IOSTfQFocq..., t:1546929851105164574, num:378, confirmed:377, txs:1, pendingtxs:0, et: 4ms
Info 2019-01-08 06:44:11.416 value.go:447 foobar
Info 2019-01-08 06:44:11.419 pob.go:378 Gen block - @8 id:IOSTfQFocq..., t:1546929851402828690, num:379, confirmed:378, txs:2, pendingtxs:0, et: 16ms
```
