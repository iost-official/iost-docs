---
id: Deployment-and-invocation
title: Deployment and invocation
sidebar_label: Deployment and invocation
---

When we finish a JavaScript smart contract, we need to deploy it on the chain.

Deployment takes a few steps:

- Compile js to generate ABI filter
- Use .js and .abi files to generate the .sc packer file
- Distribute .sc files to each signer, and signers will generate .sig files
- Collect .sig files and the .sc files, and publish them on chain

Deployment needs the iWallet program in the project. I'm sure you have already compiled an iWallet program from the documents, in the `GO-IOS-Protocol/target` directory.

First, use iWallet to compile the js codes into corresponding ABIs.

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

This will generate .js.abi files and .js.after files.

Next, generate .sc files with js and js.abi files.

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signer "ID0, ID1..."
# Example
./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
```

Distribute the .sc files to corresponding signers, and obtain .sig files.

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

Finally, deploy the .sc file in the Transaction, as well as all signed .sig files.

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.ssh/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
