---
id: Deployment
title: 배포
sidebar_label: 배포
---

## go-iost 코드 리포지토리 가져오기

다음의 명령어를 실행해서 go-iost의 코드 리포지토리를 가져옵니다.

```
git clone git@github.com:iost-official/go-iost.git
```

## 빌드하기

다음의 명령어를 실행해서 go-iost 코드를 컴파일하여 `target` 디렉토리에 빌드된 파일을 생성합니다.

```
make build
```

## 실행하기

로컬 노드를 실행하기 위해서 다음의 명령어를 입력합니다. iServer 설정에 대해서는 다음 링크를 참조해주세요: [iServer](iServer)

```
./target/iserver -f config/iserver.yml
```

## 도커

### 도커 실행하기

다음 명령어를 실행하여 도커를 통해 IOST 로컬 노드를 실행합니다.

```
docker run -it --rm iostio/iost-node:1.0.0
```

### 마운트 볼륨 Mount volume

`-v` 옵션을 이용해서 볼륨(용량)을 마운트 할 수 있습니다.

```
mkdir -p /data/iserver
cp config/iserver.docker.yml /data/iserver
docker run -it --rm -v /data/iserver:/var/lib/iserver iostio/iost-node:1.0.0
```

### 포트 바인딩하기

`-p` 옵션을 이용해서 포트를 매핑할 수 있습니다.

```
docker run -it --rm -p 30000:30000 -p 30001:30001 -p 30002:30002 -p 30003:30003 iostio/iost-node:1.0.0
```


## 테스트넷에 접속하기

### 설정 파일 수정

`go-iost/config` 경로에 존재하는 `iserver.yml` (도커의 경우 `iserver.docker.yml`) 파일 내부에 있는 genesis의 설정을 다음과 같이 변경합니다:

```
genesis:
  creategenesis: true
  witnessinfo:
  - IOST2g5LzaXkjAwpxCnCm29HK69wdbyRKbfG4BQQT7Yuqk57bgTFkY
  - "100000000000000000"
  - IOST22TgXbjvgrDd3DuMkVufcWbYDMy7vpmQoCgZXmgi8eqM7doxWD
  - "100000000000000000"
  - IOSTAXksR6rKvmkjJyzhJJkDsG3yip47BJJWmbSTYqwqoNErBoN2k
  - "100000000000000000"
  - IOSTFPe9aXhZMmyvy6BsmgeucKEgzXy3zHMhsBFFeqNtKsqy98sbX
  - "100000000000000000"
  - IOST23xQCcviwn7AGxDnJbkL2Sjh8ijsKL6sPJWAkVEP8jACHLGknX
  - "100000000000000000"
  - IOST2CxDxZJwo2Useu2kMvZRTmMpHiwrK4UzQRLEQccLTfAmY9Z4Up
  - "100000000000000000"
  - IOSTKbYwTYpGZUTQqnmnbQAeJKhCBAMfW3pNvtJn6nEtVj6aozGMQ
  - "100000000000000000"
  - IOSTxUBnFHNBb22TSU8ruiEPfVUx6utxxbUcat3ZaDmtZea4roPES
  - "100000000000000000"
  - IOSTpWBkze9vPL3rxmnobgVN6s6WwHUFJGMo7wFcAHwkbhij3eDZY
  - "100000000000000000"
  - IOST27LJHEEBZ8oNqQR9EhutmybLuNdeitNfWdkoFk8MwQ2pSbifig
  - "100000000000000000"
  - IOST2AcBEJawoVzg4MW6UcvQsP6p6mSwACF7bbroNU2jBtE3MDSt6G
  - "100000000000000000"
  votecontractpath: config/
```

동일 파일에 있는 `p2p.seednodes`의 설정또한 아래와 같이 변경합니다:

```
p2p:
  seednodes:
  - /ip4/18.218.255.180/tcp/30000/ipfs/12D3KooWLwNFzkAf3fRmjVRc9MGcn89J8HpityXbtLtdCtPSHDg1
```

주의) 설정이 끝난 후에도, 시드 노드들의 네트워크 아이디가 변경될 수 있습니다. 현재 테스트넷의 시드 노드들의 목록은 아래와 같습니다.

| Name   | Region | Network ID                                                                              |
| ------ | ------ | --------------------------------------------------------------------------------------- |
| node16 | US East | /ip4/18.218.255.180/tcp/30000/ipfs/12D3KooWLwNFzkAf3fRmjVRc9MGcn89J8HpityXbtLtdCtPSHDg1 |
| node17 | US West | /ip4/52.9.253.198/tcp/30000/ipfs/12D3KooWABS9bLYUnvmLYeuZvkgL2WY3TLHJDbmG2tUWB4GfJJiq   |
| node19 | Mumbai   | /ip4/13.127.153.57/tcp/30000/ipfs/12D3KooWAx1pZHvUq73UGMSXqjUBsKBKgXFoFBoXZZAhfvM9HnVr  |
| node20 | Seoul   | /ip4/52.79.231.23/tcp/30000/ipfs/12D3KooWCsq3Lfxe8E17anTred2o7X4cSZ77faai8hkHH611RjMp   |
| node21 | Singapore | /ip4/13.229.176.106/tcp/30000/ipfs/12D3KooWKGK1ah5JgMEic2dH8oYE3LMEZLBJUzCNP165tPaQnaW9 |
| node22 | Sydney   | /ip4/13.238.140.219/tcp/30000/ipfs/12D3KooWGHmaxL8LmRpvXoFPNYj3FavYgqqEBks4YPVUL6KRcQFs |
| node23 | Canada | /ip4/52.60.78.2/tcp/30000/ipfs/12D3KooWAivafPT52QEf2eStdXS4DjiRyLCGhLanvVgJ7hhbqans     |
| node24 | Germany   | /ip4/52.58.16.220/tcp/30000/ipfs/12D3KooWPKjYYL4tvbUQF2VzA1mg6XsByA8GVN4anDfrRxp9qdxm   |
| node25 | Ireland | /ip4/18.202.100.127/tcp/30000/ipfs/12D3KooWDL2BdvSR65kS2z8LX8142ksX35mNFWhtVpK6a24WXBoV |
| node26 | UK   | /ip4/35.176.96.113/tcp/30000/ipfs/12D3KooWHfCWdXnKkTqFYNh8AhrjJ21v7RrTTuwSBLztHgGLWYyX  |
| node27 | France   | /ip4/52.47.133.32/tcp/30000/ipfs/12D3KooWScNNuMLh1AEnWoNppXKY6qwVVGrvzYF4dKQxBMmnwW3b   |
| node28 | Brazil   | /ip4/52.67.231.15/tcp/30000/ipfs/12D3KooWRJxjPsVxRR7spvfRPRWzvGKZrWggRj5kEiqyS4tzPq78   |
| node40 | Tokyo   | /ip4/52.192.86.141/tcp/30000/ipfs/12D3KooWS4kyTpyjEA8ixqFGT7uLd4mAh4fYbYNYhaPYNEWE69BA  |

### iServer 실행하기

위에서 바꾼 설정 파일을 토대로 iServer를 실행하여 테스트넷에 접속합니다:

```
./target/iserver -f config/iserver.yml
```
