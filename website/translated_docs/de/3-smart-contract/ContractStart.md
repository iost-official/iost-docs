---
id: version-3.0.6-ContractStart
title: Smart Contract Schnellstart
sidebar_label: Smart Contract Schnellstart
original_id: ContractStart
---


# Beginn der Smart Contract Entwicklung

## IOST Smart Contract Grundlagen
Eine Blockchain kann als Zustandsmaschine abstrahiert werden, die über das Netzwerk synchronisiert wird. Ein Smart Contract ist ein Code, der auf einem Blockchain-System ausgeführt wird und den Zustand in der Zustandsmaschine durch Transaktionen ändert. Aufgrund der Eigenschaften der Blockchain kann der Aufruf des Smart Contract garantiert seriell und global konsistent sein. 

Smart Contracts empfangen und führen Transaktionen innerhalb des Blocks aus, um die Variablen des Smart Contract innerhalb der Blockchain zu erhalten und einen unwiderruflichen Beweis zu erbringen. 

IOST hat mehrsprachige Smart Contracts abgeschlossen. Derzeit öffnen wir JavaScript(ES6) mit v8-Engine, und es gibt native golang VM-Module, um leistungsstarke Transaktionen abzuwickeln, aber nur für Systemcontracts.

Ein IOST Smart Contract enthält Code für Smart Contracts und eine JSON-Datei zur Beschreibung des ABI, der einen eigenen Namensraum und isolierten Speicherplatz hat. Externe können nur ihren Speicherinhalt lesen. 

Jede Transaktion beinhaltet mehrere Transaktionsaktionen, und jede Aktion ist ein Aufruf an eine ABI. Alle Transaktionen erzeugen eine strenge Serialität in der Kette und verhindern so Double-Spend-Angriffe.

### Schlüsselwörter

| Schlüsselwörter | Beschreibung |
| :-- | :-- |
| ABI | Smart Contract Interface, das nur extern über eine deklarierte Schnittstelle aufgerufen werden kann |
Tx | Transaktion, der Zustand auf der Blockchain muss durch Senden von tx geändert werden, tx wird in den Block gepackt.  |


## Konfiguration der Debug-Umgebung

### Einrichtung von iwallet und lokalem Testknoten

Die Entwicklung und Bereitstellung von Smart Contracts erfordert [iwallet](4-running-iost-node/iWallet.md). Gleichzeitig kann [das Starten eines lokalen Testknotens](4-running-iost-node/LocalServer.md) das Debugging erleichtern. 

### Import des anfänglichen Kontos ```admin``` für iwallet

Um den Test abzuschließen, müssen Sie ein Konto für iwallet importieren.   
Sie können das Konto "admin" für den lokalen Testknoten importieren.

```
iwallet account import admin 2yquS3ySrGWPEKywCPzX4RTJugqRh7kJSo5aehsLYPEWkUxBWA39oMrZ7ZxuM4fgyXYs2cPwh5n8aNNpH5x2VyK1
```


## Hello World

### Vorbereitung des Codes
Bereiten Sie zunächst eine JavaScript-Klasse vor. z.B. HelloWorld.js

```
class HelloWorld {
    init() {} // needs to provide an init function that will be called during deployment
    hello(someone) {
        return "hello, "+ someone
    }
}

module.exports = HelloWorld;
```

Der Smart Contract enthält eine Schnittstelle, die einen Input empfängt und dann ```hello, + enter ```` ausgibt. Damit diese Schnittstelle auch außerhalb des Smart Contract aufgerufen werden kann, müssen Sie die abi-Datei vorbereiten. z.B. HelloWorld.abi

```
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

Das Namensfeld von abi entspricht dem Funktionsnamen von js, und die Argliste enthält eine vorläufige Typenprüfung. Es wird empfohlen, nur drei Typen zu verwenden: string, number und bool.

## Veröffentlichen auf lokalem Testknoten

Veröffentlichung von Smart Contracts

```
iwallet \
 --server localhost:30002 \
 --account admin \
 publish helloworld.js helloworld.abi
```

Beispielausgabe

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa
    Checking transaction receipt...
    SUCCESS!
    The contract id is: Contract2xC6ziTqXaat7dsrya9pHog6NEEAMgBMKWcMv5YNDEpa

Test ABI Aufruf

```
iwallet \
 --server localhost:30002 \
 --account admin \
 call "Contract96YFqvomoAnX6Zyj993fkv29D2HVfm8cjGhCEM1ymXGf" "hello" '["developer"]' # contract id needs to be changed to the id you received
```

Ausgabe

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: CzQi1ro44E6ysVq6o6c6UEqYNrPbN7HruAjewoGfRTBy
    Checking transaction receipt...
    SUCCESS!

Danach können Sie TxReceipt jederzeit mit dem folgenden Befehl abrufen.

```
iwallet receipt GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

Kann auch über http bezogen werden.

```
curl -X GET \
  http://localhost:30001/getTxReceiptByTxHash/GTUmtpWPdPMVvJdsVf8AiEPy9EzCBUwUCim9gqKjvFLc
```

Es kann davon ausgegangen werden, dass dieser Anruf von IOST dauerhaft aufgezeichnet wird und nicht manipuliert werden kann.

## Smart Contract Zustandspeicher

Die Verwendung von Smart Contract Ausgaben (ähnlich dem Konzept von utxo) ist ungünstig, IOST verwendet diesen Modus nicht, so dass IOST keinen Index auf jedes Feld in TxReceipt liefert und der Smart Contract nicht auf einen bestimmten TxReceipt zugreifen kann. Um die Blockchain-Zustandsmaschine aufrechtzuerhalten, verwenden wir eine Blockchain-Zustandsdatenbank, um den Zustand zu halten.

Die Datenbank ist eine reine K-V-Datenbank, der Schlüssel und der Werttyp ist string. Jeder Smart Contract hat einen eigenen Namensraum.
Smart Contracts können Statusdaten von anderen Smart Contracts lesen, aber nur ihre eigenen Felder schreiben. 

Vollständige APIs hier: [Blockchain API](3-smart-contract/IOST-Blockchain-API.md)

### Coding
```
class Test {
    init() {
        storage.put("value1", "foobar")
    }
    get() {
        return storage.get("value1")
    }
    change(someone) {
        storage.put("value1", someone)
    }
}
module.exports = Test;
```

### Verwendung des Zustandsspeichers
Nach der Bereitstellung des Codes können Sie den Speicher mit der folgenden Methode beziehen

```
curl -X POST \
  http://localhost:30001/getContractStorage \
  -d '{
    "id": "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e",
    "key": "value1",
    "by_longest_chain": true
}'
```

Dieser Post wird einen json zurückgeben

```
{
    "data": "foobar"
}
```

Dieser Wert kann durch den Aufruf von change geändert werden.

```
iwallet \
 --server localhost:30002 \
 --account admin \
 call "Contract5bxTBndRrNjMJqJdRwiC9MVtfp6Z2LFFDp3AEjceHo2e" "change" '["foobaz"]'
```

## Berechtigungskontrolle und Smart Contract Scheitern

Die Grundlage der Berechtigungskontrolle ist unter:

Beispiel

```
if (!blockchain.requireAuth("someone", "active")) {
    throw "require auth error" // throw will be thrown to the virtual machine, causing failure
}
```

Die folgenden Punkte müssen beachtet werden. 

1. requireAuth selbst beendet nicht den Betrieb des Smart Contract, es gibt nur einen Bool-Wert zurück, so dass Sie entscheiden müssen.
2. requireAuth(tx.publisher, "active") ist immer true.

Wenn die Transaktion nicht ausgeführt wird, wird dieser Smart Contract Aufruf vollständig zurückgesetzt, zieht aber die Gaskosten des Benutzers, der die Transaktion ausführt, ab (weil er zurückgesetzt wird, wird er keinen Ram berechnen).

Sie können eine fehlgeschlagene Transaktion mit einem einfachen Test beobachten.

```
iwallet \
 --server localhost:30002 \
 --account admin \
 call "token.iost" "transfer" '["iost","someone","me","10","this is steal"]'
```

Das Ergebnis wird sein

    Sending transaction...
    Transaction has been sent.
    The transaction hash is: 6KY4h4gKHFwuovXZJEDzvPtN9YYcJ5kUFHLf84gktYYu
    Checking transaction receipt...
    ERROR: running action Action{Contract: token.iost, ActionName: transfer, Data: ["iost","someone","me","10","this is st... error: transaction has no permission

## Debugging

Starten Sie zunächst den lokalen Knoten wie oben beschrieben. Wenn Sie Docker verwenden, können Sie den folgenden Befehl verwenden, um das Protokoll zu erstellen.
```
docker ps -f <container>
```

An dieser Stelle können Sie das erforderliche Protokoll im Code hinzufügen, indem Sie console.log() hinzufügen. Das an console.log() übergebene Argument wird an stdout des Serverprozesses ausgegeben.

## ABI Interface Definition

IOST Smart Contracts interagiert mit dem Netzwerk über ABIs.

ABIs sind von JSON definierte Informationen, einschließlich des Namens, der Parametertypen usw. Die unterstützten Grundtypen sind `string`, `number` und `bool`.

Komplexere Datenstrukturen können in JSON-Strings analysiert werden. Beim Aufruf von Funktionen in einem Smart Contract sollten die ABI-Parametertypen strikt eingehalten werden. Andernfalls wird die Ausführung gestoppt und es fallen Transaktionsgebühren an.

```json
// example luckybet.js.abi
{
    "lang": "javascript",
    "version": "1.0.0",
    "abi": [
        {
            "name": "bet",
            "args": [
                "string",
                "number",
                "number",
                "number"
            ],
            "amountLimit": [
            {
                "token": "iost",
                "val": "unlimited"
            },
            {
                "token": "sometoken",
                "val": "1000"
            }
            ]
        }
    ]
}
```

`amountLimit` gibt an, wie viele Token von diesem ABI ausgegeben werden können. Im obigen Beispiel kann das ABI unbegrenzte `iost` Token und höchstens 1000 `sometoken` Token kosten, und es kann keinen anderen Token kosten, sonst wird die Tx zurückgesetzt.

## Blockchain API
[Blockchain API](3-smart-contract/IOST-Blockchain-API.md) wird bereitgestellt. Sie kann zur Interaktion mit der Blockchain verwendet werden. 

## Ressourceneinschränkung
Die Ausführung des Contracts kostet Gas. Die Abrechnung erfolgt nach [dieser Tabelle](6-Referenz/GasChargeTable.md).  
Jede Transaktion muss mit 200ms abgeschlossen sein, sonst wird sie beendet und zurückgesetzt.


## Andere Contracts aufrufen

In einem Smart Contract können Sie mit `blockchain.call()` eine ABI-Schnittstelle aufrufen und den Rückgabewert erhalten.    

Aufrufe zwischen Smart Contracts können Signaturberechtigungen weiterleiten. Wenn `A.a` beispielsweise `B.b` mit `blockchain.callWithAuth` aufruft, wird die Berechtigung zu `B.b` von einem Benutzer impliziert, wenn `A.a` aufgerufen wird. Andererseits, wenn `blockchain.call` verwendet wird, dann werden die Berechtigungen nicht weitergegeben. 

Smart Contracts können den Stapel von Aufrufen überprüfen und Fragen wie "Wer hat diese ABI aufgerufen" beantworten. Dies ermöglicht es, dass bestimmte Vorgänge existieren.

## System Contracts
[Econ Contracts](6-reference/EconContract.md) kann zur Verwaltung von Ram/Gas verwendet werden.   
[Token Contracts](6-reference/TokenContract.md) können zur Ausgabe / Übertragung von Token verwendet werden.   
[System Contracts](6-reference/SystemContract.md) enthält Contracts, die sich auf Abstimmung, Konto, Contracts beziehen.


## Contract Update

Smart Contracts können aktualisiert werden, wenn `can_update()` definiert ist. Mehr Details [hier](3-smart-contract/Update-Contract.md)

## TxReceipt

Nach der Ausführung generiert der Smart Contract einen `TxReceipt` in den Block und sucht nach einem Konsens. Mehr Details [hier](3-smart-contract/Generate-Receipt)


