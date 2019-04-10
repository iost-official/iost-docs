---
id: Become-Servi-Node
title: Serviノードになるには
sidebar_label: Serviノードになるには
---

Serviノードは、報酬を受け取るためのIOSTアカウントとブロックを生成するためのフルノードが必要です。  
ノードを起動して自分のアカウントにバインドする必要があります。  
フルノードは、*最大で*１つのServiノードにバインドできます。  
Serviノードは、iServerの設定ファイル内の秘密鍵を使用して生成されるブロックに署名します。  
**Serviノードには、自分のアカウントとは異なるキーペアを使用することを強くお勧めします。**

##IOSTアカウントを作成する

まだIOSTアカウントを持っていない場合は、次のステップに従ってください。

- [iWalletをインストールする](4-running-iost-node/iWallet.md#install)
- iWalletを使って*キーペア*を生成します。(`iwallet key`)
- アカウント作成時に生成された*公開鍵*を使用します。(この機能は非公開です。必要であればご連絡ください。)

> iWalletにアカウントをインポートするのを忘れないでください: `iwallet account import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`
>
>安全のため、IOSTアカウントをServiノードとは別の秘密の場所に保管することをお勧めします。

# フルノードの開始
起動スクリプトを実行して、フルノードを起動します。

```
curl https://raw.githubusercontent.com/iost-official/go-iost/master/script/boot.sh | bash
```

問題があれば、詳細のドキュメント[ノードの開始](4-running-iost-node/Deployment.md)をご覧ください。

何も問題がなければ、次のように出力されます。

```
...
Serviノードとして登録したいなら、次にように実行します。

        iwallet sys register <pubkey> --net_id <network-id> --account <your-account>

Serviノードをオンラインにするには、次のようにします。

        iwallet sys plogin --account <your-account>

完全なドキュメントは、https://developers.iost.io にあります。
```

このスクリプトはノードの新しいキーペアとネットワークIDを生成します。**公開鍵**と**ネットワークID**を設定してください。

もし、キーベアを忘れた場合は、ここで見ることができます。
- ノードの*キーペア*は、`/data/iserver/keypair`にあり、これが**公開鍵**です。
- `network.id`セクション内のノードの*ネットワークID*は、次のコマンドで取得できます。`curl http://localhost:30001/getNodeInfo`


# iwalletのIOSTネットワークでの利用
iwalletはデフォルトでローカルノードに接続します。IOSTネットワークに接続したいなら、[シードノードリスト](4-running-iost-node/Deployment.md#seed-node-list)を参照してください。

例:

```
iwallet -s ${GRPC-URL} state
```

# GASのプレッジとRAMの購入

GASやRAMが足りない場合は、次のコマンドでGASをプレッジしたり、RAMを購入したりできます。
```
# pledge gas
iwallet system gas-pledge 80 --account <your-account>
# buy ram
iwallet system ram-buy 1024 --account <your-account>
```

充分なIOSTがない場合は、私たちにお知らせください。

# Serviノードの登録

iwalletを使って、ノードにアカウントを紐づけて、Serviノードを登録します。
```
iwallet system register <pubkey-of-producer> --location <location> --url <website> --net_id <network-ID> --account <your-account>
```

- `<your-account>`: Serviノードへ登録するのに使うアカウント
- `<pubkey-of-producer>`: ノードの公開鍵
- `<location>`: フルノードのロケーション
- `<website>`: 公式ホームページ
- `<network-ID>`: ノードのネットワークID

例:
```
iwallet system register 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b --location Singapore --url https://iost.io/ --net_id 12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht --account iost
```

# Serviノードのログイン

210万票得票して、ログイン済みのServiノードには、ブロック生成のチャンスがあります。

iwalletを使って、Serviノードをログインできます。

```
iwallet system producer-login --account <your-account>
```

# Serviノードへの投票

充分なIOSTがある場合は、次のコマンドでServiノードに投票できます。

```
iwallet system vote <your-servi-node-account> 2100000 --account <your-account>
```

- <your-servi-node-account>: 投票されたServiノードアカウント
- <your-account>: 投票アカウント

投票をキャンセルするなら、次のコマンドを使います。

```
iwallet system unvote <your-servi-node-account> 2100000 --account <your-account>
```

# Serviノードアカウント情報の表示

Serviノードのアカウント情報をチェックしたいなら、次のコマンドを使います。
```
iwallet system producer-info --account <your-account>
```

# Serviノードのログアウト

一時的にノードを止めたい場合や、ブロックを生成したくない場合は、iwalletを使って、Serviノードをログアウトできます。

```
iwallet system producer-logout --account <your-account>
```
