---
id: version-3.0.6-IOST-Blockchain-API
title: IOST Blockchain API
sidebar_label: IOST Blockchain API
original_id: IOST-Blockchain-API
---


# IOST Blockchain API
Auf die untenstehenden Objekte kann innerhalb der Contract Codes zugegriffen werden. 
  
**Hinweis: Strings dürfen nicht länger als 65536 Bytes sein**

## Storage Objekt

Alle Variablen werden zur Laufzeit im Speicher abgelegt. IOST bietet ein `storage` Objekt, das Entwicklern hilft, Daten in Smart Contracts zu speichern. 
APIs ohne Präfix 'global' werden verwendet, um die Speicherung des aufrufenden Contracts zu ermitteln bzw. einzustellen. APIs mit dem Präfix 'global' werden verwendet, um die Speicherung anderer Contracts zu ermitteln.


Entwickler können diese Klasse verwenden, um Daten bei mehreren Contractaufrufen zu synchronisieren. Hier ist die API dieses Objekts aufgeführt, Sie können auch Details finden [im Code](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/storage.js).

### Contract Storage API

#### put(key, value, payer)

Legt einfach ein Schlüssel-Wert-Paar in den Speicher ab.  

* Parameter:
	* key: string
	* value: string.
	* payer: string. Definiert, wer für die Nutzung des Ram aufkommt. Dieser Parameter ist optional. Wenn er leer ist, bezahlt der Contract Publisher die Ram-Nutzung.
* Ausgabe: none

#### get(key)

Abruf des Wertes aus dem Speicher mittels Schlüssel.

* Parameter:
	* key: string
* Ausgabe: string des Wertes wenn vorhanden; `null` wenn nicht vorhanden

#### has(key)

Prüft, ob der Schlüssel im Speicher vorhanden ist.

* Parameters:
	* key: string
* Returns: bool (`true` wenn existent, `false` wenn nicht-existent)

#### del(key)

Löscht einfach ein Schlüssel-Wert-Paar mit dem Schlüssel aus dem Speicher.

* Parameter:
	* key: string
* Ausgabe: none

#### mapPut(key, field, value, payer)

MapPut (Ablegen) ein (key, field, value) Paar, verwendet key + field um den Wert zu finden.

* Parameter:
	* key: string
	* field: string
	* value: string
	* payer: string. Ähnlich zu `payer` von `put`   
* Ausgabe: none

#### mapGet(key, field)

MapGet (Abrufen) ein (key, field) Paar, verwendet key + field um den Wert zu finden.
* Parameter:
	* key: string
	* field: string
* Ausgabe: string des Wertes wenn vorhanden; `null` wenn nicht vorhanden

#### mapHas(key, field)

MapCheck (Ermitteln) eine (key, field) Paarexistenz, verwendet key + field um zu ermitteln.

* Parameter:
	* key: string
	* field: string
* Ausgabe: bool (`true` wenn existent, `false` wenn nicht-existent)

#### mapKeys(key)

MapGet (Abrufen) Felder innerhalb eines Schlüssels.    

Achtung:

**1. Diese API speichert nur maximal 256 Felder, und das überschrittene Feld wird nicht gespeichert und wird in dieser API nicht zurückgegeben.**  
**2. Wenn "mapDel" aufgerufen wird, dann können spätere mapKeys falsch sein! Wenn sowohl mapDel als auch mapKeys im Contract benötigt werden, wird empfohlen, dass alle Felder gleich lang sind, in diesem Fall macht mapKeys keinen Fehler.**  
**3. Wenn Sie alle Schlüssel einer Map erhalten müssen, wird empfohlen, diese selbst zu pflegen und diese API nicht zu verwenden.**

* Parameter:
	* key: string
* Ausgabe: array\[string\] (Array von Feldern)

#### mapLen(key)

Ausgeben von len(mapKeys()).

**Die Achtung ist die gleiche wie bei [mapKeys](#mapkeyskey).**


* Parameter:
	* key: string
* Ausgabe: int (Anzahl von Feldern)

#### mapDel(key, field)

MapDelete (Löschung) eines (key, field, value) Paars, verwendet key + field um einen Wert zu löschen.   
**mapDel kann dazu führen, dass mapKeys ein falsches Ergebnis liefert, also verlassen Sie sich nicht auf mapKeys, wenn Sie mapDel aufrufen müssen**

* Parameter:
	* key: string
	* field: string
* Ausgabe: none

### Globale Storage API
APIs, die verwendet werden, um die Speicherung anderer Contracts zu ermitteln.

#### globalHas(contract, key)

Prüft, ob der Schlüssel im globalen Speicher vorhanden ist.

* Parameter:
	* contract: string
	* key: string
* Ausgabe: bool (`true` wenn existent, `false` wenn nicht-existent)

#### globalGet(contract, key)

Liefert den Wert aus dem globalen Speicher mit Hilfe des Schlüssels.

* Parameter:
	* contract: string
	* key: string
* Ausgabe: string des Wertes wenn vorhanden; `null` wenn nicht vorhanden

#### globalMapHas(contract, key, field)

Map Prüfung ob ein (key, field) Paar im globalen Speicher vorhanden ist, verwendet key + field zum Überprüfen.

* Parameter:
	* contract: string
	* key: string
	* field: string
* Ausgabe: bool (`true` wenn existent, `false` wenn nicht-existent)

#### globalMapGet(contract, key, field)

MapGet (Abrufen) ein (key, field) Paar aus dem globalen Speicher, verwendet key + field zum Überprüfen.

* Parameters:
	* contract: string
	* key: string
	* field: string
* Returns: string of value if exists, `null` if non exists

#### globalMapLen(contract, key)

Map Anzahl der Felder (fields) innerhalb eines Schlüssels (key) aus dem globalen Speicher. Wenn die Anzahl der Felder größer als 256 ist, garantiert diese Funktion nicht, dass das Ergebnis korrekt ist, und gibt höchstens 256 zurück.

**Die Achtung ist die gleiche wie bei [mapKeys](#mapkeyskey).**

* Parameter:
	* contract: string
	* key: string
* Ausgabe: int (Anzahl der Felder)

#### globalMapKeys(contract, key)

Map Get (Abrufen) Felder (fields) innerhalb eines Schlüssels (key) aus dem globalen Speicher. Wenn die Anzahl der Felder größer als 256 ist, garantiert diese Funktion nicht, dass das Ergebnis korrekt ist, und gibt höchstens 256 zurück.

**Die Achtung ist die gleiche wie bei [mapKeys](#mapkeyskey).**

* Parameter:
	* contract: string
	* key: string
* Ausgabe: array\[string\] (Array von Feldern)

## Blockchain Objekt

Blockchain Objekt bietet alle Methoden, die das System aufrufen kann, und hilft dem Benutzer, offizielle APIs aufzurufen, einschließlich, aber nicht beschränkt auf die Übertragung von Coins, den Aufruf anderer Contracts und das Auffinden eines Blocks oder einer Transaktion.

Das Folgende ist die API des Blockchain Objekt, Sie können auch detaillierte Schnittstellen finden [im Code](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/blockchain.js).

#### transfer(from, to, amount, memo)

Transfer IOSToken.

* Parameter:
	* from: string
	* to: string
	* amount: string/number
	* memo: string
* Ausgabe: none

#### withdraw(to, amount, memo)

Abheben von IOSToken.

* Parameter:
	* to: string
	* amount: string/number
	* memo: string
* Ausgabe: none

#### deposit(from, amount, memo)

Einzahlen von IOSToken.

* Parameter:
	* from: string
	* amount: string/number
	* memo: string
* Ausgabe: none

#### blockInfo()

Abrufen der Blockinfo.

* Parameter: none
* Ausgabe: JSONString der Blockinfo. Das Gleiche gilt für das globale `block` -Objekt

#### txInfo()

Abrufen der Transaktionsinfo.

* Parameters: none
* Returns: JSONString der Transaktionsinfo. Das Gleiche gilt für das globale `tx` -Objekt

#### contextInfo()

Abrufen der Kontextinfo.

* Parameters: none
* Returns: JSONString der Kontextinfo

Beispiel: 

```js
{
	"abi_name":"contextinfo",
	"contract_name":"ContractHYtPky2PHTAgweBw262jBZcj241ejUqweS7rcfQibn5t",
	"publisher":"admin"
}
```

#### contractName()

Abrufen des Contract-Namen.

* Parameter: none
* Ausgabe: string von Contract-Name

#### publisher()

Abrufen des Publishers.

* Parameter: none
* Ausgabe: string von TX des Publishers

#### contractOwner()

Abrufen des Contract-Besitzers.

* Parameter: none
* Ausgabe: string von Contract-Publisher


#### call(contract, api, args)

Aufruf der API des Contracts mittels Args.

* Parameter:
	* contract: string
	* api: string
	* args: JSONString
* Ausgabe: string

#### callWithAuth(contract, api, args)

Aufruf der API des Contracts über Args mit den Berechtigungen des TX-Publishers. 

* Parameter:
	* contract: string
	* api: string
	* args: JSONString
* Ausgabe: string

Beispiel:

```js
// make the tx sender to transfer 20 IOST to contract publisher
blockchain.callWithAuth("token.iost", "transfer", ["iost", tx.publisher, blockchain.contractOwner(), "20", ""]);
```

#### requireAuth(pubKey, permission)

Prüft die Berechtigung des Kontos.

* Parameter:
	* pubKey: string
	* permission: string
* Ausgabe: bool (`true` wenn Konto die Berechtigung hat, `false` wenn nicht)

#### receipt(data)

Beleg erzeugen.

* Parameter:
	* data: string
* Ausgabe: none

#### event(content)

Event posten.

* Parameter:
	* content: string
* Ausgabe: none


## TX Objekt und Block Objekt
TX Objekt enthält aktuelle Transaktionsinformationen. Beispiel:

```js
{
	time: 1541541540000000000,
	hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	expiration: 1541541540010000000,
	gas_limit: 100000,
	gas_ratio: 100,
	auth_list: {"IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn":2},
	publisher: "user0"
}
```  

Block Objekt enthält aktuelle Blockinformationen. Beispiel:

```js
{
	number: 132,
	parent_hash: "4mBbjkCYJQZz7hGSdnRKCLgGEkuhen1FCb6YDD7oLmtP",
	witness: "IOST4wQ6HPkSrtDRYi2TGkyMJZAB3em26fx79qR3UJC7fcxpL87wTn",
	time: 1541541540000000000
}
```

Sie können außerdem Details finden [hier](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/sandbox.cc#L29).

## IOSTCrypto Objekt

Quellcode [here](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/crypto.go)

#### sha3(data)
Berechnung von sha3-256 Hash.


* Parameter:
	* data: string
* Ausgabe: base58\_encode(sha3\_256(data))

##### Beispiel

```js
IOSTCrypto.sha3("Fule will be expensive. Everyone will have a small car.") // result: EBNarfcGkAczpeiSJwtUfH9FEVd1xFhdZis83erU9WNu
```

#### verify(algo, message, signature, pubkey)
Signatur Verifizierung

* Parameter:
	* algo: verwendeter Algorithmus, kann einer von 'ed25519' oder 'secp256k1' sein
	* message: **base58 kodiert** Originaltext der Signatur
	* signature: **base58 kodiert** zu prüfende Signatur
	* pubkey: **base58 kodiert** öffentlicher Schlüssel des entsprechenden privaten Schlüssels, der zum Signieren verwendet wird
* Ausgabe: 1 (Erfolg) oder 0 (Misserfolg)

```js
// StV1D.. is base58 encoded "hello world"
// 2vSjK.. is base58 encoded pubkey of private key '4PTQW2hvwZoyuMdgKbo3iQ9mM7DTzxSV54RpeJyycD9b1R1oGgYT9hKoPpAGiLrhYA8sLQ3sAVFoNuMXRsUH7zw6'
// 38V8b.. is base58 encoded signature
IOSTCrypto.verify("ed25519","StV1DL6CwTryKyV","38V8bZC4e78pU7zBN86CF8R8ip76Rhf3vyiwTQR2MVkqHesmUbZJVmN8AE6eWhQg6ekKaa2H4iB4JJibC5stBRrN","2vSjKSXhepo7vmbPQHFcnEvx8mWRFrf46DaTX1Bp3TBi") // result: 1
```

## Float64 und Int64 Klasse

`Float64` und `Int64` Klassen werden bereitgestellt, um hochpräzise Berechnungen durchzuführen.   
Float64 APIs [hier](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/float64.js) und Int64 APIs [hier](https://github.com/iost-official/go-iost/blob/master/vm/v8vm/v8/libjs/int64.js)

# Deaktivierte Javascript-Methoden
Einige Funktionen von Javascript sind aus Sicherheitsgründen gesperrt.   
[Dieses Dokument](6-reference/GasChargeTable.md) enthält eine Liste der zulässigen und verbotenen APIs.
