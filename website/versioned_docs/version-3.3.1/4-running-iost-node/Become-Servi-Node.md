---
id: version-3.3.1-Become-Servi-Node
title: Become Servi Node
sidebar_label: Become Servi Node
original_id: Become-Servi-Node
---

A Servi Node requires an IOST account, to receive reward, and a full node, to generate blocks.  
You need to start the node first, then bind the node to your account.  
Each IOST account can be bound to *at most* one Servi Node.  
Each full node can be bound to *at most* one Servi Node.  
Servi Node signs blocks it generates using the privkey in the config file of iServer.  
**Your account and full node will have different keypairs.**

# Create IOST account

If you do not have an IOST account yet, follow these steps:

- [Install iWallet](4-running-iost-node/iWallet.md#install)
- Generate a *keypair* using iWallet: `iwallet key`
- Using the *pubkey* generated to create account (This feature is not open to the public, please contact us)

> Do not forget to import your account to iWallet: `iwallet account import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`
>
> For safety reason it's recommended to keep your IOST account in a secret place different from the Servi Node.

# Start a full node

Run the boot script to start a full node:

```
curl https://developers.iost.io/docs/assets/mainnet/boot.sh | bash
```

If you encounter any problems, you can see the detailed documentation [Start the node](4-running-iost-node/Deployment.md).

If nothing goes wrong, it will outputs something like this:

```
...

If you want to register Servi node, exec:

        iwallet sys register <pubkey> --net_id <network-id> --account <your-account>

To set the Servi node online:

        iwallet sys plogin --account <your-account>

See full doc at https://developers.iost.io
```

This script will generated a new keypair and network ID for the node. Please set down the **Public key** and **Network ID**.

If you forget them, you can view them as follows:
- The *keypair* of the node is located at `/data/iserver/keypair`, so is **Public key**.
- You can get **Network ID** of the node in section `network.id` by the command `curl http://localhost:30001/getNodeInfo`

# IWallet with IOST network

IWallet will connect to the local node by default. If you want to connect to IOST network, please refer to [Seed Node List](4-running-iost-node/Deployment.md#seed-node-list).  
For example:

```
iwallet -s ${GRPC-URL} state
```

# Pledge gas and Buy ram

If you don't have enough gas and ram, you can pledge gas and buy ram with the following command:
```
# pledge gas
iwallet system gas-pledge 80 --account <your-account>
# buy ram
iwallet system ram-buy 1024 --account <your-account>
```

If you don't have enough IOST, please contact us.

# Register the Servi Node

Register the Servi Node, i.e. bind the node to your account, using iWallet:

```
iwallet system register <pubkey-of-producer> --location <location> --url <website> --net_id <network-ID> --account <your-account>
```

- `<your-account>`: The account used to register the servi node
- `<pubkey-of-producer>`: The public key of the node
- `<location>`: The location of your full node
- `<website>`: Your official homepage
- `<network-ID>`: The network ID of the node

E.g.

```
iwallet system register 6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b --location Singapore --url https://iost.io/ --net_id 12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht --account iost
```

# Login the Servi Node

When a Servi Node receives more than 2.1 million votes and has already logged in, it will have the chance to generate blocks.

Login your servi node using iWallet:

```
iwallet system producer-login --account <your-account>
```

# Vote for your Servi Node

If you have enough IOST, you could vote for your servi node by follow command:

```
iwallet system vote <your-servi-node-account> 2100000 --account <your-account>
```

- `<your-servi-node-account>`: Voted Servi Node account
- `<your-account>`: Voting account

If you want to cancel the vote, you can use the following command:

```
iwallet system unvote <your-servi-node-account> 2100000 --account <your-account>
```

# View your Servi Node Account Information

If you want to check your servi node account information, you could execute follow command:

```
iwallet system producer-info <your-servi-node-account>
```

# Logout the Servi Node

If you want to temporarily stop your node or not want to generate blocks, you could logout your Servi Node using iWallet:

```
iwallet system producer-logout --account <your-account>
```
