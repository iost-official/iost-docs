---
id: version-1.0.4-Design-Tech-data
title: Lucky Betスマートコントラクト
sidebar_label: Lucky Betスマートコントラクト
original_id: Design-Tech-data
---

## 設計

Lucky BetはIOSTのスマートコントラクトで実行するギャンブルゲームです。このゲームは、スマートコントラクトのコーディングとデプロイをデモするために設計されています。

このゲームのルールは単純です。

1. IOSTのアカウントは、１から５IOSTを賭けることができます。ベットする数は0から9です。
2. ベットが100に達すると当選番号が公開され、当選者はステークの95%を獲得し、残りの5%がトランザクション手数料になります。
3. 当選番号は、ブロック高を10で割った余りです。前の当選番号のブロックが16ブロック未満の場合は、ブロックの親のハッシュを16で割った余りが0の場合だけ公開し、そうでないときは当選番号は公開されません。

## オンチェーン情報の取得

談合のリスクがありますが、チェーン上の情報で乱数を生成するのが最も容易です。Lucky Betは、次のようにして乱数を生成しています。

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

`BlockChain.blockInfo()`を使って、詳細の情報を取得でき、擬似乱数の種として使うことができます。

## ステータスデータ: 管理と使用法

スマートコントラクトは、２つの方法でデータを格納できます。

```javascript
const maxUserNumber = 100;
```

クラス外に定義された定数は、現在のドキュメントからアクセス可能で、追加のストレージコストは発生しません。

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

ストレージシステムにアクセスすることで、キーバリューペアを読み書きできます。値だけにString型が使えます。データ型を保持するためには、コントラクト内で処理する必要があります。これには読み書きのコストが発生します。

ストレージは外部からアクセス可能です。

```shell
$ curl -X GET \
  http://<nodeIP>:30001/getState/<ContractID>-round \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: f4f7c10c-d1fe-46ff-8962-a099490acc4c'
```
```
{'value':'s66'}%
```

```shell
$ curl -X GET \
  http://<nodeIP>:30001/getState/<ContractID>-result65 \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: b9339214-4b6a-4044-9925-43d72cf74fe3'
```
```
{'value':'s{'number':18627,'user_number':99,'k_number':8,'total_coins':{'number
```

戻り値で、`s`は`文字列`です。`66`は`put`による値です。最後の結果(`result65`)は、文字列変数として格納されます。スマートコントラクトのストレージにアクセスすることにより、バックエンドで実行したコントラクトの状態と結果を取得し表示することができます。

## スマートコントラクトの使用

RPCポートを通して、スマートコントラクトに、直接アクセスすることができます。

```shell
# via iwallet
$ iwallet call --expiration 90000 <ContractID> bet \
'["<iostID>", 1, 100000000, 1551040]' -s <nodeIP>:30002 -k <seckeyFile>
```

```
you don't indicate any signers,so this tx will be sent to the iostNode directly
ok
45ENdx81jarkgEDggKikQpPECyzcUhMmDU5BtnnEV6RK
```

```shell
$ target/iwallet transaction -s 52.192.65.220:30002 Gim2LFdZ3LgLeVweYddeCZ3Y8v4GpWKoSMqdFgFtPUZa # Check if app is on-chain
```
```
txRaw:<time:1537520778569798474 expiration:1537610778569798095 gasLimit:1000 gasPrice:1 actions:<contract:"ContractAC5V12562T7XB74A8gBe3cjfwWDbJheLWjzyY8VL6JPK" actionName:"bet" data:"[\"IOST2g5LzaXkjAwpxCnCm29HK69wdbyRKbfG4BQQT7Yuqk57bgTFkY\", 1, 100000000, 1551040]" > publisher:<algorithm:2 sig:"\210\tb\026\300\326\254&\002\230\027o\223\\h\345\367\210\361\0034\232\351+F1\274r6\332\226\242?\001\303\215Dz~\252Q\031i\035\227\223\236`\r\013\211\205p\306\373u\215\254\035a\222\336\327\r" pubKey:"\334k\242\372\010Mpu\334\274\333i\335\002!\222\212j\223\3317Z\360\362\3158\003\2056y}j" > > hash:"\351\221\344\334\247=\3701\212\2752\203\335G-i\263\341\336\216\306\302q\246\3169{\317M\026\225M"
```

```shell
$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/Gim2LFdZ3LgLeVweYddeCZ3Y8v4GpWKoSMqdFgFtPUZa \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: 2e555096-0d5f-4c54-a078-94dad0f996ee'
```
```
{
    "txReceiptRaw": {
        "txHash": "6ZHk3Kc9+DGKvTKD3UctabPh3o7GwnGmzjl7z00WlU0=",
        "gasUsage": "1000",
        "status": {
            "code": 4,
            "message": "out of gas"
        }
    },
    "hash": "0oQaO9LeRYkvoi7C8zQh0zw69q6e/6LcKGmTx2o1880="
}
```

通常はスマートコントラクトのためにバックエンドを配置して、スマートコントラクトを実行するようにすることができます。

```go
func SendBet(address, privKey string, luckyNumberInt int, betAmountInt int64, nonce int, time int64) ([]byte, error) {
	act := tx.NewAction(Contract, "bet", fmt.Sprintf(`["%v",%d,%d,%d]`, address, luckyNumberInt, betAmountInt, nonce))
	t := tx.NewTx([]*tx.Action{&act}, nil, 100000, 1, time)
	a, err := account.NewAccount(common.Base58Decode(privKey), crypto.Ed25519)
	if err != nil {
		return nil, err
	}

	t, err = tx.SignTx(t, a)
	if err != nil {
		return nil, err
	}

	b := RawTxReq{
		Data: t.Encode(),
	}
	j, err := json.Marshal(b)
	_, err = post(LocalIServer+"sendRawTx", j)
	if err != nil {
		return nil, err
	}

	return t.Hash(), nil
}
```

スマートコントラクトはトランザクションが成功したかどうか検証する必要があります。

```shell
$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/2RyZC2uuxw2Lxw1rYZSmzF4q48MNvtjt2SgcYnCWyt6Z \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: e71c0601-7e46-44f9-8923-7e60143507a6'
```
```
{
    "txReceiptRaw": {
        "txHash": "FUGSwzDpVjA2vFPXzFLdCWn4nXqpVO60KHg9v8cTFJ4=",
        "gasUsage": "1129",
        "status": {},
        "succActionNum": 1
    },
    "hash": "jTAqJxGQ/OUBfKs+PofxY5sxS7M9HFhhgnfUnUvWBWs="
}
```
