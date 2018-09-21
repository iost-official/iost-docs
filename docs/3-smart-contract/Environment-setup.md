---
id: Environment-setup
title: Environment setup
sidebar_label: Environment setup
---

当前 IOST 的智能合约编写仍旧依赖于 [Go-IOS-Protocol](https://github.com/iost-official/Go-IOS-Protocol) 

IOST 将在未来的开发中把智能合约编写与 [Go-IOS-Protocol](https://github.com/iost-official/Go-IOS-Protocol) 进行分离， 未来版本中智能合约的编写将不再依赖于 [Go-IOS-Protocol](https://github.com/iost-official/Go-IOS-Protocol) 。

开发者需要首先克隆整个分支

```git
git clone https://github.com/iost-official/Go-IOS-Protocol.git
```

然后需要在 ```Go-IOS-Protocol/cmd/playground/contract``` 下安装 ```node```与```npm```

### 安装 ```Node```

参考 [官方文档](https://nodejs.org/zh-cn/download/package-manager/#macos)

### 安装```npm```

```git
cd Go-IOS-Protocol/cmd/playground/contract
npm install
```