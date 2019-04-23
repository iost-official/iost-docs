---
id: version-3.0.6-Update-Contract
title: Contract Aktualisieren
sidebar_label: Contract Aktualisieren
original_id: Update-Contract
---

## Features

Nachdem der Contract in der Blockchain bereitgestellt wurde, müssen Entwickler möglicherweise den Contract aktualisieren, wie z.B. Fehlerbehebung, Versionsupgrades usw.

Wir bieten einen kompletten Contractaktualisierungsmechanismus, der es Entwicklern ermöglicht, Smart Contracts einfach durch Senden einer Transaktion zu aktualisieren.
Noch wichtiger ist, dass wir eine sehr flexible Update-Berechtigungssteuerung anbieten, um allen Berechtigungsanforderungen gerecht zu werden.

Um den Smart Contract zu aktualisieren, müssen Sie eine Funktion im Smart Contract implementieren:

```js
can_update(data) {
}
```

Wenn Sie eine Anforderung zur Aktualisierung des Contracts erhalten, ruft das System zunächst die Funktion can_update(data) des Contracts auf. data ist ein optionaler Eingabeparameter vom Typ string. Wenn die Funktion true zurückgibt, wird die Contractaktualisierung durchgeführt. Andernfalls wird ein Fehler `Update Refused` zurückgegeben.

Indem Sie diese Funktion richtig schreiben, können Sie alle Anforderungen an das Berechtigungsmanagement umsetzen, wie z.B.: nur aktualisieren, wenn zwei Personen gleichzeitig autorisieren, oder wenn einige Personen abstimmen, um zu entscheiden, ob sie den Contract aktualisieren möchten, etc.

**Wenn die Funktion nicht im Contract implementiert ist, ist es dem Contract nicht erlaubt, standardmäßig zu aktualisieren.**

## Beispiel

Im Folgenden nehmen wir einen einfachen Smart Contract als Beispiel, um den Prozess der Contractaktualisierung zu veranschaulichen.

Erstellen Sie eine neue Contractdatei helloContract.js mit folgendem Inhalt

```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello world";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }
};
module.exports = helloContract;
```

Schauen Sie sich die Implementierung der Funktion can_update() in der Contractdatei an, sie ermöglicht, den Contract nur dann zu aktualisieren, wenn Sie die Berechtigung für das Contractinhaberkonto verwenden.

### Contract veröffentlichen

Weitere Informationen finden Sie unter [Contract veröffentlichen](4-running-iost-node/iWallet.md#publish-contract).

Zuerst sollten Sie die abi-Datei generieren. **`can_update` muss sich in der abi-Datei befinden, um Update zu aktivieren.**

```
iwallet compile hello.js
```

Dann mit Hilfe von iwallet den Contract aktualisieren

```
$ export IOST_ACCOUNT=admin # replace with your own account name here
$ iwallet --account $IOST_ACCOUNT publish hello.js hello.js.abi
...
Die Contract ID ist: ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### Aufruf des Contracts beim ersten Mal
Jetzt rufen Sie die Funktion `hello` innerhalb des Contracts auf, den Sie gerade hochgeladen haben, Sie erhalten 'hello world' als Rückgabe. 
```
$ iwallet --account $IOST_ACCOUNT -v call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello world\"]"
    ],
    "receipts": [
    ]
}
```

### Contract aktualisieren
Bearbeiten Sie zunächst die Contractdatei helloContract.js, um einen neuen Contractcode wie folgt zu generieren:
```js
class helloContract
{
    init() {
    }
    hello() {
        return "hello iost";
    }
    can_update(data) {
        return blockchain.requireAuth(blockchain.contractOwner(), "active");
    }
};
module.exports = helloContract;
```
Wir haben die Implementierung der Funktion hello() modifiziert, um die Rückgabe von 'hello world' auf 'hello iost' zu ändern.   

Verwenden Sie den folgenden Befehl, um Ihren Smart Contract zu aktualisieren:

```console
iwallet --account $IOST_ACCOUNT publish --update hello.js hello.js.abi ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax
```

### Aufruf des Contracts beim zweiten Mal
Nachdem die Transaktion bestätigt wurde, können Sie die hello()-Funktion über iwallet erneut aufrufen und feststellen, dass sich die Rückgabe von 'hello world' auf 'hello iost' ändert.
```
$ iwallet --account $IOST_ACCOUNT -v call ContractEg5zFjJrSPdgCR5mYXQLfHXripq64q17MuJoaWKTaaax hello "[]"
...
    "statusCode": "SUCCESS",
    "message": "",
    "returns": [
        "[\"hello iost\"]"
    ],
    "receipts": [
    ]
}
```







