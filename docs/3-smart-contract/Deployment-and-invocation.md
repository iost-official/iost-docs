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

### Collect .sig files and the .sc files, and publish them on chain
Finally, use ```.js``` file and ```.abi``` file to deploy the contract to chain.

```bash
# publish a transaction with .sig file from every signer
./iwallet --server serverIP --account acountName --amount_limit amountLimit publish jsFilePath abiFilePath
# Example
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...

#Return
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh
```
