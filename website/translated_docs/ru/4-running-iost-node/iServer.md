---
id: iServer
title: iServer
sidebar_label: iServer
---

## Запуск iServer

IOST служба узла iServer включает консенсус, синхронизацию, пул транзакций и сетевые модули. Запустите службу iServer для развертывания узлов IOST.

* Чтобы скомпилировать проект в корневой директории, выполните следующую команду, и исполняемые файлы будут сохранены в `target` директории в корневой папке.

```
make build
```

* Используйте комманду ниже для запуска узла IOST

```
./target/iserver -f ./config/iserver.yaml
```

* Файл конфигурации ./config/iserver.yaml

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

* Настройка информации аккаунта узла

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

* Настройка информации генезисного блока.


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```


```
db:
  ldbpath: storage/
```

Настройка расположения базы данных.


```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

Настройка сетевой информации. Для этого требуется настроить начальные узлы для доступа к сети.

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

Настройка портов RPC.


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
```

Настройка служб регистрации.


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
