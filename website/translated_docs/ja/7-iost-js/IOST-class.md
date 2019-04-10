---
id: IOST-class
title: IOST
sidebar_label: IOST
---

IOSTクラスは、IOSTブロックチェーンに送信するトランザクションやIOSTスマートコントラクトを作成するためのクラスです。

## constructor
constructorメソッドは、特殊なメソッドで、IOSTクラスを作成し、初期化します。

### パラメータ

名前                 |型       |説明 
----                |--         |--
config |Object         | IOSTクラスの設定、詳細は次の通り。<br/> <b>gasRatio:</b> トランザクションのGAS代<br/> <b>gasLimit:</b> トランザクションのGAS上限<br/> <b>expiration:</b> トランザクションの有効期限(秒)

### 戻り値
IOSTオブジェクトインスタンス

### 例
```javascript
// init iost sdk
const iost = new IOST.IOST({ // will use default setting if not set
    gasRatio: 1,
    gasLimit: 100000,
    expiration: 90,
});
```

## callABI
コントラクトのABI関数を呼び出します。

### パラメータ
名前             |型       |説明 
----                |--         |--
contract |String         | コントラクトIDまたはコントラクトドメイン
abi 	 |String 		 | コントラクトのABI関数名
args	 |Array			 | 関数の引数配列

### 戻り値
Transactionオブジェクト

### 例
```javascript
const tx = iost.callABI(
	"token.iost",
	"transfer",
	["iost", "fromAccount", "toAccount", "10.000", "memo"]
);
```

## newAccount
IOSTブロックチェーンのアカウントを作成します。

### パラメータ
名前             |型       |説明 
----                |--         |--
name 			 |String	| 新アカウント
creator 	 	 |String	| 作成者のアカウント名
ownerkey	 	 |String	| 作成者のアカウントownerKey
activekey	 	 |String	| 作成者のアカウントactivekey
initialRAM	 	 |Number	| 新アカウントの初期RAM、作成者による支払い
initialGasPledge |Number	| 新アカウントの初期GAS出資、作成者による支払い

### 戻り値
Transactionオブジェクト

### 例
```javascript
// first create KeyPair for new account
const newKP = KeyPair.newKeyPair();
// then create new Account transaction
const newAccountTx = iost.newAccount(
    "test1",
    "admin",
    newKP.id,
    newKP.id,
    1024,
    10
);
```

## transfer
トークンを指定したアカウントへ送信するcallABIのラッパー。

### パラメータ
名前             |型       |説明 
----                |--         |--
token		|String	| トークン名
from 	 	|String	| 送信元
to			|String	| 送信先
amount	 	|String	| 送信量
memo	 	|Number	| メモ

### 戻り値
Transactionオブジェクト

### 例
```javascript
const tx = iost.transfer("iost", "fromAccount", "toAccount", "10.000", "memo");
```

# トランザクションの送信方法
IOSTでのトランザクションの送信方法は、次のとおりで、サードパーティのウォレットにも互換性があります。

```
iost.setAccount(account);
iost.setRPC(rpc);
iost.signAndSend(tx)
    .on("pending", console.log)
    .on("success", console.log)
    .on("failed", console.log);
```

サードパーティのウォレットはIOSTをフックし、signAndSend()関数を引き継ぐことを推奨します。そうすれば、ウォレットが存在するかどうかに関係なく開発できます。

もし、ウォレットがあるなら、signAndSend()はウォレット内で動作し、成功か失敗かをコールバックします。なければ、IOSTは```account```でトランザクションを署名し、```rpc```を使って送信します。

## signAndSend
トランザクションに署名し、送信します。

### パラメータ
名前             |型       |説明 
----                |--         |--
tx       |IOST.Tx | 送信するトランザクション

### 戻り値
コールバックオブジェクト

### 例
```javascript
iost.signAndSend(tx)
    .on("pending", console.log)
    .on("success", console.log)
    .on("failed", console.log);
```

## Callback.on(event, callback)
イベントにハンドルを設定します。

### パラメータ
名前             |型       |説明 
----                |--         |--
event       | String | イベント名("pending", "success", "failed")
callback       | function | コールバック関数

### 戻り値
itself.

### 例
```javascript
iost.signAndSend(tx)
    .on("pending", console.log)
    .on("success", console.log)
    .on("failed", console.log);
```


## setAccount
IOSTにデフォルトのアカウントを設定します。

### パラメータ
名前             |型       |説明 
----                |--         |--
account       |IOST.Account | トランザクションで使われるアカウント

### 戻り値
null

### 例
```javascript
iost.setAccount(account);
```

## currentAccount
IOSTでの現在のアカウントを取得します。

### パラメータ
null

### 戻り値
IOST.Account

### 例
```javascript
const account = iost.currentAccount();
```

## setRPC
指定したアカウントにトークンを送信するcallABIのためのラッパーです。

### パラメータ
名前             |型       |説明 
----                |--         |--
rpc       |IOST.RPC | IOSTインスタンスで使われるRPC

### 戻り値
null.

### 例
```javascript
iost.setRPC(rpc);
```

## currentRPC
現在のRPCを取得します。

### パラメータ
null

### 戻り値
IOST.RPCインスタンス

### 例
```javascript
const rpc = iost.currentRPC();
```