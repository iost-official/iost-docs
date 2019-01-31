---
id: version-2.5.0-Become-Servi-Node
title: Станьте Узлом Servi
sidebar_label: Станьте Узлом Servi
original_id: Become-Servi-Node
---

Для Узла Servi требуется аккаунт IOST для получения вознаграждения и полный узел для генерации блоков.
Вначале вам необходимо запустить узел, а затем привязать узел к вашему аккаунту.
Каждый аккаунт IOST можно привязать *только* к одному Узлу Servi.
Узел Servi подписывает блоки, которые генерирует, с помощью приватного ключа в конфигурационном файле iServer.   
**Настоятельно рекомендуется использовать различные пары ключей вашего аккаунта для Узла Servi.**

# Создание аккаунта IOST

Если у вас еще нет аккаунта IOST, следуйте этим шагам:

- [Установите iWallet](4-running-iost-node/iWallet.md#install)
- Сгенерируйте *пару ключей* с помощью iWallet: `iwallet keys`
- Используя сгенерированный *публичный ключ* создайте аккаунт на [blockchain explorer](https://explorer.iost.io/applyIOST).

> Не забудьте импортировать ваш аккаунт с помощью iWallet: `iwallet account --import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`

Из соображений безопасности рекомендуется хранить ваш аккаунт IOST в секретном месте отличном от Узла Servi.

# Старт полного узла

Запустите загрузочный скрипт, чтобы запустить полный узел. См. также [Старт узла](4-running-iost-node/Deployment.md).

```
curl https://developers.iost.io/docs/assets/boot.sh | bash
```

Если все пройдет правильно, вывод будет таким:

```
...
If you want to register Servi node, exec:

        iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey>","","","<network-id>",true]'

To set the Servi node online:

        iwallet --acount <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'

See full doc at https://developers.iost.io
```

Этот скрипт сгенерирует новую пару ключей для узла. Пожалуйста установите **публичный ключ** и **ID сети**.

*Пара ключей* узла располагается по пути `$PREFIX/keypair`, также и **публичный ключ**.

Вы можете получить **ID сети** узла в разделе `network.id` с помощью команды `curl http://localhost:30001/getNodeInfo`

# Регистрация узла servi

Зарегистрируйте узел Servi, т.е. привяжите узел к вашему аккаунту используя iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",<is-producer>]'
```

См. API документацию `vote_producer.iost` [здесь](6-reference/SystemContract.md#vote-produceriost).

- `<your-account>`: Аккаунт использованный для регистрации узла servi
- `<pubkey-of-producer>`: Публичный ключ узла
- `<location>`: Расположение вашего полного узла
- `<website>`: Ваш официальный сайт
- `<network-ID>`:  ID сети узла
- `<is-producer>`: Станете ли вы производителем блоков (если вы хотите быть только узлом партнером, эта опция должна иметь значение false)

Например:

```
iwallet --account iost call 'vote_producer.iost' 'applyRegister' '["iost","6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b","Singapore","https://iost.io/","12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht",true]'
```

# Войдите в систему в качестве Узла Servi

Когда Узел Servi получает более 2.1 миллионов голосов и уже залогинился, он получает возможность генерации блоков.

Вы можете войти в качестве узла servi с помощью iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'
```

# Выйти из системы в качестве Узла Servi
Если вы хотите временно приостановить полный узел или не генерировать блоки, вы можете выйти из системы в качестве Узла Servi с помощью iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]'
```
