---
id: Account
title: Account
sidebar_label: Account
---


# Account Permission System

## Overview

The account-permission system of IOST is based on the mechanism of public-private key pairs. By setting up owner key and active key, users may conveniently manage multiple account systems, and at the same time, set up new permission and secret weight at will. This enables many customized management functionalities.

## Basics of Account System

An IOST account is created with ID and permissions. An account may have multiple permissions, and has `owner` and `active` permissions at the very least. Each permission will register multiple items, with one item being a public key ID, or a permission pair from another account.

Public key is a string of `IOST` prefix + Base58-encoded public key + crc32 validation digit. 

Each item has a certain weight; correspondingly, each permission has a threshold. When a transaction item has a weight larger than the threshold, the transaction assumes that permission.

The method of checking item ownership is by checking whether the transaction signatures contain the signature for that certain item's public key (when the item is a public key), or recursively check if the transaction contains the item's account-permission pair (when the item is an account-permission pair).

Generally, smart contracts will present their account ID and permission ID when validating for permissions. The system will check the transaction's signatures, calculate the items' weights and, when the signature satisfies threshold requirements, validate the transaction. Otherwise, validation fails.

`active` permission may grant all other permissions except the `owner` permission. `owner` permission grants the same set of permissions, and allows changes to items under `owner` and `active` permissions. `active` permission is required when submitting a transaction.

Permissions can operate with groups. You may add permissions to a group, and add items to that group. This way, the items will enjoy all permissions of the group.

## Account System Usage

With smart contracts, there is a simple API to call.

```
BlockChain.requireAuth(id, permission_string)
```

This will return a boolean value for you to decide whether the operation should continue.

Generally, when using Ram and Tokens, you should first check for `active` permission of the user, or the smart contract may throw unexpectedly. Pick a unique string for `permission_string` to minimize the permission.

Normally, you should not be requiring `owner` permissions, as users shouldn't be asked for owner key unless when modifying `owner` and `active` permissions.

There is no need to require a transaction sender, as they always have the `active` permission.

At user-level, only by supplying the signature do we see users adding permissions. Assume two accounts (and assume 1 for all weights and thresholds of the keys):

```
User0
├── Groups
│   └── grp0: key3
└── Permissions
    ├── owner: key0
    ├── active: key1
    ├── perm0: key2, grp0
    ├── perm1: User1@active, grp0
    ├── perm2(threshold = 2): key4, key5, grp0
    ├── perm3: key8
    └── perm4(threshold = 2): User@perm3, key9

User1
└── Permissions
    ├── owner: key6
    └── active: key7
```

RequireAuth form

Parameters	|Sig key	  |Returns    |Notes
-----	      |----				|------	    |-------
User0, perm0		|key2			|true			|Permission granted when signature for public key is provided
User0, perm0		|key3			|true			|Permission granted when the group signature is provided
User0, perm0		|key1			|true			|Permissions granted (save for `owner` permission) when `active` key is provided
User0, perm1		|key7			|true			|key7 provides User1@active permission, thus granting perm1
User0, owner		|key1			|false		|`active` does not provide `owner` permission
User0, active		|key0			|true			|`owner` grants all permissions
User0, perm2		|key4			|false		|Signatures did not reach threshold
User0, perm2		|key4,key5	|true			|Signatures reached threshold
User0, perm2		|key3			|true			|Permission group does not calculate and check for threshold
User0, perm2		|key1			|true			|`active` does not check for threshold
User0, perm4		|key8			|false		|Can be implemented when calculating permission group's weight

## Creating and Managing Accounts

Account management is based on the contract of `account.iost`. The ABI is as follows:

```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "SignUp", // Create account
      "args": ["string", "string", "string"] // Username, ownerKey ID, activeKey ID
    },
    {
      "name": "AddPermission", // Add permission
      "args": ["string", "string", "number"] // Username, permission name, threshold
    },
    {
      "name": "DropPermission", // Drop permission
      "args": ["string", "string"] // Username, permission name
    },
    {
      "name": "AssignPermission", // Assign permission to an item
      "args": ["string", "string", "string","number"] // Username, permission, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokePermission",    // Revoke permission
      "args": ["string", "string", "string"] // Username, permission, public key ID or account_name@permission_name
    },
    {
      "name": "AddGroup",   // Add permission group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "DropGroup",   // Drop group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "AssignGroup", // Assign item to group
      "args": ["string", "string", "string", "number"] // Username, group name, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokeGroup",    // Revoke group
      "args": ["string", "string", "string"] // Username, group name, public key ID or account_name@permission_name
    },
    {
      "name": "AssignPermissionToGroup", // Assign permission to group
      "args": ["string", "string", "string"] // Username, permission name, group name
    },
    {
      "name": "RevokePermissionInGroup", // Revoke permissions from a group
      "args": ["string", "string", "string"] // Username, permission name, group name
    }
  ]
}
```

Account name are only valid with `[a-z0-9_]`, with a length between 5 and 11. Permission name and group names are only valid with `[a-zA-Z0-9_]` with a length between 1 and 32.

Normally, accounts will need to deposit IOST upon application, or the account may not be used. One way to do this is with `iost.js`:

```
newAccount(name, ownerkey, activekey, initialRAM, initialGasPledge) {
    const t = new Tx(this.config.gasPrice, this.config.gasLimit, this.config.delay);
    t.addAction("iost.auth", "SignUp", JSON.stringify([name, ownerkey, activekey]));
    t.addAction("iost.ram", "buy", JSON.stringify([this.publisher, name, initialRAM]));
    t.addAction("iost.gas", "pledge", JSON.stringify([this.publisher, name, initialGasPledge]));
    return t
}
```

To optimize account creation process, the fees are deducted as follows: account creation charges GAS from the publisher, and the new account's Ram is paid by the publisher. When the Ram accumulates to the same amount, the publisher receives the Ram back. The created account will then "pay" for the account creation.

When creating an account, you may choose to buy Ram and deposit token for the created account. We recommend deposit at least 10 tokens so that the new account has enough gas to use the network. Deposited GAS should be no less than 10 Tokens to ensure enough GAS to buy resources.