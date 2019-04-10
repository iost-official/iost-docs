---
id: Design-Tech-data
title: Smart Contract Lucky Bet
sidebar_label: Smart Contract Lucky Bet
---

## Sommaire

Le tutoriel est conçu pour démontrer l'écriture et le déploiement de smart contracts.

Il vous donnera les instructions pour déployer un nœud IOST localement (juste pour le développement, pas pour se connecter à la chaîne réelle). Ensuite, un smart contract (un jeu de hasard nommé 'Lucky Bet') sera déployé sur le nœud.

Les tutoriels contiennent 3 parties. La partie 1 énumère les commandes étape par étape pour déployer et exécuter le smart contract. La partie 2 explique le code javascript du contrat. La partie 3 donne quelques détails sur le déploiement et les instructions d'utilisation.

Les lecteurs sont supposés avoir des connaissances de base en programmation et en blockchain.
Les instructions suivantes sont toutes exécutées sur Ubuntu 16.04.

## Règles

1. Les comptes IOST peuvent parier avec 1-5 IOST. Chaque pari est sur un nombre de 0-9.
2. Après 100 paris, le résultat est révélé. Les gagnants partagent 95% des mises, et les 5% restants sont des frais de transaction.
3. Le numéro gagnant est le numéro de block mod 10.
