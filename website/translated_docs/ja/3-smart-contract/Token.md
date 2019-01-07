---
id: Token
title: トークンの作成
sidebar_label: トークンの作成
---
## Token20

Token20は、IOSTブロックチェーン上の標準的なトークン実装です。 転送以外にもトークンの凍結、トークンの破棄などの実践的な機能を注意しながら設定できます。

`iost`も組み込みシステムコントラクト`token.iost`に基づき、Token20標準に従って実装されています。
`token.iost`のインターフェースは次のとおりです。

```js
// create tokenSymbol
create(tokenSymbol, issuer, totalSupply, configJson);	// string, string, number, json
issue(tokenSymbol, to, amountStr);						// string, string, string
transfer(tokenSymbol, from, to, amountStr, memo);		// string, string, string, string, string
transferFreeze(tokenSymbol, from, to, amountStr, unfreezeTime, memo);		// string, string, string, string, number, string
destroy(tokenSymbol, from, amountStr);					// string, string, string
// query interfaces
balanceOf(tokenSymbol, from);							// string, string
supply(tokenSymbol);									// string
totalSupply(tokenSymbol);								// string
```
### create(tokenSymbol, issuer, totalSupply, configJson)
`権限が必要: issuer`

tokenSymbolは、特定のトークンの一意となる識別子です。つまり、同じtokenSymbolを持った`token.iost` コントラクトは作成できません。
長さは2から16で、英小文字(`a-z`)、数字(`0-9`)、下線(`_`)のみが使えます。

issuerは、トークンの発行者で、発行者のみが任意のアカウントにトークンを発行することができます。
一般的にトークンの発行者はアカウントですが、コントラクトでも可能です。
発行者がコントラクトIDのとき、このコントラクトだけが、他へコントラクトを発行する`issue`メソッドの呼び出しが許されます。
つまり、`mytoken`の発行者はコントラクト`Contractabc`なら、`Contractabc`が`mytoken`を発行する`issue`を呼び出せることを意味します。`Contractabc`は、`Contractdef`内の関数も呼び出すことができ、`Contractdef`が`mytoken`の発行権限を持つことになります。
これにより、コントラクトの権限が呼び出したコントラクトに引き渡すことができます。権限を引き渡すために他のコントラクトを呼び出すときには、`blockchain.call`の代わりに、システム関数である`blockchain.callWithAuthority`を使う必要があります。

総供給量totalSupplyは、int64型の数値で、発行者はtotalSupplyを超えるトークンを発行できません。

configJsonは、トークンのためのJSON構造のデータで、次のような設定のためのプロパティがあります。
```console
{
	"decimal": number between 0~19,
	"canTransfer": true/false, the token can not be transferd if canTransfer is false,
	"fullName": string describes the full name of the token
}
```

### issue(tokenSymbol, acc, amountStr)
`権限が必要: tokenSymbolのissuer`

tokenSymbolトークンを`acc`アカウントに発行します。転送量amountStrは、発行数を指す文字列で、"100"や"100.999"のような正の10進固定小数点数でなければなりません。

### transfer(tokenSymbol, accFrom, accTo, amountStr, memo)
`権限が必要: accFrom`

tokenSymbolトークンを`accFrom`から`accTo`へamountStrとmemoをつけて転送します。転送量amountStrは正の10進固定小数点数で、memoはこの転送操作の追加メッセージのための512バイト以下の文字列です。

### transferFreeze(tokenSymbol, accFrom, accTo, amountStr, unfreezeTime, memo)
`権限が必要: accFrom`

tokenSymbolトークンを`accFrom`から`accTo`へamountStrとmemoをつけて転送し、この部分のトークンをunfreezeTimeまで凍結します。 
unfreezeTimeは、凍結を解除するまでのナノ秒単位のUNIX時間です。

### destroy(tokenSymbol, accFrom, amountStr)
`権限が必要: accFrom`

`accFrom`アカウント内のtokenSymbolトークンをamountStrだけ破棄します。破棄すると、このトークンの供給量は同じアカウントで減少します。つまり、トークンを破棄することで、総供給量totalSupplyの範囲内で、より多くのトークンを発行できます。

### balanceOf(tokenSymbol, acc)
`権限が必要: なし`

accアカウントのtokenSymbolトークン残高を照会します。

### supply(tokenSymbol)
`権限が必要: なし`

tokenSymbolトークンの供給量を照会します。

### totalSupply(tokenSymbol)
`権限が必要: なし`

tokenSymbolトークンの総供給量を照会します。


## ステップバイステップによる例
IOSTブロックチェーンに`Token20`を作成するのは、非常に簡単です。Token20インターフェースの実装スマートコントラクトを自分でデプロイしないで、`token.iost`コントラクトを呼び出すことができます。

`bank`アカウントでのトークンの作成方法やアカウント間の送信をする例を次に挙げておきます。`bank`、`user0`、`user1`の３つのアカウントは事前に作成しておいてください。

```console
iwallet call token.iost create '["mytoken", "bank", 21000000000, {"decimal": 8, "fullName": "token for test"}]' --account bank
iwallet call token.iost issue  '["mytoken", "bank", "1000"]' --account bank
iwallet call token.iost issue  '["mytoken", "user0", "100.00000001"]' --account bank
iwallet call token.iost transfer 		'["mytoken", "user0", "user1", "10", "user0 pay coffee"]' --account user0
iwallet call token.iost transferFreeze 	'["mytoken", "user1", "user0", "0.1", 1544880864601648640, "voucher"]' --account user1
iwallet call token.iost destroy '["mytoken", "bank", "1000"]' --account bank
```
