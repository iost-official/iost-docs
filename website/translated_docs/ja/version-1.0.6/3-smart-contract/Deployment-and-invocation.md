---
id: version-1.0.6-Deployment-and-invocation
title: デプロイと呼び出し
sidebar_label: デプロイと呼び出し
original_id: Deployment-and-invocation
---

JavaScriptでスマートコントラクトを書いたら、チェーンにデプロイする必要があります。

デプロイには次のステップが必要です。

- jsをコンパイルして、ABIファイルを作成
- ABIファイルを修正
- .jsと.abiファイルで.scパッカーファイルを作成
- .scファイルを署名者に配布し、署名者は.sigファイルを作成
- .sigファイルと.scファイルを集めて、チェーンにパブリッシュ

### jsをコンパイルしてABIファイルを作成

デプロイするにはiWalletプログラムが必要です。ドキュメントにあったように、もうすでにコンパイルしたiWalletプログラムを`go-iost/target`に持っていることでしょう。

最初に、iWalletを使って、jsのコードを関連するABIファイルにコンパイルします。

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

これで、.js.abiファイルと.js.afterファイルが生成されます。

### ABIファイルの修正
今のところ、.abiファイルはいくつかの変更をしなければなりません。主に次の項目をチェックしてください。

- abiフィールドがnullでないかチェック
- .abiファイルの「abi」フィールドを修正して、`args`のすべてのフィールドを正しい型にする

#### 例
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "transfer",
            "args": [
                "string",
                "string",
                "int"
            ]
        }
    ]
}
```

### .jsと.abiファイルを使って.scパッカーファイルを生成

次に、jsと.js.abiファイルを使って.scファイルを生成します。

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signers "ID0, ID1..."
# Example
./iwallet compile -e 10000 -l 100000 -p 1 ./test.js ./test.js.abi --signers "ID"
```

### .scファイルを各署名者に配布し、署名者が.sigファイルを生成

.scファイルを関係する署名者に配布し、署名者が.sigファイルを生成します。

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

### .sigファイルと.scファイルを集めてチェーンにパブリッシュ

最後に、トランザクション内の.scファイルを.sigファイルと一緒にデプロイします。

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.iwallet/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
