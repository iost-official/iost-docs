---
id: Deployment-Docker-Centos
title: Deployment Docker Centos
sidebar_label: Deployment Docker Centos
---

## Install Centos 7 

Download or Deploy Centos 7 minimal ,  their maybe differences in configurations of Centos 7 images available from Amazon, Google, Azure. This document is based on a default Centos 7 minimal install.

You can download Centos from https://www.centos.org/download/ (ensure you choose Centos 7 minimal)

If you are doing a manual install select the minimal ISO and install default settings other than for partitioning, refer to Centos documentation to complete installation. You will want to increase the / from the default size or add a dedicated /var/lib/docker/ partition.



## Install Depedencies 

To run the docker IOST-NODE image you will need to install a variety of dependencies on the Centos 7 server

- Git version 2.16+
- Git LFS 2.6+
- Docker-CE

It is assumed you will be running the commands as root, it is also assumed you do not have the default docker installed from Centos, if you do please review https://docs.docker.com/install/linux/docker-ce/centos/#uninstall-old-versions


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

## Firewall
If you are hosting the server in a cloud provider or similar you will need to adjust your ACL/Firewall within the vendors control panel.

Enable TCP ports 30000:30003 in your vendors firewall.

You will need to update your host firewall, the preference is to use IPTABLES directly as it is simpler to configure then firewalld. On many pre-built images firewalls are entirely disabled (depends who built your image). You can use the following command to see if firewalld is enable.

```
systemctl status firewalld
```
You may choose to use firewalld if you prefer, the instructions below are to disable firewalld and enable traditional iptables service.

Disable Firewalld and install and enable Iptables.service
```
systemctl stop firewalld
systemctl disable firewalld
yum -y install iptables-service
systemctl enable iptables.service
systemctl start iptables.service
```

Enable the necessary ports
```
iptables -I INPUT -p tcp -m tcp --dport 30000:30003 -j ACCEPT
service iptables save
```

If you are using firewalld you can run the following commands to allow the necessary ports
```
firewall-cmd --permanent --add-port=30000:30003/tcp
firewall-cmd --reload
```

It is highly recommended you adjust your servers firewall to restrict port 22 access to known IP address and/or change the SSHD port and disable sshd password authentication. This is beyond the scope of this document.


## Reboot

Reboot your server so you have the latest kernel and libraries correctly loaded in your runtime

```
reboot
```

## Clone go-iost repository

Run the following command to clone the repository

```
git clone https://github.com/iost-official/go-iost && cd go-iost
```

## Checkout the current version

Run the following command modifying the version as approriate to checkout the current version

```
git checkout v2.0.0
```

## Docker

Ensure Docker is running and enabled on your localhost

```
systemctl enable docker
systemctl start docker
```

The following command should return without an error
```
docker ps
```

### Create Data directory

The data diretory will be mounted to docker container during startup, it is recommended you create a dedicated /data partition on your server that is not the same physical medium as your running server partition. For Amazon this could be a separate EBS volume, the configuration of this is beyond the scope of this document. 

The /data/iserver/ directory will be mounted into the container as /var/lib/iserver, this data will be persistent.

Create directory
```
mkdir -p /data/iserver/
```

Copy necessary files from go-iost into your /data/iserver directory on your host machine, for example

```
cp config/{docker/iserver.yml,genesis.yml} /data/iserver/
```


### Pull

Run the following command to pull the image from Docker Hub , see https://hub.docker.com/r/iostio/iost-node , change the version as necessary. The image will automatically be pulled later on but it is worth knowing.

```
docker pull iostio/iost-node:2.0.0
```

### Modify your iserver.yml

Open /data/iserver/iserver.yml with your favorite editor (vi)

Setup your account ID and SECRET key, you can generate these at https://explorer.iost.io or using iwallet.
```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

To connect to the tesnet you must modify p2p.seednodes
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

Among the settings, the network IDs of seed nodes can be replaced,
as shown below:

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |


### Modify your genesis.yml

Change genesis settings as below:

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


### Run container

Create docker-compose.yml , this could exist anywhere on the server, you could put it in /data/iserver 

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

To start the node: `docker-compose up -d`


## Useful commands

Once your container is running

Show current running containers
```
docker ps
```

Using the container ID from above you can run further commands

Show logs
```
docker logs -f CONTAINER-ID
```

Enter container in TTY
```
docker container exec -ti CONTAINER-ID bash
```

Once you are in the container you can run iwallet
```
./iwallet state
```


