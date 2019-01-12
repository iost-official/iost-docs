---
id: version-2.1.6-EconContract
title: コントラクトの経済
sidebar_label: コントラクトの経済
original_id: EconContract
---

## gas.iost
---

GASのプレッジ、解約、転送を含むGAS関連のコントラクトです。
経済モデルの詳細は、[GASの経済モデル](../2-intro-of-iost/Economic-model/#gas奖励)を参照してください。

### 情報
| コントラクトID | gas.iost |
| :----: | :------ |
| 言語 | ネイティブ |
| バージョン | 1.0.0 |

### API

#### pledge
IOSTのGASのプレッジ。最小のプレッジ量は1IOSTです。      
##### 例
\["user1","user1","100"\]：user1は、100IOSTを自分にプレッジするので、user1は100IOST使って、いくらかのGASを得ます。   
\["user1","user2","100"\]：uuser1は、100IOSTをuser2にプレッジするので、user1は100IOST使って、user2はいくらかのGASを得ます。

| 引数の意味 | 引数の型 |
| :----: | :------ |
| IOSTをプレッジする者。このアカウントの権限が必要 | string |
| GASの受領者 | string |
| プレッジするIOSTの量 | string |

#### unpledge
解約する。以前にプレッジしたIOSTが戻されます。最小解約量は1IOSTです。
##### 例
\["user1","user1","100"\]：user1は、以前に自分にプレッジした100IOST解約します。
\["user1","user2","100"\]：user1は、以前にuser2にプレッジした100IOST解約します。

| 引数の意味 | 引数の型 |
| :----: | :------ |
| IOSTの解約者。このアカウントの権限が必要 | string |
| 現在のプレッジ外のIOSTのプレッジ量 | string |
| 解約IOST量 | string | 


#### transfer
GASの転送。最小転送量は1IOST。
__注意__: プレッジから得たGASは転送できません。`transferable GAS`だけが、転送できます。ですから、一度転送した後の`transferable GAS`は、もう転送できません。
転送可能GASは、[transferable gas reward]から取得できます。(../2-intro-of-iost/Economic-model/#流通gas奖励)

#### 例
\["user1","user2","100"\]: user1は、100GASをuser2に転送します。
 

| 引数の意味 | 引数の型 |
| :----: | :------ |
| GAS転送者。このアカウントの権限が必要 | string |
| GAS受領者| string |
| IOST転送量 | string |

## ram.iost
---
売買や転送を含むコントラクト関係のRAMです。
   
経済モデルの詳細は、[RAMの経済モデル](../2-intro-of-iost/Economic-model/#资源)で紹介されています。
RAMの売買は多すぎず、[RPC](../6-reference/API/#getraminfo)で見積価格を取得できます。

### 情報
| コントラクト | ram.iost |
| :----: | :------ |
| 言語 | JavaScript |
| バージョン | 1.0.0 |

### API

#### buy

システムからRAMを購入する。最小購入量は10バイトです。
コントラクトはIOSTのコストを返します。
##### 例
\["user1","user1",1024\]:  user1は、1024バイトのRAMを自分のために買います。   
\["user1","user2",1024\]:  user1は、1024バイトのRAMをuser2のために買います。   

| 引数の意味 | 引数の型 |
| :----: | :------ |
| RAMの購入者。このアカウントの権限が必要 | string |
| RAMの取得者| string |
| 購入RAM量 | int |

#### sell
未使用RAMを販売します。最小販売量は10バイトです。
コントラクトは返されたIOSTを返します。
##### 例
\["user1","user1",1024\]:  user1は、未使用の1024バイトのRAMをシステムに販売し、返されたIOSTを自分で取得します。
。  
\["user1","user2",1024\]:  user1は、未使用の1024バイトのRAMをシステムに販売し、返されたIOSTをuser2が取得します。

| 引数の意味 | 引数の型 |
| :----: | :------ |
| RAM販売者。このアカウントの権限が必要 | string |
| 返されたIOSTの受領者 | string |
| 販売RAM量(バイト) | int |

#### lend
RAMを他者に転送します。
`購入`したRAMだけを他者に転送できます。そのため、他者に転送されたRAMをシステムに販売したり、他者に転送することはできません。
最小転送量は10バイトです。

##### 例
\["user1","user2",1024\]: user1が未使用の1024バイトのRAMをuser2に転送します。

| 引数の意味 | 引数の型 |
| :----: | :------ |
| RAM転送者。このアカウントの権限が必要 | string |
| 転送されたRAMの受領者| string |
| RAMの転送量(バイト) | int |


