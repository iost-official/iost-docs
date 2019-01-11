---
id: Environment-Configuration
title: 环境与设置
sidebar_label: 环境与设置
---

### 安装Golang
至少需要安装 Go 1.11。   
之后运行
go version
应该输出"go version go1.11".
### 安装 Git LFS
至少需要安装 Git LFS (v2.5.2)。

MacOS安装
```
brew install git-lfs && git lfs install
```

Ubuntu安装
```
# see also: https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt install -y git-lfs && git lfs install
```

CentOS安装
```
yum --enablerepo=epel install -y git-lfs && git lfs install
```

### 获取代码

```
go get -d github.com/iost-official/go-iost
```

### 编译
```
cd $GOPATH/src/github.com/iost-official/go-iost
make build install
```
