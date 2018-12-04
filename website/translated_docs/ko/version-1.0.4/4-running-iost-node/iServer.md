---
id: iServer
title: iServer
sidebar_label: iServer
---

## iServer 구동하기

IOST 노드 서비스인 iServer에는 합의(consensus), 동기화, 트랜잭션 풀, 네트워크 모듈이 포함되어있습니다. IOST node를 띄우기 위해서 iServer 서비스를 구동해보겠습니다.

* go-iost의 루트 디렉토리에서 컴파일을 하면 `target` 디렉토리에 iServer와 iWallet 실행 파일을 만들게 됩니다. 다음의 명령어를 입력하세요.

```
make build
```

* IOST 노드를 구동하기 위해서 아래의 명령어를 입력하세요.

```
./target/iserver -f ./config/iserver.yaml
```

* ./config/iserver.yaml 설정 파일을 아래와 같이 변경하세요. YOUR_ID와 YOUR_SECRET_KEY에 IOST 계정의 아이디와 프라이빗 키를 입력합니다.

```
acc:
  id: YOUR_ID
  seckey: YOUR_SECERT_KEY
  algorithm: ed25519
```

* `genesis` - 동일한 파일(.config/iserver.yaml)에서 제네시스 블록 정보를 아래와 같이 입력합니다.

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOSTfQFocqDn7VrKV7vvPqhAQGyeFU9XMYo5SNn5yQbdbzC75wM7C
  - "21000000000"
  votecontractpath: config/
```

* `vm` `db` - vm과 db 경로를 설정합니다.


```
vm:
  jspath: vm/v8vm/v8/libjs/
  loglevel: ""

```

```
db:
  ldbpath: storage/
```

* `p2p` - 네트워크 정보를 설정합니다. 이 정보는 시드 노드가 네트워크에 접근하는데에 필요합니다.

```
p2p:
  listenaddr: 0.0.0.0:30000
  seednodes:
  chainid: 1024
  version: 1
  datapath: p2p/
```

* `rpc` - rpc 포트를 설정합니다.

```
rpc:
  jsonport: 30001
  grpcport: 30002
```

* `log` - log 서비스를 설정합니다.


```
log:
  filelog:
    path: logs/
    level: info
    enable: true
  consolelog:
    level: info
    enable: true
  asyncwrite: true
```

* `metrics` - 메트릭 서비스를 설정합니다.


```
metrics:
  pushAddr:
  username:
  password:
  enable: false
  id: iost-testnet:visitor00
```
