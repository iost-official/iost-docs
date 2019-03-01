---
id: Become-Servi-Node
title: Become Servi Node
sidebar_label: Become Servi Node
---

注册超级节点需要一个用来接收奖励的 IOST 账户，还需要运行并维护一个 IOST 全节点。
你可以先运行一个全节点，然后将这个节点绑定到某个 IOST 账户。
每个 IOST 账户至多绑定一个超级节点。
超级节点用来签名区块的私钥可以不同于对应的 IOST 账户私钥。
**建议账户和节点使用不同的公私钥对。**

# 创建 IOST 账户

按照以下步骤创建 IOST 账户：

- [安装 iWallet](4-running-iost-node/iWallet.md#install)
- 用 iWallet 生成一个*公私钥*对: `iwallet key`
- 用*公钥*创建账户 (目前该功能未公开，如有需要请联系我们)

> 别忘记用 iWallet 导入账户: `iwallet account import <账户名> <私钥>`
>
> 安全起见，账户私钥请妥善保管，并且不要放在超级节点上.

# 运行一个全节点

运行*一键脚本*:

```
curl https://raw.githubusercontent.com/iost-official/go-iost/master/script/boot.sh | bash
```

详细信息请参考[运行节点](4-running-iost-node/Deployment.md).

如果一切正常，应该会看到类似这样的输出:

```
...

If you want to register Servi node, exec:

        iwallet sys register <pubkey> --net_id <network-id> --account <your-account>

To set the Servi node online:

        iwallet sys plogin --account <your-account>

See full doc at https://developers.iost.io
```

上述命令会自动生成**节点公私钥对**和**网络 ID**。你也可以用下面的方式查询这些信息：

- *公私钥对*位于 `/data/iserver/keypair`, **节点公钥**也在里边.
- 本地执行 `curl http://localhost:30001/getNodeInfo`, **网络 ID**在返回结果的 `network.id` 部分.

# 用 iWallet 查询 iServer 状态

IWallet 默认连接本地节点。如果想连接其他节点，请查看[种子节点列表](4-running-iost-node/Deployment.md#seed-node-list).  
例如:

```
iwallet -s ${GRPC-URL} state
```

# 获取 iResource

如果提示 ‘gas 不足’ 或者 ‘ram 不足’ 请通过以下方式获取更多 iResource 资源：

```
# 质押 80 IOST 获取 gas
iwallet system gas-pledge 80 --account <your-account>

# 买 1024 ram
iwallet system ram-buy 1024 --account <your-account>
```

如果你需要更多的 IOST，请联系我们。

# 注册超级节点

用 iWallet 注册超级节点，即绑定节点到你的账户：

```
iwallet system register <pubkey-of-producer> --location <location> --url <website> --net_id <network-ID> --account <your-account>
```

- `<your-account>`: 你的账户
- `<pubkey-of-producer>`: 节点公钥
- `<location>`: 节点地理位置
- `<website>`: 你的网站
- `<network-ID>`: 节点网络 ID

例如

```
iwallet system register 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b --location Singapore --url https://iost.io/ --net_id 12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht --account iost
```

# 超级节点登陆

当你的超级节点获取到足够多的投票后，例如 210 万，且你的节点处于登陆状态才有机会造块。

节点登陆：

```
iwallet system producer-login --account <your-account>
```

# 为你的超级节点投票

只要有 IOST 就可以为超级节点投票：

```
iwallet system vote <your-servi-node-account> 2100000 --account <your-account>
```

- `<your-servi-node-account>`: 超级节点对应的账户
- `<your-account>`: 投票账户

如果你想取消投票：

```
iwallet system unvote <your-servi-node-account> 2100000 --account <your-account>
```

# 查看超级节点状态

执行一下命令查看超级节点状态:

```
iwallet system producer-info --account <your-account>
```

# 超级节点登出

当你的超级节点处于维护状态或者不想继续造块，可以临时将其下线：

```
iwallet system producer-logout --account <your-account>
```
