---
id: Environment-Configuration
title: Environment & Configuration
sidebar_label: Environment & Configuration
---

## Prerequisites

* Go 1.9 or newer (Go 1.11 recommended)
* `git-lfs` (v2.5.2 recommended)
* Rocksdb v5.14.3 or newer
* Docker v18.06.0-ce or newer (older versions are not tested)

## Environment

Currently, you can develop and deploy on below environments:

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Mac OS X

### Installing git-lfs

```
brew install git-lfs
git lfs install
```

### Installing rocksdb

```
brew install rocksdb
```

### Compiling and unit tests

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Ubuntu/Linux

### Installing git-lfs

```
brew install git-lfs
git lfs install
```

### Installing rocksdb

```
apt install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
git clone -b "v5.14.3" https://github.com/facebook/rocksdb.git && \
cd rocksdb && make static_lib && make install-static
```

### Compiling and unit tests

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Docker

### Installing docker

#### Mac OS X

Refer to [Official Documents](https://docs.docker.com/docker-for-mac/install/) to install on Mac OS X.

#### Ubuntu/Linux

Refer to [Official Documents](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) to install on Ubuntu.

### Compiling and unit tests

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make build
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make test
```
