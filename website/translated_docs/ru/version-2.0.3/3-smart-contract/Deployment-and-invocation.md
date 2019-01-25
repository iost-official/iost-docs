---
id: version-2.0.3-Deployment-and-invocation
title: Развертывание и вызов
sidebar_label: Развертывание и вызов
original_id: Deployment-and-invocation
---

Когда мы завершаем написание JavaScript смарт-контракта, нам нужно развернуть его в блокчейне.

Развертывание занимает несколько шагов:

- Скомпилируйте js для генерации файла ABI
- Модифицируйте ABI файл
- Используйте файлы .js и .abi для создания файла-пакета .sc.
- Распределите файлы .sc для каждого подписанта, а подписанты будут генерировать файлы .sig
- Соберите файлы .sig и .sc-файлы и разверните их на блокчейне

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

### Соберите файлы .sig и .sc-файлы и разверните их в блокчейне
Наконец, используйте файл ```.js``` и файл ```.abi```, чтобы развернуть контракт в блокчейне.

```bash
# publish a transaction with .sig file from every signer
./iwallet --server serverIP --account acountName --amount_limit amountLimit publish jsFilePath abiFilePath
# Example
iwallet --server 127.0.0.1:30002 --account admin --amount_limit  "ram:100000" publish contract/lucky_bet.js contract/lucky_bet.js.abi
...

#Return
The contract id is ContractBgHM72pFxE9KbTpQWipvYcNtrfNxjEYdJD7dAEiEXXZh
```
