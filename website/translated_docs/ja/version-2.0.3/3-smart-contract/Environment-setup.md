---
id: version-2.0.3-Environment-setup
title: 環境構築
sidebar_label: 環境構築
original_id: Environment-setup
---

現在はIOSTのスマートコントラクトのプログラミングは、まだ[go-iost](https://github.com/iost-official/go-iost)に依存しています。

将来的には、IOSTはgo-iostから独立した環境にする予定になっています。

開発者は最初にブランチ全体をクローンしてください。

```shell
git clone https://github.com/iost-official/go-iost.git
```

そして、`node`と`npm`を`go-iost/iwallet/contract`ディレクトリにインストールしてください。

## ```Node```のインストール

[公式ドキュメント](https://nodejs.org/zh-cn/download/package-manager#macos)を参照してください。

## ```npm```のインストール

```git
cd go-iost/iwallet/contract
npm install
```

## ```ダイナミックライブラリ```のインストール

```git
cd go-iost
make vmlib
```
