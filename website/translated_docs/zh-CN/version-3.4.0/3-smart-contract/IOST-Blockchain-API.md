---
id: IOST-Blockchain-API
title: IOST Blockchain API
sidebar_label: IOST Blockchain API
---

可以在合约代码中直接使用下面的 object。  

## storage object

`storage` object 来帮助开发人员在智能合约中存储数据。
没有 `global` 前缀的 API 用于读写本合约的 storage。带有 `global` 前缀的API 用于读取其他合约的 storage。开发人员可以使用此类在多个合约间传递数据。

### Storage API

#### put(key, value, payer=contractOwner)

将一个 key-value 对放入 storage 中。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string | 不能超过 65536 字节 |
| value | string | 不能超过 65536 字节|
| payer | string(optional) | 定义谁将支付 ram 费。此参数是可选的。如果它为空, 合约发布者将支付 ram 使用费。|

返回值：无。

例子: 

```js
// 向 storage 中插入一对 k-v，并从合约发布者账户扣除相应的 ram 费用
storage.put("test-key", "test-value");
	
// 向 storage 中插入一对 k-v，并从本交易的发布者账户扣除相应的 ram 费用
storage.put("test-key", "test-value", tx.publisher);
```

#### get(key)

使用 key 从 storage 中获得 value

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string | |

返回值：如果存在, 则返回 string 类型的 value；如果不存在，则为 null。

例子: 

```js
let v = storage.get("test-key");
if (v !== null) {
	...
}
```


#### has(key)

查找 storage 中是否存在 key。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string | |

返回值：bool 类型，key 存在则为 true，不存在则为 false。

例子: 

```js
if (storage.has("test-key")) {
	...
}
```

#### del(key)

从 storage 中删除 key-value 对，并返还相应 ram 给先前 ram 支付者。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string | |

返回值：无。

例子: 

```js
storage.del("test-key")
```

#### mapPut(key, field, value, payer=contractOwner)

向 storage 写入(key, field, value)。之后可以使用 key+field 查找 value。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string | 不能超过 65536 字节 |
| field | string | 不能超过 65536 字节 |
| value | string | 不能超过 65536 字节|
| payer | string(optional) | 定义谁将支付 ram 费。此参数是可选的。如果它为空, 合约发布者将支付 ram 使用费。|

返回值：无。

例子: 

```js
// 向 storage 中插入 key-field-value，并从合约发布者账户扣除相应的 ram 费用
storage.mapPut("test-key", "test-field", "test-value");
	
// 向 storage 中插入 key-field-value，并从本交易的发布者账户扣除相应的 ram 费用
storage.mapPut("test-key", "test-field", "test-value", tx.publisher);
```

#### mapGet(key, field)

使用 key+field 从 storage 读取 value。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string ||
| field | string ||

返回值：如果存在, 则返回 string 类型的 value；如果不存在，则为 null。

例子: 

```js
let v = storage.mapGet("test-key", "test-field");
if (v !== null) {
	...
}
```



#### mapHas(key, field)

从 storage 中查找 key+field 是否存在。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string ||
| field | string ||

返回值：bool 类型，key 存在则为 true，不存在则为 false。

例子: 

```js
if (storage.mapHas("test-key", "test-field")) {
	...
}
```

#### mapKeys(key)

从 storage 获取 key 内的 field。  

注意事项：  
**1. 本接口最多保存 256 个 field，超出的 field 不会保存，更不会在这个函数中返回**    
**2. 如果开发者需要获取一个 map 的所有 fields，建议自己维护 field 列表，不建议使用此接口**

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string ||

返回值：array\[string\]

#### mapLen(key)

返回 storage 中某个 key 内的 field 数量。

**注意事项同 [mapKeys](#mapkeyskey)。**


| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string ||

返回值：int

#### mapDel(key, field)

使用 key+field 从 storage 中删除 value，并返还相应 ram 给先前 ram 支付者。


| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| key | string ||
| field | string ||

* 返回: 无

### Global Storage API
用于读取其他合约的数据。

#### globalHas(contract, key)

查找 key 是否存在于给定的 contract 的 storage 中。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| key | string ||

返回值：bool 类型，key 存在则为 true，不存在则为 false。

例子: 

```js
if (storage.globalHas("Contractxxxxxx", "test-key")) {
	...
}
```


#### globalGet(contract, key)

从给定的 contract 的 storage 中根据 key 读取 value。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| key | string ||

返回值：如果存在, 则返回 string 类型的 value；如果不存在，则为 null。

例子: 

```js
let v = storage.globalGet("Contractxxxxxx", "test-key");
if (v !== null) {
	...
}
```

#### globalMapHas(contract, key, field)

查找 key+field 是否存在于给定的 contract 的 storage 中。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| key | string ||
| field | string ||

返回值：bool 类型，key 存在则为 true，不存在则为 false。

例子: 

```js
// 通过读 auth.iost 合约存储判断某个账户是否存在
accountExists(account) {
    return storage.globalMapHas("auth.iost", "auth", account);
}
```


#### globalMapGet(contract, key,field)

从给定的 contract 的 storage 中根据 key+field 读取 value。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| key | string ||
| field | string ||

返回值：如果存在, 则返回 string 类型的 value；如果不存在，则为 null。

例子: 

```js
let v = storage.globalMapGet("Contractxxxxxx", "test-key", "test-field");
if (v !== null) {
	...
}
```

#### globalMapLen(contract, key)

返回给定 contract 的 storage 中某个 key 内的 field 数量。

**注意事项同 [mapKeys](#mapkeyskey)。**

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| key | string ||

返回值：int

#### globalMapKeys(contract, key)

从给定 contract 的 storage 获取 key 内的 field。  

**注意事项同 [mapKeys](#mapkeyskey)。**

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| key | string ||

返回值：array\[string\]

## blockchain object

blockchain object 用于进行系统调用，并提供跨合约调用接口。

#### transfer(from, to, amount, memo)

转移 iost

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| from | string | 转出方 |
| to | string | 接收方 |
| amount | string | 金额 |
| memo | string | 附加信息 |

返回值：无

例子: 

```js
// 从交易发起者转 1.23 个 iost 到 testacc 这个账户
blockchain.transfer(tx.publisher, "testacc", "1.23", "this is memo")
```

#### withdraw(to, amount, memo)

从合约转出 iost，等价于:

```blockchain.transfer(blockchain.contractName(), to, amount, memo)```

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| to | string | 接收方 |
| amount | string | 金额 |
| memo | string | 附加信息 |

返回值：无

例子: 

```js
// 从合约转 1.23 个 iost 到交易发起者
blockchain.withdraw(tx.publisher, "1.23", "this is memo")
```


#### deposit(from, amount, memo)

转入 iost 到合约，等价于:

```blockchain.transfer(from, blockchain.contractName(), amount, memo)```


| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| from | string | 转出方 |
| amount | string | 金额 |
| memo | string | 附加信息 |

返回值：无

例子: 

```js
// 从交易发起者转 1.23 个 iost 到合约
blockchain.deposit(tx.publisher, "1.23", "this is memo")
```

#### contractName()

获取 contract id。

参数：无

返回值：合约的 id，string 类型。

#### publisher()

获取交易的发布者。

参数：无

返回值：交易发布者的账户名，string 类型。

#### contractOwner()

获得合约所有者。

参数：无

返回值：合约所有者的账户名，string 类型。


#### call(contract, abi, args)

调用指定合约的某个方法。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| abi | string | 合约方法名 |
| args | array 或 string | 合约参数的 array，或者其 JSON 序列化后的字符串 |

返回值：包含一个 string 的 array，string 为被调合约返回值 JSON 序列化后的结果。

例子: 

```js
// 调用 token.iost 合约的 balanceOf 方法获取 admin 账户的 iost 余额
let ret = blockchain.call("token.iost", "balanceOf", ["iost", "admin"])
console.log(ret[0]) // 注意 ret[0] 才是目标合约的返回值

// 调用 vote.iost 合约的 getResult 方法获取某个投票的结果
let ret = blockchain.call("vote.iost", "getResult", ["1"])
let voteRes = JSON.parse(ret[0]) // vote.iost 合约返回的是一个 array，所以此处需要 json 反序列化后才能拿到返回的 array
```


#### callWithAuth(contract, abi, args)

带着当前合约的权限调用指定合约的某个方法。

注意事项：  
**请谨慎使用 callWithAuth 调用他人合约，因为被调合约将有权限转走你合约中的 token。**   

参数: 

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| contract | string | 合约 id |
| abi | string | 合约方法名 |
| args | array 或 string | 合约参数的 array，或者其 JSON 序列化后的字符串 |

返回值：包含一个 string 的 array，string 为被调合约返回值 JSON 序列化后的结果。


例子: 

```js
// 从本合约将 20 iost transfer 到 testacc 这个账户
blockchain.callWithAuth("token.iost", "transfer", ["iost", blockchain.contractName(), "testacc", "20", ""]);

// 使用 call 调用上述操作则会报错，因为从本合约转移 token 需要本合约的权限
blockchain.call("token.iost", "transfer", ["iost", blockchain.contractName(), "testacc", "20", ""]); // throw error
```

#### requireAuth(account, permission)

检查本次调用是否包含指定账户的指定权限。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| account | string | 账户名 |
| permission | string | 权限名 |

返回值：bool 类型，如果有权限，则为 true，如果没有权限，则为 false。

例子: 

```js
// 检查本次调用是否包含 testacc 这个账户的 active 权限
// 也就是说，当前交易是否包含 testacc 这个账户的 active key 的签名
const ret = blockchain.requireAuth('testacc', 'active');
if (ret !== true) {
    throw new Error("require auth failed");
}
```

#### receipt(data)

生成 receipt。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| data | string ||

返回值：无

例子: 

```js
testReceipt() {
    blockchain.receipt("some receipt content")
}
```

调用 testReceipt 接口后，会在 TxReceipt 中包含这样的值：

```
"receipts": [
    {
        "funcName": "Contractxxxxx/testReceipt",
        "content": "some receipt content"
    }
]
```

#### event(data)

生成 event。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| data | string ||

返回值：无

例子: 

```js
testEvent() {
    blockchain.event("some event content")
}
```

调用 testEvent 接口后，会生成一个 event。通过调用 [subscribe](6-reference/API.md#subscribe) 接口能接收到该 event：

```
curl -X POST http://127.0.0.1:30001/subscribe -d '{"topics":["CONTRACT_EVENT"], "filter":{"contract_id":"Contractxxxxx"}}'

{"result":{"event":{"topic":"CONTRACT_EVENT","data":"some event content","time":"1557150634515314000"}}}

```

## tx object and block object
tx object 包含当前的交易信息，对象属性有：

```js
{
	time: 1541541540000000000, // 单位为纳秒
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000, // 单位为纳秒
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"Gcv8c2tH8qZrUYnKdEEdTtASsxivic2834MQW6mgxqto":2},
	publisher: "admin"
}
```  

例子: 

```js
console.log(tx.publisher)
```

block object 包含当前块信息，对象属性有：

```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b",
	time: 1541541540000000000 // 单位为纳秒
}
```

例子: 

```js
console.log(block.parent_hash)
```


## IOSTCrypto object

IOSTCrypto 提供哈希方法，和签名验证方法。

#### sha3(data)
计算 sha3-256 哈希值。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| data | string ||

返回值：哈希字节数组结果经过 base58 编码后的字符串。

##### 示例

```js
IOSTCrypto.sha3("Fule will be expensive. Everyone will have a small car.") // result: EBNarfcGkAczpeiSJwtUfH9FEVd1xFhdZis83erU9WNu
```

#### verify(algo, message, signature, pubkey)
签名验证，支持 ed25519 和 secp256k1 两种算法。

| 参数列表 | 参数类型 |备注 |
| :----: | :------ |:------ |
| algo | string | 只能是 "ed25519" 或 "secp256k1" |
| message | string | 原始数据经过 base58 编码后的字符串 |
| signature | string | 签名字节数组经过 base58 编码后的字符串 |
| pubkey | string | 公钥字节数组经过 base58 编码后的字符串 |

返回值：int 类型，1 为成功，0 为失败。

例子：

```js
// 签名算法选择 ed25519
// 私钥经过 base58 编码后是 "4PTQW2hvwZoyuMdgKbo3iQ9mM7DTzxSV54RpeJyycD9b1R1oGgYT9hKoPpAGiLrhYA8sLQ3sAVFoNuMXRsUH7zw6"
// 公钥经过 base58 编码后是 "2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi"
// 要签名的内容为 "hello world"
// "StV1DL6CwTryKyV" 是 "hello world" base58 编码后的结果
// "38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN" 为上述私钥对上述内容签名后，再经过 base58 编码后的结果
// 所以用公钥验证上述签名的结果应为 1
let v = IOSTCrypto.verify("ed25519", "StV1DL6CwTryKyV", "38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN", "2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi"); // v = 1
```

## Float64, Int64 and BigNumber object

在合约中，可以使用 `Float64`，`Int64`和 `BigNumber` 类来进行高精度计算。  
Float64 API [见代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/float64.js)。  
Int64 API [见代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/int64.js)。  
 BigNumber API [见代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/bignumber.js)。
 
例子：

```js
let bonus = new Float64("1.0123456789");
let earning = bonus.div(2).toFixed(8); // earning is "0.50617283"
blockchain.withdraw("testacc", earning, "");
```

## 禁用的Javascript函数
出于安全原因，我们禁用了 Javascript 的某些功能。   
这篇 [文档](6-reference/GasChargeTable.md) 给出了允许和禁止的 API 列表。