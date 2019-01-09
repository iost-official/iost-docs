---
id: version-2.0.0-Generate-Receipt
title: スマートコントラクトでのレシート生成
sidebar_label: スマートコントラクトでのレシート生成
original_id: Generate-Receipt
---
## 機能
レシートは特定の操作の発生を証明したり通知したりすることに使います。典型的なアプリケーションではメモを追加してAからBへの転送を記録するもものです。

スマートコントラクトはブロックチェーンのインフラで提供されているシステム関数の`blockchain.receipt`で生成できます。レシートはトランザクションに関連するブロックデータに格納されます。もちろん、ブロックチェーンネットワーク内のすべてのノードで検証されます。レシートはコントラクト内では照会することはできません。ブロックデータを解析するか、RPCインターフェースを通して、トランザクションハッシュを使ったリクエストをすることでレシートを照会することができます。

レシートはコントラクトの格納よりも遥かに安価です。GASとRAMの両方を使うコントラクトの格納と違い、わずかにGAS代がかかるだけです。

## レシートの生成
スマートコントラクトはシステム関数`blockchain.receipt`により、レシートを生成します。次の例では、コントラクトのreceiptf関数が呼び出されるとき、３つのレシートが生成されます。

```js
class Contract {
    init() {
    }

    receiptf() {
        blockchain.receipt(JSON.stringify(["from", "to", "100.01"]));
        blockchain.receipt('{"name": "Cindy", "amount": 1000}');
        blockchain.receipt("transfer accepted");
    }
}

module.exports = Contract;
```

`blockchain.receipt`は、レシートの内容を示すstringパラメータを受け取り、戻り値はありません。
実行が成功しなかった場合はランタイムエラーになりますが、通常の環境では発生しません。
開発者は、内容として解析が容易なJSON形式の文字列を使うことをおすすめします。

生成されたレシートは、レシートが関係するメソッドを示すコントラクト名とアクション名も含んでいます。上の３つのレシートは次のようになります。

```console
# first
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"[\"from\",\"to\",\"100.01\"]"}
# second
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"{\"name\": \"Cindy\", \"amount\": 1000}"}
# third
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"transfer accepted"}
```
`ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLM`は、このコントラクトのIDです。


## レシートの照会
### トランザクションハッシュを使ったレシートの照会
特定のトランザクションにより生成されたレシートは、RPCインターフェースを通して、トランザクションハッシュにより照会することができます。

[/getTxReceiptByHash](../6-reference/API#gettxreceiptbyhash-hash)を参照してください。



### ブロックデータによるレシートの照会
完全なブロックデータは、すべてのトランザクションとレシートを含んでいます。ブロックデータをダウンロードして解析することで、ブロック内で生成されたすべてのレシートを取得することができます。

[ /getBlockByHash](../6-reference/API#getblockbyhash-hash-complete)と[/getBlockByNumber](../6-reference/API#getblockbynumber-number-complete)を参照して、リクエストパラメータ内の`complete`を`true`にしてください。
