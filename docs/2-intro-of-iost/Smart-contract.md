---
id: Smart-contract
title: Smart contract
sidebar_label: Smart contract
---

# IOST 智能合约

智能合约接收并执行区块中的Transaction，从而维护区块链的中的状态，产生不可逆的证明。IOST实现了通用ABI接口，
可插拔的多语言支持，并且可以生成得到共识的执行结果。有效地提升了区块链的易用性。

## ABI接口
IOST智能合约通过ABI接口与区块链进行交互。

ABI通过json定义了智能合约接口的详细信息，包括ABI名字，参数类型列表等。ABI的参数类型可以支持JSON的基本类型：
```string, number, bool```，更复杂的数据结构可以通过编解码为string的方式传递。智能合约的调用当中必须要
严格匹配ABI参数类型，否则将会执行失败，并且扣除一部分手续费。

```json
// example luckybet.js.abi
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "bet",
            "args": [
                "string",
                "number",
                "number",
                "number"
            ]
        }
    ]
}
```

每个trasaction包含若干个事务性的action，每个action即为一个ABI调用。所有transaction在链上都会产生一个严格的顺序，
由此可以避免双花问题。

```golang
type Action struct {
	Contract   string  
	ActionName string 
	Data       string  // A JSON Array of args
}
```
在智能合约当中也可以通过```BlockChain.call()```接口来调用ABI接口，并且可以得到ABI的返回值。系统会记录调用栈并且阻止重入，从而防止攻击。

## 多语言的支持
IOST实现了多编程语言的智能合约，目前开放给开发者的是v8引擎下的JavaScript，另有golang原生模块支持的native VM用以处理需要高性能的
转账等交易。

IOST智能合约引擎分三个部分：monitor，VM，host。其中，monitor是全局的控制单元，路由ABI调用到正确的VM当中，VM则是智能合约虚拟机的实现，
而host则对智能合约的运行环境进行了封装，以确保智能合约在正确的上下文中运行。

## 智能合约的权限系统
Transaction支持多重签名，在智能合约当中可以通过```RequireAuth()```接口检查当前上下文是否拥有某个ID的签名。智能合约的相互调用会传递
签名权限，如果A.a调用了B.b，用户1调用了A.a，那么B.b也会得到用户1的授权。

智能合约还可以检查调用栈，从而得到“是谁调用了此ABI”的信息，从而进行一些操作。

## 智能合约的运行结果

智能合约在执行完毕之后，会生成TxReceipt加入到区块中，并且得到区块链的共识。可以通过RPC找到已上线Transaction的TxReceipt。

```sh
$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/G62UQbq9u8MP8cNLD9HUpMFtstTvRUAJ4avzKiAJc86f \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: 2442fe9c-0c80-4459-a9e6-0001bbde3dbb'l
{
    "txReceiptRaw": {
        "txHash": "4CjfeOvtjmhdZep9WG5pPoEoLPu90avQkbGKefTKNaw=",
        "gasUsage": "1129",
        "status": {},
        "succActionNum": 1
    },
    "hash": "eU9xHGM15gfDInAG7Y8q3RB9mMm1Pekmj4RUUHWFkqU="
}

```















