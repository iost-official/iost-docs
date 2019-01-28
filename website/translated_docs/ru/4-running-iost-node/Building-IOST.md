---
id: Building-IOST
title: Сборка IOST
sidebar_label: Сборка IOST
---
### Установите Golang
Необходим Go 1.11 или новее.
Вы можете пройти по [этой ссылке](https://golang.org/doc/install) для установки. После установки проверьте версию:
```
go version
```
При правильной установке выдаст "go version go1.11".

> Возможно вам необходимо добавить следующие переменные среды для лучшей работы с golang.
> ```
> # Golang
> export GOPATH=$(go env GOPATH)
> export PATH=$PATH:$GOPATH/bin
> ```

### Установите Git LFS
Необходим Git LFS (v2.5.2 или новее).

Установка на MacOS
```
brew install git-lfs && git lfs install
```
Установка на Ubuntu
```
# see also: https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt install -y git-lfs && git lfs install
```

Установка на CentOS
```
yum --enablerepo=epel install -y git-lfs && git lfs install
```

### Клонируйте код

```
go get -d github.com/iost-official/go-iost
```

### Сборка IOST
```
cd $GOPATH/src/github.com/iost-official/go-iost
make build install
```
