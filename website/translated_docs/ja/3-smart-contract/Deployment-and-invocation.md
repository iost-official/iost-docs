---
id: Deployment-and-invocation
title: デプロイと呼び出し
sidebar_label: デプロイと呼び出し
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

### .sigファイルと.scファイルを集めて、チェーンにパブリッシュ
最後に、```.js```ファイルと```.abi```ファイルを使って、チェーンにデプロイします。

```bash
# publish a transaction with .sig file from every signer
./iwallet --server serverIP --account acountName --amount_limit amountLimit publish jsFilePath abiFilePath
# Example
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...

#Return
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh
```
