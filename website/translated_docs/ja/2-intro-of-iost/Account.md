---
id: Account
title: アカウント
sidebar_label: アカウント
---


# アカウント管理システム

## 概要

IOSTのアカウント管理システムは公開鍵と秘密鍵のペアによるメカニズムを利用しています。オーナーキーとアクティブキーを設定することにより、ユーザーは複数のアカウントシステム管理できるようになり、同時に機密の重みを自由に設定したり、権限を追加したりできます。これにより、多くのカスタマイズした管理機能が実装できます。

## アカウントシステムの基礎

IOSTのアカウントは、アカウント名(ID)と権限(permission)でできています。アカウントは少なくとも`owner`と`active`という権限を含む複数の権限があります。それぞれの権限には複数の項目が登録されていて、その項目は公開鍵IDにまたは別アカウントの権限ペアにすることができます。

公開鍵は`IOST`から始まり、Base58でエンコードされた公開鍵にCRC32によるチェックディジットを付加したものになります。


それぞれの項目は一定の重みを持ち、それに対応した各権限にはしきい値があります。トランザクションの項目の重みがしきい値より大きい場合にトランザクションがその権限を持つことになります。


項目の所有権をチェックするには、項目が公開鍵なら、トランザクションがその項目の公開鍵に対する署名を持つかどうかをチェックします。項目がアカウント権限ペアなら、再帰的にトランザクションが項目のアカウント権限ペアを持つかどうかをチェックします。

一般的に、スマートコントラクトは権限の検証にアカウント名と権限名を使います。システムはトランザクションの署名を調べて項目の重みを計算して、署名がしきい値を超えていることを検査して、トランザクションが正当であることを確認します。そうでない場合は検証が失敗し、アクセスが拒否されます。

`active`権限は、`owner`権限以外のすべての権限を付与することができます。`owner`権限のみが、`owner`権限や`active`権限を持つ項目を変更することができます。トランザクションをサブミットするには、`active`権限が必要です。

権限はグループで管理することもできます。グループに権限を付与し、グループに項目を追加することもできます。この方法で、項目はグループのすべての権限を持つことができます。

## アカウントシステムの利用法

スマートコントラクトでは、単純なAPI呼び出しがあります。

```
BlockChain.requireAuth(id, permission_string)
```

これは、操作を継続すべきかどうかを判断するためのブール値を返します。

一般的に、RAMとトークンを使うときには、ユーザーが`active`権限を持つかどうかを最初にチェックする必要があり、そうしないとスマートコントラクトが予定していない場所で投げられることがあります。権限を最小限にするために`permission_string`の一意の文字列を取り出しすようにします。

通常は、`owner`権限は不要で、`owner`や`active`権限を変更するときでさえ、ユーザーがオーナーキーを聞くべきではありません。

トランザクションの送信元は `active`権限を常に持っているので、送信元は不要です。

ユーザーレベルでは、署名を提供することでのみ、権限を追加できます。２つのアカウントでは例えば次のようになります。すべての重みと鍵のしきい値は1になっています。

```
User0
├── Groups
│   └── grp0: key3
└── Permissions
    ├── owner: key0
    ├── active: key1
    ├── perm0: key2, grp0
    ├── perm1: User1@active, grp0
    ├── perm2(threshold = 2): key4, key5, grp0
    ├── perm3: key8
    └── perm4(threshold = 2): User@perm3, key9

User1
└── Permissions
    ├── owner: key6
    └── active: key7
```

RequireAuthの形式

パラメータ	|署名鍵	  |戻り値    |説明
-----	      |----				|------	    |-------
User0, perm0		|key2			|true			|公開鍵の署名が提供されたときの権限
User0, perm0		|key3			|true			|グループの署名が提供されたときの権限
User0, perm0		|key1			|true			|`active`の鍵が提供されたときの権限(`owner`権限を使わない)
User0, perm1		|key7			|true			|key7はUser1@active権限、すなわちperm1を付与
User0, owner		|key1			|false		|`active`は`owner`権限なし
User0, active		|key0			|true			|`owner`は全権限を付与
User0, perm2		|key4			|false		|署名はしきい値に届いていない
User0, perm2		|key4,key5	|true			|署名がしきい値に到達した
User0, perm2		|key3			|true			|グループ権限はしきい値を計算しないし、チェックもしない
User0, perm2		|key1			|true			|`active`はしきい値をチェックしない
User0, perm4		|key8			|false		|権限グループの重みを計算するとき、これを実装できる

## アカウントの作成と管理

アカウント管理は、`account.iost`のスマートコントラクトに基づいていて、そのABIは次のようになっています。

```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "SignUp", // Create account
      "args": ["string", "string", "string"] // Username, ownerKey ID, activeKey ID
    },
    {
      "name": "AddPermission", // Add permission
      "args": ["string", "string", "number"] // Username, permission name, threshold
    },
    {
      "name": "DropPermission", // Drop permission
      "args": ["string", "string"] // Username, permission name
    },
    {
      "name": "AssignPermission", // Assign permission to an item
      "args": ["string", "string", "string","number"] // Username, permission, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokePermission",    // Revoke permission
      "args": ["string", "string", "string"] // Username, permission, public key ID or account_name@permission_name
    },
    {
      "name": "AddGroup",   // Add permission group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "DropGroup",   // Drop group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "AssignGroup", // Assign item to group
      "args": ["string", "string", "string", "number"] // Username, group name, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokeGroup",    // Revoke group
      "args": ["string", "string", "string"] // Username, group name, public key ID or account_name@permission_name
    },
    {
      "name": "AssignPermissionToGroup", // Assign permission to group
      "args": ["string", "string", "string"] // Username, permission name, group name
    },
    {
      "name": "RevokePermissionInGroup", // Revoke permissions from a group
      "args": ["string", "string", "string"] // Username, permission name, group name
    }
  ]
}
```

アカウント名は、小文字英数字と下線(`[a-z0-9_]`)のみを使用でき、6から32文字でなければなりません。権限名とグループ名は、小文字英数字と下線(`[a-z0-9_]`)で、1から32文字でなければなりません。

通常は、アカウントはアプリケーション上でIOSTへのデポジットが必要です。そうでなければ、アカウントを使うことができません。その方法は、`iost.js`を使って次のようにします。

```
newAccount(name, ownerkey, activekey, initialRAM, initialGasPledge) {
    const t = new Tx(this.config.gasPrice, this.config.gasLimit, this.config.delay);
    t.addAction("iost.auth", "SignUp", JSON.stringify([name, ownerkey, activekey]));
    t.addAction("iost.ram", "buy", JSON.stringify([this.publisher, name, initialRAM]));
    t.addAction("iost.gas", "pledge", JSON.stringify([this.publisher, name, initialGasPledge]));
    return t
}
```

アカウント作成プロセスを最適化するには、手数料は次のようにします。アカウント作成のGAS手数料はパブリッシャーが払い、新規アカウントのRAMもパブリッシャーが支払います。作成されたアカウントがアカウントのRAMサイズを増やすと、前に支払われたRAMがパブリッシャーに返却されます。その後、作成されたアカウントがアカウント作成のためにRAMを支払います。

アカウントを作成するとき、作成するアカウントに対して、RAMを買うかトークンをデポジットするか選択できます。10トークン以上をデポジットすることをおすすめします。そうすれば、新規アカウントはネットワークを利用するための十分なGASを持ちます。GASのデポジットは、リソースを買うためには、少なくとも10トークン必要です。
