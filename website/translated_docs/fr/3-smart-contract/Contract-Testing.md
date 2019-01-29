---
id: Contract-Testing
title: Test
sidebar_label: Test
---

Pour tester facilement les smart contracts, IOST fourni aux développeurs un miroir docker avec générateur de blocs autonome. Cela peut aider les développeurs à s'assurer de la validité des smart contracts avant de les inclure sur la chaine principale, en leur permettant d'utiliser le docker autonome comme backend pour les requêtes RPC.

Il convient de noter que les contrats ne sont pas directement publiés sur la chaine lorsqu'ils sont téléchargés via RPC. Le contrat devra attendre que le bloc suivant soit généré. Le contrôle de validité sera également exécuté lorsque le contrat sera intégré dans un bloc.

## Lancer le miroir docker

```bash
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:1.0.0
```

Avec cette commande, nous mappons le port 30002 du docker sur le port 30002 de la machine, ce qui permet d'envoyer des requêtes RPC directement au docker. Il est ensuite traité par notre programme Blockchain et publié sur la chaîne.

### Notes

Dans ce miroir, tous les IOST sont mis sur un compte initial, avec 21.000.000.000.000 IOST. Lorsqu'il est nécessaire d'initier une transaction ou de publier un contrat, vous devez transférer de l'argent de ce compte. Comme toute transaction IOST coûte du gaz et que tous les tokens sont stockés dans le compte initial, seul ce compte peut effectuer une transaction.

- Compte initial : `IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C`
- Clé privée : `1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB`

## Comment transférer des IOST vers un autre compte

### Générer un compte

```bash
// Ceci va générer un couple clé privée/publique dans le répertoire ~/.iwallet/
./iwallet account
```

### Initier une transaction

```bash
// Normalement nous demandons le fromID pour signer la transaction
./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' --signer "ID0, ID1"
// Exemple
./iwallet call iost.system Transfer '["IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", 100]' --signers "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
```

Ceci va générer le fichier de transaction `iost.sc`. Afin de publier ce contrat sur la chaine, nous devons suivre le workflow établi dans *Déploiement et appel*.

## Publier un contrat sur la chaine locale

Se référer a *Déploiement et appel*.

## Vérifier si le contrat est présent sur la chaine

Quand on publie une transaction ou un contrat, on initie une `Transaction`. `iWallet` va renvoyer un hash à cette `Transaction`, et ce hash sera l'ID de la transaction. Il est possible de regarder si la transaction a été publiée avec succès.

```bash
./iwallet transaction $TxID
```

Si la transaction n'a pas été publiée, il est possible d'exporter le fichier log de docker et d'y trouver des informations détaillées sur l'erreur.

```bash
docker logs $ContainerID
```
