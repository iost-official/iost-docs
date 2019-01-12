---
id: LocalServer
title: ローカルサーバーの起動
sidebar_label: ローカルサーバーの起動
---
ローカルサーバーを起動するには、Dockerとネイティブの２つの方法があります。

## Dockerを使用したiServerの起動
Dockerを使ってIOSTサーバーを起動するのは簡単です。これが推奨されます。
次のコマンドは、シングルモードのネイティブIOSTブロックチェーンサーバーを起動します。
これをデバッグやテストに使用できます。
[Docker CE 18.06以上](https://docs.docker.com/install)が必要です。(古いバージョンはテストしていません)

```
docker run -it --rm -p 30000-30003:30000-30003 iostio/iost-node:2.1.0
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

## IOSTサーバーをネイティブで起動

[IOSTをビルド](Building-IOST.md)した後、サーバーを実行できます。
```
iserver -f ./config/iserver.yml
```
![server_output](assets/5-lucky-bet/Lucky-Bet-Operation/server_output.png)

