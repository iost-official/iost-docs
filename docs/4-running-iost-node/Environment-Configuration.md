---
id: Building-IOST
title: Build IOST
sidebar_label: Build IOST
---
### Install Golang
Go 1.11 or newer is needed.
After installing, running
```
go version
```
You will see outputs contains "go version go1.11".

### Install Git LFS
Git LFS (v2.5.2 or newer) is needed.

Install on MacOS
```
brew install git-lfs && git lfs install
```
Install on Ubuntu
```
# see also: https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt install -y git-lfs && git lfs install
```

Install on CentOS
```
yum --enablerepo=epel install -y git-lfs && git lfs install
```

### Clone Code

```
go get -d github.com/iost-official/go-iost
```

### Build IOST
```
cd $GOPATH/src/github.com/iost-official/go-iost
make build install
```
