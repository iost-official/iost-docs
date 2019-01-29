---
id: Deployment-and-invocation
title: Déploiement et appel
sidebar_label: Déploiement et appel
---

Une fois un smart contract JavaScript terminé, il est nécessaire de le déployer sur la chaîne.

Le déploiement a lieu en plusieurs étapes :

- Compiler le js afin de générer un fichier ABI
- Modification du fichier ABI
- Utiliser les fichiers .js et .abi pour générer le fichier container .sc
- Distribuer les fichiers .sc aux signataires qui généreront les fichiers .sig
- Collecter les fichiers .sig et .sc afin de les publier sur la chaîne

### Compiler le js pour générer le fichier ABI

Le programme iWallet est nécessaire dans le projet pour le déploiement. Je suis sur que vous avez déjà compilé un programme iWallet à partir des documents dans le répertoire `go-iost/target`.

Tout d'abord utiliser iWallet pour compiler le code js en fichiers ABIs correspondants.

```bash
# Générer un fichier ABI pour un fichier js cible
./iwallet compile -g jsFilePath
```

Ceci va générer des fichiers .js.abi et .js.after.

### Modification de fichier ABI
Pour l'instant, le fichier .abi nécessite encore des modifications. Il est nécessaire de contrôler les éléments suivants :

- Vérifier que le champ abi field n'est pas null
- Modifier le champ "abi" dans le fichier .abi, corriger chaque type dans `args`.

#### Exemple
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "transfer",
            "args": [
                "string",
                "string",
                "int"
            ]
        }
    ]
}
```

### Collecter les fichiers .sig et .sc afin de les publier sur la chaîne
Enfin utiliser les fichiers ```.js``` et ```.abi``` pour déployer le contrat.

```bash
# publier une transaction avec fichier .sig de chaque signataire
./iwallet --server serverIP --account acountName --amount_limit amountLimit publish jsFilePath abiFilePath
# Exemple
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...

# Retour
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh
```
