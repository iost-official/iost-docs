---
id: Smart-contract
title: 스마트 컨트랙트
sidebar_label: 스마트 컨트랙트
---
스마트 컨트랙트는 블록에 담긴 트랜잭션을 받아서 실행하여, 스마트 컨트랙트 내부의 변수 값을 유지합니다. 이는 IOST 블록체인 위에서 일어나기 때문에 일단 트랜잭션이 블록에 들어가게 되면 "되돌릴 수 없는" 비가역적 성질을 지니게 됩니다. IOST는 ABI 인터페이스와 플러그 앤 플레이, 여러 개발 언어를 지원하여 블록체인을 좀 더 쉽게 사용할 수 있게합니다.

## ABI 인터페이스
IOST 스마트 컨트랙트는 ABI를 통해서 IOST 블록체인 네트워크와 상호작용 할 수 있습니다. ABI는 쉽게 말해, JSON으로 정의된 정보인데, 이 정보에는 컨트랙트의 이름, 파라미터들의 타입 등 컨트랙트 함수 실행에 필요한 정보가 담기게 됩니다. 현재 지원되는 타입으로는 `string`, `number`, `bool`이 있습니다.

스마트 컨트랙트 함수를 실행할 때에는 ABI에 정의된 대로 파라미터 타입을 맞춰주어야 하며, 이를 맞춰주지 않은 채로 컨트랙트 함수 실행을 하게되면 트랜잭션 수수료가 발생하고 실제로 함수가 정상적으로 실행되지 않습니다.

```json
// example luckybet.js.abi
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "bet",
            "args": [
                "string",
                "number",
                "number",
                "number"
            ]
        }
    ]
}
```

모든 트랜잭션에는 `Action`이라고 하는 트랜잭션을 일으키는 구현체가 존재하는데, 각 Action은 ABI에 대한 호출이라고 생각하면 된다. 모든 트랜잭션은 블록체인 내에서 strict serial을 만들어 이중 지불 공격을 막는다.

```golang
type Action struct {
	Contract   string  
	ActionName string
	Data       string  // A JSON Array of args
}
```

스마트 컨트랙트 내에서 `BlockChain.call()`을 통해 ABI interface를 호출하여, 리턴되는 값을 얻을 수 있습니다. 이러한 시스템은 콜 스택에 로그를 남겨 이중 지불(double-spend)를 방지합니다.

## 다중 언어 지원
IOST에선, 여러 언어로 스마트 컨트랙트를 개발 할 수 있습니다. 현재는 V8 엔진 위에서 자바스크립트로 스마트 컨트랙트를 개발할 수 있고, 고 성능의 트랜잭션을 처리 할 수 있는 golang VM 모듈도 존재합니다.

IOST의 스마트 컨트랙트 엔진은 `monitor`, `VM`, `host`라는 세 가지 요소로 구성됩니다. monitor는 ABI 콜을 적절한 VM으로 보내주는 글로벌 제어 장치이고, VM은 스마트 컨트랙트의 버츄얼 머신 구현체입니다. 마지막으로 host는 런타임 환경을 구성하고 컨트랙트가 올바른 컨텍스트 내에서 실행 될 수 있게 합니다.

## 스마트 컨트랙트 '권한' 시스템
IOST의 트랜잭션은 다중 서명(multiple signatures)를 지원합니다. 스마트 컨트랙트 내에 `RequireAuth()`라는 함수가 존재하는데, 이를 통해서 현재 트랜잭션의 컨텍스트가 특정한 ID의 서명을 가지고 있는지 확인 할 수 있습니다. 또한 스마트 컨트랙트 간의 호출은 이러한 서명 인증 전달하는데, 예를 들면 A 컨트랙트의 `a`라는 함수가 B 컨트랙트의 `b`를 호출하는 구조인 경우, 사용자가 A 컨트랙트의 `a` 함수를 호출할 때 서명에 대해서 인증이 되었다면, 인증되었다는 정보가 B 컨트랙트의 `b` 함수에서도 그대로 전달됩니다.

스마트 컨트랙트는 콜 스택을 체크하여 현재 누가 이 ABI를 호출하였는지에 대해서 알려줄 수 있습니다. 이를 통해 ABI 호출한 사람이 누구인지에 따라서 다른 로직을 적용하게끔 개발할 수 있습니다.

스마트 컨트랙트는 컨트랙트를 업그레이드 하거나 삭제할 수 있는 특별한 권한이 존재하는데, 이들은 각각 `can_update()`와 `can_destroy()` 함수를 통해 권한 여부에 대해서 알 수 있습니다.

## 컨트랙트 실행(Call) 결과
컨트랙트 함수 실행 후, 스마트 컨트랙트는 `TxReceipt`를 만들어 블록에 집어넣고 컨센서스(합의)를 기다립니다. `TxReceipt`가 합의를 거쳐 최종적으로 블록에 들어가게 되면 RPC를 이용해서 블록체인에서 발생한 `TxReceipt` 들을 조회할 수 있습니다.

```sh
$ curl -X GET \
  http://52.192.65.220:30001/getTxReceiptByTxHash/G62UQbq9u8MP8cNLD9HUpMFtstTvRUAJ4avzKiAJc86f \
  -H 'Cache-Control: no-cache' \
  -H 'Postman-Token: 2442fe9c-0c80-4459-a9e6-0001bbde3dbb'l
{
    "txReceiptRaw": {
        "txHash": "4CjfeOvtjmhdZep9WG5pPoEoLPu90avQkbGKefTKNaw=",
        "gasUsage": "1129",
        "status": {},
        "succActionNum": 1
    },
    "hash": "eU9xHGM15gfDInAG7Y8q3RB9mMm1Pekmj4RUUHWFkqU="
}

```
