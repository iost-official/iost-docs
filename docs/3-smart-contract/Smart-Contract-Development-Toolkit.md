---
id: Smart-Contract-Development-Toolkit
title: Scaf: A Marvelous Smart Contract Development Toolkit
sidebar_label: Scaf: A Marvelous Smart Contract Development Toolkit
---

## Features
Scaffold is designed to offer developers convenience when writing js smart contract for iost blockchain.

It has following features

- init a dapp project with appropriate structure

- commands to init contract files, add functions and add tests for contract easily

- mocked system functions (including blockchain functions and storage functions) are embedded to test contract properly

- compile contract file to generate valid contract and abi file which can be uploaded to blockchain directly

- run test cases for a contract

## Install and Setup
(make sure you have node and npm installed in your computer)

1. git clone git@github.com:iost-official/dapp.git

2. cd dapp

3. sudo npm install

4. sudo npm link

## Commands
help printed when entering specific command
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
### New Project
> scaf new helloBlockChain

project is generated in current directory, with initialized structure


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


### Add a Contract
> cd helloBlockChain

> scaf add contract helloContract

'add <item>' command should be executed in project directory

contract file helloContract.js and abi file helloContract.json is generated with following initial content


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
    hello(p0) {
		console.log(BlockChain.transfer("a", "b", 100));
		console.log(BlockChain.blockInfo());
		console.log("hello ", p0);
    }
};
module.exports = helloContract;

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat abi/helloContract.json 
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": [
                "string"
            ]
        }
    ]
}
```


### Add a Function
> scaf add func helloContract hello string p0

add a func named hello to helloContract contract class. 'string p0' means function hello has one parameter with type string and name p0

function hello(p0) and its corresponding abi infomation is added into helloContract.js and helloContract.json


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

Now edit contract/helloContract.js to implement function hello(p0) {}
```js
    hello(p0) {
		console.log(BlockChain.transfer("a", "b", 100));
		console.log(BlockChain.blockInfo());
		console.log("hello ", p0);
    }
```
In function hello(p0), we log the result of two system functions, BlockChain.transfer() and BlockChain.blockInfo()

Cause system functions are mocked, these functions will always return same valid results.


### Add a test
> scaf add test helloContract test1

add a test named test1 for helloContract contract, helloContract_test1.js is created in test/ with just one require statement


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
> scaf test helloContract

scaf test <contract_name> will run all the tests of specific contract

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf test helloContract
test ./test/helloContract_test1.js
transfer  a b 100
0
{"parent_hash":"0x00","number":10,"witness":"IOSTwitness","time":1537000000}
hello  iost
```
### Compile the Contract
> scaf compile helloContract

compiled contract file and abi file is created in build/, which you can use to upload to an iost blockchain


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
