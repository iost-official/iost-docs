---
id: version-2.1.0-Environment-Configuration
title: 環境と設定
sidebar_label: 環境と設定
original_id: Environment-Configuration
---

## 前提条件

* Go 1.9 以上 (Go 1.11 推奨)
* `git-lfs` (v2.5.2 推奨)
* [Docker CE 18.06以上](https://docs.docker.com/install/) (旧バージョンはテストしていません)

現在のところ、開発には次の環境がテストされています。

* [Mac OS X](#mac-os-x)
* [Ubuntu/Linux](#ubuntu-linux)
* [Docker](#docker)

## ビルドとユニットテスト

- 前提条件を満たすようにインストールしてください。
   プラットフォームごとのインストールドキュメントを参照してください。

   Git-LFSをインストールするには、次のようにします。

```
# mac-os-x
brew install git-lfs

# ubuntu
# see also: https://github.com/git-lfs/git-lfs/wiki/Installation
sudo apt install -y git-lfs

# centos
yum --enablerepo=epel install -y git-lfs
```

- Gitコマンドライン拡張をインストールします。それにより、Git-LFSを一度設定するだけですみます。

```
git lfs install
```

- リポジトリを取得します。

```
git clone git@github.com:iost-official/go-iost.git && cd go-iost
```

- バイナリにビルドします。

```
make
```

- バイナリを実行します。

```
target/iserver -f config/iserver.yml

target/iwallet state
```
