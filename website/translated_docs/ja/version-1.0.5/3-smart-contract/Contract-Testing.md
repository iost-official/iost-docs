---
id: version-1.0.5-Contract-Testing
title: テスト
sidebar_label: テスト
original_id: Contract-Testing
---

スマートコントラクトをテストするために、IOSTはスタンドアロンスタンドアロンでブロック生成するDockerミラーを開発者に用意しています。これにより、開発者はRPCリクエストのバックエンドとしてスタンドアロンのDockerを使うことで、スマートコントラクトをメインチェーンに入れる前に正当性を確認することができます。

コントラクトが受信側RPCにアップロードされたときに直接チェーンに書かれるわけではないことに注意してください。コントラクトは次のブロックが生成されるまで待たねばなりません。コントラクトがブロックに入ったときも妥当性チェックが実行されます。

## Dockerミラーの起動

```bash
docker run -d -p 30002:30002 iostio/iost-node:2.0.0
```

このコマンドで、Dockerの30002ポートをマシンの30002ポートへマッピングし、RPCリクエストがDockerに直接送信されるようになります。その後、ブロックチェーンプログラムによってパックされ、チェーンに入れられます。

### メモ

このミラー内では、すべてのIOST、21,000,000,000 IOSTは初期アカウントに入れられます。コントラクトを初期化したり公開したいなら、このアカウントから送金する必要があります。IOSTのトランザクションはGasを必要としますので、すべてのトークンは初期アカウントに格納され、このアカウントだけがトランザクションを実行できます。

- 初期アカウント: `IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C`
- 秘密鍵: `1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB`

## 他のアカウントへのIOSTの送金方法

### アカウントの作成

```bash
// This will generate a private/public key pair under ~/.iwallet/ folder
./iwallet account
```

### トランザクションの初期化

```bash
// Normally we ask the fromID to sign the transaction
./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' --signer "ID0, ID1"
// Example
./iwallet call iost.system Transfer '["IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", 100]' --signers "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
```

これで、`iost.sc`トランザクションファイルが生成されます。*デプロイと呼び出し*で説明したようにチェーンへ入れる公開ワークフローをたどる必要があります。

## ローカルチェーンにコントラクトを入れる

*デプロイと呼び出し*を参照してください。

## チェーン上のコントラクトの存在チェック

トランザクションやコントラクトをパブリッシュするときは、まず`Transaction`を初期します。`iWallet`は、この`Transaction`のハッシュを返し、これがトランザクションのIDになります。またトランザクションが正常にパブリッシュされたかどうかを調べることもできます。

```bash
./iwallet transaction $TxID
```

もしトランザクションの公開に失敗したときは、Dockerからログを抜き出して、エラー情報を詳細に調べることもできます。

```bash
docker logs $ContainerID
```
