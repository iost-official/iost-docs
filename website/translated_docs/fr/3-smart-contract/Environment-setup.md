---
id: Environment-setup
title: Installation de l'environnement
sidebar_label: Installation de l'environnement
---

Pour le moment, les smart contracts IOST dépendent de [go-iost](https://github.com/iost-official/go-iost).

Dans le future IOST sera indépendant de go-iost.

Les développeurs doivent cloner la branche complète :

```shell
git clone https://github.com/iost-official/go-iost.git
```

Puis, installer `node` et `npm` dans le répertoire `go-iost/iwallet/contract`.

## Installer ```Node```

Se référer à [Official Documents](https://nodejs.org/zh-cn/download/package-manager/#macos)

## Installer ```npm```

```git
cd go-iost/iwallet/contract
npm install
```

## Installer ```Dynamic Library```

```git
cd go-iost
make deploy
```
