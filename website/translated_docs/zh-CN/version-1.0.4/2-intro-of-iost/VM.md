---
id: VM
title: VM
sidebar_label: VM
---

我们认为一个良好的虚拟机实现必须在做到架构设计优雅的同时满足易用性和安全性的需求，在经过对比参考EVM、EOS、C Lua、V8等相关虚拟机的优缺点之后，我们从根源上解决了很多EVM和EOS不合理性设计与问题，并且基于V8在NodeJs和Chrome上的优异表现，最终构建了基于V8的IOST虚拟机。

## 1. IOST V8VM架构与设计

V8VM架构的核心是VMManger，主要有如下三个功能：

![statedb](assets/2-intro-of-iost/VM/V8VM.png)
* <font color="#0092ff">VM入口，</font>对外接收其他模块的请求，包括RPC请求、Block验证、Tx验证等等，预处理、格式化后交给VMWorker执行。
* <font color="#0092ff">管理VMWorker生命周期，</font>根据当前系统负载灵活设置worker数量，实现worker复用；同时在worker内部实现了JavaScript代码热启动、热点Sandbox快照持久化功能，减少了频繁创建虚拟机、频繁载入相同代码引发的高负载、内存飙升问题，降低系统消耗的同时，又极大的提高了系统吞吐量，使得IOST V8VM在处理fomo3D这种典型的海量用户合约时游刃有余。
* <font color="#0092ff">管理与State数据库的交互，</font>保证每一笔IOST交易的原子性，在合约执行出错，或者gas不足的情况下，能够回退整个交易。同时在State数据库中，也是实现了两级内存缓存，最终才会flush到RocksDB中。

## 2. Sandbox核心设计

![statedb](assets/2-intro-of-iost/VM/sandbox.png)

Sandbox作为最终执行JavaScript智能合约的载体，对上承接V8VM，对下封装Chrome V8完成调用，主要分为Compile阶段和Execute阶段：

### Compile阶段

主要面向合约开发和上链，有如下两个主要功能：

* <font color="#0092ff">Contract Pack，</font>打包智能合约，基于webpack实现，会打包当前合约项目下的所有JavaScript代码，并自动完成依赖安装，使IOST V8VM开发大型合约项目变成可能。同时IOST V8VM和Node.js的模块系统完全兼容，可以无缝使用require、module.exports和exports等方法，赋予合约开发者原生JavaScript开发体验。

* <font color="#0092ff">Contract Snapshot, </font>借助v8的snapshot快照技术，完成对JavaScript代码的编译，编译后的代码提升了Chrome V8创建isolate和contexts的效率，真正执行时只需要反序列化快照就可以完成执行， 极大的提高了JavaScript的载入速度和执行速度。

### Execute阶段

主要面向链上合约真正执行，有如下两个主要功能：

* <font color="#0092ff">LoadVM，</font>
完成VM初始化，包括生成Chrome V8对象、 设置系统执行参数、导入相关JavaScript类库等等，完成智能合约执行之前的所有准备工作。部分JavaScript类库如下：

| 类库          | 功能   |
| --------     | -----  |
| Blockchain   | 类Node.js的模块系统，包括模块缓存、模块预编译、模块循环调用等等。 |
| Event        | 事件实现，JavaScript合约内部对event的调用在完成上链后都可以得到回调。 |
| NativeModule | 区块链相关功能函数实现，包括transfer、withdraw以及获取当前block、当前tx信息。    |
| Storage      | JavaScript对State数据库的读写，并在合约执行失败或者出现异常的时候完成回退。    |

* <font color="#0092ff">Execute，</font>
最终执行JavaScript智能合约，IOST V8VM会开辟单独的线程执行合约，并监控当前执行状态，当发生异常、使用资源超过限制、执行时间超过最大限制时，会调用Terminate结束当前合约执行，返回异常结果。
