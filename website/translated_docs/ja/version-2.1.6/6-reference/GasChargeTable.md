---
id: version-2.1.6-GASChargeTable
title: GASチャージテーブル
sidebar_label: GASチャージテーブル
original_id: GASChargeTable
---


# Start Up

| 名前    |         操作          |     コスト |
| :------ | :------------------------: | -------: |
| StartUp | 仮想マシンを初期化 | 30000GAS |

# 基本文法
| 名前    |         操作          |     コスト |
| :---------------------------- | :------------------------------------------------------------------------------: | -----------------------------------------------------------------: |
| 配列パターン                  |                          let [a, b, ...c] = [1,2,3,4,5]                          |                                                                ban |
| オブジェクトパターン                 |                      let {p0, p1} = {"p0": 123, "p1": 345}                       |                                                                ban |
| 正規表現             |                                   /ab{2,5}c/g                                    |                                                                ban |
|                               |                                                                                  |                                                                    |
| 文のスロー                |                                 throw "justtest"                                 |                                                              50GAS |
| 式の呼び出し                |                                  f("justtest")                                   |                                                               4GAS |
| テンプレートリテラル               |                    &#x60;that ${ person } is a ${ age }&#x60;                    |                                        4GAS + 8GAS * string length |
| タグ付きテンプレートリテラル       |                 myTag&#x60;that ${ person } is a ${ age }&#x60;                  |                                                               4GAS |
| new式                 |                                  new Number(10)                                  |                                                               8GAS |
| yield式               |                                 yield "justtest"                                 |                                                               8GAS |
| メンバー式              |                                     a.member                                     |                                                               4GAS |
| メタプロパティ                  |                                    new.target                                    |                                                               4GAS |
| 代入式          | '*='  '**='  '/='  '%='  '+='  '-='  '<<='  '>>='  '>>>='  '&='  '^='  '&#124;=' |                                     3GAS + BinaryExpression charge |
|                               |                                       '='                                        |                                                               3GAS |
| UpdateExpression              |                                    '++'  '--'                                    |                                                               3GAS |
| 二項式              |         '-'  '*'  '/'  '%'  '**'  '&#124;'  '^'  '&'  '<<'  '>>'  '>>>'          |                                                               3GAS |
|                               |               '+'  '=='  '!='  '==='  '!=='  '<'  '<='  '>'  '>='                | 3GAS + (1GAS * (left op length + right op length) if op is string) |
|                               |                                'instanceof'  'in'                                |                                                               3GAS |
| 単項式               |                  '+'  '-'  '~'  '!'  'delete'  'void'  'typeof'                  |                                                               3GAS |
| LogicalExpression             |                               '&#124;&#124;'  '&&'                               |                                                               3GAS |
| 条件式         |                                 ... ? ... : ...                                  |                                                               3GAS |
| Spread式                |                              f(...[10, 11, 12, 13])                              |                                            1GAS * arguments length |
|                               |                                                                                  |                                                                    |
| オブジェクト式           |                         { name:"Jack", age:10, 5:true }                          |                                       2GAS + 0.1GAS * array length |
| 配列式               |                                  [ 3, 5, 100 ]                                   |                                       2GAS + 0.1GAS * array length |
| 関数式            |            let a = function(width, height) { return width * height }             |                                                               1GAS |
|アロー関数式       |                           material => material.length                            |                                                               3GAS |
| クラス宣言              |                              class Polygon { ... }                               |                                                             150GAS |
| 関数宣言           |               function a(width, height) { return width * height }                |                                                               3GAS |
| 変数宣言            |                                    let a = 1                                     |                                                               3GAS |
| 初期化なし変数宣言 |                                      let a                                       |                                                               3GAS |
| メソッド定義              |                       let obj = { foo() {return 'bar';} }                        |                                                               2GAS |
| 文字列リテラル                 |                                    "justtest"                                    |                                             0.1GAS * string length |
|                               |                                                                                  |                                                                    |
| For文                  |                               for ( ... ) { ... }                                |                                                      1GAS * cycles |
| For-In文                |                                  for ... in ...                                  |                                                      4GAS * cycles |
| For-Of文                |                                  for ... of ...                                  |                                                      2GAS * cycles |
| While文                |                              while ( ... ) { ... }                               |                                                      1GAS * cycles |
| Do-While文              |                             do { ... } while ( ... )                             |                                                      1GAS * cycles |

# ライブラリ
| 名前                  |                                   操作                                   |                                                コスト |
| :-------------------- | :---------------------------------------------------------------------------: | --------------------------------------------------: |
| StringCharAt          |                          ("redbluegreen").charAt(3)                           |                                                1GAS |
| StringCharCodeAt      |                        ("redbluegreen").charCodeAt(3)                         |                                                1GAS |
| StringLength          |                            ("redbluegreen").length                            |                                                   X |
| StringConstructor     |                         String.constructor("yellow")                          |                       1GAS + 0.1GAS * string length |
| StringToString        |                          ("redbluegreen").toString()                          |                                                   X |
| StringValueOf         |                          ("redbluegreen").valueOf()                           |                                                1GAS |
| StringConcat          |                    ("redbluegreen").concat("redbluegreen")                    |                   1GAS + 0.1GAS * res string length |
| StringIncludes        |                       ("redbluegreen").includes("red")                        |                       1GAS + 0.1GAS * string length |
| StringEndsWith        |                       ("redbluegreen").endsWith("red")                        |                       1GAS + 0.1GAS * string length |
| StringIndexOf         |                        ("redbluegreen").indexOf("red")                        |                       1GAS + 0.1GAS * string length |
| StringLastIndexOf     |                      ("redbluegreen").lastIndexOf("red")                      |                       1GAS + 0.1GAS * string length |
| StringReplace         |                    ("redbluegreen").replace("red", "blue")                    |                       1GAS + 0.1GAS * string length |
| StringSearch          |                        ("redbluegreen").search("red")                         |                       1GAS + 0.1GAS * string length |
| StringSplit           |                         ("redbluegreen").split("red")                         |                       1GAS + 0.1GAS * string length |
| StringStartsWith      |                      ("redbluegreen").startsWith("red")                       |                       1GAS + 0.1GAS * string length |
| StringSlice           |                           ("redbluegreen").slice()                            |                       1GAS + 0.1GAS * string length |
| StringSubstring       |                         ("redbluegreen").substring(3)                         |                       1GAS + 0.1GAS * string length |
| StringToLowerCase     |                        ("redbluegreen").toLowerCase()                         |                       1GAS + 0.1GAS * string length |
| StringToUpperCase     |                        ("redbluegreen").toUpperCase()                         |                       1GAS + 0.1GAS * string length |
| StringTrim            |                            ("redbluegreen").trim()                            |                       1GAS + 0.1GAS * string length |
| StringTrimLeft        |                          ("redbluegreen").trimLeft()                          |                       1GAS + 0.1GAS * string length |
| StringTrimRight       |                         ("redbluegreen").trimRight()                          |                       1GAS + 0.1GAS * string length |
| StringRepeat          |                          ("redbluegreen").repeat(10)                          |                   1GAS + 0.1GAS * res string length |
|                       |                                                                               |                                                     |
| ArrayConstructor      |                  Array.constructor(["red", "blue", "green"])                  |                    1GAS + 0.2GAS * res array length |
| ArrayToString         |                     (["red", "blue", "green"]).toString()                     |                          1GAS + 1GAS * array length |
| ArrayConcat           |          (["red", "blue", "green"]).concat(["red", "blue", "green"])          |                      1GAS + 1GAS * res array length |
| ArrayEvery            |        (["red", "blue", "green"]).every(function (x) { return true; })        |                          1GAS + 1GAS * array length |
| ArrayFilter           |       (["red", "blue", "green"]).filter(function (x) { return true; })        |                         1GAS + 10GAS * array length |
| ArrayFind             |        (["red", "blue", "green"]).find(function (x) { return true; })         |                          1GAS + 1GAS * array length |
| ArrayFindIndex        |      (["red", "blue", "green"]).findIndex(function (x) { return true; })      |                          1GAS + 1GAS * array length |
| ArrayForEach          |         (["red", "blue", "green"]).forEach(function (x) { return; })          |                          1GAS + 1GAS * array length |
| ArrayIncludes         |                  (["red", "blue", "green"]).includes("red")                   |                          1GAS + 1GAS * array length |
| ArrayIndexOf          |                   (["red", "blue", "green"]).indexOf("red")                   |                        1GAS + 0.2GAS * array length |
| ArrayJoin             |                       (["red", "blue", "green"]).join()                       |                          1GAS + 1GAS * array length |
| ArrayKeys             |                       (["red", "blue", "green"]).keys()                       |                        1GAS + 0.2GAS * array length |
| ArrayLastIndexOf      |                 (["red", "blue", "green"]).lastIndexOf("red")                 |                        1GAS + 0.2GAS * array length |
| ArrayMap              |          (["red", "blue", "green"]).map(function (x) { return x; })           |                         1GAS + 10GAS * array length |
| ArrayPop              |                       (["red", "blue", "green"]).pop()                        |                                                1GAS |
| ArrayPush             |                   (["red", "blue", "green"]).push("yellow")                   |                                                1GAS |
| ArrayReverse          |                     (["red", "blue", "green"]).reverse()                      |                        1GAS + 0.2GAS * array length |
| ArrayShift            |                      (["red", "blue", "green"]).shift()                       |                                                1GAS |
| ArraySlice            |                      (["red", "blue", "green"]).slice()                       |                         1GAS + 10GAS * array length |
| ArraySort             |                       (["red", "blue", "green"]).sort()                       |                          1GAS + 1GAS * array length |
| ArraySplice           |                     (["red", "blue", "green"]).splice(0)                      | 1GAS + 10GAS * array length + (arguments length -2) |
| ArrayUnshift          |                 (["red", "blue", "green"]).unshift("yellow")                  |                                                1GAS |
|                       |                                                                               |                                                     |
| JSONParse             | JSON.parse(`{"array": ["red", "blue", "green"], "string": "", "float": 100}`) |                       10GAS + 10GAS * string length |
|                       |                                                                               |                                                     |
| MathAbs               |                                 Math.abs(-1)                                  |                                                2GAS |
| MathCbrt              |                                Math.cbrt(2.5)                                 |                                                2GAS |
| MathCeil              |                                Math.ceil(-1.5)                                |                                                2GAS |
| MathFloor             |                                Math.floor(1.5)                                |                                                2GAS |
| MathLog               |                                  Math.log(5)                                  |                                                2GAS |
| MathLog10             |                               Math.log10(1234)                                |                                                2GAS |
| MathLog1p             |                                Math.log1p(0.7)                                |                                                2GAS |
| MathMax               |                              Math.max(3, 10, 5)                               |                                                2GAS |
| MathMin               |                              Math.min(3, 10, 5)                               |                                                2GAS |
| MathPow               |                               Math.pow(3, 15.5)                               |                                                2GAS |
| MathRound             |                                Math.round(2.7)                                |                                                2GAS |
| MathSqrt              |                                Math.sqrt(3.4)                                 |                                                2GAS |
|                       |                                                                               |                                                     |
| BigNumberConstructor  |       BigNumber.prototype.constructor("99999999999999999999999999999")        |                                               20GAS |
| BigNumberAbs          |             new BigNumber("-99999999999999999999999999999").abs()             |                                               20GAS |
| BigNumberDiv          |         new BigNumber("-99999999999999999999999999999").div("99999")          |    20GAS + 10GAS * (number length + args[0] length) |
| BigNumberIdiv         |         new BigNumber("-99999999999999999999999999999").idiv("99999")         |    20GAS + 10GAS * (number length + args[0] length) |
| BigNumberPow          |         new BigNumber("-99999999999999999999999999999").pow("99999")          |    20GAS + 10GAS * (number length + args[0] length) |
| BigNumberIntegerValue |        new BigNumber("-99999999999999999999999999999").integerValue()         |                        20GAS + 4GAS * number length |
| BigNumberEq           |          new BigNumber("-99999999999999999999999999999").eq("99999")          |     20GAS + 2GAS * (number length + args[0] length) |
| BigNumberIsFinite     |          new BigNumber("-99999999999999999999999999999").isFinite()           |                                               20GAS |
| BigNumberGt           |          new BigNumber("-99999999999999999999999999999").gt("99999")          |     20GAS + 2GAS * (number length + args[0] length) |
| BigNumberGte          |         new BigNumber("-99999999999999999999999999999").gte("99999")          |     20GAS + 2GAS * (number length + args[0] length) |
| BigNumberIsInteger    |          new BigNumber("-99999999999999999999999999999").isInteger()          |                                               20GAS |
| BigNumberLt           |          new BigNumber("-99999999999999999999999999999").lt("99999")          |     20GAS + 2GAS * (number length + args[0] length) |
| BigNumberLte          |         new BigNumber("-99999999999999999999999999999").lte("99999")          |     20GAS + 2GAS * (number length + args[0] length) |
| BigNumberIsNaN        |            new BigNumber("-99999999999999999999999999999").isNaN()            |                                               20GAS |
| BigNumberIsNegative   |         new BigNumber("-99999999999999999999999999999").isNegative()          |                                               20GAS |
| BigNumberIsPositive   |         new BigNumber("-99999999999999999999999999999").isPositive()          |                                               20GAS |
| BigNumberIsZero       |           new BigNumber("-99999999999999999999999999999").isZero()            |                                               20GAS |
| BigNumberMinus        |        new BigNumber("-99999999999999999999999999999").minus("99999")         |    20GAS + 10GAS * (number length + args[0] length) |
| BigNumberMod          |         new BigNumber("-99999999999999999999999999999").mod("99999")          |    20GAS + 10GAS * (number length + args[0] length) |
| BigNumberTimes        |        new BigNumber("-99999999999999999999999999999").times("99999")         |     20GAS + 4GAS * (number length + args[0] length) |
| BigNumberNegated      |           new BigNumber("-99999999999999999999999999999").negated()           |                                               20GAS |
| BigNumberPlus         |         new BigNumber("-99999999999999999999999999999").plus("99999")         |    20GAS + 10GAS * (number length + args[0] length) |
| BigNumberSqrt         |            new BigNumber("-99999999999999999999999999999").sqrt()             |                        20GAS + 4GAS * number length |
| BigNumberToFixed      |          new BigNumber("-99999999999999999999999999999").toFixed(5)           |                        20GAS + 4GAS * number length |

# ストレージ
| 名前    |                操作                |   コスト |
| :------ | :-------------------------------------: | -----: |
| Put     |       storage.put("key", "value")       | 300GAS |
| Get     |           storage.get("key")            | 300GAS |
| Has     |           storage.has("key")            | 300GAS |
| Del     |           storage.del("key")            | 300GAS |
| MapPut  | storage.mapPut("key", "field", "value") | 300GAS |
| MapGet  |     storage.mapGet("key", "field")      | 300GAS |
| MapHas  |     storage.mapHas("key", "field")      | 300GAS |
| MapDel  |     storage.mapDel("key", "field")      | 300GAS |
| MapKeys |         storage.mapKeys("key")          | 300GAS |
| MapLen  |          storage.mapLen("key")          | 300GAS |

# ネットワーク
| 名前        |        操作        |                     コスト |
| :---------- | :---------------------: | -----------------------: |
| transaction | transaction size (byte) | 10GAS * transaction size |
| receipt     |   receipt size (byte)   |     10GAS * receipt size |
