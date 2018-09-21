---
id: Database
title: Database
sidebar_label: Database
---

IOST数据库层的整体架构图如下所示：

![statedb](assets/2-intro-of-iost/Database/statedb.png)

最底层为Storage，提供最终的持久化存储。我们采用最简单的key-value数据库的形式，通过写不同数据库的backend可以实现不同数据库的接入。

为了更加符合区块链数据处理的模式，我们实现了一个MVCC的cache进行内存中多版本的并发处理与写缓存机制，这样可以提高性能与易用性。

最外层是Commit Manager，用来进行多版本数据的管理与维护，这样可以让上层切换数据库至任意版本，并当作普通数据库进行使用。
