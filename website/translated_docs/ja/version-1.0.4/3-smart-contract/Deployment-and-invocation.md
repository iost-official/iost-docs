---
id: version-1.0.4-Deployment-and-invocation
title: デプロイと呼び出し
sidebar_label: デプロイと呼び出し
original_id: Deployment-and-invocation
---

JavaScriptでスマートコントラクトを書いたら、チェーンにデプロイする必要があります。

デプロイには次のステップが必要です。

- jsをコンパイルして、ABIファイルを作成
- .jsと.abiファイルで.scパッカーファイルを作成
- .scファイルを署名者に配布し、署名者は.sigファイルを作成
- .sigファイルと.scファイルを集めて、チェーンにパブリッシュ

デプロイするにはiWalletプログラムが必要です。ドキュメントにあったように、もうすでにコンパイルしたiWalletプログラムを`go-iost/target`に持っていることでしょう。

最初に、iWalletを使って、jsのコードを関連するABIファイルにコンパイルします。

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

これで、.js.abiファイルと.js.afterファイルが生成されます。

次に、jsと.js.abiファイルを使って.scファイルを生成します。

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signer "ID0, ID1..."
# Example
./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
```

.scファイルを関係する署名者に配布し、署名者が.sigファイルを生成します。

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

最後に、トランザクション内の.scファイルを.sigファイルと一緒にデプロイします。

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.ssh/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
