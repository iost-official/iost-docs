---
id: version-2.1.7-How-to-write-a-smart-contract
title: スマートコントラクトの書き方
sidebar_label: スマートコントラクトの書き方
original_id: How-to-write-a-smart-contract
---

## 基本情報

### 言語サポート

現在IOSTは、JavaScriptで書かれたスマートコントラクトをサポートしています。

### 実行環境

IOSTはコントラクトの実行のために[Chrome V8](https://developers.google.com/v8)エンジンを内部で使っています。

## スマートコントラクトプログラミングガイド

### スマートコントラクトの実装

IOST内では、スマートコントラクトはJavaScriptの`class`としてコーディングされています。それを使うには、そのクラスを`export`する必要があります。

#### スマートコントラクトの構造

スマートコントラクトのクラスは、`init`関数を持たなければいけません。

- `init`は、コントラクトがデプロイされたときに実行されます。それはコントラクトのプロパティを初期化するのに使います。

これらの２つの関数とは別に、必要であれば開発者は他の関数も定義できます。`transfer`関数を使ったシンプルなスマートコントラクトのテンプレートを次に示します。

```javascript
class Test {
    init() {
        //Execute once when contract is packed into a block
    }

    transfer(from, to, amount) {
        //Function called by other
        blockchain.transfer(from, to, amount, "");
    }

};
module.exports = Test;
```

## IOSTブロックチェーンAPI
以下のオブジェクトは、コントラクトコード内でアクセスできます。

### storageオブジェクト

すべての変数はラインタイム上のメモリに格納されます。IOSTでは、スマートコントラクトでデータを保持するために`storage`オブジェクトを使うことができます。

開発者はこのクラスを利用して複数のコントラクト呼び出し中にデータを同期することができます。
APIは、[こちら](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js)を参照してください。



### blockchainオブジェクト

blockchainオブジェクトは、システムが呼び出すためのすべてのメソッドを提供し、ユーザーが公式のAPIを呼び出すのを助けます。それには、送金、他のコントラクトの呼び出し、ブロックやトランザクションの検索が含まれます。

詳細なインターフェースは、[ここに](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js)挙げてあります。


### txオブジェクトとblockオブジェクト
txオブジェクトは、現在のトランザクションの情報を、blockオブジェクトは、現在のブロックの情報を含んでいます。
APIは、[こちら](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29)を参照してください。