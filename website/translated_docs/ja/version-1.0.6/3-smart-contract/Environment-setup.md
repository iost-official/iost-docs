---
id: version-1.0.6-Environment-setup
title: 環境構築
sidebar_label: 環境構築
original_id: Environment-setup
---

現在はIOSTのスマートコントラクトのプログラミングは、[go-iost](https://github.com/iost-official/go-iost)に依存しています。

将来的には、IOSTはgo-iostから独立した環境にする予定になっています。

開発者は最初にブランチ全体をクローンしてください。

```shell
git clone https://github.com/iost-official/go-iost.git
```

そして、`node`と`npm`を`go-iost/iwallet/contract`ディレクトリにインストールしてください。

## ```Node```のインストール

Please refer to [Official Documents](https://nodejs.org/zh-cn/download/package-manager/#macos)

## ```npm```のインストール

```git
cd go-iost/iwallet/contract
npm install
```
