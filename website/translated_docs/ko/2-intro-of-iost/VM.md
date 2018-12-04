---
id: VM
title: VM
sidebar_label: VM
---
IOST에서 생각하는 좋은 가상 머신(VM)이란, 설계가 잘 되어 있어야 하고, 사용하기 쉽고 안전해야 합니다. 이러한 기준에서 EVM, EOS, C Lua, V8의 장단점을 각각 비교해보면서 IOST VM을 만들게 되었습니다. IOST VM은 크롬에서 높은 성능을 보여주고 있는 V8을 기반으로 만들어진 VM으로, EVM과 EOS의 합리적이지 않은 설계를 근본적으로 해결하였습니다.

## 1. IOST V8VM 구조와 설계
VM매니저(VMManager)는 V8VM의 핵심요소로 세 가지의 주요기능이 있습니다.

![statedb](../assets/2-intro-of-iost/VM/V8VM.png)
* <font color="#0092ff">VM Entrance </font>VM Entrance는 다른 모듈에서 들어오는 외부 요청(requests)들을 받습니다. 주로 이러한 요청에는 RPC request, 블록 검증(block validation), 트랜잭션 검증(Tx validation) 등이 포함됩니다. VM Entrance는 이러한 요청을 받아 전처리와 포맷을 진행한 뒤에 VMWorker로 요청(request)을 넘겨줍니다.
* <font color="#0092ff">VMWorker 라이프사이클 관리자(VMWorker lifecycle management) </font>VMWorker의 수는 시스템 부하에 따라 동적으로 설정됩니다. 이를 통해 worker의 재사용이 가능하며, worker 내에서 Javascript hot launch와 핫스팟 샌드박스 스냅샷의 영속성을 통해서 빈번하게 생성되는 VM을 줄일 수 있습니다. 또한, 동일한 코드가 로드될 때, CPU와 메모리의 과부하를 방지합니다. 결과적으로 이러한 설계는 시스템의 처리량(throughput)을 증가시키고, fomo3D와 같은 다수의 유저의 트랜잭션을 처리하는 컨트랙트를 실행하는데에도 전혀 무리가 없습니다.
* <font color="#0092ff">상태 DB의 인터페이스 관리(Management of interface with State database) </font> 이는 각 IOST 트랜잭션의 atomicity를 보장합니다. 예를 들어, 트랜잭션을 처리하던 중에 트랜잭션을 보내는 사람의 자산이 충분하지 않아서 에러가 발생한다면, 전체 트랜잭션을 취소하여 트랜잭션의 atomicity를 보장하는 식입니다. 동시에, RocksDB로 flush 하기 전에 Local Cache와 MVCCDB에서 각각 캐시를 진행합니다.

## 2. 샌드박스 핵심 설계(Sandbox core design)

![statedb](../assets/2-intro-of-iost/VM/sandbox.png)
자바스크립트 스마트 컨트랙트 실행 시에, 샌드박스는 V8VM을 인터페이스하고 호출된 컨트랙트 함수를 크롬 V8에서 실행되게 합니다. 컨트랙트를 실행하기 위해서는 1)컴파일과, 2)실행 두 단계가 필요합니다. 이 단계들에 대해서 설명하도록 하겠습니다.

### 컴파일 단계
컴파일 단계에서는 스마트 컨트랙트 개발과 배포를 위한 두 가지 기능을 제공합니다.

* <font color="#0092ff">컨트랙트 팩(Contract Pack) </font>컨트랙트 팩은 Webpack을 통해서 컨트랙트 프로젝트 코드를 패키징화 하는 기술을 말합니다. 이는 현재 개발하고 있는 프로젝트에 있는 모든 자바스크립트 코드를 번들링하고, 자바스크립트 코드에 있는 dependency들을 자동으로 설치합니다. 이러한 방식은 대규모 프로젝트 개발을 하는데 유용하며, Node.js 모듈 시스템에 있는 모든 기능들과 완전히 호환해서 사용할 수 있습니다. 따라서 자바스크립트 컨트랙트 코드를 작성할 때, `require`, `module.exports`, `exports`와 같은 기능을 그대로 사용할 수 있어, 기존 자바스크립트 개발자들이 쉽게 컨트랙트 코드를 작성할 수 있게 합니다.  
* <font color="#0092ff">컨트랙트 스냅샷(Contract Snapshot) </font>컨트랙트 스냅샷 기술을 통해서 컴파일을 하게 되면, 컨텍스트 생성의 성능을 높일 수 있습니다. 또한 컨트랙트 스냅샷의 비직렬화는 결과를 런타임에 얻을 수 있게하여 자바스크립트의 로딩 속도와 실행 속도를 대폭 향상시킵니다.

### 실행 단계

실행 단계에서는 VM을 불러오고 실행시키는 두 가지 기능을 제공합니다.

* <font color="#0092ff">VM 불러오기(LoadVM) </font>크롬의 V8 object를 포함한 VM 개체를 생성하고, 시스템 설정 변수들을 설정하며, 연관된 자바스크립트 클래스 라이브러리들을 가져옵니다. 포함되는 자바스크립트 클래스 라이브러리는 다음과 같습니다.

| Class Library          | Features   |
| --------     | -----  |
| Blockchain   | Node.js와 유사한 모듈 시스템 기능을 제공합니다. 이러한 기능에는 모듈 캐싱, 프리 컴파일(pre-compilation), cycle call 등이 포함됩니다.|
| Event        | 상태 라이브러리(State Library)를 이용해 자바스크립트를 읽고 쓰는 기능을 하며 컨트랙트에서 에러가 발생했을 때 롤백을 하는 기능을 제공합니다. |
| NativeModule | 블록체인과 관련된 함수들을 제공합니다. 이러한 함수들에는 전송, 출금, 현재 블록과 트랜잭션 정보 가져오기 등의 함수가 포함됩니다.|
| Storage      | 이벤트의 구현체로, 컨트랙트가 실행되어 트랜잭션이 블록체인에 성공적으로 들어갔을 때, 자바스크립트 컨트랙트 내부 이벤트가 콜백을 받을 수 있게하는 기능을 제공합니다. |

* <font color="#0092ff">실행(Execute) </font>최종적으로 자바스크립트 스마트 컨트랙트를 실행합니다. IOST V8VM은 독립된 쓰레드에서 컨트랙트를 실행시키고, 실행 결과를 모니터링하여 에러가 발생하거나, 자산이 부족하거나, 타임아웃, 또는 비정상적인 결과가 나왔을 때에 현재의 실행을 종료(Terminate)합니다.
