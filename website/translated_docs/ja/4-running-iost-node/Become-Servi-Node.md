---
id: Become-Servi-Node
title: Serviノードになるには
sidebar_label: Serviノードになるには
---

Serviノードは、報酬を受け取るためのIOSTアカウントとブロックを生成するためのフルノードが必要です。ノードを起動して自分のアカウントにバインドする必要があります。１つのIOSTアカウントは、*最大*１つのServiノードにバインドできます。Serviノードは、iServerの設定ファイル内の秘密鍵を使用して生成されるブロックに署名します。
**Serviノードには、自分のアカウントとは異なるキーペアを使用することを強くお勧めします。**

##IOSTアカウントを作成する
まだIOSTアカウントを持っていない場合は、次のステップに従ってください。

- [iWalletをインストールする](4-running-iost-node/iWallet.md#install)
- iWalletを使って*キーペア*を生成します。(`iwallet key`)
- [ブロックチェーンエクスプローラ](https://explorer.iost.io/applyIOST)でアカウント作成時に生成された*公開鍵*を使用します。

> iWalletにアカウントをインポートするのを忘れないでください: `iwallet account import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`
安全のため、IOSTアカウントをServiノードとは別の秘密の場所に保管することをお勧めします。

# フルノードの開始
起動スクリプトを実行して、フルノードを起動します。[ノードの起動](4-running-iost-node/Deployment.md)も参照してください。

```
curl https://developers.iost.io/docs/assets/boot.sh | bash
```

何も問題がなければ、次のように出力されます。

```
...
Serviノードとして登録したいなら、次にように実行します。

        iwallet sys register <pubkey> --net_id <network-id> --account <your-account>

Serviノードをオンラインにするには、次のようにします。

        iwallet sys plogin --acount <your-account>

完全なドキュメントは、https://developers.iost.io にあります。
```

このスクリプトはノードの新しいキーペアを生成します。**公開鍵**と**ネットワークID**を設定してください。

ノードの*キーペア*は、$PREFIX/keypair にあり、この**pubkey**です。

コマンド `curl http://localhost:30001/getNodeInfo`で、`network.id`セクションのノードの**network.id**を取得できます。

# GASのプレッジとRAMの購入

GASやRAMが足りない場合は、次のコマンドでGASをプレッジしたり、RAMを購入したりできます。
```
# pledge gas
iwallet --account account000 call gas.iost pledge '["account000","account000","50"]'
# buy ram
iwallet --account account000 call ram.iost buy '["account000","account000",200]'
```

# Serviノードの登録

iwalletを使って、ノードにアカウントを紐づけて、Serviノードを登録します。
```
iwallet sys register <pubkey-of-producer> --location <location> --url <website> --net_id <network-ID> --account <your-account>
```

- `<your-account>`: Serviノードへ登録するのに使うアカウント
- `<pubkey-of-producer>`: ノードの公開鍵
- `<location>`: フルノードのロケーション
- `<website>`: 公式ホームページ
- `<network-ID>`: ノードのネットワークID

例:
```
iwallet sys register 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b --location Singapore --url https://iost.io/ --net_id 12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht --account iost
```

# Serviノードへのログイン

210万票得票して、ログイン済みのServiノードには、ブロック生成のチャンスがあります。

iwalletを使って、Serviノードにログインできます。

```
iwallet sys plogin --account <your-account>
```

# Serviノードのログアウト
一時的にノードを止めたい場合や、ブロックを生成したくない場合は、iwalletを使って、Serviノードをログアウトできます。

```
iwallet sys plogout --account <your-account>
```
