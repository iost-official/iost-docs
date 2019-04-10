---
id: Generate-Receipt
title: Générer un reçu dans le smart contract
sidebar_label: Générer un reçu dans le smart contract
---
## Fonction
Le reçu est utilisé afin de prouver ou de rappeler l'occurrence de certaines opérations,
une application typique est l'enregistrement d'un transfert de A vers B avec une information supplémentaire.

Le smart contract peut générer un reçu en appelant la fonction système `blockchain.receipt` offerte par l'infrastructure blockchain.
Le reçu est stocké dans les données du block associé à la transaction, qui sera bien entendu vérifiée par tous les nœuds du réseau.
Rappelez-vous que le reçu ne peut pas être appelé au sein d'un contrat, il est accessible uniquement en analysant les données de block
ou en demandant un reçu particulier en spécifiant le hash de transaction via une interface rpc.

Un reçu est bien moins cher que de l'espace de stockage de contrat. Il coûte uniquement du gas, à l'inverse du stockage qui coûte du gas et de la ram.

## Générer un reçu
Le smart contract génère un reçu en appelant la fonction système `blockchain.receipt`.
Voici un exemple où la fonction receiptf de ce contrat est appelée, générant ainsi trois reçus.

```js
class Contract {
    init() {
    }

    receiptf() {
        blockchain.receipt(JSON.stringify(["from", "to", "100.01"]));
        blockchain.receipt('{"name": "Cindy", "amount": 1000}');
        blockchain.receipt("transfer accepted");
    }
}

module.exports = Contract;
```

`blockchain.receipt` accepte un paramètre de type string, qui réfère au contenu du reçu et n'a pas de retour.
Une erreur runtime sera renvoyée si l'exécution échoue, ce qui ne devrait pas avoir lieu normalement.
Nous recommandons aux développeurs d'utiliser un format json pour le contenu, car il est pratique pour une analyse ultérieure.

Le reçu généré contient aussi le nom du contrat et de l'action, indiquant quelle méthode est à l'origine du reçu.
Les trois reçus générés ci-dessus ressembleront à :

```console
# first
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"[\"from\",\"to\",\"100.01\"]"}
# second
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"{\"name\": \"Cindy\", \"amount\": 1000}"}
# third
{"funcName":"ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLMz/receiptf", "content":"transfer accepted"}
```
`ContractFhx828oUPYHRtkp9ABaBFHwm6S94eeeai1TD3FkTgLM` is ID of this contract.


## Consulter un reçu
### Consulter un reçu à l'aide du hash de transaction
Le reçu généré par une transaction spécifique peut être appelé à l'aide du hash de transaction via l'interface rpc.

Se référer à [/getTxReceiptByHash](../6-reference/API#gettxreceiptbyhash-hash)


### Consulter un reçu depuis les données de block
Les données exhaustives d'un block contiennent toutes les transactions et les reçus correspondants. Il est possible de
télécharger les données et de les analyser afin de récupérer tous les reçus générés dans le block.

Se référer à [ /getBlockByHash](../6-reference/API#getblockbyhash-hash-complete) and [/getBlockByNumber](../6-reference/API#getblockbynumber-number-complete)
et définir le paramètre `complete` dans les paramètres de requête à `true`
