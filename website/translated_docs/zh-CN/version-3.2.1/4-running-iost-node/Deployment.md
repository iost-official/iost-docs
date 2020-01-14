---
id: Deployment
title: 部署
sidebar_label: 部署
---
本文介绍如何加入IOST官方网。如果只是测试调试，建议部署[本地单节点网络](4-running-iost-node/LocalServer.md)

## 硬件配置

- CPU: 4 核或者更多，至少3.0GHz (推荐 8 核)
- RAM: 8GB 或者更多 (推荐 16GB)
- 存储: 1TB 或者更多 (推荐 5TB HDD)
- 网络: 开启 tcp/30000 端口 (开启 tcp/30000-30002 如果开启 rpc 服务)

## 依赖

- Curl (版本任意)
- Python (版本任意)
- [Docker 1.13/Docker CE 17.03 以上](https://docs.docker.com/install)
- (推荐) [Docker Compose](https://docs.docker.com/compose/install)

## 启动节点

默认情况下 `/data/iserver` 是数据目录，可以根据实际情况自行修改。
以下用 `PREFIX` 指代数据目录。

使用一键脚本：

```
curl https://raw.githubusercontent.com/iost-official/go-iost/master/script/boot.sh | bash
```

| 变量 | 默认值 | 描述 |
| :------: | :------: | :------: |
| PREFIX | `/data/iserver` | iServer 数据路径 |
| INET | `mainnet` | IOST 网络, `mainnet` 或者 `testnet` |
| PYTHON | `python` | python 命令 |
| USR_LOCAL_BIN | `/usr/local/bin` | `docker-compose` 前缀 |

如果需要更改默认配置，请设置环境变量。
例如: 最新版 Ubuntu 使用 python3 而不是 python，所以需要这样启动节点：
`curl ... | PYTHON=python3 bash`

如果没有安装 docker, 脚本会自动安装。
对于某些 Linux 发行版，请确保当前用户拥有 docker 执行权限。

这个脚本会清理 `$PREFIX` 目录并创建一个连接到 IOST 网络的全节点。
同时也会创建一个**节点公私钥对**(用于超级节点造块)。
如果你想成为一个**超级节点**，后续步骤请参考[这里](4-running-iost-node/Become-Servi-Node.md).

执行一下命令 *开启/停止/重启* 节点：

```
## 开始
docker start iserver

## 停止
docker stop iserver

## 重启
docker restart iserver
```

### 手动启动节点

#### 数据

如果运行过以前版本的测试网，请清空数据:

```
rm -rf $PREFIX/storage
```

#### 配置文件

获取最新配置文件：

```
## 获取创世信息
curl -fsSL "https://developers.iost.io/docs/assets/mainnet/latest/genesis.tgz" | tar zxC $PREFIX/

## 获取 iServer 配置
curl -fsSL "https://developers.iost.io/docs/assets/mainnet/latest/iserver.yml" -o $PREFIX/iserver.yml
```

如果你是一个超级节点，在 `iserver.yml` 中的 `acc` 一栏设置节点造块私钥。
其他请参考[iServer 配置](4-running-iost-node/Configuration.md).

#### 运行

执行以下命令启动节点：

```
docker pull iostio/iost-node
docker run -d \
    --name iserver \
    -v /data/iserver:/var/lib/iserver \
    -p 30000-30003:30000-30003 \
    --restart unless-stopped \
    iostio/iost-node
```

## 检查节点

日志文件位于 `$PREFIX/logs/iost.log`.
日志文件默认关闭。如果打开日志文件，请及时清理日志数据。

通过 `(docker|docker-compose) logs iserver` 命令获取日志。
其中 `confirmed` 值持续快速增长说明节点正在同步：

```
...
Info 2019-01-19 08:36:34.249 pob.go:456 Rec block - @4 id:Dy3X54QSkZ..., num:1130, t:1547886994201273330, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:34.550 pob.go:456 Rec block - @5 id:Dy3X54QSkZ..., num:1131, t:1547886994501284335, txs:1, confirmed:1095, et:49ms
Info 2019-01-19 08:36:34.850 pob.go:456 Rec block - @6 id:Dy3X54QSkZ..., num:1132, t:1547886994801292955, txs:1, confirmed:1095, et:49ms
Info 2019-01-19 08:36:35.150 pob.go:456 Rec block - @7 id:Dy3X54QSkZ..., num:1133, t:1547886995101291970, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:35.450 pob.go:456 Rec block - @8 id:Dy3X54QSkZ..., num:1134, t:1547886995401281644, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:35.750 pob.go:456 Rec block - @9 id:Dy3X54QSkZ..., num:1135, t:1547886995701294638, txs:1, confirmed:1095, et:48ms
Info 2019-01-19 08:36:36.022 pob.go:456 Rec block - @0 id:EkRgHNoeeP..., num:1136, t:1547886996001223210, txs:1, confirmed:1105, et:21ms
Info 2019-01-19 08:36:36.324 pob.go:456 Rec block - @1 id:EkRgHNoeeP..., num:1137, t:1547886996301308669, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:36.624 pob.go:456 Rec block - @2 id:EkRgHNoeeP..., num:1138, t:1547886996601304333, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:36.921 pob.go:456 Rec block - @3 id:EkRgHNoeeP..., num:1139, t:1547886996901318752, txs:1, confirmed:1105, et:20ms
Info 2019-01-19 08:36:37.224 pob.go:456 Rec block - @4 id:EkRgHNoeeP..., num:1140, t:1547886997201327191, txs:1, confirmed:1105, et:23ms
Info 2019-01-19 08:36:37.521 pob.go:456 Rec block - @5 id:EkRgHNoeeP..., num:1141, t:1547886997501297659, txs:1, confirmed:1105, et:20ms
...
```

也可以使用钱包工具 `iwallet` 查看**本地**节点信息。

```
docker-compose exec iserver iwallet state
```

IWallet 更多用法请参考[iWallet](4-running-iost-node/iWallet.md).

访问[区块链浏览器](https://explorer.iost.io)获取当前区块高度。

## 升级节点

新版本 iServer 发布时，建议尽快升级至最新版本。

### 使用升级脚本

如果你是使用*一键脚本*部署的，推荐使用*一键升级脚本*：

```
curl https://raw.githubusercontent.com/iost-official/go-iost/master/script/upgrade.sh | bash
```

可以配置的变量有：

| 变量 | 默认值 | 描述 |
| :------: | :------: | :------: |
| PREFIX | `/data/iserver` | iServer 数据目录 |
| PYTHON | `python` | python 命令 |
| USR_LOCAL_BIN | `/usr/local/bin` | `docker-compose` 前缀 |

例如：最新的 Ubuntu 请执行 `curl ... | PYTHON=python3 bash`.

这个脚本会拉取最新的 iServer 镜像并重启节点。

### 手动升级

#### 拉取镜像

```
docker image pull iostio/iost-node:latest
```

#### 删除旧容器

IServer 容器将被重建，*除了 iServer 数据*容器内所有内容将被删除。

```
docker stop iserver && docker rm iserver
```

#### 重建容器

假设 iServer 数据目录是默认值 `/data/iserver`:

```
docker run -d --name iserver -v /data/iserver:/var/lib/iserver -p 30000-30003:30000-30003 iostio/iost-node
```

## 种子节点列表

主网 mainnet 种子节点信息如下：

| 地理位置 | GRPC-URL | HTTP-URL | P2P-URL |
| :------: | :------: | :------: | :-----: |
| US        | 18.209.137.246:30002 | http://18.209.137.246:30001 | /ip4/18.209.137.246/tcp/30000/ipfs/12D3KooWGoPE333zygBN61vtSjvPfosi78JFSwRRDrLoAKaH1mTP |
| Korea     | 54.180.196.80:30002  | http://54.180.196.80:30001  | /ip4/54.180.196.80/tcp/30000/ipfs/12D3KooWMm2RzyZDPBie89FXceKFSBRg8zzkwAGQmdauj6tmrqcA  |
| UK        | 35.176.24.11:30002   | http://35.176.24.11:30001   | /ip4/35.176.24.11/tcp/30000/ipfs/12D3KooWHzHUBq4x4LmXtZH79LCAxVUYgpKXgMgAtyvYQWeHZAAp   |

测试网:

| 地理位置 | GRPC-URL | HTTP-URL | P2P-URL |
| :------: | :------: | :------: | :-----: |
| US | 13.52.105.102:30002 | http://13.52.105.102:30001 | /ip4/13.52.105.102/tcp/30000/ipfs/12D3KooWQwH8BTC4QMpTxm7u4Bj38ZdaCLSA1uJ4io3o1j8FCqYE |

### GRPC

使用 grpc 服务：

```
## Get the node information
iwallet -s 18.209.137.246:30002 state
iwallet -s ${GRPC-URL} state
```

### HTTP

使用 HTTP 服务：

```
## Get the block information by block height
curl http://18.209.137.246:30001/getBlockByNumber/3/true
curl ${HTTP-URL}/getBlockByNumber/3/true
```

### P2P
如果你想变更 iServer 种子节点信息，修改 `/data/iserver/iserver.yml`, 例如:

```
...
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
    - /ip4/18.209.137.246/tcp/30000/ipfs/12D3KooWGoPE333zygBN61vtSjvPfosi78JFSwRRDrLoAKaH1mTP
    - ${P2P-URL}
    - ...
```

## 使用 snapshot 加速同步

从 snapshot 导入区块链数据可以显著加速同步过程。   
下载链接: [storage.tar](http://archive.iost.io/snapshot/storage.tar)   
文件校验:
[MD5](http://archive.iost.io/snapshot/MD5SUMS) /
[SHA1](http://archive.iost.io/snapshot/SHA1SUMS) /
[SHA256](http://archive.iost.io/snapshot/SHA256SUMS)

下载镜像文件，然后以此执行以下操作：

- 确保 iServer 停止：`docker stop iserver`
- 导入数据：`sudo rm -rf $PREFIX/storage && sudo tar xvf storage.tar -C $PREFIX`
- 重启 iServer：`docker start iserver`

之后节点会从 snapshot 中的高度继续同步。
