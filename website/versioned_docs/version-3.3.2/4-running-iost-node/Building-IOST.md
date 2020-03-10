---
id: version-3.3.2-Building-IOST
title: Build IOST
sidebar_label: Build IOST
original_id: Building-IOST
---
### Install Golang
Go 1.13 or newer is needed.
You can refer to [here](https://golang.org/doc/install) for installation. After installing, running
```
go version
```
You will see outputs contains "go version go1.13".

> You may need to add the following environment variables to make your golang work better.
> ```
> # Golang
> export GOPATH=$(go env GOPATH)
> export PATH=$PATH:$GOPATH/bin
> ```

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
git lfs pull
make build install
cd vm/v8vm/v8/; make deploy; cd ../../..
```
