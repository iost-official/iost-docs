---
id: version-1.0.6-Environment-setup
title: Настройка среды
sidebar_label: Настройка среды
original_id: Environment-setup
---

В настоящее время программирование смарт-контрактов IOST зависит от [go-iost](https://github.com/iost-official/go-iost).

В будущем IOST станет независимым от go-iost.

Разработчикам необходимо клонировать всю ветвь:

```shell
git clone https://github.com/iost-official/go-iost.git
```

Затем установить `node` и `npm` в директорию `go-iost/iwallet/contract`.

## Установка ```Node```

Пожалуйста, обратитесь к [Официальная документация Node.js](https://nodejs.org/en/download/package-manager/#macos)

## Установка```npm```

```git
cd go-iost/iwallet/contract
npm install
```
