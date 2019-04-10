---
id: iServer
title: iServer
sidebar_label: iServer
---

## Lancer iServer

Le service de nœud IOST iServer comprend des modules de consensus, de synchronisation, de pool de transactions et de réseau. Lancer le service iServer pour déployer les nœuds IOST.

* Pour compiler le projet dans le répertoire root, lancer la commande suivante et les exécutables seront sauvegardés dans le répertoire `target` dans le dossier root.

```
make build
```

* Utilisez la commande ci-dessous pour lancer le nœud IOST

```
./target/iserver -f ./config/iserver.yml
```

* Modifier ./config/iserver.yml

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

* Paramétrer les informations de compte du nœud

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

* Configurez les informations du block genesis et noter le block et le montant.


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```


```
db:
  ldbpath: storage/
```

Paramétrer le chemin de la base de données


```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

Paramétrer les informations réseau. Ceci implique la mise en place de seed nodes pour accéder au réseau.

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

Paramétrer les ports RPC.


```
log:
  filelog:
    path: logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
```

Paramétrer les services de logs.


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
