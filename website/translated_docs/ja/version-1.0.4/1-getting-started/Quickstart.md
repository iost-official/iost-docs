---
id: version-1.0.4-Quickstart
title: クイックスタート
sidebar_label: クイックスタート
original_id: Quickstart
---

最も簡単な方法

## 1. リポジトリのクローン

```
git clone https://github.com/iost-official/go-iost.git
cd go-iost
```

## 2. 依存性のインストール

次のコマンドで、すべての依存性をインストールします。

```
cd go-iost/iwallet/contract
npm install
```

## 3. 最初のスマートコントラクトを書く

IOSTのスマートコントラクトは、JavaScriptをサポートしています。単純なスマートコントラクトは次のようになります。

```
class Sample {
    init() {
        //Execute once when contract is packed into a block
    }

    constructor() {
        //Execute everytime the contract class is called
    }

    transfer(from, to, amount) {
        //Function called by other
        BlockChain.transfer(from, to, amount)

    }

};
module.exports = Sample;
```

## 4. コントラクトのデプロイ

デプロイには次のステップが必要です。

- .jsファイルをコンパイルして、ABIファイルを作成
- .js、.abi、.scファイルで、トランザクションのパッケージファイルを生成
- .scファイルを署名者に送って、署名者が.sigを生成
- .sigファイルと.scファイルを集めて、メインチェーンにファイルをパブリッシュ
