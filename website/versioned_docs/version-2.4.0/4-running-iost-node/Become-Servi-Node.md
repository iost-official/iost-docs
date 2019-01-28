---
id: version-2.4.0-Become-Servi-Node
title: Become Servi Node
sidebar_label: Become Servi Node
original_id: Become-Servi-Node
---

A Servi node is able to generate blocks only when being a *producer*, which requires an IOST account and a full node. 

# Start a full node
Run the boot script to start a full node. See also [Start the node](4-running-iost-node/Deployment.md).

```
curl https://developers.iost.io/docs/assets/boot.sh | sh
```

The *keypair* of producer is located at `/data/iserver/keypair`. You could get the public key of producer in here.

You can get *network ID* of the node in section `network.id` by the command `curl http://localhost:30001/getNodeInfo`

# Create IOST account

If you do not have an account yet, follow these steps:

- [Install iwallet](4-running-iost-node/iWallet.md#install)
- Generate a *keypair* using iWallet: `iwallet keys`
- Using the *pubkey* generated to create testnet account by [blockchain explorer](https://explorer.iost.io/applyIOST).

> Do not forget to import your account to iwallet: `iwallet account --import $YOUR_ACCOUNT_NAME $YOUR_PRIVATE_KEY`

# Register the servi node

You could register your account as servi node using iwallet:
```
iwallet --account <your-account> call 'vote_producer.iost' 'applyRegister' '["<your-account>","<pubkey-of-producer>","<location>","<website>","<network-ID>",<is-producer>]'
```
See API doc of `vote_producer.iost` [here](6-reference/SystemContract.md#vote-produceriost).

- `<your-account>`: The account used to register the servi node
- `<pubkey-of-producer>`: The pubkey of the full node producer
- `<location>`: The location of your full node
- `<website>`: Your official homepage
- `<network-ID>`: The network ID of the full node producer
- `<is-producer>`: Whether it becomes a producer (If you just want to be a partner node, this option is false)

example:
```
iwallet --account iost call 'vote_producer.iost' 'applyRegister' '["iost","6sNQa7PV2SFzqCBtQUcQYJGGoU7XaB6R4xuCQVXNZe6b","Singapore","https://iost.io/","/ip4/3.85.187.72/tcp/30000/ipfs/12D3KooWA2QZHXCLsVL9rxrtKPRqBSkQj7mCdHEhRoW8eJtn24ht",true]'
```

# Login the servi node

When a servi node receives more than 2.1 million votes and has already logged in, it will have the opportunity to generate a block.

You could login your servi node using iwallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logInProducer' '["<your-account>"]'
```

# Logout the servi node
If you want to temporarily stop the full node or not generate a block, you could logout your servi node using iwallet:

```
iwallet --account <your-account> call 'vote_producer.iost' 'logOutProducer' '["<your-account>"]'
```
