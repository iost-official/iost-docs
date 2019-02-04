---
id: Google-Compute-Platform
title: Google Compute Platform
sidebar_label: Google Compute Platform
---


#

Вам необходим аккаунт Gmail для регистрации в Google Compute Platform или корпоративный аккаунт на основе Gmail.

Перейдите по ссылке https://accounts.google.com/SignUp , чтобы создать аккаунт Google

Вы можете использовать Google Account (при наличии) для управления Google Compute Platform https://console.cloud.google.com/compute/

Возможно, вы имеете право на бесплатную пробную версию, пробный аккаунт имеет множество ограничений таких как CPU и хранилище.

## Создание виртуальной машины

В меню Compute вы сможете создать виртуальную машину (VM), если у вас нет виртуальных машин, вы увидите следующее, в противном случае вы увидите стандартный *Create Instance*

![create_instance](assets/4-running-iost-node/GoogleCloudPlatform/create_instance.png)

Нажмите кнопку *Create* , чтобы продолжить

Далее вам нужно задать вашему узлу имя, Регион, Зону и настроить Размер. В следующем примере мы настроили инстанс в соответствии с минимальным рекомендуемым размером:

* 8 Cores
* 16 GB memory

Вам следует дать своему инстансу имя, которое будет отличимое как от вашего, так и от Региона, рекомендуется выбрать регион, который близок к вашему географическому положению, это поможет децентрализации платформы IOST.

![configure_instance](assets/4-running-iost-node/GoogleCloudPlatform/configure_instance.png)

### Загрузочный диск

Прокрутите вниз, пока не увидите *Boot disk*, нажмите *Change* (тип по умолчанию - Debian GNU/Linux 9). Выберите *CentOS 7*

![configure_boot_disk](assets/4-running-iost-node/GoogleCloudPlatform/configure_boot_disk.png)

Прокрутите до низа для изменения Размера с *10* на минимум *100*, если вы хотите можете выбрать больше, это значение можно будет изменить при необходимости.

![configure_boot_disk_size](assets/4-running-iost-node/GoogleCloudPlatform/configure_boot_disk_size.png)

После того, как вы настроили эти два параметра, нажмите *Select* внизу страницы, вы вернетесь на главную страницу *New VM instance* и увидете следующее

![configure_boot_disk_complete](assets/4-running-iost-node/GoogleCloudPlatform/configure_boot_disk_complete.png)


### Файрвол

При первоначальном создании инстанса вы не можете добавить необходимые правила файрвола, это можно сделать, когда сервер будет в онлайне


### Управление

Ниже раздела Файрвол вы увидете *Management, security, disks, networking, sole tenancy* , нажмите

![management](assets/4-running-iost-node/GoogleCloudPlatform/management.png)


Во вкладке Management вы можете создать скрипт Автоматизации, это поможет упростить некоторую работу, см. https://cloud.google.com/compute/docs/startupscript для подробной информации

Пожалуйста, обратитесь к [Развертывание Докера в ОС Centos](4-running-iost-node/Deployment-Docker-Centos.md), откуда этот скрипт был получен

Обратите внимание, что этот скрипт также пытается подключить ваш диск с данными, этот скрипт не предназначен для многократного запуска, пожалуйста **Удалите его** после первой инициализации.

```
#! /bin/bash
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y git2u docker-ce
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod 755 /usr/local/bin/docker-compose
git clone https://github.com/iost-official/go-iost && cd go-iost
git checkout v2.1.0
systemctl enable docker
systemctl start docker
mkfs.xfs /dev/sdb
mkdir -p /data/
mount /dev/sdb /data/
mkdir -p /data/iserver
mkdir -p /data/docker
cat <<EOF> /data/iserver/iserver.yml
acc:
  id: IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  seckey: 1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB
  algorithm: ed25519
genesis: /var/lib/iserver/genesis.yml
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""
db:
  ldbpath: /var/lib/iserver/storage/
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a
  chainid: 1024
  version: 1
  datapath: /var/lib/iserver/p2p/
  inboundConn: 15
  outboundConn: 15
  blackPID:
  blackIP:
  adminPort: 30005
rpc:
  gatewayaddr: 0.0.0.0:30001
  grpcaddr: 0.0.0.0:30002
log:
  filelog:
    path: /var/lib/iserver/logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
metrics:
  pushaddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
debug:
  listenaddr: 0.0.0.0:30003
version:
  netname: "debugnet"
  protocolversion: "1.0"
EOF
cat <<EOF > /data/iserver/genesis.yml
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
EOF
cat <<EOF> /data/docker/docker-compose.yml
version: "2.2"

services:
  iserver:
    image: iostio/iost-node:2.1.0
    restart: always
    ports:
      - "30000:30000"
      - "30001:30001"
      - "30002:30002"
      - "30003:30003"
    volumes:
      - /data/iserver:/var/lib/iserver
EOF
cd /data/docker
docker-compose up -d
```
Когда вы заполните эту форму, она будет выглядеть

![management_automation](assets/4-running-iost-node/GoogleCloudPlatform/management_automation.png)



### Диски

Перейдите на вкладку Диски и нажмите *Add new disk*

![disks_add_disk](assets/4-running-iost-node/GoogleCloudPlatform/disks_add_disk.png)

Далее укажите Name(имя) и Size(размер), обратите внимание, что если у вас пробный аккаунт, вы не можете создавать диски в вашем регионе более *2048 GB* без запроса на увеличение квоты.

![disks_configure](assets/4-running-iost-node/GoogleCloudPlatform/disks_configure.png)

На этом этапе вы можете нажать кнопку *Create* внизу страницы для инициализации развертывания виртуальной машины


## Файрвол

Нажмите на имя вашего инстанса и вы попадете на страницу *VM instance details* , нажмите на три маленькие точки и нажмите *Network Details* , слева перейдите к *Firewall rules*

Нажмите *Create Firewall Rule* и задайте имя создаваемому правилу

![firewall_name](assets/4-running-iost-node/GoogleCloudPlatform/firewall_name.png)

Затем вы должны указать порты Target, Source и Destination, вы можете указать целью аккаунт службы, связанной с вашим текущим инстансом (это более безопасно), но в этом примере для простоты он открывается для всех виртуальных машин в VPC.

![firewal_ports](assets/4-running-iost-node/GoogleCloudPlatform/firewall_ports.png)

Нажмите Create и вы увидете следующее правило

![verify_ssh](assets/4-running-iost-node/GoogleCloudPlatform/firewall_confirm.png)

Вам необходимо нажать на 3 строки рядом с *Google Cloud Platform* и перейти *Compute Engine* , *VM Instances* , чтобы вернуться к вашему инстансу виртуальной машины.

## Проверка инстанса

На консоли Compute вы увидите, что ваш узел работает, на нем будет отображаться ваш внутренний и внешний IP-адрес, а также опция для подключения через SSH, выберите *Open in browser window*, произойдет подключение непосредственно из Google Compute Platform без необходимости открытия SSH-порта в интернет или на определенный IP.

![verify_ssh](assets/4-running-iost-node/GoogleCloudPlatform/verify_ssh.png)

Из консоли вы можете стать пользователем root и проверить некоторые логи
```
sudo su -
docker ps
tail -f /data/iserver/logs/iost.log
```
Вы должны увидеть синхронизацию блоков
![verify_server](assets/4-running-iost-node/GoogleCloudPlatform/verify_server.png)


Вам может потребоваться перезапустить контейнер докера, если он был запущен до применения правил файрвола в VPC. Перед запуском команды убедитесь, что вы в директории с файлом docker-compose.yml.
```
docker-compose restart iserver
```

Вам также может понадобиться изменить номер своего аккаунта в /data/iserver/iserver.yml , если вы запускаете Servi Node


Чтобы проверить синхронизацию вашего узла, выполните следующую команду и посмотрите увеличивается ли *headBlock*
```
docker exec -ti 1234abcd bash
./iwallet state
```

Чтобы проверить, работает ли ваш узел, запросите начальный узел и найдите ваш публичный ip
```
docker exec -ti 1234abcd bash
./iwallet state -s 35.176.127.71:30002 | grep 35.246.82.51
```

Вы должны увидеть следующие выходные данные, убедитесь, что ваш порт показывает 30000

![verify_node](assets/4-running-iost-node/GoogleCloudPlatform/verify_server.png)

Удаленно с другого сервера вы также сможете получить подключение к сокету с запущенным telnet

```
telnet 35.246.82.51 30000
```
