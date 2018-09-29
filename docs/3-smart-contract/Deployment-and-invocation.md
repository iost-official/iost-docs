---
id: Deployment-and-invocation
title: Deployment and invocation
sidebar_label: Deployment and invocation
---

When we finish a JavaScript smart contract, we need to deploy it on the chain.

Deployment takes a few steps:

- Compile js to generate ABI file
- Modify ABI file
- Use .js and .abi files to generate the .sc packer file
- Distribute .sc files to each signer, and signers will generate .sig files
- Collect .sig files and the .sc files, and publish them on chain

### Compile js to generate ABI file

Deployment needs the iWallet program in the project. I'm sure you have already compiled an iWallet program from the documents, in the `go-iost/target` directory.

First, use iWallet to compile the js codes into corresponding ABIs.

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

This will generate .js.abi files and .js.after files.

### Modify ABI file
Currently, the .abi file still needs some modifications. Mainly check the following items:

- Check abi field not null
- Modify the "abi" field in .abi file, change every filed in `args` into correct type

#### Example
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "transfer",
            "args": [
                "string",
                "string",
                "int"
            ]
        }
    ]
}
```

### Use .js and .abi files to generate the .sc packer file

Next, generate .sc files with js and js.abi files.

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signers "ID0, ID1..."
# Example
./iwallet compile -e 10000 -l 100000 -p 1 ./test.js ./test.js.abi --signers "ID"
```

### Distribute .sc files to each signer, and signers will generate .sig files

Distribute the .sc files to corresponding signers, and obtain .sig files.

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

### Collect .sig files and the .sc files, and publish them on chain

Finally, deploy the .sc file in the Transaction, as well as all signed .sig files.

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.iwallet/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
