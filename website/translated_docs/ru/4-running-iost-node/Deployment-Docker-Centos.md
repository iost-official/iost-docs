---
id: Deployment-Docker-Centos
title: Развертывание Докера в ОС Centos
sidebar_label: Развертывание Докера в ОС Centos
---

## Установка Centos 7

Загрузите или разверните Centos 7 minimal , могут быть различия в настройках образов Centos 7 доступных из Amazon, Google, Azure. Данный документ основан на установке Centos 7 minimal по умолчанию.

Вы можете скачать Centos с https://www.centos.org/download/ (убедитесь, что вы выбрали Centos 7 minimal).

Если вы выполняете установку вручную, выберите ISO minimal и сконфигурируйте разделы, обратитесь к документации Centos для успешной установки. Вы можете увеличить размер разделов по умолчанию или добавить выделенный раздел /var/lib/docker/.



## Установка зависимостей

Для запуска образа докера IOST-NODE вам необходимо установить различные зависимости на сервере Centos 7:

- Git version 2.16+
- Git LFS 2.6+
- Docker-CE

Предполагается, что вы будете запускать команды от имени пользователя root, также предполагается, что у вас нет установленного докера по умолчанию из Centos, а если есть просмотрите https://docs.docker.com/install/linux/docker-ce/centos/#uninstall-old-versions


```
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y  https://centos7.iuscommunity.org/ius-release.rpm
yum install -y git2u docker-ce netstat
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod 755 /usr/local/bin/docker-compose
```

## Файрвол
Если вы размещаете сервер в облачном провайдере или аналогичном ему, вам необходимо настроить ACL/Файрвол в панели управления поставщика.

Включите TCP порты 30000:30003 в файрволе вашего поставщика.

Вам потребуется обновить файрвол вашего хоста, предпочтение отдается непосредственному использованию IPTABLES, так как его проще настроить, чем файрвол. Во многих готовых образах файрволы полностью отключены (зависит от того, кто создал ваш образ). Вы можете использовать следующую команду, чтобы увидеть, включен ли файрвол:

```
systemctl status firewalld
```
Вы можете использовать файрвол (если отдаете предпочтение файрволу), приведенные ниже инструкции отключают файрвол и включают традиционную службу iptables.

Отключите Файрвол, установите и включите Iptables.service:
```
systemctl stop firewalld
systemctl disable firewalld
yum -y install iptables-service
systemctl enable iptables.service
systemctl start iptables.service
```

Включите необходимые порты:
```
iptables -I INPUT -p tcp -m tcp --dport 30000:30003 -j ACCEPT
service iptables save
```

Если вы используете файрвол, вы можете запустить следующие команды, чтобы разрешить необходимые порты:
```
firewall-cmd --permanent --add-port=30000:30003/tcp
firewall-cmd --reload
```

Настоятельно рекомендуется настроить файрвол вашего сервера для ограничения доступа порта 22 к известному IP-адресу и/или изменить порт SSHD и отключить проверку подлинности с помощью пароля sshd. Это выходит за рамки этого документа.


## Перезагрузка

Перезагрузите сервер, чтобы у вас было правильно загружено последнее ядро ОС и библиотеки во время выполнения:

```
reboot
```

## Клонируйте репозиторий go-iost

Запустите следующую команду, чтобы клонировать репозиторий:

```
git clone https://github.com/iost-official/go-iost && cd go-iost
```

## Проверьте текущую версию

Выполните следующую команду, изменяя версию соответствующим образом, чтобы получить текущую версию:

```
git checkout v2.0.0
```

## Докер

Убедитесь, что докер запущен и включен на вашем локальном хосте:

```
systemctl enable docker
systemctl start docker
```

Следующая команда должна быть выполнена без ошибки:
```
docker ps
```

### Создайте директорию Data

Директория data будет монтироваться в докер-контейнер во время запуска, рекомендуется создать выделенный раздел /data на вашем сервере, который не совпадает с физическим носителем, на котором работает раздел вашего сервера. Для Amazon это может быть отдельный том EBS, конфигурация которого выходит за рамки этого документа.

Директория /data/iserver/ будет смонтирована в контейнер как /var/lib/iserver, эти данные будут постоянными.

Создайте директорию:
```
mkdir -p /data/iserver/
```

Скопируйте необходимые файлы из go-iost в вашу директорию /data/iserver на вашем хосте, например:

```
cp config/{docker/iserver.yml,genesis.yml} /data/iserver/
```


### Pull

Запустите следующую команду, чтобы вытащить образ из Docker Hub, смотрите  https://hub.docker.com/r/iostio/iost-node , при необходимости измените версию. Образ будет автоматически получен позже, но это стоит знать.

```
docker pull iostio/iost-node:2.0.0
```

### Модифицируйте ваш iserver.yml

Откройте /data/iserver/iserver.yml в вашем любимом редакторе.

Установите свой ID аккаунта и секретный ключ, вы можете сгенерировать их в https://explorer.iost.io или используя iwallet.
```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

Для подкючения к тестовой сети вам необходимо изменить p2p.seednodes
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

Среди настроек можно заменить сетевые ID начальных узлов, как показано ниже:

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |


### Модифицируйте ваш genesis.yml

Изменить настройки генезиса, как показано ниже:

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


### Запустите контейнер

Создайте docker-compose.yml , этот файл может существовать на сервере где угодно, вы можете поместить его в /data/iserver

```
version: "2.2"

services:
  iserver:
    image: iostio/iost-node:2.0.0
    restart: always
    ports:
      - "30000:30000"
      - "30001:30001"
      - "30002:30002"
      - "30003:30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

Для запуска узла: `docker-compose up -d`


## Полезные команды

Теперь, когда ваш контейнер работает, вы можете использовать различные команды.

Показать текущие запущенные контейнеры:
```
docker ps
```

Используя ID контейнера сверху, вы можете запускать дальнейшие команды:

Показать логи
```
docker logs -f CONTAINER-ID
```

Войти в запущенный контейнер в новом TTY (терминале)
```
docker container exec -ti CONTAINER-ID bash
```

Как только вы окажетесь в контейнере, вы можете запустить iwallet
```
./iwallet state
```
