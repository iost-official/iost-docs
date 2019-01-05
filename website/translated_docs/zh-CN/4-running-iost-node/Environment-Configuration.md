---
id: Environment-Configuration
title: 环境与设置
sidebar_label: 环境与设置
---

## 准备条件

* Go 1.9 及以上（推荐Go 1.11）
* Git LFS（推荐2.5.2）
* Docker CE 18.06 及以上（低版本未测试）

## 运行环境

目前支持如下环境进行开发与部署：

* [Mac OS X](#mac-os-x)
* [Ubuntu](#ubuntu-linux)
* [CentOS](#docker)

## 编译

- 安装所有依赖。请参考对应的官方文档。

- 安装 Git LFS 插件。只需要运行一次。

```
git lfs install
```

- 获取仓库。

```
git clone https://github.com/iost-official/go-iost && cd go-iost
```

- 编译。

```
make
```

- 运行。

```
target/iserver -f config/iserver.yml

target/iwallet -h
```
