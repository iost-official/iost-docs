---
id: LocalServer
title: Запуск локального сервера
sidebar_label: Запуск локального сервера
---
Существует два способа запуска локального сервера: с помощью Докера или нативно.

## Запуск сервера IOST используя Докер
Запустить сервер IOST с помощью докера очень просто. Этот способ рекомендуется.    
Следующая команда запустит сервер одного-узла блокчейна IOST.   
Вы можете использовать его для отладки и тестирования.  
Необходим [Docker CE 18.06 или новее](https://docs.docker.com/install/) (старые версии не тестировались).

```
docker run -it --rm -p 30000-30003:30000-30003 iostio/iost-node:2.1.0
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

## Нативный запуск сервера IOST

После окончания [сборки IOST](Building-IOST), вы можете запустить сервер.
```
iserver -f ./config/iserver.yml
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)
