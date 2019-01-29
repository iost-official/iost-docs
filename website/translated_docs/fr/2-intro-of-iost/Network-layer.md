---
id: Network-layer
title: Couche réseau
sidebar_label: Couche réseau
---

Le réseau P2P (Peer-to-Peer), ou Peer Network, est une structure décentralisée qui répartit les tâches et la charge de travail entre pairs. Dans les réseaux P2P, les ordinateurs connectés sont égaux les uns aux autres et chaque nœud est à la fois fournisseur et consommateur de ressources, de services et de contenus. Contrairement aux modèles de réseau client-serveur traditionnels, les réseaux P2P ont l'avantage d'être décentralisés, évolutifs, résistants aux attaques et privés. Ces avantages assurent le fonctionnement du système de la blockchain et sont les pierres angulaires d'une blockchain libre, autonome et décentralisée.

## Design de la couche réseau IOST

Notre objectif est de construire une topologie de réseau entièrement décentralisée, avec une découverte rapide des nœuds et une diffusion rapide des transactions et des blocs sur tout le réseau. En même temps, nous espérons limiter la redondance au sein du réseau et sécuriser la transmission des données entre les nœuds. Grâce à la recherche et aux tests, nous avons décidé d'utiliser la puissante bibliothèque [libp2p](https://github.com/libp2p/go-libp2p) comme couche réseau.

### Découverte de nœuds et connectivité

Le protocole de base est TCP/IP. Afin d'éviter les écoutes et les manipulations non désirées, nous sécurisons les données avec une couche TLS sur TCP. Pour mieux utiliser chaque connexion TCP, nous adoptons le multiplexage de flux pour envoyer et recevoir des données, en établissant dynamiquement plusieurs flux entre les nœuds et en maximisant la bande passante.

Avec les nœuds, nous utilisons [Kademlia](https://en.wikipedia.org/wiki/Kademlia) pour maintenir leurs tables de passerelle. L'algorithme de Kademlia utilise la valeur XOR entre les ID des nœuds pour calculer la distance entre eux. Les nœuds sont placés dans des buckets en fonction de leur distance par rapport aux autres pairs. Lorsqu'un nœud est interrogé, il suffit de trouver le nœud le plus proche dans le bucket correspondant. Avec un nombre défini de requêtes, nous pouvons garantir que l'information sera trouvée pour le nœud. Kademlia se distingue par sa rapidité et sa polyvalence.

### Transmission de données

Pour réduire la bande passante et accélérer la transmission des données, nous sérialisons toutes les données structurées avec Protocol Buffer, et les compressons avec l'algorithme Snappy. Au cours de nos tests, cette politique a réduit la taille des données de plus de 80 %.

La diffusion entraînera une redondance dans la transmission des données, et donc un gaspillage de bande passante et de puissance de traitement. De nombreux projets empêchent la rediffusion indéfinie des données en limitant les "sauts" (ou combien de fois certaines données ont été rediffusées). L'inconvénient de cette politique est qu'un nombre défini de rediffusion ne peut pas garantir l'accès aux données à l'ensemble du réseau, surtout lorsque le réseau est immense. La façon dont EOS traite le problème est que la couche réseau enregistre les transactions et les blocs des voisins de chaque nœud et décide d'envoyer ou non des données à un certain nœud. Cette conception peut réduire la transmission redondante dans une certaine mesure, mais elle n'est pas élégante et ajoute de la charge au stockage.

La façon dont nous nous y prenons est d'adopter un algorithme de filtrage pour filtrer l'information en double. Après avoir comparé [Bloom Filter](https://en.wikipedia.org/wiki/Bloom_filter), [Cuckoo Filter](https://brilliant.org/wiki/cuckoo-filter/) et bien d'autres, nous avons décidé de choisir Bloom. Nous pouvons réaliser un double filtrage d'un million de paquets de données, avec seulement 1,7 Mo de stockage et 0,1% de faux négatifs. Pour réduire encore davantage la transmission redondante des données, nous avons mis en place une politique spéciale pour les blocs et les grosses transactions : leur hachage sera diffusé en premier. Les nœuds peuvent alors utiliser le hachage pour télécharger les données manquantes.

### Pénétration du réseau local

Nous utilisons le protocole [UPnP](https://en.wikipedia.org/wiki/Universal_Plug_and_Play) pour la pénétration LAN. UPnP est différent des autres politiques, telles que [UDP Hole Punching](https://en.wikipedia.org/wiki/UDP_hole_punching) et [STUN](https://en.wikipedia.org/wiki/STUN) ; il ne nécessite pas d'exposition de port. Cela signifie que vous pouvez utiliser votre ordinateur personnel pour accéder à notre réseau et communiquer avec d'autres nœuds, sans avoir à utiliser un serveur cloud.

## Un Easter Egg

Dans le package réseau P2P de notre répertoire de code vous trouverez un répertoire `/example`. Nous avons créée une application de messagerie instantanée avec notre package réseau. Allez dans le répertoire et exécuter `go build` pour compiler le binaire `./example`. Vous pouvez à présent chatter avec les autres pairs du réseau. Amusez vous bien !
