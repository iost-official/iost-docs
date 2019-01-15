---
id: TokenContract
title: トークンコントラクト
sidebar_label: Token Contract
---

## token.iost
---

### 説明
トークンコントラクトは、トークンの作成、配布、転送、破棄に使用され、しばらくの間トークンを凍結することができ、トークンのフルネーム、小数点以下の桁数、転送属性の設定もサポートします。

### 情報
| コントラクトID | token.iost |
| :----: | :------ |
| 言語 | ネイティブ |
| バージョン | 1.0.0 |

### API

#### create (tokenSym, issuer, totalSupply, config)
トークンを作成します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンコントラクトを識別する一意の識別子 | string |
| issuer | トークン権限を持つ発行者 | string |
| totalSupply | 総供給量で整数 | number |
| config | 設定 | json |

| 戻り値 | なし |
| :----: | :------ |

tokenSymには、2文字から16文字で、英小文字(a-z)、数字(0-9)、下線(_)だけが使えます。

configでサポートされている設定項目は次のとおりです。

{

   "fullName": "iost token", // トークンのフルネーム、string型

   "canTransfer": true, // 取引可能かどうか、bool型

   "decimal": 8 // 小数点以下の桁数、number型

}

#### issue (tokenSym, to, amount)
トークンを発行します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |
| to | トークン受信アカウント | string |
| amount | 量 | string |

| 戻り値 | なし |
| :----: | :------ |

amountパラメータは文字列で、"100"などの整数または10進数を指定できます。"1.22"は有効な数値です。

#### transfer (tokenSym, from, to, amount, memo)
トークンを転送します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |
| from | トークン送信アカウント | string |
| to | トークン受信アカウント | string |
| amount | 量 | string |
| memo | 追加情報 | string |

| 戻り値 | なし |
| :----: | :------ |

#### transferFreeze (tokenSym, from, to, amount, ftime, memo)
トークンを転送し、凍結します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |
| from | トークン送信アカウント | string |
| to | トークン受信アカウント | string |
| amount | 量 | string |
| ftime| 凍結解除までの時間(ミリ秒単位のUNIX時間) | number |
| memo | 追加情報 | string |

| 戻り値 | なし |
| :----: | :------ |

#### destroy (tokenSym, from, amount)
トークンを破棄します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |
| from | トークンを破棄するアカウント | string |
| amount | 量 | string |

| 戻り値 | なし |
| :----: | :------ |

#### balanceOf (tokenSym, from)
トークンの残高を取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |
| from | トークンのアカウント | string |

| 戻り値 | 型 |
| :----: | :------ |
| アカウントの残高 | string |

#### supply (tokenSym)
トークンの流通量、つまり発行済みで破棄されていないトークンの合計数量を取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |

| 戻り値 | 型 |
| :----: | :------ |
| 流通量 | string |

#### totalSupply(tokenSym)
トークンの総供給量を取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークンの識別子 | string |

| 戻り値 | 型 |
| :----: | :------ |
| 総供給量 | string |


## token721.iost
---

### 説明
Token721コントラクトは、交換不可能なトークンの作成、配布、転送、破棄に使用します。

### 情報
| コントラクトID | token721.iost |
| :----: | :------ |
| 言語 | ネイティブ |
| バージョン | 1.0.0 |

### API

#### create (tokenSym, issuer, totalSupply)
トークンを作成します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | コントラクト内での一意のトークン識別子 | string |
| issuer | トークンの発行権を持つ発行者 | string |
| totalSupply | 総流通量で、整数 | number |

| 戻り値 | なし |
| :----: | :------ |

tokenSymには、2文字から16文字で、英小文字(a-z)、数字(0-9)、下線(_)だけが使えます。

#### issue (tokenSym, to, metaData)

トークンを発行します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークン識別子 | string |
| to | トークン受信アカウント | string |
| metaData | トークンのメタデータ | string |

| 戻り値 | 型 |
| :----: | :------ |
| トークンID | string |

tokenIDはトークンIDです。特定のトークンでは、システムが発行された各トークンに対してトークンIDを生成しますが、それは重複しません。

#### transfer (tokenSym, from, to, tokenID)
トークンを転送します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークン識別子 | string |
| from | トークン送信アカウント | string |
| to | トークン受信アカウント | string |
| tokenID | トークンID | string |

| 戻り値 | なし |
| :----: | :------ |

#### balanceOf (tokenSym, from)
トークンの残高を取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークン識別子 | string |
| from | トークンアカウント | string |

| 戻り値 | 型 |
| :----: | :------ |
| アカウントの残高 | number |

#### ownerOf (tokenSym, tokenID)
特殊なトークンのオーナーを取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークン識別子 | string |
| tokenID | トークンID | string |

| 戻り値 | Type|
| :----: | :------ |
| オーナーのアカウント | string |

#### tokenOfOwnerByIndex(tokenSym, owner, index)
アカウントが所有しているインデックス番目のトークンを取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークン識別子 | string |
| owner | トークンのアカウント | string |
| index | トークンのインデックスで整数 | number |

| 戻り値 | 型 |
| :----: | :------ |
| トークンID | string |

#### tokenMetadata(tokenSym, tokenID)
トークンのメタデータを取得します。

| パラメータ名 | パラメータの説明 | パラメータの型 |
| :----: | :----: | :------ |
| tokenSym | トークン識別子 | string |
| tokenID | トークンID | string |

| 戻り値 | 型 |
| :----: | :------ |
| メタデータ | string |
