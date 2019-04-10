---
id: Metrics
title: Metrics
sidebar_label: Metrics
---

Metrics est un outil qui surveille la performance du système. Nous utilisons [Prometheus](https://prometheus.io/) pour notre système.

## Déploiement de Prometheus

Si vous exécuter un nœud IOST, et désirez suivre les métriques de celui-ci, suivez ces étapes :

* Lancer prometheus `pushgateway`

```
docker run -d -p 9091:9091 prom/pushgateway
```

Après installation, aller à `[pushgateway_ip]:9091` dans votre navigateur et vous verrez la page suivante (`[pushgateway_ip]` est l'IP sur laquelle docker est déployé) :

![example](assets/doc004/pushgateway.png)

* Run prometheus server

```
docker run -d -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

* Configurer `promethus.yml`

```
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'codelab-monitor'
scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    target_groups:
      - targets: ['pushgateway_ip:9090']
```

Ne pas oublier de remplacer `pushgateway_ip` avec l'IP du docker.

![example](assets/doc004/prometheus.png)

* Configurer `iserver.yml`

```
metrics:
	pushAddr: "pushgateway_ip:9090"
	username: ""
	password: ""
	enable: true
	id: "defined_by_yourself"
```

Ajouter la configuration ci-dessus à `iserver.yml`.

Après les étapes ci-dessus, vous pouvez afficher les métriques IOST dans "prometheus\_ip:9091". Les métriques suivants sont disponibles :

```
iost_pob_verify_block: Number of verify blocks
iost_pob_confirmed_length: Block height
iost_tx_received_count: Number of transactions received
iost_txpool_size: Number of transactions to pack
iost_p2p_neighbor_count: Number of neighbors
iost_p2p_bytes_out: Bytes sent
iost_p2p_packet_out: Packets sent
iost_p2p_bytes_in: Bytes received
iost_p2p_packet_in: Packets received
```

## Validation des permissions de métriques

S'il est nécessaire d'ajouter des permissions aux métriques afin d'éviter que d'autres envoient des métriques sur votre système, déployer nginx et ajouter le contrôle de permissions. Se référer à : https://prometheus.io/docs/guides/basic-auth/

Après le déploiement nginx, ajouter un champ `username` et un champ `password` à `iserver.yml`.
