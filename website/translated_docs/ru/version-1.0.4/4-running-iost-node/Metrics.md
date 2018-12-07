---
id: version-1.0.4-Metrics
title: Метрика
sidebar_label: Метрика
original_id: Metrics
---

Показатели - это инструмент, который контролирует производительность системы. Мы используем [Prometheus](https://prometheus.io/) для нашей системы.

## Развертывание Prometheus

Если вы используете узел IOST и хотите просмотреть метрики узла, выполните следующие действия:

* Запустите prometheus `pushgateway`

```
docker run -d -p 9091:9091 prom/pushgateway
```

После установки перейдите к `[pushgateway_ip]:9091` в вашем браузере, и вы можете увидеть следующую страницу (`[pushgateway]` это IP-адрес, к которому применяется докер):

![example](assets/doc004/pushgateway.png)

* Запустите prometheus сервер

```
docker run -d -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

* Конфигурировать `promethus.yml`

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

Не забудьте заменить `pushgateway_ip` с IP-адресом докера.

![example](assets/doc004/prometheus.png)

* Конфигурировать `iserver.yml`

```
metrics:
	pushAddr: "pushgateway_ip:9090"
	username: ""
	password: ""
	enable: true
	id: "defined_by_yourself"
```

Добавьте вышеуказанную конфигурацию в `iserver.yml`.

После вышеуказанных шагов вы можете проверить показатели IOST в "prometheus\_ip:9091". Предоставляются следующие показатели::

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

## Проверка разрешений на метрики

Если вам нужно добавить разрешение на метрику, чтобы другие пользователи не влияли на показатели к вашей системе, разверните экземпляр объекта nginx и добавьте контроль разрешений. Обратитесь к документу за конкретными шагами: https://prometheus.io/docs/guides/basic-auth/

После развертывания nginx, добавьте поля `username` и `password` в конфигурационный файл `iserver.yml`.
