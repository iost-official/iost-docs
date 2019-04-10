---
id: VM
title: VM
sidebar_label: VM
---

Nous pensons qu'une bonne implémentation d'une machine virtuelle doit être à la fois élégante, facile à utiliser et sécurisée. Après avoir comparé les avantages et les inconvénients de EVM, EOS, C Lua et V8, nous avons réussi à construire la VM IOST basée sur le V8 en raison de ses hautes performances sur Chrome.

## 1. Structure et design de la V8VM IOST

VMManager est au cœur de V8VM. Il a trois fonctionnalités majeures :

![statedb](assets/2-intro-of-iost/VM/V8VM.png)
* <font color="#0092ff">VM Entrance. </font>Interface les requêtes externes d'autres modules, y compris les requêtes RPC, la validation de blocs, la validation de Tx, etc. Le travail est transmis à VMWorker après prétraitement et formatage.
* <font color="#0092ff">VMWorker lifecycle management. </font>Le nombre de workers est défini dynamiquement en fonction de la charge du système. Il permet la réutilisation des workers. Au sein des workers, le lancement à chaud de JavaScript et la persistance des snapshots des hotspot sandbox permettent de réduire la création fréquente de machines virtuelles et d'éviter une charge importante dans le CPU et la mémoire lorsque le même code est chargé. Ceci augmentera le débit du système, permettant au V8VM de respirer même lors du traitement de contrats avec une base d'utilisateurs massive, telle que fomo3D.
* <font color="#0092ff">Management de l'interface avec la base de données d'état. </font>Ceci assure l'atomicité de chaque transaction IOST, en refusant la transaction entière lorsqu'il y a une erreur de fonds insuffisants. En même temps, le cache à deux niveaux est réalisé dans la base de données d'état, avant d'être vidé vers RocksDB.

## 2. Core Design de le Sandbox

![statedb](assets/2-intro-of-iost/VM/sandbox.png)

En tant que charge utile de l'exécution de smart contract JavaScript, la Sandbox s'interface avec V8VM, et package pour les appels dans Chrome V8. Il y a deux étapes, Compiler et Exécuter.

### Etape de compilation

Principalement pour le développement et la publication de smart contracts, il a deux caractéristiques :

* <font color="#0092ff">Contract Pack. </font>打包智能合约，基于webpack实现，会打包当前合约项目下的所有JavaScript代码，并自动完成依赖安装，使IOST V8VM开发大型合约项目变成可能。同时IOST V8VM和Node.js的模块系统完全兼容，可以无缝使用require、module.exports和exports等方法，赋予合约开发者原生JavaScript开发体验。
* <font color="#0092ff">Contract Snapshot. </font>Avec la technologie de snapshot, la compilation augmente la performance de la création d'un isolat et des contextes - une anti-sérialisation du snapshot permettra d'obtenir le résultat en temps réel et d'augmenter considérablement la vitesse de chargement et d'exécution du JavaScript.

### Etape d'exécution

Principalement pour l'exécution des contrats sur chaîne, il a deux caractéristiques :

* <font color="#0092ff">LoadVM. </font>Achève l'initialisation de la VM, y compris la génération de l'objet Chrome V8, la définition des paramètres d'exécution du système, l'importation des bibliothèques de classes JavaScript pertinentes, etc. Certaines bibliothèques de classes JavaScript incluent :

| Class Library          | Fonctions   |
| --------     | -----  |
| Blockchain   | Système modulaire semablable à Node.js, incluant le caching de modules, la pré-compilation, cycle calls, etc.|
| Event        | Lecture/écriture de JavaScript avec la bibliothèque d'état, et rollback lorsque les contrats rencontrent des erreurs.|
| NativeModule | Fonctions liées à la blockchain, y compris le transfert, le retrait et l'obtention d'informations sur le bloc actuel et le Tx.|
| Storage      | Implémentation d'événements. Les événements internes des contrats JavaScript peuvent recevoir des rappels après la mise sur chaîne.|

* <font color="#0092ff">Exécution. </font>Exécute le contrat intelligent JavaScript. IOST V8VM exécutera le contrat sur un thread autonome, surveillera l'état de l'exécution, et `interrompra` l'exécution en cours lorsqu'il y a une erreur, une ressource insuffisante ou un délai d'attente, et retournera des résultats anormaux.
