---
id: version-2.1.7-Metrics
title: メトリクス
sidebar_label: メトリクス
original_id: Metrics
---

メトリクスはシステムのパフォーマンスをモニターするツールです。IOST用には、[Prometheus](https://prometheus.io)を使います。

## Prometheusのデプロイ

IOSTノードを実行中で、ノードのメトリクスを調べたいなら、次のステップに従って実行します。

* Prometheusの`pushgateway`の実行

```
docker run -d -p 9091:9091 prom/pushgateway
```

インストールできたら、ブラウザで`[pushgateway_ip]:9091`にアクセスすると、次のページが表示されます。 (`[pushgateway]`は、DockerがデプロイされたマシンのIPです)

![example](assets/doc004/pushgateway.png)

* Prometheusサーバーの実行

```
docker run -d -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

* `promethus.yml`の設定

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

`pushgateway_ip`をDockerのIPアドレスに置き換えてください。

![example](assets/doc004/prometheus.png)

* `iserver.yml`の設定

```
metrics:
	pushAddr: "pushgateway_ip:9090"
	username: ""
	password: ""
	enable: true
	id: "defined_by_yourself"
```

上の項目を`iserver.yml`に追加します。

上のステップの後、 "prometheus\_ip:9091"内のIOSTのメトリクスのチェックができます。ここは、次のメトリクスが得られます。

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

## メトリクス権限認証

システムに他のプッシュしたメトリクスを避けるために、権限を追加する必要があるなら、nginxのインスタンスをデプロイして、権限制御を追加します。次のドキュメントを参照してください。https://prometheus.io/docs/guides/basic-auth/

nginxをデプロイ後、`username`と`password`フィールドを`iserver.yml`設定ファイルに追加する必要があります。
