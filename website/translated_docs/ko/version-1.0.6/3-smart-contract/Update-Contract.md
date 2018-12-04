---
id: Update-Contract
title: 컨트랙트 업데이트
sidebar_label: 컨트랙트 업데이트
---

## 컨트랙트 업데이트

컨트랙트를 블록체인에 배포하고 난 후에는, 발생하는 버그를 고치거나, 버전 업그레이드 등 컨트랙트의 기능을 업데이트하고 싶을 때가 있을 것입니다.

IOST에서는 이러한 컨트랙트 업그레이드 메커니즘을 제공합니다. 컨트랙트 업그레이드는 업그레이드 트랜잭션을 전송하는 것으로 쉽게 적용할 수 있습니다. 물론, 어느 누구나 컨트랙트를 업그레이드를 한다면 문제가 발생할 수 있기 때문에, 업그레이드 권한에 대해서도 설정할 수 있는 기능이 제공됩니다.

스마트 컨트랙트를 업그레이드 하기 위해서는 우선, 컨트랙트 내부에 `can_update` 라는 이름의 함수를 만듭니다.

```js
can_update(data) {
}
```

스마트 컨트랙트가 업데이트 요청의 트랜잭션을 받은 경우, 컨트랙트는 우선 `can_update(data)` 함수를 실행합니다. (여기서 `data`로 들어오는 인자는 optional한 string 타입의 인자입니다.) 만약 이 함수가 true를 리턴한다면, 컨트랙트의 업데이트가 실행되고, 반대의 경우에는 `Update refused`라는 에러가 리턴됩니다.

이 함수를 잘 활용해서 권한 관리를 유연하게 할 수 있습니다. 예를 들어, "어느 두 명의 사람이 동시에 update에 대해서 승인한 경우 업데이트를 진행한다.", 또는 "몇 명의 사람이 컨트랙트 업데이트하는 것에 투표를 했을 때 업데이트를 진행한다."와 같은 로직을 추가하는 것이 가능합니다.

만약 이러한 `can_update` 함수가 컨트랙트 내부에 선언되어 있지 않다면, 그 컨트랙트는 업데이트가 허용되지 않습니다.

## Hello BlockChain

컨트랙트를 업데이트하는 간단한 예제입니다.

### 컨트랙트 생성하기
우선 `iwallet account` 명령어를 이용해 계정을 생성합니다.
`-n` 옵션은 단순히 계정에 이름을 지어주는 것으로, 아래 예제에서와 같이 `./iwallet account -n update`을 하게 되면, update라는 이름의 계정이 생성되게 됩니다. 생성된 계정의 account ID를 저장해두세요.
```console
./iwallet account -n update
return:
the iost account ID is:
IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h
```

helloContract.js 의 이름으로 새 컨트랙트 파일을 만들고 helloContract.json 이라는 이름의 ABI 파일을 만듭니다. 각각 파일의 내용은 아래에 있는 내용을 그대로 넣어주세요.
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "hello block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": []
        },
		{
			"name": "can_update",
			"args": ["string"]
		}
    ]
}
```
위의 코드에서 can_update() 함수의 내부를 살펴보면 `adminID` 라는 변수에 IOST의 계정 아이디가 들어가있는데, 이는 `BlockChain.requireAuth(adminId)` 함수와 같이 여기에 선언되어 있는 계정 아이디(IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h)만 컨트랙트를 업데이트 할 수 있게 해줍니다.

### 컨트랙트 배포하기

[배포와 실행](../3-smart-contract/Deployment-and-invocation) 챕터를 참조해주세요.

배포 후에 컨트랙트 ID(contractID)를 저장해주세요.
(ex: ContractHDnNufJLz8YTfY3rQYUFDDxo6AN9F5bRKa2p2LUdqWVW)

### 컨트랙트 업데이트하기
helloContract.js 파일을 다음과 같은 내용으로 수정해봅시다:
First edit the contract file helloContract.js to generate a new contract code as follows:
```js
class helloContract
{
    constructor() {
    }
    init() {
    }
    hello() {
		const ret = storage.put("message", "update block chain");
        if (ret !== 0) {
            throw new Error("storage put failed. ret = " + ret);
        }
    }
	can_update(data) {
		const adminID = "IOSTURXazDVc1hJ9R9HdFxt2PivzKxUdUaN1A7rgRkoBDMJZ9qj2h";
		const ret = BlockChain.requireAuth(adminID);
		return ret;
	}
};
module.exports = helloContract;
```
위의 코드에서 기존의 helloContract.js 파일의 `hello()` 함수 내부의 `storage.put`에 들어가는 값을 "hello block chain"에서 "update block chain"으로 수정했습니다.

이제 변경된 사항을 담은 컨트랙트를 업그레이드 하기 위해서 다음 명령어를 사용합니다:

```console
./iwallet compile -u -e 3600 -l 100000 -p 1 ./helloContract.js ./helloContract.json <合约ID> <can_update 参数> -k ~/.iwallet/update_ed25519
```
위 명령어의 `-u` 옵션은 컨트랙트를 업데이트하는 옵션입니다. 다음으로 `-k` 옵션은 트랜잭션을 서명하고 배포할 프라이빗 키를 입력하는 옵션입니다. `-k` 뒤에 프라이빗 키의 경로를 입력해주세요. 기본적으로 프라이빗 키의 경로는 `~/.iwallet`로 설정되어있습니다. 바로 전에 `update`라는 이름의 계정을 만들었기 때문에 경로에 `update_ed25519` 파일과 `update_ed25519.pub` 파일이 존재합니다. 이 중 `update_ed25519`가 트랜잭션 서명과 전송에 쓰이는 프라이빗 키입니다.

트랜잭션이 컨펌되고 나면, 컨트랙트가 업데이트가 됩니다. iwallet을 통해 `hello()` 함수를 실행해서 "message"가 실제로 "update block chain"으로 변경되었음을 확인할 수 있습니다.
