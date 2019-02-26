---
id: version-3.0.0-VM
title: VM
sidebar_label: VM
original_id: VM
---

We believe a good implementation of virtual machine needs to be both elegantly designed, easy to use, and secure. After comparing the pros and cons of EVM, EOS, C Lua and V8, we have fundamentally resolved unreasonable designs of EVM and EOS. We have managed to build the IOST VM based on V8 due to on the its high performance on Chrome.

## 1. IOST V8VM structure and designs

VMManager is at the core of V8VM. It has three main features:

![statedb](assets/2-intro-of-iost/VM/V8VM.png)
* <font color="#0092ff">VM Entrance. </font>It interfaces external requests from other modules, including RPC requests, block validation, Tx validation, etc. The work is handed off to VMWorker after preprocessing and formatting.
* <font color="#0092ff">VMWorker lifecycle management. </font>The number of workers are set dynamically based on system load. It achieves reuse of workers. Within the workers, JavaScript hot launch and persistence of hotspot Sandbox snapshots help reduce frequent creation of VMs, and avoid heavy load in CPU and memory when the same code is loaded. This will increase the throughput of the system, allowing the IOST V8VM to breathe even when processing contracts with a massive user base, such as fomo3D.
* <font color="#0092ff">Management of interface with State database. </font>This ensures atomicity of each IOST transaction, denying the entire transaction when there is an error of insufficient funds. At the same time, two-level cache is achieved in the State database, before being flushed to RocksDB.

## 2. Sandbox core design

![statedb](assets/2-intro-of-iost/VM/sandbox.png)

As the payload of JavaScript smart contract execution, Sandbox interfaces with V8VM, and packs for calling in Chrome V8. There are two stages, Compile and Execution.

### Compile Stage

Mainly for smart contract development and publishing, it has two features:

* <font color="#0092ff">Contract Pack. </font>Pack smart contracts using webpack. It will pack all javascript source codes in the project and install all dependencies, making IOST V8VM easy to develop large projects. Besides, IOST V8VM shares almost all features of Node.js, so developers will feel familiar.
* <font color="#0092ff">Contract Snapshot. </font>With the snapshot technology, compilation increases the performance of creating an isolate and contexts — an anti-serialization of the snapshot will achieve the result in runtime, and tremendously increase loading and execution speed of JavaScript.

### Execute Stage

Mainly for execution of on-chain contracts, it has two features, too:

* <font color="#0092ff">LoadVM. </font>Completes initialization of VM, including the generation of Chrome V8 object, setting system execution parameters, importing relevant JavaScript class libraries, etc. Some JavaScript class libraries include:

| Class Library          | Features   |
| --------     | -----  |
| Blockchain   | Node.js-like modular system, including module caching, pre-compilation, cycle calls, etc.|
| Event        | Read/write of JavaScript with State Library, and rollback when contracts encounter errors.|
| NativeModule | Blockchain-related functions including transfer, withdraw and obtaining information on current block and Tx.|
| Storage      | Implementation of events. JavaScript contracts internal events can receive callbacks after going on-chain.|

* <font color="#0092ff">Execute. </font>Finally executes JavaScript smart contract. IOST V8VM will run the contract on a standalone thread, monitor the status of the run, and will `Terminate` the current run when there is an error, insufficient resource, or timeout, and return abnormal results.
