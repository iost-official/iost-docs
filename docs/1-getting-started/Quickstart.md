---
id: Quickstart
title: Quickstart
sidebar_label: Quickstart
---

The Easiest Way

## 1. Clone the repository

```
git clone https://github.com/iost-official/go-iost.git
cd go-iost
```

## 2. Install the dependencies

Run this command to install all dependencies:

```
cd go-iost/iwallet/contract
npm install
```

## 3. Write your first smart contract

IOST smart contract supports JavaScript. A sample smart contract may look like this:

```
class Sample {
    init() {
        //Execute once when contract is packed into a block
    }

    constructor() {
        //Execute everytime the contract class is called
    }

    transfer(from, to, amount) {
        //Function called by other
        BlockChain.transfer(from, to, amount)

    }

};
module.exports = Sample;
```

## 4. Deploy the contract

Deployment requires the following steps:

- Compile .js files to generate ABI files
- Generate a package file for transactions with .js, .abi and .sc files
- Issue the .sc file to each signer, and the signers generate the .sig files
- Collect .sig files and .sc files. Publish the files to the main chain
