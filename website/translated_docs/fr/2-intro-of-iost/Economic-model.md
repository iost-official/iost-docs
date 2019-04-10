---
id: Economic-model
title: Modèle économique
sidebar_label: Modèle économique
---
# Résumé

Les deux principaux modèles économiques sont le modèle d'appartenance d'ETH et celui de prêt d'EOS.

Le modèle économique basé sur la contribution d'IOST est dédié à profiter des avantages des modèles matures tout en évitant leurs désavantages. Nous souhaitons implémenter un modèle économise gratuit à l'utilisation pour des DAPP commerciales de grande envergure.

Voici la comparaison du modèle économique :

 Système | Modèle | Avantages | Désavantages |
| :---: | :----: | ----- | ----- |
ETH | Appartenance | 1. Créer un compte gratuitement<br>2. Participer à l'aide de ressources afin d'équilibrer l'utilisation du réseau<br>3. Les frais de Gas sont plus précis. | 1. Quand le système est chargé, l'utilisation du réseau sera chère et les prix fluctuent énormément.<br>2. La performance du système est faible, et le développement, le déploiement va continuer à charger le système. Il est donc difficile d'offrir un support pour des DAPP de grande envergure.<br>3. L'espace de stockage ne peut pas être rendu. L'utilisateur n'a donc aucune motivation pour rendre l'espace utilisé, impliquant une grande quantité de déchets.<br>4. Les ressources CPU et de stockage sont payées de façon unifiée en Gas, provoquant une interdépendance entre les deux et une utilisation faible |
EOS | Location | 1. Combien y a t'il de tokens sur le réseau, combien de ressources sont disponibles ?<br>2. Le système impose l'engagement de token sans consommer ceux-cis, et supporte des DAPP de grande envergure<br>3. Lors de location de RAM, les utilisateurs sont motivés à rendre l'espace utilisé, récupérant ainsi les tokens et allégeant les problèmes d'expansion de la blockchain | 1. Création de comptes compliquée avec des frais importants <br>2. Lorsque des clients fortunés engagent de grandes quantités de token afin d'obtenir des ressources cela aura pour effet de diluer les ressources disponibles même si le réseau est faiblement utilisé, faisant que les "petits" clients ne pourront plus se permettre les transactions sur le réseau EOS.<br>3. Il y a trop de types de ressources à louer (NET, CPU et RAM), et le seuil pour un utilisateur lambda est trop élevé.
| IOST | Contribution | 1. Créer un compte est simple et les frais sont faibles<br>2. Plus la contribution est grande plus les ressources à disposition sont grandes.<br>3. Il ets nécessaire d'engager des tokens pour obtenir du GAS, ceci ne consommera pas les tokens, créant une blockchain publique réellement gratuite.<br>4. A l'aide de la définition du prix du GAS il sera possible d'éviter la dilution de ressources rencontrée sur EOS, créant un système plus juste.<br>5. Les ressources systèmes sont divisées en CPU et stockage. La division de ressources est plus logique et permet une définition du prix décorrélée. Ceci permet d'éviter le problème de faible utilisation des ressources d'ETH. | La complexité du modèle économique est élevée |

# Emissions additionnelles

Le système lance des émissions supplémentaires toutes les 24 heures.

La quantité totale de tokens IOST est de 21 milliards avec une émission annuelle fixe de 2% utilisée pour récompenser les nœuds producteurs, les votes et les nœuds partenaires.

### Fréquence d'émission

A chaque émission l'augmentation = coefficient d'inflation annuel (1.98%) * quantité totale actuelle d'IOST * deux intervalles de temps additionnels (en millisecondes) / durée de l'année (en millisecondes)

Formule de calcul de l'inflation annuelle : (1+x)^n = 214.2/210

Ainsi, x = ln1.02 = 1.98%

x est le coefficient d'inflation, n est le nombre d'émissions, et 21.42 milliards est la quantité totale de tokens après une année d'inflation.

# récompense

Le modèle de récompense est un élément important de l'ensemble du modèle économique. Il existe quatre types de récompenses : la récompense de production de blocs, la récompense de vote, la récompense hypothécaire et la récompense d'engagement.

La valeur de la contribution obtenue par le producteur du bloc peut être échangée contre la récompense en token à partir du pool de récompenses. Les tokens engagés sevent à obtenir du GAS permettant de payer les transactions.

Si le nœud obtient des votes au-dessus d'un certain seuil et passe la certification, alors le nœud et l'électeur du nœud peuvent obtenir la récompense en même temps.

Le nœud producteur peut racheter la récompense du Token du pool de récompenses à tout moment avec la valeur de la contribution.

La valeur de la contribution est de 1 contre 1 pour le Token, et la moitié de la prime de remboursement est versée à l'électeur.

La valeur de l'apport est détruite après le rachat et peut être rachetée une fois toutes les 24 heures.

### Récompense en GAS
    
Un nœud normal peut obtenir du gas en engageant des tokens, 1Token = 100,000 Gas/Jour, le token engagé étant verrouillé et ne pouvant pas être vendu.

Règles :

- Engagez 1 IOST, obtenez 100 000 GAS d'un coup, et générez 100 000 GAS par jour.
- Le processus de production est fluide et la vitesse de production du gaz est de 100 000 Gas/Token/Jour.
- La limite supérieure du GAS par utilisateur est de 300 000 fois le nombre total de token de mise en gage, c'est-à-dire l'équivalent de 2 jours.
- Lorsque le gas est utilisé, il est inférieur à 300 000 fois le nombre de token en gage, relançant la production de gas.
- Le rachat d'IOST peut être initié à tout moment. Les tokens demandant le rachat ne génèrent plus de GAS. Le rachat nécessite 72 heures.
- Si les IOST sont rachetés, la limite supérieure du gaz de récompense est réduite en conséquence et le gas dépassant la limite supérieure est détruit.

### Utilisation du gas

- L'exécution de transactions nécessite la consommation de gas
- La quantité de gas consommée par la transaction = CGas (Command Gas) consommation de la commande * nombre de commandes * taux de gas
- Il n'est pas possible de trader le gas

### Quantité de gas

- A chaque initialisation de transaction, calculer la quantité de gas détenur, puis utiliser le dernier solde afin de payer la transaction.

# Invitation

### Gas échangeable

Quand l'utilisateur est invité par le nœud officiel et que le nœud partenaire consomme du gas, il est possible d'obtenir du gas échangeable.

Le créateur du compte devient automatiquement l'inviteur du compte créé et ne peut être modifié.

- Obtention
   - Si l'inviteur est un nœud formel ou partenaire, le compte consomme 10% du GAS et la récompense est donnée à l'inviteur
   - Il n'y a pas de limite de GAS échangeable
   - Avoir du GAS échangeable ne nécessite pas d'engager de tokens
   
- Utilisation
   - Le gas échangéable peut être envoyé à un autre utilisateur une fois. Il ne sera plus transférable ensuite
   - Le gas échangeable peut être utilisé comme du Gas normal. La priorité d'utilisation est donnée au Gas non échangeable

### Bonus sur les frais
- 30% des frais sur la RAM de l'invités sont donnés à l'inviteur du nœud officiel ou partenaire
- Créer un compte nécessite 10 tokens hypothéqués, 30% de cet engagement est reversé à l'inviteur du nœud officiel ou partenaire, et le token de récompense est issu de la création
   
# Ressources
    
Les ressources système sont divisés en NET, CPU et RAM. Le NET et le CPU nécessitent un payement de GAS. La RAM nécessite la mise en hypothèque de tokens.

RAM:

- La limite itiniale du système est de 128G
- L'utilisateur achète et vend de la RAM au système. L'achat de RAM implique 2% de frais qui seront détruits.
- Moins il reste de RAM dans le système, plus le prix est élevé, et vice versa.
- L'hypothèque des tokens permet d'encourager les utilisateurs à libérer l'espace RAM inutilisé et à échanger le token de récompense
- Augmentation de la RAM de 64G par an, et ajout de RAM chaque fois que vous avez un compte pour acheter de la RAM.
- Créer un compte nécessite une petite quantité de RAM pour éviter de créer une attaque de création de comptes
- La RAM peut être louée mais non échangée
- Lors de l'appel d'un contrat système, il est possible d'utiliser la RAM de l'utilisateur.

# Circulation
    
La liquidité du token reflète la prospérité du modèle économique. Augmenter la mobilité du token est un des buts du modèle économique.

La chaine publique IOST est de nouvelle génération et offre des performances inégalées. Les utilisateurs peuvent utiliser la blockchain gratuitement, offrant une incitation importante pour les DAPP et les transferts C2C.

# Recyclage

Le recyclage de tokens est là pour équilibrer l'offre et la demande

- Voter, acheter de la RAM, obtenir du Gas, nécessitent tous l'hypothèque/l'engagement de tokens
- Les frais prélevés pour l'achat de RAM sont détruits
- Le gas consommé à l'exécution de la transaction sera détruit
- L'augmentation des utilisateurs du système augmentera la destruction de tokens ainsi que le nombre de tokens hypothéqués. Ceci diminuera l'offre et fait du modèle économique d'IOST un modèle déflationniste. 
