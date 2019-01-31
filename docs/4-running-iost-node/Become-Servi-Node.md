---
id: Become-Servi-Node
title: Become Servi Node
sidebar_label: Become Servi Node
---

A Servi Node requires an IOST account, to receive reward, and a full node, to generate blocks.
You need to start the node first, then bind the node to your account.
Each IOST account can be bound to *at most* one Servi Node.
Servi Node signs blocks it generates using the privkey in the config file of iServer.   
**It's highly recommended to use a different keypair from your account for the Servi Node.**

# Create IOST account

If you do not have an IOST account yet, follow these steps:

- [Install iWallet](4-running-iost-node/iWallet.md#install)
- Generate a *keypair* using iWallet: `iwallet keys`
- Using the *pubkey* generated to create account by [blockchain explorer](https://explorer.iost.io/applyIOST).

> Do not forget to import your account to iWallet: `iwallet account --import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`

For safety reason it's recommended to keep your IOST account in a secret place different from the Servi Node.

# Start a full node

Run the boot script to start a full node. See also [Start the node](4-running-iost-node/Deployment.md).

```
curl https://developers.iost.io/docs/assets/boot.sh | bash
```

If nothing goes wrong, it will outputs something like this:

```
...
If you want to register Servi node, exec:

        iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey>","","","<network-id>",true]'

To set the Servi node online:

        iwallet --acount <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'

See full doc at https://developers.iost.io
```

This script will generated a new keypair for the node. Please set down the **pubkey** and **network ID**.

The *keypair* of the node is located at `$PREFIX/keypair`, so is **pubkey**.

You can get **network ID** of the node in section `network.id` by the command `curl http://localhost:30001/getNodeInfo`

# Register the servi node

Register the Servi Node, i.e. bind the node to your account, using iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",<is-producer>]'
```

See API doc of `vote_producer.iost` [here](6-reference/SystemContract.md#vote-produceriost).

- `<your-account>`: The account used to register the servi node
- `<pubkey-of-producer>`: The pubkey of the node
- `<location>`: The location of your full node
- `<website>`: Your official homepage
- `<network-ID>`: The network ID of the node
- `<is-producer>`: Whether it becomes a producer (if you just want to be a partner node, this option is false)

E.g.

```
iwallet --account iost call 'vote_producer.iost' 'applyRegister' '["iost","6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b","Singapore","https://iost.io/","12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht",true]'
```

# Login the Servi Node

When a Servi Node receives more than 2.1 million votes and has already logged in, it will have the chance to generate blocks.

Login your servi node using iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'
```

# Logout the Servi Node

If you want to temporarily stop your node or not want to generate blocks, you could logout your Servi Node using iWallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]'
```
