---
id: Vote
title: Vote
sidebar_label: Vote
---

# Résumé

Le vote est un mécanisme autonome important pour les systèmes blockchain. Si un nœud continue à servir la communauté de l'IOST, à contribuer au code et à participer à la gouvernance, alors ce nœud gagnera certainement plus de votes de la communauté. Les nœuds ayant plus de votes ont la possibilité de participer à la production des blocs et d'obtenir des récompenses. La participation active au vote est très importante pour le développement de la communauté, de sorte que le système récompensera les électeurs par des tokens.

## Règles

- 1 token représente un droit de vote
- 1 droit de vote peut être utilisé pour un seul nœud enregistré, partenaire ou formel
- Un token engagé pour l'achat de ressources n'octroie pas de droit de vote
- Après l'annulation d'un vote il faut attendre 7 jours pour récupérer le token

## Récompenses

### Nœud officiel

- 2% de tokens sont émis chaque année en guise de récompenses aux nœuds officiels, aux nœuds partenaires et aux électeurs.
- Le système émet automatiquement des tokens toutes les 24 heures.
- 50% de chaque token supplémentaire est attribué à un nœud authentifié qui a reçu plus de 0,01% (2,1 millions de votes) de votes sur l'ensemble du réseau, en fonction de son taux de vote.
- Les nœuds avec des votes inférieurs à 0,01% ne produisent pas de blocs et n'ont pas de récompenses de vote.
- 50 % des revenus de vote du nœud officiel et des nœuds partenaires sont versés au fonds de récompenses de l'électeur.
- Les récompenses déjà gagnées ne sont pas affectées par les changements dans les attributs et les votes des nœuds, et n'ont pas de durée d'expiration.
- Le nœud doit appeler activement le contrat pour recevoir les récompenses de production et de vote. Le token de récompense ne s'accumulera pas automatiquement dans le vote.
- La proportion de votes obtenus par tous les nœuds officiels est la même que la proportion du nombre de blocs que chaque nœud officiel a produit.

### Voter

- 50% des votes pour le nœud officiel et le nœud partenaire seront distribués à l'utilisateur qui a voté pour le ticket du nœud.
- Les utilisateurs ne peuvent voter que pour les nœuds enregistrés, les nœuds formels et les nœuds partenaires, et peuvent voter pour plusieurs nœuds en même temps.
- Les électeurs reçoivent des récompenses de nœud en fonction de la proportion des votes, et ne peuvent obtenir des récompenses générées qu'après le vote.
- N'importe quel compte peut être utilisé pour recharger le pool de récompenses d'un nœud (utilisé pour donner plus de récompenses aux électeurs), la logique de distribution est la même que la prime de vote du nœud officiel.
- Les électeurs doivent appeler activement le contrat pour recevoir la prime de vote. Le token de récompense ne s'accumule pas automatiquement lors du vote.
- Les récompenses déjà reçues ne sont pas touchés par l'annulation du vote et n'ont pas de date d'expiration.
