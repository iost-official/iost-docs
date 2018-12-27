---
id: Deployment-and-invocation
title: 部署和调用
sidebar_label: 部署和调用
---

当我们编写了一个智能合约之后(js代码)， 我们需要将这个JS智能合约部署上链。

部署需要经过以下步骤:

- 编译js生成ABI文件
- 修改ABI文件
- 使用 .js 与 .abi 文件生成 transaction 的封装文件 .sc
- 发放 .sc 文件给各个签名人， 签名人生成 .sig 文件
- 收集 .sig 文件与 .sc 文件, publish 到主链上

### 编译js生成ABI文件
合约上链需要使用项目中的 iWallet 程序。 相信在前面的步骤中您已经编译了一个 iWallet 程序， 在 go-iost/target 文件夹下。
首先， 使用 iWallet 程序将 js 代码编译成相应的 ABI。

```bash
# Generate ABI for target js
./iwallet compile jsFilePath
```

这个会生成 .js.abi 文件和 .js.after 文件。
### 修改ABI文件
此时的.abi文件还需要进行手动修改。主要需要检查以下几项:

- 检查 abi 域不为 null
- 将.abi 中的 "abi" 数组中的每一项中 ```args``` 的值改为函数参数的正确类型

#### 例子
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "transfer",
            "args": [
                "string",
                "string",
                "int"
            ]
        }
    ]
}
```

### publish 到主链上
使用 ```.js``` 与 ```.abi``` 发布该合约到链上。

```bash
# publish a transaction with .sig file from every signer
./iwallet --server serverIP --account acountName --amount_limit amountLimit publish jsFilePath abiFilePath
# Example
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...

#Return
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh
```
