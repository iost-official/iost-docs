---
id: Contract-Testing
title: 테스팅
sidebar_label: 테스팅
---
스마트 컨트랙트 테스트를 쉽게 할 수 있게끔, IOST에서는 개발자에게 블록 생성 도커 미러를 제공합니다. 이 미러를 통해서 실제 IOST 메인체인에 스마트 컨트랙트를 올리지 않고 사전에 스마트 컨트랙트가 제대로 짜여졌는지에 대해서 확인 할 수 있습니다. 스마트 컨트랙트 함수를 테스트 할 때, 이 도커를 RPC 요청의 백엔드로 사용할 수 있습니다.

참고로 말씀드리면, 컨트랙트 배포는 RPC 요청이 끝났다고 해서 바로 되는 것이 아닙니다. 컨트랙트는 다음 블록이 생성될 때 까지 기다린 후에, 유효성 체크가 끝이나게 되면 마침내 블록에 들어가게 되어 컨트랙트가 배포되는 것입니다.

## 도커 미러 실행하기

```bash
docker run -d -p 30002:30002 -p 30001:30001 iostio/iost-node:1.0.0
```

위 명령어를 통해, 도커의 30002 포트를 매핑하여 RPC 요청들이 도커에 보내지게끔 할 수 있고, 스마트 컨트랙트의 배포 요청 또한 도커에 보내져서 최종적으로 도커 미러의 블록체인에 올라가게 됩니다.

### 도커 미러 참고사항

이 도커 미러에는 기본적으로 초기 생성 계정에 21,000,000,000의 IOST 토큰을 부여합니다. 트랜잭션을 생성하거나 컨트랙트를 배포하거나 단순히 토큰을 전송할 때 이 계정을 이용할 수 있습니다. IOST의 트랜잭션은 기본적으로 가스 수수료를 지불해야 하기 때문에, 자산이 들어있는 초기 계정을 통해서만 트랜잭션을 보내는 것이 가능합니다.

- 초기 계정: `IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C`
- 초기 계정의 시크릿 키: `1rANSfcRzr4HkhbUFZ7L1Zp69JZZHiDDq5v7dNSbbEqeU4jxy3fszV4HGiaLQEyqVpS1dKT9g7zCVRxBVzuiUzB`

## IOST를 다른 계정으로 보내기

### 새로운 계정 생성

```bash
// This will generate a private/public key pair under ~/.iwallet/ folder
./iwallet account
```

### 트랜잭션 파일 생성

```bash
// Normally we ask the fromID to sign the transaction
./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' --signer "ID0, ID1"
// Example
./iwallet call iost.system Transfer '["IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C", 100]' --signers "IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C"
```

위 명령어는 `iost.sc`라고 하는 트랜잭션 파일을 생성합니다. 이 트랜잭션 파일을 블록체인에 올려 실제로 트랜잭션을 전송하는 방법에 대해서는 *배포와 실행* 챕터에서 설명하고 있으니 해당 챕터를 확인해주세요.

## 로컬 체인에 컨트랙트 올리기

*배포와 실행* 챕터를 확인해주세요.

## 컨트랙트가 블록체인에 올라갔는지 확인하기

트랜잭션을 전송하거나 컨트랙트를 배포하고 난 후 `iWallet`은 `Transaction`의 해시값을 반환해줍니다. 이 해시값은 일종의 트랜잭션 ID라고 볼 수 있고, 이 트랜잭션 ID를 블록체인에 조회해서 트랜잭션이 성공적으로 블록체인에 들어갔는지, 컨트랙트가 성공적으로 배포되었는지 확인 할 수 있습니다.

```bash
./iwallet transaction $TxID
```

트랜잭션 전송에 실패했다면, 도커의 로그를 조회해서 상세한 에러 정보에 대해서 알 수 있습니다.

```bash
docker logs $ContainerID
```
