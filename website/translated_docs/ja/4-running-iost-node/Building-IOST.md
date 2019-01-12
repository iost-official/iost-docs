---
id: Building-IOST
title: IOSTのビルド
sidebar_label: IOSTのビルド
---
### Go言語のインストール
Go 1.11 以上が必要
インストール後、次を実行してください。
```
go version
```
出力に、"go version go1.11"が含まれていることを確認してください。

### Git-LFSのインストール
Git-LFS (v2.5.2以上)が必要

MacOS上でのインストール
```
brew install git-lfs && git lfs install
```
Ubuntu上でのインストール
```
# see also: https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt install -y git-lfs && git lfs install
```

CentOS上でのインストール
```
yum --enablerepo=epel install -y git-lfs && git lfs install
```

### コードのクローン

```
go get -d github.com/iost-official/go-iost
```

### IOSTのビルド
```
cd $GOPATH/src/github.com/iost-official/go-iost
make build install
```
