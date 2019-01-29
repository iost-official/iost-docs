---
id: Deployment-Docker-Centos
title: Déploiement Centos Docker
sidebar_label: Déploiement Centos Docker
---

## Installer Centos 7

Télécharger ou déployer Centos 7 minimal, il peut exister des différences dans les images proposées par Amazon, Google, Azure. Ce document est basé sur l'utilisation de Centos 7 minimum.

Vous pouvez télécharger Centos ici https://www.centos.org/download/ (choisir Centos 7 minimal)

Si vous effectuez une installation manuelle, sélectionner l'ISO minimal et utiliser les paramètres par défaut sauf pour le partitionnement. Se référer à la documentation Centos pour terminer l'installation. Il est conseillé d'augmenter la taille de / par rapport à la taille par défaut, ou d'ajouter une partition /var/lib/docker/ dédiée.



## Installation des dépendances

Afin d'exécuter l'image IOST-NODE les dépendances suivantes sont nécessaires

- Git version 2.16+
- Git LFS 2.6+
- Docker-CE

Il est admis que les commandes sont lancées en tant que root. Il est aussi supposé que vous n'avez pas la version de docker installée par défaut par Centos https://docs.docker.com/install/linux/docker-ce/centos/#uninstall-old-versions


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
Si vous hébergez le serveur chez un hébergeur cloud ou similaire, vous devrez ajuster votre ACL/Firewall dans le panneau de configuration du fournisseur.

Activez les ports TCP 30000:30003 dans le firewall de l'hébergeur.

Vous devrez mettre à jour votre firewxall hôte, la préférence est d'utiliser directement IPTABLES car il est plus simple à configurer que firewalld. Sur de nombreuses images pré-construites, les firewall sont entièrement désactivés (dépend de qui a construit votre image). Vous pouvez utiliser la commande suivante pour voir si firewalld est activé.

```
systemctl status firewalld
```
Vous pouvez utiliser firewalld si vous préférez, les instructions ci-dessous sont pour désactiver firewalld et utiliser le traditionnel iptables à la place.

Désactiver Firewalld et installer puis activer Iptables.service
```
systemctl stop firewalld
systemctl disable firewalld
yum -y install iptables-service
systemctl enable iptables.service
systemctl start iptables.service
```

Autoriser les ports nécessaires
```
iptables -I INPUT -p tcp -m tcp --dport 30000:30003 -j ACCEPT
service iptables save
```

Si vous utilisez firewalld vous pouvez lancer la commande suivante pour autoriser les ports nécessaires
```
firewall-cmd --permanent --add-port=30000:30003/tcp
firewall-cmd --reload
```

Il est hautement recommandé de restreindre l'accès au port 22 à une ip connue, ou de changer le port SSHD par défaut, ainsi que de désactiver l'authentification par mot de passe.


## Reboot

Rebooter le serveur afin d'activer le dernier kernel et que les librairies soient correctement chargées

```
reboot
```

## Clone go-iost

Lancer la commande suivante pour cloner le répertoire

```
git clone https://github.com/iost-official/go-iost && cd go-iost
```

## Contrôler la version installée

Exécuter la commande suivante afin de sélectionner la bonne branche

```
git checkout v2.0.0
```

## Docker

S'assurer que Docker est lancé et activé

```
systemctl enable docker
systemctl start docker
```

La commande suivante devrait s'exécuter sans erreur
```
docker ps
```

### Créer le répertoire de données

Le répertoire de données sera monté sur le conteneur docker au démarrage, il est recommandé de créer une partition /data dédiée sur votre serveur qui n'est pas le même support physique que votre partition serveur en cours d'exécution. Pour Amazon, il pourrait s'agir d'un volume EBS séparé, dont la configuration dépasse le cadre du présent document.

Le répertoire /data/iserver/ sera monté dans le container comme /var/lib/iserver, ces données seront persistentes.

Créer le répertoire
```
mkdir -p /data/iserver/
```

Copiez les fichiers nécessaires depuis go-iost dans votre répertoire /data/iserver sur votre machine hôte, par exemple

```
cp config/{docker/iserver.yml,genesis.yml} /data/iserver/
```


### Pull

Exécutez la commande suivante pour extraire l'image de Docker Hub, voir https://hub.docker.com/r/iostio/iost-node, changez la version si nécessaire. L'image sera automatiquement pull plus tard mais cela vaut la peine d'être connu.

```
docker pull iostio/iost-node:2.0.0
```

### Modifier votre iserver.yml

Ouvrir /data/iserver/iserver.yml avec votre éditeur favori (vi)

Renseigner votre ID de compte et votre clé secrète, vous pouvez générer ceux-ci sur https://explorer.iost.io ou avec iwallet.
```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

Afin de se connecter au testnet il faut modifier p2p.seednodes
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

Parmi les paramètres, les ID des seed nodes du réseau peuvent être remplacés comme ci-dessous :

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |


### Modifier votre genesis.yml

Changer les paramètres genesis :

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


### Lancer le container

Créer docker-compose.yml, ceci peut exister n'importe où sur le serveur, par exemple dans /data/iserver

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

Pour lancer le nœud : `docker-compose up -d`


## Commandes utiles

Une fois que votre container est lancé

Montrer les container lancés
```
docker ps
```

A l'aide de l'ID du container vous pouvez lancer les commandes suivantes

Afficher les logs
```
docker logs -f CONTAINER-ID
```

Entrer dans le container dans TTY
```
docker container exec -ti CONTAINER-ID bash
```

Une fois dans le container vous pouvez lancer iwallet
```
./iwallet state
```
