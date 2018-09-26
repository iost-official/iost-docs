---
id: Deployment-and-invocation
title: 部署和调用
sidebar_label: 部署和调用
---

当我们编写了一个智能合约之后(js代码)， 我们需要将这个JS智能合约部署上链。

部署需要经过以下步骤:
- 编译js生成ABI文件
- 使用 .js 与 .abi 文件生成 transaction 的封装文件 .sc
- 发放 .sc 文件给各个签名人， 签名人生成 .sig 文件
- 收集 .sig 文件与 .sc 文件, publish 到主链上

合约上链需要使用项目中的 iWallet 程序。 相信在前面的步骤中您已经编译了一个 iWallet 程序， 在 Go-IOS-Protocol/target 文件夹下。
首先， 使用 iWallet 程序将 js 代码编译成相应的 ABI。

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

这个会生成 .js.abi 文件和 .js.after 文件。
然后使用 js 和 js.abi 文件， 生成交易对应的 .sc 文件。

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signer "ID0, ID1..."
# Example
./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
```

然后将生成的 .sc 文件发给对应的signer进行签名, 生成 .sig 文件 。
签名方法

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

最后使用 Transaction 的 .sc 文件， 和所有的签名文件 .sig， 发布该合约到链上。

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.iwallet/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
