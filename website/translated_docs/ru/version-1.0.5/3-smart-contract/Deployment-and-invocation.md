---
id: version-1.0.5-Deployment-and-invocation
title: Развертывание и вызов
sidebar_label: Развертывание и вызов
original_id: Deployment-and-invocation
---

Когда мы завершаем JavaScript смарт-контракт, нам нужно развернуть его в блокчейне.

Развертывание занимает несколько шагов:

- Скомпилируйте js для генерации файла ABI
- Модифицируйте ABI файл
- Используйте файлы .js и .abi для создания файла-пакета .sc.
- Распределите файлы .sc для каждого подписанта, а подписанты будут генерировать файлы .sig
- Соберите файлы .sig и .sc-файлы и опубликуйте их на блокчейне

### Компиляция js для генерации файла ABI

Для развертывания нужна программа iWallet в проекте. Я уверен, что вы уже скомпилировали iWallet из документов в каталоге `go-iost/target`.

Во-первых, используйте iWallet для компиляции js-кода в соответствующие ABI.

```bash
# Generate ABI for target js
./iwallet compile -g jsFilePath
```

Это сгенерирует .js.abi файлы и .js.after файлы.

### Модификация ABI файла
В настоящее время файл .abi по-прежнему нуждается в некоторых модификациях. В основном проверьте следующие пункты:

- Проверьте abi поле не null
- Измените поле «abi» в файле .abi, измените каждый элемент в `args` на правильный тип

#### Пример
```json
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "transfer",
            "args": [
                "string",
                "string",
                "int"
            ]
        }
    ]
}
```

### Используйте файлы .js и .abi для создания файла-пакета .sc.

Затем сгенерируйте файлы .sc с js и js.abi-файлами.

```bash
# Generate .sc for signsers to sign
./iwallet compile -e $expire_time -l $gasLimit -p $gasPrice --signers "ID0, ID1..."
# Example
./iwallet compile -e 3600 -l 100000 -p 1 ./test.js ./test.js.abi
```

### Распределите файлы .sc для каждого подписанта, а подписанты будут генерировать файлы .sig

Распределите файлы .sc для соответствующих подписантов и получите .sig-файлы.

```bash
# sign a .sc file with private key
./iwallet sign -k path_of_seckey path_of_txFile
# Example
./iwallet sign -k ~/.iwallet/id_secp ./test.sc
```

### Соберите файлы .sig и .sc-файлы и опубликуйте их в блокчейне

Наконец, разверните файл .sc в транзакции, а также все подписанные .sig-файлы.

```bash
# publish a transaction with .sig file from every signer
./iwallet publish -k path_of_seckey path_of_txFile path_of_sig0 path_of_sig1 ...
# Example
./iwallet publish -k ~/.iwallet/id_secp ./dashen.sc ./dashen.sig0 ./dashen.sig1
```
