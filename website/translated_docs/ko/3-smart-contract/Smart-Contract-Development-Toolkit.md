---
id: Smart-Contract-Development-Toolkit
title: Scaf: 스마트 컨트랙트 개발 툴
sidebar_label: Scaf: 스마트 컨트랙트 개발 툴
---

## Features

Scaf은 IOST 스마트 컨트랙트를 작성하기 쉽게하기 위해 다음과 같은 기능들을 제공합니다:

- dapp 프로젝트에 맞는 폴더 구조 생성
- 컨트랙트 파일 초기화와 함수 생성, 테스트 기능을 명령어로 제공
- 컨트랙트를 테스트하는데 필요한 Mocking 기능
- 컨트랙트 파일 컴파일 후 유효한 컨트랙트와 블록체인에 배포 될 ABI 파일 생성
- 컨트랙트 테스트 케이스 실행 기능

## 설치하기

시작하기 전에, node와 npm이 컴퓨터에 반드시 설치되어 있어야합니다. node와 npm이 설치되어 있지 않다면, *환경 설정* 챕터를 확인해주세요.

1. `git clone git@github.com:iost-official/dapp.git`

2. `cd dapp`

3. `sudo npm install`

4. `sudo npm link`

## 명령어

`scaf`를 터미널에 입력해보세요. 사용방법과 기본 명령어에 대한 설명이 제공됩니다.

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
### 새 프로젝트 만들기

```
scaf new <contract_name>
```

위 명령어를 통해 현재 디렉토리에 스마트 컨트랙트 프로젝트에 필요한 폴더 구조를 만듭니다.

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

### 컨트랙트 생성하기

```
cd <contract_name>
scaf add contract <contract_name>
```

`add <item>` 명령어는 반드시 프로젝트 디렉토리에서 실행되어야 합니다. 컨트랙트 파일 `helloContract.js` 과 ABI 파일 `helloContract.json`은 다음과 같은 내용으로 생성됩니다:

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

### 컨트랙트에 함수 추가하기

```
scaf add func <contract_name> <function_name> [type0] [parameter0] [type1] [parameter1] ...
```

위의 명령어는 `hello`라는 이름의 함수를 만들어 `helloContract` 클래스에 추가합니다. `string p0` 은 `string` 타입의 `p0`이라는 이름을 가진 인자를 `hello`라는 함수의 인자로 추가하는 것을 의미합니다.

인자의 타입으로는 ['string', 'number', 'bool', 'json'] 를 허용합니다.

함수 `hello(p0)` 와 이에 해당하는 ABI 정보는 각각 `helloContract.js` and `helloContract.json`에 추가됩니다.

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

이제 `contract/helloContract.js`의 `hello(p0) {}` 함수의 내부에 로직을 구현해보겠습니다.

```js
hello(p0) {
  console.log(BlockChain.transfer("a", "b", 100));
  console.log(BlockChain.blockInfo());
  console.log("hello ", p0);
}
```

`hello(p0)` 함수 내부에, `BlockChain.transfer()` 과 `BlockChain.blockInfo()`라는 시스템 함수의 실행결과를 출력하도록 구현했습니다.

### 테스트 추가하기

```
scaf add test <contract_name> <test_name>
```

위 명령어는 `<contract_name>` 컨트랙트에서 사용될 `<test_name>` 이라는 이름의 테스트를 만듭니다.
이를 통해 `<contract_name>_<test_name>.js`라는 이름의 파일이 `test/` 경로에 생성됩니다. 파일의 내부에는 컨트랙트를 가리키는 `require`문 한 줄이 존재합니다.

아래의 예제는 `helloContract` 컨트랙트에서 사용될 `test1`이라는 이름의 테스트를 추가하여, `test/` 경로에 `helloContract_test1.js` 파일을 생성한 예제입니다.
```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add test helloContract test1
create file: ./test/helloContract_test1.js

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');
```
`require`문만 존재하던 test/helloContract_test1.js 파일 내부를 수정해봅시다.
```js
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');

var ins0 = new helloContract();
ins0.hello("iost");
```

### 테스트 실행하기

```
scaf test <contract_name>
```

위 명령어는 `<contract_name>`에 정의된 모든 테스트를 실행합니다.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf test helloContract
test ./test/helloContract_test1.js
transfer  a b 100
0
{"parent_hash":"0x00","number":10,"witness":"IOSTwitness","time":1537000000}
hello  iost
```

### 컨트랙트 컴파일하기

```
scaf compile <contract_name>
```

위 명령어는 컨트랙트 파일을 컴파일하여 ABI 파일을 `build/` 경로에 생성합니다. 추후에 배포 시에는 이 파일들을 이용하여 IOST 블록체인에 올립니다.

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
