---
id: Environment-Configuration
title: 环境与设置
sidebar_label: 环境与设置
---

## 准备条件

* 需要安装go 1.9及以上版本（推荐go 1.11版本）
* 需要安装git-lfs（推荐2.5.2版本）
* 需要安装Rocksdb v5.14.3及以上版本
* 使用docker部署时，建议docker 18.06.0-ce及以上版本，低版本应该也可以跑，但未做过测试

## 运行环境

目前支持如下环境进行开发与部署：

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Mac OS X

### 安装git-lfs

```
brew install git-lfs
git lfs install
```

### 安装rocksdb

```
brew install rocksdb
```

### 进行编译与单元测试

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
make test
```

## Ubuntu/Linux

### 安装git-lfs

```
brew install git-lfs
git lfs install
```

### 安装rocksdb

```
apt install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
git clone -b "v5.14.3" https://github.com/facebook/rocksdb.git && \
cd rocksdb && make static_lib && make install-static
```

### 进行编译与单元测试

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Docker

### 安装docker

#### Mac OS X

Mac OS X下安装docker可参考[官网文档](https://docs.docker.com/docker-for-mac/install/)

#### Ubuntu/Linux

Ubuntu下安装docker可参考[官网文档](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository)

### 进行编译与单元测试

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:2.0.0-go1.11 make build
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:2.0.0-go1.11 make test
```
