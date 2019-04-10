---
id: IOST-Blockchain-API
title: IOST Blockchain API
sidebar_label: IOST Blockchain API
---

可以在contract 代码中访问下面的object。  
**注意: string不能超过65536字节**

## storage object

IOST提供 `storage` object 来帮助开发人员在智能contract 中保存数据。
没有 `global` 前缀的API用于处理本contract 的storage 。带有 `global` 前缀的API用于处理其他contract 。开发人员可以使用此类在多个contract 间传递数据。

这里列出了这个object的API,你也可以在[代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js)中找到详细信息。

### Contract Storage API

#### put(key,value,payer)

将一个key value对放入storage 中。

*  参数: 
*  key: string
*  value: string。
*  payer: string。定义谁将支付ram费。此参数是可选的。如果它是空的,contract 发布者将支付ram使用费。
*  返回: 无

#### get(key)

使用key从storage 中获得value

*  参数: 
*  key: string
*  返回: 如果存在,则返回value的string;如果不存在,则为"null"

#### has(key)

查找storage 中是否存在key。

* 参数: 
*  key: string
* 返回: bool(如果存在则为 true ,如果不存在则为 false)

#### del(key)

使用key从 storage 中删除key value对。

* 参数: 
*  key: string
* 返回: 无

#### mapPut(key,field,value,payer)

map 写入 (key, field, value)。之后可以使用key+field查找value。

* 参数: 
*  key: string
*  field: string
* value: string
* payer: string。类似于`put`的`payer`
* 返回: 无

#### mapGet(key,field)

map获取(key,field)对,使用key+field查找value
* 参数: 
*  key: string
*  field: string
* 返回: 如果存在,则返回value的string;如果不存在,则为"null"

#### mapHas(key,field)

map查找(key,field)对的存在,使用key+field进行查找。
* 参数: 
*  key: string
*  field: string
* 返回: bool(如果存在则为true,如果不存在则为false)

#### mapKeys(key)

map获取key内的field。   
**1. 最多返回256个field，超过的field虽然还存在，但是不会在这个函数中返回**   
**2. 如果调用过"mapDel", 那么之后的mapKeys可能会出错！如果合约中需要同时使用mapDel和mapKeys，那么建议所有field长度相同，这种情况下mapKeys不会出错**

* 参数: 
*  key: string
* 返回: array\[string\] (field数组)

#### mapLen(key)

返回 len(mapKeys())


* 参数: 
*  key: string
* 返回: int(field数)

#### mapDel(key,field)

map删除(key,field,value),使用key+field删除value。  
**mapDel可能使mapKeys返回不正确的结果,所以如果你需要调用mapDel，请不要依赖mapKeys**

* 参数: 
*  key: string
*  field: string
* 返回: 无

### Global Storage API
用于storage 其他contract 的API。

#### globalHas(contract, key)

查找key是否存在于全局storage 中。

* 参数: 
* contract : string
*  key: string
* 返回: bool(如果存在则为"true",如果不存在则为"false")

#### globalGet(contract, key)

使用key从全局storage 中获取value。

* 参数: 
* contract : string
*  key: string
* 返回: 如果存在则为value的string,如果不存在则返回"null"

#### globalMapHas(contract, key,field)

查找全局storage 中是否存在(key,field)对,使用key+field进行查找。

* 参数: 
* contract : string
*  key: string
*  field: string
* 返回: bool(如果存在则为true,如果不存在则为false)

#### globalMapGet(contract, key,field)

从全局storage 中获取(key,field)值,使用key+field进行查找。

* 参数: 
* contract : string
*  key: string
*  field: string
* 返回: 如果存在则为value的string,如果不存在则返回"null"

#### globalMapLen(contract, key)

map计数来自全局storage 的key内的field数。如果field数大于256,则此函数不承诺返回正确的结果,并且最多将返回256。

* 参数: 
* contract : string
*  key: string
* 返回: int(field数)

#### globalMapKeys(contract, key)

map从全局storage 中获取key中的field。如果field数大于256,则此函数不保证返回正确的结果,并且最多将返回256个结果。

* 参数: 
* contract : string
*  key: string
* 返回: array\[string\] (field数组)

## blockchain object

blockchain object提供系统调用的所有方法,并帮助用户调用官方API,包括但不限于转账,调用其他contract 以及查找块或交易。

以下是 blockchain object的API,你也可以在[代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js)中找到详细的实现。

#### transfer(from,to,amount,memo)

IOST转账

* 参数: 
* from: string
* to: string
* amount: string
* memo: string
* 返回: 无

#### withdraw(to,amount,memo)

撤回IOST

* 参数: 
* to: string
* amount: string
* memo: string
* 返回: 无

#### deposit(from,amount,memo)

存入IOST

* 参数: 
* from: string
* amount: string
* memo: string
* 返回: 无

#### blockInfo()

获取block信息。

* 参数: 无
* 返回: 块信息的JSONstring。与全局`block`object相同

#### txInfo()

获取交易信息。

* 参数: 无
* 返回: 交易信息的JSONstring。与全局`tx`object相同

#### contextInfo()

获取上下文信息。

* 参数: 无
* 返回: 上下文信息的JSONstring

例子: 

```js
{
	"abi_name":"contextinfo",
	"contract_name":"ContractHYtPky2PHTAgweBw262jBZcj241ejUqweS7rcfQibn5t",
	"publisher":"admin"
}
```

#### contractName()

获取contract 名称。

* 参数: 无
* 返回: contract 名称的string

#### publisher()

获得发布者。

* 参数: 无
* 返回: tx发布者的string

#### contractOwner()

获得contract 所有者。

* 参数: 无
* 返回: contract 发布者的string


#### call(contract,api,args)

使用args调用contract 的api。

* 参数: 
* contract : string
*  api: string
*  args: JSONstring
* 返回: string

#### callWithAuth(contract, api, args)

使用具有tx发布者权限的args调用contract 的api。

* 参数: 
* contract : string
* api: string
* args: JSONstring
* 返回: string

例子: 

```js
// 让 tx publisher 将 20 IOST transfer 到 contract 发布者
blockchain.callWithAuth("token.iost","transfer",["iost",tx.publisher,blockchain.contractOwner(),"20",""]);
```

#### requireAuth(pubKey, permission)

查找帐户的权限。

* 参数: 
* pubKey: string
* permission: string
* 返回: bool(如果帐户有权限,则为true,如果帐户没有,则为false)

#### receipt(data)

生成receipt。

* 参数: 
* data: string
* 返回: 无

#### event(content)

生成event

* 参数: 
* content: string
* 返回: 无

## tx object 和 block object
tx object包含当前的交易信息。例子: 

```js
{
	time: 1541541540000000000,
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000,
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn":2},
	publisher: "user0"
}
```  

block object显示当前块信息。例子: 

```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn",
	time: 1541541540000000000
}
```

您也可以在[代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29)找到详细信息。

## IOSTCrypto object

源代码[位置](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/crypto.go)

#### sha3(data)
计算sha3-256哈希value。


* 参数: 
* data: string
* 返回: base58\_encode(sha3\_256(data))

##### 示例

```js
IOSTCrypto.sha3("Fule will be expensive. Everyone will have a small car.") // result: EBNarfcGkAczpeiSJwtUfH9FEVd1xFhdZis83erU9WNu
```

#### verify(algo, message, signature, pubkey)
签名验证

* 参数: 
* algo: 使用的算法,可以是'ed25519'或'secp256k1'之一
* message: **base58编码的**原始文本
* signature: **base58编码的**签名
* pubkey: **base58编码的**用于签名的私钥对应的公钥
* 返回: 1(成功)或0(失败)

```js
// StV1D.. 是base58编码的"hello world"
// 2vSjK.. 是私钥'4PTQW2hvwZoyuMdgKbo3iQ9mM7DTzxSV54RpeJyycD9b1R1oGgYT9hKoPpAGiLrhYA8sLQ3sAVFoNuMXRsUH7zw6'的pubkey的base58编码
// 38V8b.. 是base58编码的签名
IOSTCrypto.verify("ed25519", "StV1DL6CwTryKyV", "38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN", "2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi")//结果: 1
```

## Float64和Int64类

提供`Float64`和`Int64`类来进行高精度计算。  
Float64 API [见代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/float64.js) 和 Int64 API [见代码](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/int64.js)

## 禁用的Javascript函数
出于安全原因,禁止使用Javascript的某些功能。   
[文档](6-reference/GasChargeTable.md) 给出了允许和禁止的API列表。