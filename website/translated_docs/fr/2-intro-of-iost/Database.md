---
id: Database
title: Base de Données
sidebar_label: Base de Données
---

La couche de base de données d'IOST est structurée comme suit :

![statedb](assets/2-intro-of-iost/Database/statedb.png)

Le niveau le plus bas est le stockage, qui assure la persistance finale des données. Nous adoptons le facteur de forme de base de données de valeur clé le plus simple, et nous obtenons l'accès à différentes bases de données en écrivant à différents backends.

En raison du paradigme du traitement des données sur la blockchain, nous utilisons le cache MVCC pour traiter les requêtes et les mettre en cache simultanément en mémoire. Cela améliore l'utilisabilité et les performances.

La couche la plus éloignée est Commit Manager, qui gère la gestion et la maintenance des données multi-versions. Les couches supérieures peuvent donc traiter l'interface comme une base de données typique et passer à n'importe quelle version à volonté.
