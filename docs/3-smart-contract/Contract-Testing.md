---
id: Contract-Testing
title: Testing
sidebar_label: Testing
---

To conveniently test smart contracts, IOST has provided developers with standalone block-generating docker mirror. This can help developers ensure the validity of smart contracts before putting them on the main chain, by allowing them to use the standalone docker as the backend of RPC requrests.

It's worth noting that, contracts are not directly put on chain when uploaded to the receiving end of RPC. The contract will have to wait for the next block to be generated. Validity check will be run, too, when the contract is packed into the block.

## Launch Docker Mirror

```bash
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:1.0.0
```

With this command, we map the docker's 30002 port to the machine's 30002 port, allowing RPC requests to be sent directly to the docker. It is subsequently packed by our blockchain program and put on chain.

### Notes

In this mirror, all IOSTs are put into an initial account, with 21,000,000,000 IOST. When we need to initiate a transaction or publish a contract, you need to transfer money from that account. Since any IOST transaction costs gas, and all tokens are stored in the initial account, only that account can afford a transaction.

- Initial Account: `IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C`
- Initial Secret: `1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB`

## How to Transfer IOST to Another Account

### Generate an account

```bash
// This will generate a private/public key pair under ~/.iwallet/ folder
./iwallet account
```

### Initiate a transaction

```bash
// Normally we ask the fromID to sign the transaction
./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' --signer "ID0, ID1"
// Example
./iwallet call iost.system Transfer '["IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", 100]' --signers "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
```

This will generate an `iost.sc` transaction file. We should follow the publishing workflow to put this contract on chain, as mentioned in *Deployment and invocation*.

## Putting a Contract on the Local Chain

Please refer to *Deployment and invocation*.

## Check If Contract Is On Chain

When we publish a transaction or a contract, we initiate a `Transaction`. `iWallet` will return a hash to this `Transaction`, and this hash will be the ID of the transaction. We can look up whether the transaction is successfully published.

```bash
./iwallet transaction $TxID
```

If the transaction failed to publish, we can export the log from the docker, and check detailed error information.

```bash
docker logs $ContainerID
```
