---
id: Database
title: Database
sidebar_label: Database
---

The database layer of IOST is structured as below:

![statedb](assets/2-intro-of-iost/Database/statedb.png)

The lowest level is Storage, which provides final persistence of data. We adopt the simplest key-value database form factor, and achieve access to different databases by writing to different database backends.

Due to the paradigm of data handling on the blockchain, we use MVCC cache to process requests and cache them concurrently in memory. This improves usability and performance.

The out-most layer is Commit Manager, which handles the management and maintenance of multi-version data. Higher layers, therefore, can treat the interface as a typical database and switch to any version at will.
