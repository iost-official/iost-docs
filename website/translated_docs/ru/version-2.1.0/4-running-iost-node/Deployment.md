---
id: version-2.1.0-Deployment
title: Развертывание
sidebar_label: Развертывание
original_id: Deployment
---

Мы используем Докер для развертывания узла IOST.

Однако вы также можете выбрать запуск нативных двоичных файлов. Посмотрите [это](Environment-Configuration.md).

## Необходимо

- [Docker CE 18.06 или новее](https://docs.docker.com/install/) (старые версии не тестировались)
- (Опционально) [Docker Compose](https://docs.docker.com/compose/install/)

## Конфигурация генезиса и [iServer](./iServer.md)

Сначала получите шаблоны конфигурации:

```
mkdir -p /data/iserver
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/docker/iserver.yml -o /data/iserver/iserver.yml
curl https://raw.githubusercontent.com/iost-official/go-iost/v2.1.0/config/genesis.yml -o /data/iserver/genesis.yml
```

`/data/iserver` будет монтироваться как том данных, вы можете изменить путь в соответствии с вашими потребностями.

*Если вы уже запускали предыдущую версию iServer, убедитесь, что старые данные удалены:*

```
rm -rf /data/iserver/storage
```

Для получения доступа к тестовой сети Everest v2.1.0, файл генезиса `/data/iserver/genesis.yml` необходимо изменить как показано ниже:

```
creategenesis: true
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 21000000000
  iostdecimal: 8
  ramtotalsupply: 9000000000000000000
  ramgenesisamount: 137438953472
witnessinfo:
  - id: producer00000
    owner: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    active: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    balance: 1000000000
  - id: producer00001
    owner: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    active: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    balance: 1000000000
  - id: producer00002
    owner: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    active: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    balance: 1000000000
  - id: producer00003
    owner: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    active: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    balance: 1000000000
  - id: producer00004
    owner: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    active: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    balance: 1000000000
  - id: producer00005
    owner: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    active: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    balance: 1000000000
  - id: producer00006
    owner: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    active: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    balance: 1000000000
contractpath: contract/
admininfo:
  id: admin
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 14000000000
foundationinfo:
  id: foundation
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 0
initialtimestamp: "2006-01-02T15:04:05Z"
```

Кроме этого, раздел `p2p.seednodes` в `/data/iserver/iserver.yml` также необходимо изменить:

```
...
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a
  chainid: 1024
  version: 1
...
```

В настройках можно заменить сетевые IDs начальных узлов, как показано ниже:

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |

## Запуск узла

Запустите команду, чтобы запустить локальный узел:

```
docker run -d iostio/iost-node:2.1.0
```

Вам необходимо смонтировать том данных и опубликовать порты, как показано ниже:

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node:2.1.0
```

Или при использовании docker-compose:

```
# docker-compose.yml

version: "2"

services:
  iserver:
    image: iostio/iost-node:2.1.0
    restart: always
    ports:
      - "30000-30003:30000-30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

Для запуска узла: `docker-compose up -d`

Для запуска, остановки, перезапуска или удаления: `docker-compose (start|stop|restart|down)`

## Проверка узла

Файл логов находится по этому пути `/data/iserver/logs/iost.log`.
Растущие значения `confirmed` означают синхронизацию данных блока.

Вы также можете проверить состояние узла, используя `iwallet`:
`docker-compose exec iserver ./iwallet state`

Используйте флаг `-s` вместе с IP-адресом начального узла для получения последней информации о блокчейне:
`docker-compose exec iserver ./iwallet -s 35.176.129.71:30002 state`
