---
id: Lucky-Bet-Operation
title: Commandes pas à pas pour déployer et exécuter
sidebar_label: Commandes pas à pas pour déployer et exécuter
---

## Installation de l'environnement
### Installer Golang.
```shell
wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
# untar vers /usr/local/go
sudo tar -C /usr/local -xzf go1.11.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOROOT/bin:$GOPATH/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
go version # Vous verrez "go version go1.11 linux/amd64".
```
### Installer Docker  
Se référer à [official steps](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Après installation, lancer 'docker run hello-world', pour voir le retour suivant ：
![docker_output](assets/5-lucky-bet/Lucky-Bet-Operation/docker_output.png)
## Build IOST
```shell
go get -d github.com/iost-official/go-iost
cd $GOPATH/src/github.com/iost-official/go-iost
git checkout develop # master est la branche stable, develop est la branche active
make image # build le projet coplet afin de make une image docker. Patienter. Vous verrez des output du type 'Successfully tagged iostio/iost-node:1.0.0-ed23f6d'.
```
## Lancer un nœud IOST local
```shell
mkdir -p data/iserver # Le répertoire sera utiliser pour stocker la config et les données blockchain
cp config/iserver.docker.yml data/iserver/iserver.yml
# Lancer le nœud. YVous devez vous assurer que le nom de l'image docker dans cette commande est le même que celui de la commande 'make image'.
docker run -it --rm -v `pwd`/data/iserver:/var/lib/iserver -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:1.0.0-ed23f6d
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)
## Déployer et lancer le Smart Contract
```shell
# installer 'iwallet'
cd ~/go/src/github.com/iost-official/go-iost
make install
iwallet # Vous verrez les informations sur l'utilisation des commandes iwallet

# déployer et exécuter le smart contract
cd ~/go/src/github.com/iost-official
git clone https://github.com/iost-official/luckybet_sample.git
cd luckybet_sample/
python3.6 luckbet.py # Vous verrez "Congratulations! You have just run a smart contract on IOST!".
```

## Résolution d'erreurs
### Build Error
Problème : make build error：can't load package: package github.com/iost-official/go-iost/cmd/iserver.  
Solution : GOPATH peut être incorrect。Exécuter "echo $GOPATH", s'assurer que l'output est correct.
