---
id: iWallet
title: iWallet
sidebar_label: iWallet
---

**IOSTBlockchain** 은 두 가지 프로그램으로 구성됩니다: `iServer` 가 가장 핵심이 되는 프로그램으로, 여러개의 `iServer` 프로그램이 IOST 블록체인 네트워크를 구성합니다. `iWallet` 은 CLI로 `iServer` 프로그램과 상호작용하는데에 사용됩니다.

시스템을 빌드(`build`) 하는데에 성공했다면, `iWallet` 프로그램과 `iServer` 프로그램은 프로젝트 디렉토리의 `target/` 폴더에 생성되어 있습니다.

![iWallet](../assets/4-running-iost-node/iWallet/iwallet.png)

## 명령어 목록

|명령어      |내용                                |실행 예
|:-----------:|:--------------------------------------:|:--------------------------------------------|
|help         |iWallet의 명령어 안내 기능                  |  ./iwallet -h
|account      |계정 관리 기능                             |  ./iwallet account -n id
|balance      |특정 계정의 잔액(balance) 조회 기능           |  ./iwallet balance ~/.iwallet/id_ed25519.pub
|block        |블록 정보 출력 기능                         |  ./iwallet block -m num 0
|call         |컨트랙트의 함수 호출 기능                     |  ./iwallet call "iost.system" "Transfer" '["fromID", "toID", 100]' -k SecKeyPath --expiration 50
|compile      |컨트랙트 파일 컴파일 기능                     |  ./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
|net          |네트워크 ID 조회 기능                       |  ./iwallet net
|publish      |.sc 파일 서명 후 컨트랙트 배포 기능            |./iwallet publish -k ~/.iwallet/id_ed25519 ./dashen.sc ./dashen.sig0 ./dashen.sig1
|sign         |.sc file 서명 기능                        |  ./iwallet sign -k ~/.iwallet/id_ed25519 ./test.sc
|transaction  |트랜잭션 조회 기능(트랜잭션 해시로 조회)          |  ./iwallet transaction HUVdKWhstUHbdHKiZma4YRHGQZwVXerh75hKcXTdu39t

## 명령어 사용 예제

### help:

`iwallet`의 명령어 안내 기능을 출력합니다.

```
./iwallet -h
```

### account:

IOST 계정을 생성하고 계정의 퍼블릭 키와 프라이빗 키를 `~/.iwallet/` 경로에 저장합니다.

```
./iwallet account -n id
return:
the iost account ID is:
IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
```

### balance:

계정의 잔액을 조회합니다.

```
./iwallet balance IOSTPVgmuin4vxcqxLvNQ2XnRxPk64MtDkanQEZ4ttkysbjPD6XiW
return:
1000 iost
```

### block:

블록 정보를 조회합니다. (블록 해시나 블록넘버를 통해 조회가능합니다.)

```
# 查询0号block数据
./iwallet block -m num 0
return:
{"head":{"txsHash":"bG7L/GLaF4l8AhMCzdl9r7uVvK6BwqBq/sMMuRqbUH0=","merkleHash":"cv7EfVzjHCzieYStfEm61Ew4zbNFYN80i/6J8Ijhbos=","witness":"IOST2FpDWNFqH9VuA8GbbVAwQcyYGHZxFeiTwSyaeyXnV84yJZAG7A"},"hash":"9NzDz2iueLZ4e8YDotIieJRZrlTMddbjaJAvSV23TFU=","txhash":["3u12deEbLcyP7kI5k+WIuxUrskAOu8UKUOPV+H51bjE="]}
```

### call:

배포된 컨트랙트의 메서드를 호출하는데에 `call`을 사용합니다.

```
# Calls iost.system contract's Transfer method，Account IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP transfers Account IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk 100 token,
# -k is private key，--expiration specifies timeout
./iwallet call "iost.system" "Transfer" '["IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP", "IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk", 100]' -k ~/.iwallet/id_ed25519 --expiration 50
return:
ok
8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
```

### net:

`net` 명령어는 iServer의 네트워크 아이디를 출력합니다.

```
./iwallet net
return:
netId: 12D3KooWNdJgdRAAYoHvrYgCHhNEXS9p7LshjmJWJhDApMXCfahk

```

### transaction:

`transaction` 명령어는 트랜잭션 ID(트랜잭션 해시)를 조회할 때에 사용됩니다.

```
./iwallet transaction 8LaUT2gbZeTG8Ev988DELNjCWSMQ369uGHAhUUWEHxuV
return:
txRaw:<time:1537540108548894481 expiration:1537540158548891677 gasLimit:1000 gasPrice:1 actions:<contract:"iost.system" actionName:"Transfer" data:"[\"IOSTjBxx7sUJvmxrMiyjEQnz9h5bfNrXwLinkoL9YvWjnrGdbKnBP\", \"IOSTEj4hBu1b3WwGKscUpcdE7ULtMAPbazt1VeALcvf28CDHc5oAk\", 100]" > publisher:<algorithm:2 sig:"\224iI\0300\317;\337N\030\031)'\277/xO\231\325\277\022\217M\017k.\260\205+*$\235\017}\353\007\206\352\367N(\203\343\333\017\374\361\230\313,\231\313* oK\270.f;6\371\332\010" pubKey:"_\313\236\251\370\270:\004\\\016\312\300\2739\304\317Jt\330\344P\347s\2413!\3725\3126\246\247" > > hash:"m\005\2613%\371\234\233\315\377@\016\253Aw\024\214IX@\0368\330\370T\241\267\342\256\252\354P"

```

### 컴파일/배포/서명:

[배포와 실행](../3-smart-contract/Deployment-and-invocation)챕터를 참조해주세요.
