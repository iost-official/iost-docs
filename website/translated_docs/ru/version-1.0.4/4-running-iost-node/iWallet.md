---
id: version-1.0.4-iWallet
title: iWallet
sidebar_label: iWallet
original_id: iWallet
---

**IOSBlockchain** имеет две программы: `iServer` является основной программой и несколько `iServer` формируют сеть блокчейна. `iWallet` это инструмент командной строки для взаимодействия с `iServer` блокчейна.

После успешной `build`ing(постройки) системы, `iWallet` находится в `target/` папке в директории проекта.

![iwallet1](assets/4-running-iost-node/iWallet/iwallet.png)

## Команды

|Команда      |Содержание                              |Описание
|:-----------:|:--------------------------------------:|:--------------------------------------------|
|help         |Помощь по любой команде                 |  using iwallet -h to get further infomation
|account      |Управление аккаунтом                    |  ./iwallet account -n id
|balance      |проверка баланса указанного аккаунта    |  ./iwallet balance ~/.iwallet/id_ed25519.pub
|block        |печатает информацию о блоке, по умолчанию находит по номеру блока   |  
|call         |Вызов метода в каком-либо контракте         |  ./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' -k SecKeyPath --expiration 50
|compile      |Компилирует файлы контракта в смарт-контракт|  ./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
|net          |Получить id сети                          |  ./iwallet net
|publish      |подписывает .sc файлы с помощью .sig файлов, и публикует их        |./iwallet publish -k ~/.iwallet/id_ed25519 ./dashen.sc ./dashen.sig0 ./dashen.sig1
|sign         |Подписать файл .sc                        |  ./iwallet sign -k ~/.iwallet/id_ed25519 ./test.sc
|transaction  |найти транзакцию по транзакционному хешу    |  ./iwallet transaction HUVdKWhstUHbdHKiZma4YRHGQZwVXerh75hKcXTdu39t

## Примеры команд

### help:

Посмотреть информацию о помощи `iwallet`

```
./iwallet -h
```

### account:

Создать аккаунт IOST, с соответствующими открытым и закрытым ключами сохранеными в директории `~/.iwallet/`.

```
./iwallet account -n id
return:
the iost account ID is:
IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
```

### balance:

Просмотр баланса аккаунта:

```
./iwallet balance IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
return:
1000 iost
```

### block:

Просмотр блока с хешем:

```
# 查询0号block数据
./iwallet block -m num 0
return:
{"head":{"txsHash":"bG7L/GLaF4l8AhMCzdl9r7uVvK6BwqBq/sMMuRqbUH0=","merkleHash":"cv7EfVzjHCzieYStfEm61Ew4zbNFYN80i/6J8Ijhbos=","witness":"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A"},"hash":"9NzDz2iueLZ4e8YDotIieJRZrlTMddbjaJAvSV23TFU=","txhash":["3u12deEbLcyP7kI5k+WIuxUrskAOu8UKUOPV+H51bjE="]}
```

### call:

Вы можете `call` (вызвать) методы контракта в блокчейне.

```
# Calls iost.system contract's Transfer method，Account IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP transfers Account IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk 100 token,
# -k is private key，--expiration specifies timeout
./iwallet call "iost.system" "Transfer" '["IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP", "IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk", 100]' -k ~/.iwallet/id_ed25519 --expiration 50
return:
ok
8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
```

### net:

`net` команда получает сетевой адрес iserver.

```
./iwallet net
return:
netId: 12D3KooWNdJgdRAAYoHvrYgCHhNEXS9p7LshjmJWJhDApMXCfahk

```

### transaction:

`transaction` команда используется для поиска

```
./iwallet transaction 8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
return:
txRaw:<time:1537540108548894481 expiration:1537540158548891677 gasLimit:1000 gasPrice:1 actions:<contract:"iost.system" actionName:"Transfer" data:"[\"IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP\", \"IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk\", 100]" > publisher:<algorithm:2 sig:"\224iI\0300\317;\337N\030\031)'\277/xO\231\325\277\022\217M\017k.\260\205+*$\235\017}\353\007\206\352\367N(\203\343\333\017\374\361\230\313,\231\313* oK\270.f;6\371\332\010" pubKey:"_\313\236\251\370\270:\004\\\016\312\300\2739\304\317Jt\330\344P\347s\2413!\3725\3126\246\247" > > hash:"m\005\2613%\371\234\233\315\377@\016\253Aw\024\214IX@\0368\330\370T\241\267\342\256\252\354P"

```

### компиляция/публикация/подпись:

Пожалуйста, обратитесь к [Развертывание-и-вызов](../3-smart-contract/Deployment-and-invocation)
