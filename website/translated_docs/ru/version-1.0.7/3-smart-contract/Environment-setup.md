---
id: version-1.0.7-Environment-setup
title: Настройка среды разработки
sidebar_label: Настройка среды разработки
original_id: Environment-setup
---

В настоящее время программирование смарт-контрактов IOST зависит от [go-iost](https://github.com/iost-official/go-iost).

В будущем IOST станет независимым от go-iost.

Разработчикам необходимо клонировать всю ветвь:

```shell
git clone https://github.com/iost-official/go-iost.git
```

Затем установить `node` и `npm` в директорию `go-iost/iwallet/contract`.

## Установить ```Node```

Пожалуйста, обратитесь к  [Официальной документации Node.js](https://nodejs.org/en/download/package-manager/#macos)

## Установить```npm```

```git
cd go-iost/iwallet/contract
npm install
```

## Установить```Dynamic Library```

```git
cd go-iost/vm/v8vm/v8
make deploy
```
