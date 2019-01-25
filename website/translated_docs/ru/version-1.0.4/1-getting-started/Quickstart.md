---
id: version-1.0.4-Quickstart
title: Быстрый старт
sidebar_label: Быстрый старт
original_id: Quickstart
---

Самый простой способ

## 1. Клонировать репозиторий

```
git clone https://github.com/iost-official/go-iost.git
cd go-iost
```

## 2. Установка зависимостей

Запустите эту команду, чтобы установить все зависимости:

```
cd go-iost/iwallet/contract
npm install
```

## 3. Напишите свой первый смарт-контракт

IOST смарт-контракты поддерживают JavaScript. Пример смарт-контракта может выглядеть следующим образом:

```
class Sample {
    init() {
        //Execute once when contract is packed into a block
    }

    constructor() {
        //Execute everytime the contract class is called
    }

    transfer(from, to, amount) {
        //Function called by other
        BlockChain.transfer(from, to, amount)

    }

};
module.exports = Sample;
```

## 4. Разверните контракт

Для развертывания требуются следующие шаги:

- Скомпилируйте .js файлы для генерации ABI файлов
- Сгенерируйте файл пакета для транзакций с .js, .abi и .sc файлов
- Выдать файл .sc каждому подписанту, и подписанты генерируют .sig файлы
- Соберите файлы .sig и .sc. Опубликуйте файлы в главной цепи
