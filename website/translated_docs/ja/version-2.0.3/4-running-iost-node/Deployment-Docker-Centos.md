---
id: version-2.0.3-Deployment-Docker-Centos
title: CentOSでのDockerによるデプロイ
sidebar_label: CentOSでのDockerによるデプロイ
original_id: Deployment-Docker-Centos
---

## CentOS7のインストール

CentOS7 Minimalをダウンロードしてください。AmazonやGoogle、Azureから得られるCentOS7イメージは設定が違っています。このドキュメントでは、デフォルトのCentOS最小インストールに基づいています。

CentOSは、https://www.centos.org/download/ からダウンロードできます。(CentOS7 Minimalを選択してください)

マニュアルインストールするなら、Minimal ISOを選択して、パーティションを作成せずにCentOSのドキュメントを参照してデフォルト設定でインストールしてください。ルートパーティション(/)をデフォルトのサイズから拡張するか、/var/lib/docker/ パーティションを追加してください。



## 依存性のインストール

DockerのIOSTノードイメージを実行するには、CentOS7サーバーにいくつかアプリをインストールする必要があります。

- Git version 2.16+
- Git LFS 2.6+
- Docker-CE

コマンドをrootで実行し、デフォルトのCentOS用Dockerがないことを前提にしています。その場合は、
https://docs.docker.com/install/linux/docker-ce/centos/#uninstall-old-versions を参照してください。


```
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y  https://centos7.iuscommunity.org/ius-release.rpm
yum install -y git2u docker-ce netstat
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod 755 /usr/local/bin/docker-compose
```

## ファイアーウォール
サーバーをクラウドにホスティングしているなら、ベンダーコントロールパネルで、ACL/Firewallを変更する必要があります。

TCPポート30000から30003をベンダーのファイアーウォールで、有効にしてください。

ホストのファイアーウォールを更新するには、IPTABLESを直接使ってfirewalldを設定することです。多くのプリビルドされたイメージのファイアーウォールでは、完全に無効になっています(イメージの作成者に依存します)。次のコマンドを使って、firewalldが有効かどうか調べてください。

```
systemctl status firewalld
```
ファイアーウォールを使うこともできますが、次の命令は、firewalldを無効にし、伝統的なiptablesを有効にします。

Firewalldを無効にし、Iptables.serviceをインストールして、有効にします。
```
systemctl stop firewalld
systemctl disable firewalld
yum -y install iptables-service
systemctl enable iptables.service
systemctl start iptables.service
```

必要なポートを有効にします。
```
iptables -I INPUT -p tcp -m tcp --dport 30000:30003 -j ACCEPT
service iptables save
```

firewalldを使うなら、次のコマンドで、必要なポートを有効にしてください。
```
firewall-cmd --permanent --add-port=30000:30003/tcp
firewall-cmd --reload
```

サーバーのファイアーウォールをポート22へのアクセスを制限し、SSHDのポートを変更し、パスワード認証を禁止することを強くお勧めします。これ以上はこのドキュメントの範囲を超えますので、他を参照してください。


## リブート

サーバーをリブートすると、最新カーネルとライブラリがランタイムに正しくロードされます。

```
reboot
```

## go-iostリポジトリのクローン

次のコマンドでリポジトリをクローンしてください。

```
git clone https://github.com/iost-official/go-iost && cd go-iost
```

## 現在のバージョンのチェックアウト

次のコマンドで、適切なバージョンをチェックアウトしてください。

```
git checkout v2.0.0
```

## Docker

Dockerがローカルホストで利用可能なことを確認してください。

```
systemctl enable docker
systemctl start docker
```

正しくインストールされていれば、次のコマンドで、結果がエラーなしで返ってくるはずです。
```
docker ps
```

### データディレクトリの作成

データディレクトリは、開始時にDockerコンテナにマウントされます。実行中のサーバーパーティションではない専用の/dataパーティションをサーバーに作成することをお勧めします。Amazonでは、これは別のEBSにすれば可能です。設定はこのドキュメントの範囲を超えますので、他を参照してください。

/data/iserver/ ディレクトは、 /var/lib/iserver　として、コンテナにマウントされます。このデータは永続化します。

ディレクトリの作成
```
mkdir -p /data/iserver/
```

例えば、次のように必要なファイルをgo-iostから /data/iserver ディレクトリにコピーしてください。

```
cp config/{docker/iserver.yml,genesis.yml} /data/iserver/
```


### Pull

https://hub.docker.com/r/iostio/iost-node を参照して、DockerHubからイメージをpullしてください。イメージは後で自動的にpullされますが、それを知っていることは重要です。

```
docker pull iostio/iost-node:2.0.0
```

### iserver.ymlの修正

/data/iserver/iserver.yml をお好きなエディタで開きます。

アカウントIDと秘密鍵を設定します。これはhttps://explorer.iost.io やiwalletを使って生成できます。
```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

テストネットへ接続するには、p2p.seednodesを変更する必要があります。
```
...
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a
  chainid: 1024
  version: 1
...
```

設定中に、シードノードのネットワークIDが次のように置き換わります。

| 名前   | リージョン | ネットワークID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node-7 | London | /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a |
| node-8 | Paris  | /ip4/35.180.171.246/tcp/30000/ipfs/12D3KooWMBoNscv9tKUioseQemmrWFmEBPcLatRfWohAdkDQWb9w |


### genesis.ymlの修正

ジェネシスの設定を次のように変更します。

```
creategenesis: true
tokeninfo:
  foundationaccount: foundation
  iosttotalsupply: 21000000000
  iostdecimal: 8
  ramtotalsupply: 9000000000000000000
  ramgenesisamount: 137438953472
witnessinfo:
  - id: producer00000
    owner: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    active: IOST22xmaHFXW4D2LCuC9gU1qt4mQss8BucMqMpFqeq9M2XSxYa7rF
    balance: 1000000000
  - id: producer00001
    owner: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    active: IOST25NTSxZ9rWht235FyN9XWwWx1cXqr9EyQrmxMzdr5sebmvrkA4
    balance: 1000000000
  - id: producer00002
    owner: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    active: IOSTowEse8dXYV7cSM7y8VMCWsvWnZAKDc9GmW9yGyBihphVMhbSF
    balance: 1000000000
  - id: producer00003
    owner: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    active: IOST24cF7DSTjLoZwDmQ7UpQ5pim7eQtFxKy8fh1w4zoezp5YSJ5kF
    balance: 1000000000
  - id: producer00004
    owner: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    active: IOSTP336SxjTL7epFvjC3Te5srxbcdXtd7PmQJo6432uTULapqniQ
    balance: 1000000000
  - id: producer00005
    owner: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    active: IOST2wiZ98sq3QHa7vpmf9qg1CTYu3NZCcZhD179hWWV2YGx6MgpiH
    balance: 1000000000
  - id: producer00006
    owner: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    active: IOSTjcx7BVrHJC27QtqurRpqAzWH2diHgzFRPZG3artfUU2u7uisQ
    balance: 1000000000
contractpath: contract/
admininfo:
  id: admin
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 14000000000
foundationinfo:
  id: foundation
  owner: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  active: IOST2DWhdDHz8kjExZNH2gmWYnbJBrfVMUPwLDnmZRstT47EsEgZzb
  balance: 0
initialtimestamp: "2006-01-02T15:04:05Z"
```


### コンテナの実行

サーバーのどこかにあるdocker-compose.ymlを作成し、/data/iserver 内に置きます。

```
version: "2.2"

services:
  iserver:
    image: iostio/iost-node:2.0.0
    restart: always
    ports:
      - "30000:30000"
      - "30001:30001"
      - "30002:30002"
      - "30003:30003"
    volumes:
      - /data/iserver:/var/lib/iserver
```

ノードを実行するには次のようにします。

`docker-compose up -d`


## 便利なコマンド

コンテナ実行中

現在実行中のコンテナを表示します。
```
docker ps
```

上の処理からのコンテナIDを使って、さらにコマンドを実行できます。

ログを表示します。
```
docker logs -f CONTAINER-ID
```

TTYで、コンテナに入ります。
```
docker container exec -ti CONTAINER-ID bash
```

コンテナ内に入ったら、iwalletを実行できます。
```
./iwallet state
```


