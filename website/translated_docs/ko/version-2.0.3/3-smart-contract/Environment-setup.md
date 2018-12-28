---
id: Environment-setup
title: 환경 설정
sidebar_label: 환경 설정
---

현재 버전에서 IOST 스마트 컨트랙트를 작성하기 위해서는 [go-iost](https://github.com/iost-official/go-iost) 리포지토리를 이용해야 합니다.

추후에는 go-iost 리포지토리 없이도 스마트 컨트랙트 작성이 없게끔 수정될 예정입니다.

우선, go-iost 브랜치를 클론합니다:

```shell
git clone https://github.com/iost-official/go-iost.git
```

`node` 와 `npm` 을 `go-iost/iwallet/contract` 경로에 설치합니다.

## ```Node``` 설치하기

[Node.js 공식 문서](https://nodejs.org/zh-cn/download/package-manager/#macos)를 참조해주세요.

## ```npm``` 설치하기

```git
cd go-iost/iwallet/contract
npm install
```

## ```Dynamic Library``` 설치하기

```git
cd go-iost/vm/v8vm/v8
make deploy
```
