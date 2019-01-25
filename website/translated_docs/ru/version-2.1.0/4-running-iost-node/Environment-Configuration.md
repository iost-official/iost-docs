---
id: version-2.1.0-Environment-Configuration
title: Среда и Настройка
sidebar_label: Среда и Настройка
original_id: Environment-Configuration
---

## Предварительно необходимы

* Go 1.9 или новее (Go 1.11 рекомендуется)
* Git LFS (v2.5.2 рекомендуется)
* [Docker CE 18.06 или новее](https://docs.docker.com/install/) (тарые версии не тестировались)

В настоящее время тестируются следующие среды:

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Сборка и юнит-тесты

- Установите все необходимое.
   Пожалуйста, обратитесь к документации по установке для конкретной платформы.

   Установите Git LFS:

```
# mac-os-x
brew install git-lfs

# ubuntu
# see also: https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt install -y git-lfs

# centos
yum --enablerepo=epel install -y git-lfs
```

- Установите расширение командной строки Git. Вы должны настроить Git LFS только один раз.

```
git lfs install
```

- Получите репозиторий.

```
git clone git@github.com:iost-official/go-iost.git && cd go-iost
```

- Сборка бинарных пакетов

```
make
```

- Запустите бинарные пакеты.

```
target/iserver -f config/iserver.yml

target/iwallet state
```
