---
id: Building-IOST
title: Build IOST
sidebar_label: Build IOST
---
### Install Golang
Go 1.16 or newer is needed. CGO is needed too.   
You can refer to [here](https://golang.org/doc/install) for installation. After installing, running
```
go version
```
You will see outputs contains "go version go1.16".

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
git clone https://github.com/iost-official/go-iost.git
```

### Build IOST
```
cd go-iost
git lfs pull
make vmlib_install
make build install
```
