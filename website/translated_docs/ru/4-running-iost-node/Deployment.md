---
id: Deployment
title: Присоединяйтесь к тестовой сети IOST
sidebar_label: Присоединяйтесь к тестовой сети IOST
---

Документация описывает, как настроить работающий сервер, подключающийся к тестовой сети IOST, если вы хотите просто настроить локальный одиночный сервер сети блокчейна для отладки/тестирования, вам лучше обратиться к [Запуску локального сервера](4-running-iost-node/LocalServer.md)   

Мы используем Докер для развертывания узла IOST.

## Необходимо

- Curl (любая версия, которая вам нравится)
- Python (любая версия, которая вам нравится)
- [Docker 1.13/Docker CE 17.03 или новее](https://docs.docker.com/install) (старые версии не тестировались)
- (Опционально) [Docker Compose](https://docs.docker.com/compose/install)

## Перед началом

По умолчанию, `/data/iserver` монтируется как том данных, вы можете изменить путь в соответствии с вашими потребностями.
Мы будем вдальнейшем ссылаться на `PREFIX` в качестве пути.

*Если вы уже запускали предыдущие версии iServer, убедитесь, что старые данные были удалены:*

```
rm -rf $PREFIX/storage
```

## Старт узла

Выполните команду для запуска узла:

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

Или используя скрипт *boot*(загрузки):

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

Этот скрипт очищает `$PREFIX` и запускает новый свежий полный узел, подключающийся к сети IOST.
Он также генерирует пару ключей *producer* ("производителя блоков") для генерации блоков.

Для запуска, остановки и перезапуска узла измените директорию на `$PREFIX` и выполните команду: `docker-compose (start|stop|restart|down)`

## Проверка узла

Файл логов расположен по пути `$PREFIX/logs/iost.log`.
Растущие значения `confirmed`, как к примеру ниже, означают синхронизацию данных блоков:

```
...
Info 2019-01-19 08:36:34.249 pob.go:456 Rec block - @4 id:Dy3X54QSkZ..., num:1130, t:1547886994201273330, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:34.550 pob.go:456 Rec block - @5 id:Dy3X54QSkZ..., num:1131, t:1547886994501284335, txs:1, confirmed:1095, et:49ms
Info 2019-01-19 08:36:34.850 pob.go:456 Rec block - @6 id:Dy3X54QSkZ..., num:1132, t:1547886994801292955, txs:1, confirmed:1095, et:49ms
Info 2019-01-19 08:36:35.150 pob.go:456 Rec block - @7 id:Dy3X54QSkZ..., num:1133, t:1547886995101291970, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:35.450 pob.go:456 Rec block - @8 id:Dy3X54QSkZ..., num:1134, t:1547886995401281644, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:35.750 pob.go:456 Rec block - @9 id:Dy3X54QSkZ..., num:1135, t:1547886995701294638, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:36.022 pob.go:456 Rec block - @0 id:EkRgHNoeeP..., num:1136, t:1547886996001223210, txs:1, confirmed:1105, et:21ms
Info 2019-01-19 08:36:36.324 pob.go:456 Rec block - @1 id:EkRgHNoeeP..., num:1137, t:1547886996301308669, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:36.624 pob.go:456 Rec block - @2 id:EkRgHNoeeP..., num:1138, t:1547886996601304333, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:36.921 pob.go:456 Rec block - @3 id:EkRgHNoeeP..., num:1139, t:1547886996901318752, txs:1, confirmed:1105, et:20ms
Info 2019-01-19 08:36:37.224 pob.go:456 Rec block - @4 id:EkRgHNoeeP..., num:1140, t:1547886997201327191, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:37.521 pob.go:456 Rec block - @5 id:EkRgHNoeeP..., num:1141, t:1547886997501297659, txs:1, confirmed:1105, et:20ms
...
```

Вы также можете проверить состояние узла используя инструмент `iwallet`.
См. также [iWallet](4-running-iost-node/iWallet.md).

```
docker-compose exec iserver ./iwallet state
```

Последняя информация о блокчейне также показана на [blockchain explorer](https://explorer.iost.io).

## Servi Node (Узел Servi)

Узел Servi, так же известен как Super узел, может генерировать блоки только когда является *producer*,
что требует аккаунт IOST и полный узел.   
**Настоятельно рекомендуется использовать другую пару ключей из вашего аккаунта для producer.**

### Создание аккаунта IOST

Если у вас пока нет аккаунта, следуйте этим шагам:

- Сгенерируйте *keypair*(пару ключей) с помощью iWallet.
- Зарегистрируйтесь в [blockchain explorer](https://explorer.iost.io) используя сгенерированную *keypair*(пару ключей).

Не забудьте импортировать ваш аккаунт с помощью iWallet.

### Запуск узла

Запустите загрузочный скрипт, чтобы запустить полный узел. См. также [Старт узла](#start-the-node).

```
curl https://developers.iost.io/docs/assets/boot.sh | PREFIX=$PREFIX sh
```

Пара ключей (*keypair*) производителя расположена по пути `$PREFIX/keypair`.
Вы можете получить *network ID*(сетевой ID) узла в разделе `.network.id` `http://localhost:30001/getNodeInfo`.

### Подача заявки на регистрацию

Проведите tx (транзакцию) для регистрации вашего узла с помощью iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",true]' --amount_limit '*:unlimited'
```

См. документацию API `vote_producer.iost` [здесь](6-reference/SystemContract.md#vote-produceriost).

## Оператор для узла Servi

После утверждения **admin**(администратором), когда узел готов, переведите его в онлайн режим:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]' --amount_limit '*:unlimited'
```

Для остановки генерации блоков узлом выполните команду:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]' --amount_limit '*:unlimited'
```
