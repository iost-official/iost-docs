---
id: Become-Servi-Node
title: Serviノードになるには
sidebar_label: Serviノードになるには
---

Serviノードは*プロデューサー*の場合にのみブロックを生成できます。これにはIOSTアカウントとフルノードが必要です。

# フルノードの開始
起動スクリプトを実行して、フルノードを起動します。[ノードの起動](4-running-iost-node/Deployment.md)も参照してください。

```
curl https://developers.iost.io/docs/assets/boot.sh | bash
```

プロデューサーの*キーペア*は、/data/iserver/keypair にありますので、ここでプロデューサーの公開鍵を入手することができます。

コマンド `curl http://localhost:30001/getNodeInfo`で、`network.id`セクションのノードのネットワークIDを取得できます。

# IOSTアカウントの作成

まだ、アカウントがないなら、次のステップに従ってください。

- [ウォレットをインストール](4-running-iost-node/iWallet.md#install)
- iWallet: `iwallet keys`を使って、*キーペア*を生成します。
- 生成された*公開鍵*を使って、[ブロックチェーンエクスプローラー](https://explorer.iost.io/applyIOST)により、テストネットのアカウントを作り出します。

> アカウントをiwalletにインポートするのを忘れないでください。`iwallet account --import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`

# Serviノードの登録

walletを使って、Serviノードとして、アカウントを登録することができます。
```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",<is-producer>]'
```
`vote_producer.iost` [ここ](6-reference/SystemContract.md#vote-produceriost)のAPIドキュメントを参照してください。

- `<your-account>`: Serviノードへ登録するのに使うアカウント
- `<pubkey-of-producer>`: フルノードの公開鍵
- `<location>`: フルノードのロケーション
- `<website>`: 公式ホームページ
- `<network-ID>`: フルノードプロデューサーのネットワークID
- `<is-producer>`: プロデューサーになるかどうか (単なるパートナーノードになりたいなら、このオプションはfalse)

例:
```
iwallet --account iost call 'vote_producer.iost' 'applyRegister' '["iost","6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b","Singapore","https://iost.io/","/ip4/3.85.187.72/tcp/30000/ipfs/12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht",true]'
```

# Serviノードのログイン

210万票得票して、ログイン済みのServiノードには、ブロック生成のチャンスがあります。

iwalletを使って、Serviノードにログインできます。

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'
```

# Serviノードのログアウト
一時的にフルノードを止めたい場合や、ブロックを生成したくない場合は、iwalletを使って、Serviノードをログアウトできます。

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]'
```
