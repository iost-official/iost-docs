---
id: version-2.1.7-Deployment
title: Присоединяйтесь к тестовой сети IOST
sidebar_label: Присоединяйтесь к тестовой сети IOST
original_id: Deployment
---

Документация описывает, как настроить работающий сервер, подключающийся к тестовой сети IOST, если вы хотите просто настроить локальный одиночный сервер сети блокчейна для отладки/тестирования, вам лучше обратиться к [Запуску локального сервера](4-running-iost-node/LocalServer.md)   

Мы используем Докер для развертывания узла IOST.

## Необходимо

- [Docker CE 18.06 или новее](https://docs.docker.com/install) (старые версии не тестировались)
- (Опционально) [Docker Compose](https://docs.docker.com/compose/install)

## Подготовка файла конфигурации

Для более детальной информации об iServer, см. [здесь](4-running-iost-node/LocalServer.md).

Сначала получите шаблоны конфигурации:

```
mkdir -p /data/iserver
curl https://developers.iost.io/docs/assets/testnet/latest/genesis.tgz | tar zxC /data/iserver
curl https://developers.iost.io/docs/assets/testnet/latest/iserver.yml -o /data/iserver/iserver.yml
```

`/data/iserver` будет монтироваться как том данных, вы можете изменить путь в соответствии с вашими потребностями.

*Если вы уже запускали предыдущую версию iServer, убедитесь, что старые данные удалены:*

```
rm -rf /data/iserver/storage
```

## Запуск узла

Запустите следующую команду, чтобы запустить узел

```
docker run -d -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

Или при использовании docker-compose:

```
# docker-compose.yml

version: "2"

services:
  iserver:
    image: iostio/iost-node
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

Вы также можете проверить состояние узла, используя инструмент `iwallet` внутри докера.
См. также [iWallet](4-running-iost-node/iWallet.md).

```
docker-compose exec iserver ./iwallet state
```

Последняя информация о блокчейне также отображается на [blockchain explorer](https://explorer.iost.io).
