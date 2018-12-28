---
id: Deployment-and-invocation
title: 배포와 실행
sidebar_label: 배포와 실행
---

자바스크립트 스마트 컨트랙트 작성이 끝났으면, 이를 블록체인에 배포할 수 있습니다.

배포는 다음과 같은 단계를 거칩니다:

- 자바스크립트를 컴파일 하여 ABI 파일 생성하기
- ABI 파일 수정하기
- .js 파일과 .abi 파일들을 이용해서 .sc 파일을 생성하기
- .sc 파일을 각각의 서명자들에게 보내고(단독 서명일 경우 스스로만 가지고 있어도 됩니다.) .sig 파일을 생성하기
- 생성된 .sig 파일들을 모아 .sc 파일을 블록체인에 배포하기

### 자바스크립트를 컴파일하여 ABI 파일 생성하기

배포를 하기 위해서는 iWallet 프로그램이 필요합니다. 앞서 환경설정을 통해서 `go-iost/target` 경로에 iWallet 프로그램이 설치되어 있습니다. 만약 설치가 되어있지 않다면, *환경 설정* 챕터를 확인해주세요.

iWallet을 통해서 js 파일을 컴파일하고, ABI 파일을 만듭니다.

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

위 명령어는 .js.abi 파일과 .js.after 파일을 생성합니다.

### ABI 파일 수정하기
컨트랙트를 배포하기 전에 위에서 생성된 .abi 파일에는 몇 가지 수정이 필요합니다. 확인해야 할 사항은 다음과 같습니다.

- abi 필드가 null이 아닐 것
- "abi" 필드에 정의되어 있는 "args"에 들어있는 각각의 인자들이 올바른 타입으로 설정되어 있을 것

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

### .js 파일과 .abi 파일들을 이용해서 .sc 파일을 생성하기

다음으로, .js 파일과 js.abi 파일을 이용하여 .sc 파일을 생성해봅시다.

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signers "ID0, ID1..."
# Example
./iwallet compile -e 10000 -l 100000 -p 1 ./test.js ./test.js.abi --signers "ID"
```

### .sc 파일을 각각의 서명자들에게 보내고 .sig 파일을 생성하기

컨트랙트 배포가 단독 서명으로 이루어 질 경우에는 .sc 파일을 다른 서명자에게 보낼 필요 없이 .sig 파일을 만들면 되지만, 다중 서명일 경우에는 .sc 파일을 다른 서명자에게도 보내어 .sig 파일들을 만들 수 있게끔 해야 합니다.

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

### 생성된 .sig 파일들을 모아 .sc 파일을 블록체인에 배포하기

.sc 파일로 부터 생성된 .sig 파일들이 모였다면, .sc 파일을 최종적으로 배포합니다.

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.iwallet/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
