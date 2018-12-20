---
id: version-1.0.4-Smart-Contract-Development-Toolkit
title: Scaf: Замечательный инструментарий разработки смарт-контрактов
sidebar_label: Scaf: Замечательный инструментарий разработки смарт-контрактов
original_id: Smart-Contract-Development-Toolkit
---

## Характеристики

Scaffold предназначен для предоставления удобства разработчикам при написании js смарт-контракта для блокчейна IOST. Он содержит следующее:

- Инициализация проекта децентрализованого приложения с соответствующей структурой
- Команды для запуска файлов контракта, легкого добавления функций и тестов контракта
- Вызванные системные функции (включая блокчейн функции и storage функции) встроены в тестовый контракт правильно
- Компиляция файла контракта для генерирования действительного контракта и файла abi, который может быть загружен непосредственно в блокчейн.
- Запуск тестовых кейсов для контракта

## Установка и настройка

Прежде чем начать, убедитесь, что на вашем компьютере установлен node и npm.

1. `git clone git@github.com:iost-official/dapp.git`

2. `cd dapp`

3. `sudo npm install`

4. `sudo npm link`

## Команды

`help` печатается при вводе специальных команд.

```console
usr@Tower [master]:~/nodecode/dapp$ scaf
Usage: scaf <cmd> [args]

Commands:
  scaf new <name>      create a new DApp in current directory
  scaf add <item>      add a new [contract|function]
  scaf compile <name>  compile contract
  scaf test <name>     test contract

Options:
  --version   Show version number                                      [boolean]
  -h, --help  Show help                                                [boolean]

Not enough non-option arguments: got 0, need at least 1
usr@Tower [master]:~/nodecode/dapp$ scaf add
Usage: scaf add <item> [args]

Commands:
  scaf add contract <name>                  create a smart contract class
  scaf add func <con_name> <func_name>      add a function to a contract class
  [param...]
  scaf add test <con_name> <test_name>      add a test for a contract class

Options:
  --version           Show version number                              [boolean]
  -h, --help, --help  Show help                                        [boolean]

Not enough non-option arguments: got 0, need at least 1
```

## Hello BlockChain

### Создать новый проект

```
scaf new helloBlockChain
```

Проект создается в текущей директории с инициализированной структурой.

```console
usr@Tower [master]:~/nodecode/dapp$ scaf new helloBlockChain
make directory: helloBlockChain
make directory: helloBlockChain/contract
make directory: helloBlockChain/abi
make directory: helloBlockChain/test
make directory: helloBlockChain/libjs

usr@Tower [master]:~/nodecode/dapp$ ls helloBlockChain/
abi  contract  libjs  test
```

### Добавить контракт

```
cd helloBlockChain
scaf add contract helloContract
```

`add <item>` команда должна быть выполнена в директории проекта. Файл контракта `helloContract.js` и ABI файл `helloContract.json` генерируется с последующим исходным содержимым:

```js
usr@Tower [master]:~/nodecode/dapp$ cd helloBlockChain/

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add contract helloContract
create file: ./contract/helloContract.js
create file: ./abi/helloContract.json

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat contract/helloContract.js
const rstorage = require('../libjs/storage.js');
const rBlockChain = require('../libjs/blockchain.js');
const storage = new rstorage();
const BlockChain = new rBlockChain();

class helloContract
{
    constructor() {
    }
    init() {
    }
    hello(p0) {
		console.log(BlockChain.transfer("a", "b", 100));
		console.log(BlockChain.blockInfo());
		console.log("hello ", p0);
    }
};
module.exports = helloContract;

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat abi/helloContract.json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "hello",
            "args": [
                "string"
            ]
        }
    ]
}
```

### Добавить функцию

```
scaf add func helloContract hello string p0
```

Вышеупомянутая команда добавляет функцию с именем `hello` в класс `helloContract`. `string p0` означает функция `hello` имеет один параметр типа `string` и имя `p0`.

функция `hello(p0)` и ей соответствующая ABI информация добавляется в `helloContract.js` и `helloContract.json`.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add func helloContract hello string p0
add function hello() to ./contract/helloContract.js
add abi hello to ./abi/helloContract.json
{
    "name": "hello",
    "args": [
        "string"
    ]
}
```

Теперь редактируйте `contract/helloContract.js`, чтобы реализовать функцию `hello(p0) {}`

```js
hello(p0) {
  console.log(BlockChain.transfer("a", "b", 100));
  console.log(BlockChain.blockInfo());
  console.log("hello ", p0);
}
```

В функции `hello(p0)`, мы регистрируем результат двух системных функций `BlockChain.transfer()` и `BlockChain.blockInfo()`.

Поскольку системные функции вызваны, они всегда будут возвращать одинаковые допустимые результаты.

### Добавить тест

```
scaf add test helloContract test1
```

Эта комманда добавляет тест с именем test1 для `helloContract` контракта. `helloContract_test1.js` создается в `test/` всего с одним `require` утверждением.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf add test helloContract test1
create file: ./test/helloContract_test1.js

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');
```
Now edit test/helloContract_test1.js
```js
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ cat test/helloContract_test1.js
var helloContract = require('../contract/helloContract.js');

var ins0 = new helloContract();
ins0.hello("iost");
```

### Запуск теста

```
scaf test helloContract
```

Эта команда выполнит все тесты конкретного контракта.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf test helloContract
test ./test/helloContract_test1.js
transfer  a b 100
0
{"parent_hash":"0x00","number":10,"witness":"IOSTwitness","time":1537000000}
hello  iost
```

### Скомпилировать контракт

```
scaf compile helloContract
```

Эта команда компилирует файл контракта, и файл ABI создается в `build/`. Вы можете загрузить эти файлы в блокчейн IOST.

```console
usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ scaf compile helloContract
compile ./contract/helloContract.js and ./abi/helloContract.json
compile ./abi/helloContract.json successfully
generate file ./build/helloContract.js successfully

usr@Tower [master]:~/nodecode/dapp/helloBlockChain$ find build/
build/
build/helloContract.js
build/helloContract.json
```
