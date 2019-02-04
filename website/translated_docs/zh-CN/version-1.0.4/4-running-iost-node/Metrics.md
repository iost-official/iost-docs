---
id: Metrics
title: Metrics
sidebar_label: Metrics
---

Metrics 是监控一个系统运行状态的工具。我们使用了 [Prometheus](https://prometheus.io/) 来作为我们系统的监控工具。

## 部署 Prometheus

如果你运行了一个 IOST 节点，并且想查看该节点的 metrics 状态信息，你需要执行如下的步骤：

* 运行 prometheus pushgateway

```
docker run -d -p 9091:9091 prom/pushgateway
```

安装成功后，在浏览器访问 "pushgateway\_ip:9091" (pushgateway\_ip 就是部署上述 docker 的机器的 IP ) 能看到如下页面：

![example](assets/doc004/pushgateway.png)

* 运行 prometheus server

```
docker run -d -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
```

* 修改 promethus.yml 配置文件

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
注意替换上述配置中的 “pushgateway_ip” 成第一步部署 pushgateway 的机器的 IP。  
这一步成功后，在浏览器访问 "prometheus\_ip:9091" (prometheus\_ip 就是部署第二步中 docker 的机器的 IP ) 能看到如下页面：

![example](assets/doc004/prometheus.png)


* 修改 IOST 配置文件 iserver.yml

```
metrics:
	pushAddr: "pushgateway_ip:9090"
	username: ""
	password: ""
	enable: true
	id: "defined_by_yourself"
```

在 iserver.yml 中加入如上配置项，pushgateway\_ip 就是部署第一步中 docker 的机器的 IP。

完成上述步骤后，你就能在 "prometheus\_ip:9091" 页面中查看 IOST 的 metrics。目前我们提供了下列 metrics 监控：

```
iost_pob_verify_block: 验证块个数
iost_pob_confirmed_length: 确认块高度
iost_tx_received_count: 接收交易个数
iost_txpool_size: 待打包交易个数
iost_p2p_neighbor_count: 邻居节点个数
iost_p2p_bytes_out: 网络发送字节数
iost_p2p_packet_out: 网络发送包个数
iost_p2p_bytes_in: 网络接收字节数
iost_p2p_packet_in: 网络接收包个数
```

## metrics 权限认证

如果你需要为 metrics 添加权限认证，防止其他人将 metrics push 到你的系统，你可以在 pushgateway 之前部署一个 nginx 并添加权限管理。具体部署方式可以参考文档：https://prometheus.io/docs/guides/basic-auth/。完成 nginx 部署后，你需要在 iserver.yml 的 metrics 配置项中，添加 username 和 password 值。
