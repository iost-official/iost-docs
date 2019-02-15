---
id: GasChargeTable
title: Gas Charge Table
sidebar_label: Gas Charge Table
---


# Start Up

| Name    |         Operation          |     cost |
| :------ | :------------------------: | -------: |
| StartUp | initialize virtual machine | 30000gas |

# Basic Grammar
| Name                          |                                    Operation                                     |                                                               cost |
| :---------------------------- | :------------------------------------------------------------------------------: | -----------------------------------------------------------------: |
| ArrayPattern                  |                          let [a, b, ...c] = [1,2,3,4,5]                          |                                                                ban |
| ObjectPattern                 |                      let {p0, p1} = {"p0": 123, "p1": 345}                       |                                                                ban |
| RegularExpression             |                                   /ab{2,5}c/g                                    |                                                                ban |
|                               |                                                                                  |                                                                    |
| ThrowStatement                |                                 throw "justtest"                                 |                                                              50gas |
| CallExpression                |                                  f("justtest")                                   |                                                               4gas |
| TemplateLiteral               |                    &#x60;that ${ person } is a ${ age }&#x60;                    |                                        4gas + 8gas * string length |
| TaggedTemplateExpression      |                 myTag&#x60;that ${ person } is a ${ age }&#x60;                  |                                                               4gas |
| NewExpression                 |                                  new Number(10)                                  |                                                               8gas |
| YieldExpression               |                                 yield "justtest"                                 |                                                               8gas |
| MemberExpression              |                                     a.member                                     |                                                               4gas |
| MetaProperty                  |                                    new.target                                    |                                                               4gas |
| AssignmentExpression          | '*='  '**='  '/='  '%='  '+='  '-='  '<<='  '>>='  '>>>='  '&='  '^='  '&#124;=' |                                     3gas + BinaryExpression charge |
|                               |                                       '='                                        |                                                               3gas |
| UpdateExpression              |                                    '++'  '--'                                    |                                                               3gas |
| BinaryExpression              |         '-'  '*'  '/'  '%'  '**'  '&#124;'  '^'  '&'  '<<'  '>>'  '>>>'          |                                                               3gas |
|                               |               '+'  '=='  '!='  '==='  '!=='  '<'  '<='  '>'  '>='                | 3gas + (1gas * (left op length + right op length) if op is string) |
|                               |                                'instanceof'  'in'                                |                                                               3gas |
| UnaryExpression               |                  '+'  '-'  '~'  '!'  'delete'  'void'  'typeof'                  |                                                               3gas |
| LogicalExpression             |                               '&#124;&#124;'  '&&'                               |                                                               3gas |
| ConditionalExpression         |                                 ... ? ... : ...                                  |                                                               3gas |
| SpreadElement                 |                              f(...[10, 11, 12, 13])                              |                                            1gas * arguments length |
|                               |                                                                                  |                                                                    |
| ObjectExpression              |                         { name:"Jack", age:10, 5:true }                          |                                       2gas + 0.1gas * array length |
| ArrayExpression               |                                  [ 3, 5, 100 ]                                   |                                       2gas + 0.1gas * array length |
| FunctionExpression            |            let a = function(width, height) { return width * height }             |                                                               1gas |
| ArrowFunctionExpression       |                           material => material.length                            |                                                               3gas |
| ClassDeclaration              |                              class Polygon { ... }                               |                                                             150gas |
| FunctionDeclaration           |               function a(width, height) { return width * height }                |                                                               3gas |
| VariableDeclarator            |                                    let a = 1                                     |                                                               3gas |
| VariableDeclaratorWithoutInit |                                      let a                                       |                                                               3gas |
| MethodDefinition              |                       let obj = { foo() {return 'bar';} }                        |                                                               2gas |
| StringLiteral                 |                                    "justtest"                                    |                                             0.1gas * string length |
|                               |                                                                                  |                                                                    |
| ForStatement                  |                               for ( ... ) { ... }                                |                                                      1gas * cycles |
| ForInStatement                |                                  for ... in ...                                  |                                                      4gas * cycles |
| ForOfStatement                |                                  for ... of ...                                  |                                                      2gas * cycles |
| WhileStatement                |                              while ( ... ) { ... }                               |                                                      1gas * cycles |
| DoWhileStatement              |                             do { ... } while ( ... )                             |                                                      1gas * cycles |

# Library
| Name                  |                                   Operation                                   |                                                cost |
| :-------------------- | :---------------------------------------------------------------------------: | --------------------------------------------------: |
| StringCharAt          |                          ("redbluegreen").charAt(3)                           |                                                1gas |
| StringCharCodeAt      |                        ("redbluegreen").charCodeAt(3)                         |                                                1gas |
| StringLength          |                            ("redbluegreen").length                            |                                                   X |
| StringConstructor     |                         String.constructor("yellow")                          |                       1gas + 0.1gas * string length |
| StringToString        |                          ("redbluegreen").toString()                          |                                                   X |
| StringValueOf         |                          ("redbluegreen").valueOf()                           |                                                1gas |
| StringConcat          |                    ("redbluegreen").concat("redbluegreen")                    |                   1gas + 0.1gas * res string length |
| StringIncludes        |                       ("redbluegreen").includes("red")                        |                       1gas + 0.1gas * string length |
| StringEndsWith        |                       ("redbluegreen").endsWith("red")                        |                       1gas + 0.1gas * string length |
| StringIndexOf         |                        ("redbluegreen").indexOf("red")                        |                       1gas + 0.1gas * string length |
| StringLastIndexOf     |                      ("redbluegreen").lastIndexOf("red")                      |                       1gas + 0.1gas * string length |
| StringReplace         |                    ("redbluegreen").replace("red", "blue")                    |                       1gas + 0.1gas * string length |
| StringSearch          |                        ("redbluegreen").search("red")                         |                       1gas + 0.1gas * string length |
| StringSplit           |                         ("redbluegreen").split("red")                         |                       1gas + 0.1gas * string length |
| StringStartsWith      |                      ("redbluegreen").startsWith("red")                       |                       1gas + 0.1gas * string length |
| StringSlice           |                           ("redbluegreen").slice()                            |                       1gas + 0.1gas * string length |
| StringSubstring       |                         ("redbluegreen").substring(3)                         |                       1gas + 0.1gas * string length |
| StringToLowerCase     |                        ("redbluegreen").toLowerCase()                         |                       1gas + 0.1gas * string length |
| StringToUpperCase     |                        ("redbluegreen").toUpperCase()                         |                       1gas + 0.1gas * string length |
| StringTrim            |                            ("redbluegreen").trim()                            |                       1gas + 0.1gas * string length |
| StringTrimLeft        |                          ("redbluegreen").trimLeft()                          |                       1gas + 0.1gas * string length |
| StringTrimRight       |                         ("redbluegreen").trimRight()                          |                       1gas + 0.1gas * string length |
| StringRepeat          |                          ("redbluegreen").repeat(10)                          |                   1gas + 0.1gas * res string length |
|                       |                                                                               |                                                     |
| ArrayConstructor      |                  Array.constructor(["red", "blue", "green"])                  |                    1gas + 0.2gas * res array length |
| ArrayToString         |                     (["red", "blue", "green"]).toString()                     |                          1gas + 1gas * array length |
| ArrayConcat           |          (["red", "blue", "green"]).concat(["red", "blue", "green"])          |                      1gas + 1gas * res array length |
| ArrayEvery            |        (["red", "blue", "green"]).every(function (x) { return true; })        |                          1gas + 1gas * array length |
| ArrayFilter           |       (["red", "blue", "green"]).filter(function (x) { return true; })        |                         1gas + 10gas * array length |
| ArrayFind             |        (["red", "blue", "green"]).find(function (x) { return true; })         |                          1gas + 1gas * array length |
| ArrayFindIndex        |      (["red", "blue", "green"]).findIndex(function (x) { return true; })      |                          1gas + 1gas * array length |
| ArrayForEach          |         (["red", "blue", "green"]).forEach(function (x) { return; })          |                          1gas + 1gas * array length |
| ArrayIncludes         |                  (["red", "blue", "green"]).includes("red")                   |                          1gas + 1gas * array length |
| ArrayIndexOf          |                   (["red", "blue", "green"]).indexOf("red")                   |                        1gas + 0.2gas * array length |
| ArrayJoin             |                       (["red", "blue", "green"]).join()                       |                          1gas + 1gas * array length |
| ArrayKeys             |                       (["red", "blue", "green"]).keys()                       |                        1gas + 0.2gas * array length |
| ArrayLastIndexOf      |                 (["red", "blue", "green"]).lastIndexOf("red")                 |                        1gas + 0.2gas * array length |
| ArrayMap              |          (["red", "blue", "green"]).map(function (x) { return x; })           |                         1gas + 10gas * array length |
| ArrayPop              |                       (["red", "blue", "green"]).pop()                        |                                                1gas |
| ArrayPush             |                   (["red", "blue", "green"]).push("yellow")                   |                                                1gas |
| ArrayReverse          |                     (["red", "blue", "green"]).reverse()                      |                        1gas + 0.2gas * array length |
| ArrayShift            |                      (["red", "blue", "green"]).shift()                       |                                                1gas |
| ArraySlice            |                      (["red", "blue", "green"]).slice()                       |                         1gas + 10gas * array length |
| ArraySort             |                       (["red", "blue", "green"]).sort()                       |                          1gas + 1gas * array length |
| ArraySplice           |                     (["red", "blue", "green"]).splice(0)                      | 1gas + 10gas * array length + (arguments length -2) |
| ArrayUnshift          |                 (["red", "blue", "green"]).unshift("yellow")                  |                                                1gas |
|                       |                                                                               |                                                     |
| JSONParse             | JSON.parse(`{"array": ["red", "blue", "green"], "string": "", "float": 100}`) |                       10gas + 10gas * string length |
|                       |                                                                               |                                                     |
| MathAbs               |                                 Math.abs(-1)                                  |                                                2gas |
| MathCbrt              |                                Math.cbrt(2.5)                                 |                                                2gas |
| MathCeil              |                                Math.ceil(-1.5)                                |                                                2gas |
| MathFloor             |                                Math.floor(1.5)                                |                                                2gas |
| MathLog               |                                  Math.log(5)                                  |                                                2gas |
| MathLog10             |                               Math.log10(1234)                                |                                                2gas |
| MathLog1p             |                                Math.log1p(0.7)                                |                                                2gas |
| MathMax               |                              Math.max(3, 10, 5)                               |                                                2gas |
| MathMin               |                              Math.min(3, 10, 5)                               |                                                2gas |
| MathPow               |                               Math.pow(3, 15.5)                               |                                                2gas |
| MathRound             |                                Math.round(2.7)                                |                                                2gas |
| MathSqrt              |                                Math.sqrt(3.4)                                 |                                                2gas |
|                       |                                                                               |                                                     |
| BigNumberConstructor  |       BigNumber.prototype.constructor("99999999999999999")        |                                               20gas |
| BigNumberAbs          |             new BigNumber("-99999999999999999").abs()             |                                               20gas |
| BigNumberDiv          |         new BigNumber("-99999999999999999").div("99999")          |    20gas + 10gas * (number length + args[0] length) |
| BigNumberIdiv         |         new BigNumber("-99999999999999999").idiv("99999")         |    20gas + 10gas * (number length + args[0] length) |
| BigNumberPow          |         new BigNumber("-99999999999999999").pow("99999")          |    20gas + 10gas * (number length + args[0] length) |
| BigNumberIntegerValue |        new BigNumber("-99999999999999999").integerValue()         |                        20gas + 4gas * number length |
| BigNumberEq           |          new BigNumber("-99999999999999999").eq("99999")          |     20gas + 2gas * (number length + args[0] length) |
| BigNumberIsFinite     |          new BigNumber("-99999999999999999").isFinite()           |                                               20gas |
| BigNumberGt           |          new BigNumber("-99999999999999999").gt("99999")          |     20gas + 2gas * (number length + args[0] length) |
| BigNumberGte          |         new BigNumber("-99999999999999999").gte("99999")          |     20gas + 2gas * (number length + args[0] length) |
| BigNumberIsInteger    |          new BigNumber("-99999999999999999").isInteger()          |                                               20gas |
| BigNumberLt           |          new BigNumber("-99999999999999999").lt("99999")          |     20gas + 2gas * (number length + args[0] length) |
| BigNumberLte          |         new BigNumber("-99999999999999999").lte("99999")          |     20gas + 2gas * (number length + args[0] length) |
| BigNumberIsNaN        |            new BigNumber("-99999999999999999").isNaN()            |                                               20gas |
| BigNumberIsNegative   |         new BigNumber("-99999999999999999").isNegative()          |                                               20gas |
| BigNumberIsPositive   |         new BigNumber("-99999999999999999").isPositive()          |                                               20gas |
| BigNumberIsZero       |           new BigNumber("-99999999999999999").isZero()            |                                               20gas |
| BigNumberMinus        |        new BigNumber("-99999999999999999").minus("99999")         |    20gas + 10gas * (number length + args[0] length) |
| BigNumberMod          |         new BigNumber("-99999999999999999").mod("99999")          |    20gas + 10gas * (number length + args[0] length) |
| BigNumberTimes        |        new BigNumber("-99999999999999999").times("99999")         |     20gas + 4gas * (number length + args[0] length) |
| BigNumberNegated      |           new BigNumber("-99999999999999999").negated()           |                                               20gas |
| BigNumberPlus         |         new BigNumber("-99999999999999999").plus("99999")         |    20gas + 10gas * (number length + args[0] length) |
| BigNumberSqrt         |            new BigNumber("-99999999999999999").sqrt()             |                        20gas + 4gas * number length |
| BigNumberToFixed      |          new BigNumber("-99999999999999999").toFixed(5)           |                        20gas + 4gas * number length |

# Storage：
| Name    |                Operation                |   cost |
| :------ | :-------------------------------------: | -----: |
| Put     |       storage.put("key", "value")       | 300gas |
| Get     |           storage.get("key")            | 300gas |
| Has     |           storage.has("key")            | 300gas |
| Del     |           storage.del("key")            | 300gas |
| MapPut  | storage.mapPut("key", "field", "value") | 300gas |
| MapGet  |     storage.mapGet("key", "field")      | 300gas |
| MapHas  |     storage.mapHas("key", "field")      | 300gas |
| MapDel  |     storage.mapDel("key", "field")      | 300gas |
| MapKeys |         storage.mapKeys("key")          | 300gas |
| MapLen  |          storage.mapLen("key")          | 300gas |

# Network：
| Name        |        Operation        |                     cost |
| :---------- | :---------------------: | -----------------------: |
| transaction | transaction size (byte) | 10gas * transaction size |
| receipt     |   receipt size (byte)   |     10gas * receipt size |
