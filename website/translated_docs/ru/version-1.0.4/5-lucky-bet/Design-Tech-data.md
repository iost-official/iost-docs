---
id: version-1.0.4-Design-Tech-data
title: Смарт-контракт Удачная ставка (Lucky Bet)
sidebar_label: Смарт-контракт Удачная ставка (Lucky Bet)
original_id: Design-Tech-data
---

## Конструкция

Удачная ставка - игра в азартные игры, работающая на смарт-контракте IOST. Он был разработан, чтобы продемонстрировать кодирование и развертывание смарт-контракта.

Правила игры просты:

1. IOST аккаунты могут сделать удачную ставку между 1-5 IOST. Каждая ставка это число между 0-9.
2. Когда сделано 100 ставок, число раскрывается. Победители разделяют 95% всех ставок, а оставшиеся 5% берутся в качестве транзакционной комиссии.
3. Удачное число расчитывается как модуль 10 высоты блока. Если последний блок Удачного числа находится не на расстоянии не менее 16 блоков, мы требуем, чтобы родительский хеш блока имел 0, когда он был изменен на 16. В противном случае мы не раскрываем удачное число.

## Получение информации о блокчейне

С небольшим риском быть сфальсифицированным, использование информации о цепочке для генерации случайных чисел является самым простым способом. Удачная ставка генерирует случайное число таким образом:

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

Используя `BlockChain.blockInfo()`, мы можем получить подробную информацию о блокчейне и использовать ее в качестве источника псевдослучайных чисел.

## Данные состояния (Status Data): Управление и использование

Смарт-контракты могут хранить данные одним из двух способов:

```javascript
const maxUserNumber = 100;
```

Константы, определенные за пределами класса, доступны в текущем документе и не требуют дополнительных затрат на хранение.

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

Получая доступ к интерфейсам системы хранения, мы можем читать/записывать парные данные с ключом-значением(key-value). Обратите внимание, что значения поддерживают только тип String. Чтобы сохранить информацию о типе данных, нам необходимо обработать их в контракте. Это приведет к расходам на чтение и запись.

Доступ к хранилищу также можно получить извне:

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

В возвращаемых значениях, `s` является префиксом типа `String`. `66` это значение, которое мы пишем `put`. Последний результат (`result65`) сохраняется в строковой переменной. Получив доступ к хранилищу смарт-контракта, мы можем получить статус и результаты контракта для запуска и отображения бэкэнд.

## Использование смарт-контракта

Доступ к смарт-контракту можно получить напрямую через порт RPC:

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

Бэкэнд обычно настраивается на смарт-контракт для выполнения метода отправки смарт-контракта.

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

В смарт-контракте необходимо проверить правильность успешной транзакции.

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
