---
id: iWallet
title: iWallet
sidebar_label: iWallet
---

**IOSBlockchain** a deux programmes : `iServer` est le programme principale et les multiples `iServer` forment le réseau blockchain. `iWallet` est un outil en ligne de commande pour interagir avec la blockchain `iServer`.

Après avoir `build` le système avec succès, `iWallet` est dans le répertoire `target/`.

![iwallet1](assets/4-running-iost-node/iWallet/iwallet.png)

## Commandes

|Command      |Contents                                |Description
|:-----------:|:--------------------------------------:|:--------------------------------------------|
|help         |Help about any command                  |  using iwallet -h to get further infomation
|account      |Account manage                          |  ./iwallet account -n id
|balance      |check balance of specified account      |  ./iwallet balance ~/.iwallet/id_ed25519.pub
|block        |print block info, default find by block number   |  
|call         |Call a method in some contract          |  ./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' -k SecKeyPath --expiration 50
|compile      |Compile contract files to smart contract|  ./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
|net          |Get network id                          |  ./iwallet net
|publish      |sign to a .sc file with .sig files, and publish it        |./iwallet publish -k ~/.iwallet/id_ed25519 ./dashen.sc ./dashen.sig0 ./dashen.sig1
|sign         |Sign to .sc file                        |  ./iwallet sign -k ~/.iwallet/id_ed25519 ./test.sc
|transaction  |find transaction by transaction hash    |  ./iwallet transaction HUVdKWhstUHbdHKiZma4YRHGQZwVXerh75hKcXTdu39t

## Exemples de commandes

### help:

Affiche l'aide sur `iwallet`

```
./iwallet -h
```

### account:

Créé un compte IOST avec les clés publiques et privées correspondantes sauvegardées dans le répertoire `~/.iwallet/`.

```
./iwallet account -n id
return:
the iost account ID is:
IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
```

### balance:

Vérifier le solde du compte :

```
./iwallet balance IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
return:
1000 iost
```

### block:

Rechercher un block avec son hash :

```
# 查询0号block数据
./iwallet block -m num 0
return:
{"head":{"txsHash":"bG7L/GLaF4l8AhMCzdl9r7uVvK6BwqBq/sMMuRqbUH0=","merkleHash":"cv7EfVzjHCzieYStfEm61Ew4zbNFYN80i/6J8Ijhbos=","witness":"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A"},"hash":"9NzDz2iueLZ4e8YDotIieJRZrlTMddbjaJAvSV23TFU=","txhash":["3u12deEbLcyP7kI5k+WIuxUrskAOu8UKUOPV+H51bjE="]}
```

### call:

Vous pouvez `call` une méthode d'un contrat sur la blockchain.

```
# Calls iost.system contract's Transfer method，Account IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP transfers Account IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk 100 token,
# -k is private key，--expiration specifies timeout
./iwallet call "iost.system" "Transfer" '["IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP", "IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk", 100]' -k ~/.iwallet/id_ed25519 --expiration 50
return:
ok
8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
```

### net:

La commande `net` obtient l'adresse réseau d'iserver.

```
./iwallet net
return:
netId: 12D3KooWNdJgdRAAYoHvrYgCHhNEXS9p7LshjmJWJhDApMXCfahk

```

### transaction:

`transaction` est utilisée pour les recherches

```
./iwallet transaction 8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
return:
txRaw:<time:1537540108548894481 expiration:1537540158548891677 gasLimit:1000 gasPrice:1 actions:<contract:"iost.system" actionName:"Transfer" data:"[\"IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP\", \"IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk\", 100]" > publisher:<algorithm:2 sig:"\224iI\0300\317;\337N\030\031)'\277/xO\231\325\277\022\217M\017k.\260\205+*$\235\017}\353\007\206\352\367N(\203\343\333\017\374\361\230\313,\231\313* oK\270.f;6\371\332\010" pubKey:"_\313\236\251\370\270:\004\\\016\312\300\2739\304\317Jt\330\344P\347s\2413!\3725\3126\246\247" > > hash:"m\005\2613%\371\234\233\315\377@\016\253Aw\024\214IX@\0368\330\370T\241\267\342\256\252\354P"

```

### compile/publish/sign:

Se référer à [Déploiement et appel](../3-smart-contract/Deployment-and-invocation)
