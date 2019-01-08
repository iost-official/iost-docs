---
id: IOST-class
title: IOST
sidebar_label: IOST
---

IOSTクラスは、IOSTブロックチェーンに送信するトランザクションやIOSTスマートコントラクトを作成するためのクラスです。

## constructor
constructorメソッドは、特殊なメソッドで、IOSTクラスを作成し、初期化します。

### パラメータ
名前             |型       |説明 
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
