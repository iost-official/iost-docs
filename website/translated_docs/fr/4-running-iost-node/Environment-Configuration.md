---
id: Environment-Configuration
title: Environnement & Configuration
sidebar_label: Environnement & Configuration
---

## Prérequis

* Go 1.9 ou plus récent (Go 1.11 recommendé)
* `git-lfs` (v2.5.2 recommendé)
* Rocksdb v5.14.3 ou plus récent
* Docker v18.06.0-ce ou plus récent (versions plus anciennes non testées)

## Environnement

Il est possible de développer et déployer dans les environnements suivants :

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Mac OS X

### Installer git-lfs

```
brew install git-lfs
git lfs install
```

### Installer rocksdb

```
brew install rocksdb
```

### Compiler et tests

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Ubuntu/Linux

### Installer git-lfs

```
brew install git-lfs
git lfs install
```

### Installer rocksdb

```
apt install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
git clone -b "v5.14.3" https://github.com/facebook/rocksdb.git && \
cd rocksdb && make static_lib && make install-static
```

### Compiler et tests

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Docker

### Installer docker

#### Mac OS X

Se référer à [Official Documents](https://docs.docker.com/docker-for-mac/install/) pour l'installation sur Mac OS X.

#### Ubuntu/Linux

Se référer à  [Official Documents](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) pour l'installation sur Ubuntu.

### Compiler et tests

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make build
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make test
```
