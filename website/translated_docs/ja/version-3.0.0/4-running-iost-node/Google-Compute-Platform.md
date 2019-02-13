---
id: Google-Compute-Platform
title: Google Compute Platform
sidebar_label: Google Compute Platform
---

#

Google Compute Platformにサインアップするには、Gmailアカウントか法人用のGmailベースのアカウントが必要です。

Googleアカウントを作成するには、https://accounts.google.com/SignUp へ移動します。

Googleアカウントを作成したら、
https://console.cloud.google.com/compute/ でGoogle Compute Platformを管理できます。

無料トライアルを受けられるかもしれませんが、トライアルアカウトにはCPUやストレージにさまざまな制限があります。

## 仮想マシンの作成

Computeメニューで、仮想マシン(VM)を作成できます。仮想マシンが１つもない場合は、次のような画面が表示されます。仮想マシンがある場合は、標準的な*Create Instance*が表示されます。

![create_instance](assets/4-running-iost-node/GoogleCloudPlatform/create_instance.png)

*Create*ボタンを押して次に進みます。

次にノード名、リージョン、ゾーン、設定、サイズを入力します。ここでは、推奨される最小サイズでインスタンスを作成します。

* 8コア
* 16 GBメモリ

インスタンスには、あなたとリージョンを区別できる名前を付けます。あなたの居る位置に近いリージョンを選ぶことをお勧めします。これは、IOSTプラットフォームが分散にも好都合です。

![configure_instance](assets/4-running-iost-node/GoogleCloudPlatform/configure_instance.png)

### Boot Disk

*Boot disk*までスクロールして、*Change*をクリックします。デフォルトは、GNU/Linux 9ですが、*CentOS 7*を選択します。

![configure_boot_disk](assets/4-running-iost-node/GoogleCloudPlatform/configure_boot_disk.png)

一番下のSizeまでスクロールして、*10*を*100*に変更します。もっと多くしてもいいですし、後で変更することもできます。

![configure_boot_disk_size](assets/4-running-iost-node/GoogleCloudPlatform/configure_boot_disk_size.png)

２つのパラメータを設定して、ページ下部の*Select*をクリックすると、*New VM instance*のメインページに戻って次のように表示されます。

![configure_boot_disk_complete](assets/4-running-iost-node/GoogleCloudPlatform/configure_boot_disk_complete.png)


### ファイアーウォール

インスタンスを最初に作成するときには、必要なファイアーウォールのルール設定ができませんので、オンラインになった後で、設定します。


### 管理

ファイアーウォールセクションのすぐ下に、*Management, security, disks, networking, sole tenancy*が表示されています。これをクリックすると、詳細が表示されます。

![management](assets/4-running-iost-node/GoogleCloudPlatform/management.png)


Managementタブから、Automationスクリプトが作成できます。これを使うと作業の一部を自動化できます。詳細については、
https://cloud.google.com/compute/docs/startupscript を参照してください。

このスクリプトの派生元については、[CentOSでのDockerによるデプロイ](Deployment-Docker-Centos.md)を参照してください。

このスクリプトは、データディスクもアタッチしようとしますので気をつけてください。このスクリプトはすく数回実行できるようにはなっていませんので、最初の初期化後に、**削除**してください。 

```
#! /bin/bash
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y git2u docker-ce
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod 755 /usr/local/bin/docker-compose
git clone https://github.com/iost-official/go-iost && cd go-iost
git checkout v2.1.0
systemctl enable docker
systemctl start docker
mkfs.xfs /dev/sdb
mkdir -p /data/
mount /dev/sdb /data/
mkdir -p /data/iserver
mkdir -p /data/docker
cat <<EOF> /data/iserver/iserver.yml
acc:
  id: IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  seckey: 1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB
  algorithm: ed25519
genesis: /var/lib/iserver/genesis.yml
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""
db:
  ldbpath: /var/lib/iserver/storage/
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/35.176.129.71/tcp/30000/ipfs/12D3KooWSCfx6q7w8FVg9P8CwREkcjd5hihmujdQKttuXgAGWh6a
  chainid: 1024
  version: 1
  datapath: /var/lib/iserver/p2p/
  inboundConn: 15
  outboundConn: 15
  blackPID:
  blackIP:
  adminPort: 30005
rpc:
  gatewayaddr: 0.0.0.0:30001
  grpcaddr: 0.0.0.0:30002
log:
  filelog:
    path: /var/lib/iserver/logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
metrics:
  pushaddr: 
  username: 
  password: 
  enable: false
  id: iost-testnet:visitor00
debug:
  listenaddr: 0.0.0.0:30003
version:
  netname: "debugnet"
  protocolversion: "1.0"
EOF
cat <<EOF > /data/iserver/genesis.yml
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
EOF
cat <<EOF> /data/docker/docker-compose.yml
version: "2.2"

services:
  iserver:
    image: iostio/iost-node:2.1.0
    restart: always
    ports:
      - "30000:30000"
      - "30001:30001"
      - "30002:30002"
      - "30003:30003"
    volumes:
      - /data/iserver:/var/lib/iserver
EOF
cd /data/docker
docker-compose up -d
```
これをAutomationのフォームに入力すると、次のようになります。

![mangement_automation](assets/4-running-iost-node/GoogleCloudPlatform/management_automation.png)



### Disks

Disksタブに移動して、*Add new disk*をクリックします。

![disks_add_disk](assets/4-running-iost-node/GoogleCloudPlatform/disks_add_disk.png)

次に名前とサイズを指定します。トライアルアカウントの場合は、*クォータの増加をしないと、2048GBを超えることはできません。*

![disks_configure](assets/4-running-iost-node/GoogleCloudPlatform/disks_configure.png)

この時点で、ページの下部にある*Create*ボタンを押すと、仮想マシンのデプロイが開始します。


## ファイアーウォール

インスタンス名をクリックすると、*VM instance details*に移動します。３つの小さな点をクリックして、*Network Details*をクリックします。そして、左側の*Firewall rules*に移動します。

*Create Firewall Rule*をクリックして、ルール名を入れます。

![firewall_name](assets/4-running-iost-node/GoogleCloudPlatform/firewall_name.png)

次に、Target、Source、Destinationの各ポートを指定します。ターゲットを現在のインスタンスにリンクされているサービスアカウントにすることができます（より安全）。この例では、単純にVPCのすべてのVMに対してオープンになっています。

![firewal_ports](assets/4-running-iost-node/GoogleCloudPlatform/firewall_ports.png)

Createをクリックすると、次のルールが表示されます。

![verify_ssh](assets/4-running-iost-node/GoogleCloudPlatform/firewall_confirm.png)

VMインスタンスに戻るには、Google Cloud Platformの横の三つの横線をクリックして、Compute EngineのVM Instanncesに移動します。

## インスタンスの確認

Computeのコンソールでノードが実行されているのがわかります。内部IPと外部IP、SSH接続のオプションが表示されています。*Open in browser window*を選択するとGoogle Compute Platform内で、インターネットや定義されたIP向けの直接SSHポートを開くことなく、接続ができます。

![verify_ssh](assets/4-running-iost-node/GoogleCloudPlatform/verify_ssh.png)

コンソールでrootになって、いくつかのログをチェックすることもできます。
```
sudo su - 
docker ps
tail -f /data/iserver/logs/iost.log
```
ブロックが同期しているのを見ることができます。
![verify_server](assets/4-running-iost-node/GoogleCloudPlatform/verify_server.png)


VPCでファイアウォールのルールを適用する前にDockerコンテナを起動した場合は、再起動する必要があります。docker-compose.ymlがあるディレクトリにいることを確認してください。
```
docker-compose restart iserver
```

Serviノードを実行している場合は、/data/iserver/iserver.ymlのアカウント番号を変更する必要があるかもしれません。

ノードが同期していることを確認するには、次のコマンドを実行して*headBlock*の値が増えているかを確認します。
``
docker exec -ti 1234abcd bash
./iwallet state
```

ノードが実行中かどうかをチェックするには、シードノードに問い合わせて、パブリックIPを探します。
```
docker exec -ti 1234abcd bash
./iwallet state -s 35.176.127.71:30002 | grep 35.246.82.51
``

次の出力が得られます。ポートが30000であることを確認します。

![verify_node](assets/4-running-iost-node/GoogleCloudPlatform/verify_server.png)

別サーバーからリモートで接続しているなら、telnetを実行しているソケット接続を取得できます。

```
telnet 35.246.82.51 30000
```


