---
id: Environment-Configuration
title: 환경 설정
sidebar_label: 환경 설정
---

## 준비물

* Go 1.9 버전 이상(Go 1.11 버전을 권장합니다.)
* `git-lfs` (v2.5.2을 권장합니다.)
* Rocksdb v5.14.3 버전 이상
* Docker v18.06.0-ce 버전 이상 (이하의 버전에서는 테스트가 되지 않았습니다.)

## Environment

현재 IOST 테스트넷 개발환경은 Mac OS X, Ubuntu/Linux, Docker를 지원하고 있습니다:

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## Mac OS X

### git-lfs 설치하기

```
brew install git-lfs
git lfs install
```

### rocksdb 설치하기

```
brew install rocksdb
```

### 컴파일 & 유닛테스트

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Ubuntu/Linux

### git-lfs 설치하기

```
brew install git-lfs
git lfs install
```

### rocksdb 설치하기

```
apt install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev
git clone -b "v5.14.3" https://github.com/facebook/rocksdb.git && \
cd rocksdb && make static_lib && make install-static
```

### 컴파일 & 유닛 테스트

```
git clone git@github.com:iost-official/go-iost.git
make build
make test
```

## Docker

### 도커 설치하기

#### Mac OS X

Mac OS X에 도커를 설치하신다면, [공식문서](https://docs.docker.com/docker-for-mac/install/)를 참조해주세요.

#### Ubuntu/Linux

Ubuntu에 도커를 설치하신다면, [공식문서](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository)를 참조해주세요.

### 컴파일 & 유닛 테스트

```
git clone git@github.com:iost-official/go-iost.git
cd go-iost
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make build
docker run -it --rm -v $(pwd):/gopath/src/github.com/iost-official/go-iost iostio/iost-dev:1.0.0 make test
```
