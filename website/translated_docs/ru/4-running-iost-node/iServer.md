---
id: iServer
title: iServer
sidebar_label: iServer
---

## Запуск iServer

iServer - это служба узлов IOST, которая включает в себя консенсус, синхронизацию, пул транзакций и сетевые модули. Запустите службу iServer для развертывания узлов IOST.

* Выполните следующую команду, чтобы скомпилировать проект в корневой директории, и исполняемые файлы будут сохранены в `target` директории в корневой папке.

```
make build
```

* Используйте комманду ниже для запуска узла IOST

```
./target/iserver -f ./config/iserver.yml
```

* Измените файл конфигурации ./config/iserver.yml

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

* Настройте информацию об аккаунте узла

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

* Настройте информацию о генезисном блоке, производителе блоков и сумме токенов.


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```


```
db:
  ldbpath: storage/
```

Настройте расположения базы данных.


```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

Настройте сетевую информацию. Это требует настройки начальных узлов для доступа к сети.

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

Настройте порты RPC.


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

Настройте службы регистрации.


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
