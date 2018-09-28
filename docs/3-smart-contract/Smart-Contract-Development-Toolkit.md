---
id: Smart-Contract-Development-Toolkit
title: Scaf: A Marvelous Smart Contract Development Toolkit
sidebar_label: Scaf: A Marvelous Smart Contract Development Toolkit
---

## Features

Scaffold is designed to offer developers convenience when writing js smart contract for IOST blockchain. It features the following:

- Initializing a dapp project with appropriate structure
- Commands to init contract files, add functions and add tests for contract easily
- Mocked system functions (including blockchain functions and storage functions) are embedded to test contract properly
- Compiling contract file to generate valid contract and abi file which can be uploaded to blockchain directly
- Running test cases for a contract

## Install and Setup

Before you start, make sure you have node and npm installed on your computer.

1. `git clone git@github.com:iost-official/dapp.git`

2. `cd dapp`

3. `sudo npm install`

4. `sudo npm link`

## Commands

`help` is printed when entering specific commands.

```console
usr@Tower [master]:~/nodecode/dapp$ scaf
Usage: scaf <cmd> [args]

Commands:
  scaf new <name>      create a new DApp in current directory
  scaf add <item>      add a new [contract|function]
  scaf compile <name>  compile contract
  scaf test <name>     test contract

Options:
  --version   Show version number                                      [boolean]
  -h, --help  Show help                                                [boolean]

Not enough non-option arguments: got 0, need at least 1
usr@Tower [master]:~/nodecode/dapp$ scaf add
Usage: scaf add <item> [args]

Commands:
  scaf add contract <name>                  create a smart contract class
  scaf add func <con_name> <func_name>      add a function to a contract class
  [param...]
  scaf add test <con_name> <test_name>      add a test for a contract class

Options:
  --version           Show version number                              [boolean]
  -h, --help, --help  Show help                                        [boolean]

Not enough non-option arguments: got 0, need at least 1
```

## Hello BlockChain
### Create a new project

```
scaf new <contract_name>
```

The project is generated in the current directory, with initialized structure.

```console
usr@Tower [master]:~/nodecode/dapp$ scaf new helloBlockChain
make directory: helloBlockChain
make directory: helloBlockChain/contract
make directory: helloBlockChain/abi
make directory: helloBlockChain/test
make directory: helloBlockChain/libjs

usr@Tower [master]:~/nodecode/dapp$ ls helloBlockChain/
abi  contract  libjs  test
```

### Add a contract

```
cd <contract_name>
scaf add contract <contract_name>
```

`add <item>` command should be executed in project directory. Contract file `helloContract.js` and ABI file `helloContract.json` is generated with following initial content:

```js
usr@Tower [master]:~/nodecode/dapp$ cd helloBlockChain/

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add contract helloContract
create file: ./contract/helloContract.js
create file: ./abi/helloContract.json

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat contract/helloContract.js
const rstorage = require('../libjs/storage.js');
const rBlockChain = require('../libjs/blockchain.js');
const storage = new rstorage();
const BlockChain = new rBlockChain();

class helloContract
{
    constructor() {
    }
    init() {
    }
};
module.exports = helloContract;

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat abi/helloContract.json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
    ]
}
```

### Add a function

```
scaf add func <contract_name> <function_name> [type0] [parameter0] [type1] [parameter1] ...
```

The above command adds a function named `hello` to `helloContract` class. `string p0` means function `hello` has one parameter with type `string` and name `p0`.

The type of parameter should be one of ['string', 'number', 'bool', 'json']

function `hello(p0)` and its corresponding ABI infomation is added into `helloContract.js` and `helloContract.json`.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add func helloContract hello string p0
add function hello() to ./contract/helloContract.js
add abi hello to ./abi/helloContract.json
{
    "name": "hello",
    "args": [
        "string"
    ]
}
```

Now edit `contract/helloContract.js` to implement function `hello(p0) {}`

```js
hello(p0) {
  console.log(BlockChain.transfer("a", "b", 100));
  console.log(BlockChain.blockInfo());
  console.log("hello ", p0);
}
```

In the function `hello(p0)`, we log the result of two system functions, `BlockChain.transfer()` and `BlockChain.blockInfo()`.

Since system functions are mocked, they will always return the same valid results.

### Add a test

```
scaf add test <contract_name> <test_name>
```

This command adds a test named test1 for `helloContract` contract. `helloContract_test1.js` is created in `test/` with just one `require` statement.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add test helloContract test1
create file: ./test/helloContract_test1.js

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');
```
Now edit test/helloContract_test1.js
```js
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');

var ins0 = new helloContract();
ins0.hello("iost");
```

### Run test

```
scaf test <contract_name>
```

This command will run all the tests of specific contract.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf test helloContract
test ./test/helloContract_test1.js
transfer  a b 100
0
{"parent_hash":"0x00","number":10,"witness":"IOSTwitness","time":1537000000}
hello  iost
```

### Compile the contract

```
scaf compile <contract_name>
```

This command compiles contract file and the ABI file is created in `build/`. You can upload these files to an IOST blockchain.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf compile helloContract
compile ./contract/helloContract.js and ./abi/helloContract.json
compile ./abi/helloContract.json successfully
generate file ./build/helloContract.js successfully

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ find build/
build/
build/helloContract.js
build/helloContract.json
```
