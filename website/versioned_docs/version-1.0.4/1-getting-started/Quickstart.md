---
id: version-1.0.4-Quickstart
title: Quickstart
sidebar_label: Quickstart
original_id: Quickstart
---

# The easiest way

## 1. Clone the repository
```
git clone https://github.com/iost-official/Go-IOS-Protocol.git
cd Go-IOS-Protocol
```

## 2. Install the dependencies

Just run this to install all dependencies:

```
cd Go-IOS-Protocol/cmd/playground/contract
npm install
```


## 3. Write a smart contract
IOST smart contract supports Javascript. A sample smart contract looks like:

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

## 4. Deployment

The deployment requires the following steps:

- Compile js to generate ABI files
- Generate a package file for transaction using .js and .abi files .sc
- Issue the .sc file to each signer, and the signer generates the .sig file
- Collect .sig files and .sc files, publish to the main chain