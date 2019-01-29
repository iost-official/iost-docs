---
id: Configuration
title: Конфигурация
sidebar_label: Конфигурация
---

Эта страница демонстрирует подробную информацию о конфигурации.
Вы можете получить последнюю конфигурацию по ссылкам ниже:

- genesis.tgz: https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz
- iserver.yml: https://developers.iost.io/docs/assets/testnet/latest/iserver.yml

Мы собираемся пройтись по каждому разделу в [конфигурации по умолчанию](https://github.com/iost-official/go-iost/tree/master/config).

## Настройка iServer

- acc

```
acc:
  id: producer000
  seckey: 1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB
  algorithm: ed25519
```

Когда iServer становиться producer(производителем блоков), он подписывает блок приватным ключом `acc.seckey`.   
`acc.id` это аккаунт IOST привязанный к producer.
На самом деле это поле не используется.

- genesis

```
genesis: config/genesis
```

Начиная с [Everest v2.3.0](https://github.com/iost-official/go-iost/releases/tag/everest-v2.3.0), iServer считывает информацию генезиса из директории вместо одного файла конфигурации.   
Такая директория содержит необходимый системный контракт, а также файл конфигурации genesis.   
См. также [настройка genesis](#config-genesis)

- vm & db

```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""
db:
  ldbpath: storage/
```

Настройки v8vm и базы данных.

- snapshot

```
snapshot:
  enable: false
  filepath: storage/snapshot.tar.gz
```

Если этот параметр включен (enable: true), iServer начнет со снимка блокчейна вместо того, чтобы начать с генезиса.   
Таким образом вы можете легко догнать текущую высоту блоков используя snapshot(снимок).

- p2p

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
  inboundConn: 15
  outboundConn: 15
  blackPID:
  blackIP:
  adminPort: 30005
```

listenaddr это адрес, который прослушивает p2p сеть. Если узел развернут в облачном сервисе, обязательно откройте порт в группе безопасности.  
seednodes это начальные узлы, обнаруженные сетью p2p, могут быть заполнены любым известным списком узлов.
chainid используется для изоляции разных сетей(к примеру, главная сеть и тестовая сеть будут иметь разные id).  
version это номер версии сетевого протокола.  
datapath это директория хранения таблицы маршрутизации p2p, приватного ключа узла и других данных.  
inboundConn это максимальное количество (входящих) соединений, которые подключены.  
outboundConn это максимальное количество подключенных (исходящих) соединений.  
blackPID и blackIP это ID узлов и IP узлов в черном списке. При такой конфигурации узел отклоняет сетевое p2p соединение с узлом из черного списка.  
adminPort это порт сетевого управления, доступ к которому возможен только через localhost.

- rpc

```
rpc:
  enable: true
  gatewayaddr: 0.0.0.0:30001
  grpcaddr: 0.0.0.0:30002
  trytx: false
  allowOrigins:
    - "*"
```

enable указывает следует ли включать сервис RPC.  
gatewayaddr это адрес прослушивания JSON RPC.  
grpcaddr это адрес прослушивания GRPC.  
trytx указывает, была ли транзакция предварительно выполнена.  
allowOrigins является междоменной настройкой.

- log

```
log:
  filelog:
    path: logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
  enablecontractlog: true
```

Существуют как консольные так и файловые обработчики логов.
Рекомендуется оставить этот блок по умолчанию.

- metrics

```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```

Мы используем [Prometheus](https://prometheus.io/) для сбора данных в реальном времени, в частности [Prometheus Pushgateway](https://github.com/prometheus/pushgateway).   
[Базовая аутентификация доступа HTTP](https://en.wikipedia.org/wiki/Basic_access_authentication) поддерживается.   
Просмотрите [метрика](4-running-iost-node/Metrics.md) для настройки вашего собственного сервера Prometheus.

- version

```
version:
  netname: "debugnet"
  protocolversion: "1.0"
```

Описание информации об узле.

## Настройка Genesis

Изменение genesis помешает подключению iServer к сети IOST.   
Убедитесь, что вы знаете, что делаете.

- tokeninfo

```
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 90000000000
  iostdecimal: 8
```

`iosttotalsupply` определяет максимальное количество токенов IOST.
Это не означает, что это количество IOST будет создано на этапе генезиса.

- witnessinfo

```
witnessinfo:
  - id: producer000
    owner: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    active: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    signatureblock: 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b
    balance: 0
```

Witnesses являются producers(производителями блоков) на этапе генезиса.   
Producer будут чередоваться с поступлением новых узлов Servi.

- admininfo & foundationinfo

```
admininfo:
  id: admin
  owner: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  active: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  balance: 21000000000
foundationinfo:
  id: foundation
  owner: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  active: Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto
  balance: 0
```

Этот раздел определяет аккаунты admin и foundation.

### initialtimestamp (начальная временная отметка)

```
initialtimestamp: "2018-11-10T11:04:05Z"
```

Это время начала сети.
