---
id: version-1.0.6-Environment-Configuration
title: Среда и Настройка
sidebar_label: Среда и Настройка
original_id: Environment-Configuration
---

## Предварительно необходимы

* Go 1.9 или новее (Go 1.11 рекомендованный)
* `git-lfs` (v2.5.2 рекомендованный)
* Rocksdb v5.14.3 или новее
* Docker v18.06.0-ce или новее (старые версии не тестируются)

## Среда

В настоящее время вы можете разрабатывать и развертывать в следующих средах:

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Mac OS X

### Установка git-lfs

```
brew install git-lfs
git lfs install
```

### Установка rocksdb

```
brew install rocksdb
```

### Компиляция и модульные тесты

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Ubuntu/Linux

### Установка git-lfs

```
brew install git-lfs
git lfs install
```

### Установка rocksdb

```
apt install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
git clone -b "v5.14.3" https://github.com/facebook/rocksdb.git && \
cd rocksdb && make static_lib && make install-static
```

### Компиляция и модульные тесты

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Докер

### Установка докера

#### Mac OS X

Ссылка на [Официальная Документация](https://docs.docker.com/docker-for-mac/install/) для установки на Mac OS X.

#### Ubuntu/Linux

Ссылка на [Официальная Документация](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) для установки на Ubuntu.

### Компиляция и модульные тесты

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make build
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make test
```
