---
id: Contract-Testing
title: Testing
sidebar_label: Testing
---

To conveniently test smart contracts, IOST has provided developers with standalone block-generating docker mirror. This can help developers ensure the validity of smart contracts before putting them on the main chain, by allowing them to use the standalone docker as the backend of RPC requrests.

It's worth noting that, contracts are not directly put on chain when uploaded to the receiving end of RPC. The contract will have to wait for the next block to be generated. Validity check will be run, too, when the contract is packed into the block.

## Launch Docker Mirror

```bash
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:2.0.0
```

With this command, we map the docker's 30002 port to the machine's 30002 port, allowing RPC requests to be sent directly to the docker. It is subsequently packed by our blockchain program and put on chain.

### Notes

In this mirror, all IOSTs are put into an initial account, with 21,000,000,000 IOST. When we need to initiate a transaction or publish a contract, you need to transfer money from that account. Since any IOST transaction costs gas, and all tokens are stored in the initial account, only that account can afford a transaction.

## How to Transfer IOST to Another Account

### Generate an account

```bash
// This will generate a private/public key pair under ~/.iwallet/ folder
./iwallet account
// Import Admin 
./iwallet account --import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```

### Initiate a transaction

```bash
// Normally we ask the fromID to sign the transaction
./iwallet -s localhost:30002 --account admin  account --create yourAccountName --initial_balance 1000 --initial_gas_pledge 10 --initial_ram 0
// Example
./iwallet -s localhost:30002 --account admin  account --create lispczz3 --initial_balance 1000 --initial_gas_pledge 10 --initial_ram 0
```

## Check If Contract Is On Chain

When we publish a transaction or a contract, we initiate a `Transaction`. `iWallet` will return a hash to this `Transaction`, and this hash will be the ID of the transaction. We can look up whether the transaction is successfully published.

```bash
./iwallet transaction $TxID
```

If the transaction failed to publish, we can export the log from the docker, and check detailed error information.

```bash
docker logs $ContainerID
```
