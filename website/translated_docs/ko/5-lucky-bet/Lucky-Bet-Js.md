---
id: Lucky-Bet-Js
title: 행운의 베팅 자바스크립트 코드
sidebar_label: 행운의 베팅 자바스크립트 코드
---

## IOST 블록체인의 정보 가져오기

랜덤 숫자를 생성하는데 가장 쉬운 방법은 블록체인의 정보를 이용하는 것입니다.  
\*주의: 블록체인의 정보를 이용해서 랜덤 숫자를 생성하는 것은 조작될 우려가 있어 안전하지 못한 방법입니다. 이 튜토리얼에서는 쉬운 설명을 위해서 위와 같은 방법을 사용했습니다.

```javascript
	const bi = JSON.parse(BlockChain.blockInfo());
	const bn = bi.number;
	const ph = bi.parent_hash;
	const lastLuckyBlock = JSON.parse(storage.get("last_lucky_block"));

	if ( lastLuckyBlock < 0 || bn - lastLuckyBlock >= 9 || bn > lastLuckyBlock && ph[ph.length-1] % 16 === 0) {
		// do lottery
	}
```

`BlockChain.blockInfo()` 함수를 호출하면 블록체인의 정보를 상세하게 알 수 있습니다. 이 정보는 랜덤 숫자를 만드는데에 사용됩니다.

## 상태 데이터(Status data) 관리 및 사용

스마트 컨트랙트가 데이터를 저장하는 방법은 두 가지입니다:

```javascript
const maxUserNumber = 100;
```

상수(Constants)를 컨트랙트 클래스의 외부에 정의하는 방법: 컨트랙트 클래스의 외부에 상수(Constants)를 정의하게 되면 컨트랙트 클래스 내부에서도 그대로 쓸 수 있으며, 실제로 컨트랙트 내부 데이터에 담긴 것은 아니기 때문에 추가적인 스토리지 비용이 발생하진 않습니다.

```javascript
	storage.put("user_number", JSON.stringify(0));
	storage.put("total_coins", JSON.stringify(0));
	storage.put("last_lucky_block", JSON.stringify(-1));
	storage.put("round", JSON.stringify(1));
```

`storage.put` 함수나 `storage.get` 함수를 이용해 스토리지 시스템에 접근해서, 키-밸류 형태의 데이터를 쓰거나 읽을 수 있습니다.  
주의할 점은, 현재 스토리지의 값으로 들어갈 수 있는 타입은 String 타입입니다. 따라서 `JSON.stringify`를 꼭 해주어야합니다.  
이렇게 키-밸류 형태의 데이터를 컨트랙트 내부에 저장하는 것은 쓰기/읽기 비용이 발생하게 됩니다.
