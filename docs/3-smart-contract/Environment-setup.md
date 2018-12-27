---
id: Environment-setup
title: Environment setup
sidebar_label: Environment setup
---

Currently, IOST smart contracts programming depends on [go-iost](https://github.com/iost-official/go-iost).

In the future, IOST will become independent of go-iost.

Developers needs to clone the entire branch:

```shell
git clone https://github.com/iost-official/go-iost.git
```

Then, install `node` and `npm` in the directory `go-iost/iwallet/contract`.

## Install ```Node```

Please refer to [Official Documents](https://nodejs.org/zh-cn/download/package-manager/#macos)

## Install```npm```

```git
cd go-iost/iwallet/contract
npm install
```

## Install```Dynamic Library```

```git
cd go-iost
make deploy
```
