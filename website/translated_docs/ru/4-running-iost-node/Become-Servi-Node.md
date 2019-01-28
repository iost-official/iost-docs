---
id: Become-Servi-Node
title: Станьте Узлом Servi
sidebar_label: Станьте Узлом Servi  
---

Узел Servi может генерировать блоки только являясь *producer*(производителем блоков), для чего требуется аккаунт IOST и полный узел.

# Старт полного узла
Запустите загрузочный скрипт, чтобы запустить полный узел. См. также [Старт узла](4-running-iost-node/Deployment.md).

```
curl https://developers.iost.io/docs/assets/boot.sh | sh
```

Пара ключей (*keypair*) производителя блоков расположена по пути `/data/iserver/keypair`. Здесь вы можете получить публичный ключ производителя блоков.

Вы можете получить *network ID*(сетевой ID) узла в разделе `network.id` с помощью команды `curl http://localhost:30001/getNodeInfo`

# Создание аккаунта IOST

Если у вас еще нет аккаунта, следуйте этим шагам:

- [Установите iwallet](4-running-iost-node/iWallet.md#install)
- Сгенерируйте *пару ключей* с помощью iWallet: `iwallet keys`
- Используйте сгенерированный *публичный ключ* для создания аккаунта в тестовой сети с помощью [blockchain explorer](https://explorer.iost.io/applyIOST).

> Не забудьте импортировать свой аккаунт в iwallet: `iwallet account --import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`

# Регистрация узла servi

Вы можете зарегистрировать свой аккаунт в качестве узла servi с помощью iwallet:
```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",<is-producer>]'
```
См. API документацию `vote_producer.iost` [здесь](6-reference/SystemContract.md#vote-produceriost).

- `<your-account>`: Аккаунт использованный для регистрации узла servi
- `<pubkey-of-producer>`: Публичный ключ полного узла производителя блоков
- `<location>`: Расположение вашего полного узла
- `<website>`: Ваш официальный сайт
- `<network-ID>`: Сетевой ID полного узла производителя блоков
- `<is-producer>`: Будете ли вы производителем блоков (Если вы хотите быть только узлом партнером, эта опция должна иметь значение false)

пример:
```
iwallet --account iost call 'vote_producer.iost' 'applyRegister' '["iost","6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b","Singapore","https://iost.io/","/ip4/3.85.187.72/tcp/30000/ipfs/12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht",true]'
```

# Войдите в систему качестве узла servi

Когда узел servi получает более 2.1 миллионов голосов и уже залогинился, он получает возможность генерации блоков.

Вы можете войти в качестве узла servi с помощью iwallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'
```

# Выйти из системы в качестве узла servi
Если вы хотите временно приостановить полный узел или не генерировать блоки, вы можете выйти из системы в качестве узла servi с помощью iwallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]'
```
