---
id: version-1.0.4-Design-Tech-data
title: Design & Tech data
sidebar_label: Design & Tech data
original_id: Design-Tech-data
---

# Lucky Bet 智能合约

## 设计
Lucky Bet是一个通过iost智能合约实现的博彩小游戏，用以展示iost testnet下智能合约的编写和部署。

规则如下

1. iost账户可以自由投注lucky bet，投注额为1~5iost，可以投注0~9；
2. 当投注人数到达100时开奖，中奖者根据投注额得到这一轮所有投注的95%的奖励，剩余5%将会作为手续费收走
3. 中奖号码为开奖时block高度取模10，如果上一次开奖的block与这一次的距离小于16个block，则要求这次
block的parent hash取模16为0，不合格则不开奖

## 获取链上信息
虽然有被人操纵的可能性，但获取链上信息作为随机数源依然是目前最方便，并且有足够有效性的做法。luckybet
智能合约采取了链上的信息来生成中奖号码：
```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```
通过```BlockChain.blockInfo()```，我们可以获得区块链的详细信息，也可以将其作为一个不准确的随机数源来使用

## 状态数据的管理和存储
智能合约可以用两种方法存储数据：
```javascript
const maxUserNumber = 100;
```
定义在class外的常数可以被当前文件访问到，并且不需要支付额外的存储开销。
```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```
调用storage系列接口，可以存取kv数据，注意value目前只能使用string来存储，为了保持数据类型的信息，需要在智能合约内进行处理。

同时，也需要支付存取的费用。

智能合约的存储可以被从外部访问到：
```shell
$ curl -X GET \
  http://<nodeIP>:30001/getState/<ContractID>-round \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: f4f7c10c-d1fe-46ff-8962-a099490acc4c'
{"value":"s66"}%

$ curl -X GET \
  http://<nodeIP>:30001/getState/<ContractID>-result65 \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: b9339214-4b6a-4044-9925-43d72cf74fe3'
{"value":"s{\"number\":18627,\"user_number\":99,\"k_number\":8,\"total_coins\":{\"number\"......
```
返回值value中s是类型string的前缀，66即put写入时的值，而上一次开奖结果（result65）则以JSON字符串的形式存储。
通过访问智能合约的存储，就可以得到智能合约的运行状态和运行结果，以便后端的运行和展示。

## 智能合约的使用
智能合约可以通过iost区块链RPC接口直接访问：
```shell
# via iwallet
$ iwallet call --expiration 90000 <ContractID> bet \
'["<iostID>", 1, 100000000, 1551040]' -s <nodeIP>:30002 -k <seckeyFile> 
you don't indicate any signers,so this tx will be sent to the iostNode directly
ok
45ENdx81jarkgEDggKikQpPECyzcUhMmDU5BtnnEV6RK

$ target/iwallet transaction -s 52.192.65.220:30002 Gim2LFdZ3LgLeVweYddeCZ3Y8v4GpWKoSMqdFgFtPUZa # 检查调用是否上链
txRaw:<time:1537520778569798474 expiration:1537610778569798095 gasLimit:1000 gasPrice:1 actions:<contract:"ContractAC5V12562T7XB74A8gBe3cjfwWDbJheLWjzyY8VL6JPK" actionName:"bet" data:"[\"IOST2g5LzaXkjAwpxCnCm29HK69wdbyRKbfG4BQQT7Yuqk57bgTFkY\", 1, 100000000, 1551040]" > publisher:<algorithm:2 sig:"\210\tb\026\300\326\254&\002\230\027o\223\\h\345\367\210\361\0034\232\351+F1\274r6\332\226\242?\001\303\215Dz~\252Q\031i\035\227\223\236`\r\013\211\205p\306\373u\215\254\035a\222\336\327\r" pubKey:"\334k\242\372\010Mpu\334\274\333i\335\002!\222\212j\223\3317Z\360\362\3158\003\2056y}j" > > hash:"\351\221\344\334\247=\3701\212\2752\203\335G-i\263\341\336\216\306\302q\246\3169{\317M\026\225M" 

$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/Gim2LFdZ3LgLeVweYddeCZ3Y8v4GpWKoSMqdFgFtPUZa \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: 2e555096-0d5f-4c54-a078-94dad0f996ee'
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
通常会为智能合约配置一个后端来执行发送智能合约的方法
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
智能合约需要通过TxReceipt检查是否成功交易
```shell
$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/2RyZC2uuxw2Lxw1rYZSmzF4q48MNvtjt2SgcYnCWyt6Z \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: e71c0601-7e46-44f9-8923-7e60143507a6'
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



