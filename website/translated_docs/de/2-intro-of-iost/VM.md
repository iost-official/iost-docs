---
id: version-3.0.0-VM
title: VM
sidebar_label: VM
original_id: VM
---

Wir glauben, dass eine gute Implementierung einer virtuellen Maschine sowohl elegant gestaltet als auch einfach zu bedienen und sicher sein muss. Nach dem Vergleich der Vor- und Nachteile von EVM, EOS, C Lua und V8 haben wir die unvernünftigen Designs von EVM und EOS grundsätzlich aufgelöst. Wir haben es geschafft, die IOST-VM auf Basis von V8 zu erstellen, da sie eine hohe Performance auf Chrome aufweist.

## 1. IOST V8VM Struktur und Designs

VMManager ist das Herzstück von V8VM. Es hat drei Hauptmerkmale:

![statedb](assets/2-intro-of-iost/VM/V8VM.png)
* <font color="#0092ff">VM Eingang. </font>Er verbindet externe Anfragen von anderen Modulen, einschließlich RPC-Anfragen, Blockvalidierung, Tx-Validierung, etc. Die Arbeit wird nach der Vorverarbeitung und Formatierung an VMWorker übergeben.
* <font color="#0092ff">VMWorker Lifecycle Management. </font>Die Anzahl der Worker wird dynamisch basierend auf der Systemlast festgelegt. Es erreicht die Wiederverwendung von Workern. Innerhalb der Worker helfen JavaScript Hot Launch und Persistenz von Hotspot Sandbox Snapshots, die häufige Erstellung von VMs zu reduzieren und eine hohe Belastung von CPU und Speicher zu vermeiden, wenn derselbe Code geladen wird. Dies erhöht den Durchsatz des Systems und ermöglicht es dem IOST V8VM, auch bei der Verarbeitung von Contracts mit einer großen Nutzerbasis, wie z.B. fomo3D, zu agieren.
* <font color="#0092ff">Verwaltung der Schnittstelle zur Zustandsdatenbank. </font>Dies stellt die Atomizität jeder IOST-Transaktion sicher und verweigert die gesamte Transaktion, wenn ein Fehler mit unzureichender Deckung vorliegt. Gleichzeitig wird in der Zustandsdatenbank ein zweistufiger Cache erreicht, bevor er in die RocksDB übertragen wird.

## 2. Sandbox Coredesign

![statedb](assets/2-intro-of-iost/VM/sandbox.png)

Als Nutzlast von JavaScript für die Ausführung von Smart Contracts bietet Sandbox Schnittstellen zu V8VM und Pakete für den Aufruf von Chrome V8. Es gibt zwei Stufen, Kompilieren und Ausführen.

### Kompilierungsstufe

Hauptsächlich für die Entwicklung und Veröffentlichung von Smart Contracts konzipiert, verfügt es über zwei Funktionen:

* <font color="#0092ff">Contract Paket. </font>Verpacken Sie Smart Contracts mit Hilfe von Webpack. Es packt alle Javascript-Quellcodes im Projekt und installiert alle Abhängigkeiten, so dass IOST V8VM einfach zu großen Projekten entwickelt werden kann. Außerdem teilt IOST V8VM fast alle Funktionen von Node.js, so dass sich die Entwickler vertraut fühlen.
* <font color="#0092ff">Contract Snapshot. </font>Mit der Snapshot-Technologie erhöht die Kompilierung die Leistung bei der Erstellung eines Isolats und von Kontexten - eine Anti-Serialisierung des Snapshots wird das Ergebnis zur Laufzeit erzielen und die Lade- und Ausführungsgeschwindigkeit von JavaScript enorm erhöhen.

### Ausführungsstufe

Vor allem für die Ausführung von On-Chain-Verträgen hat es ebenfalls zwei Funktionen:

* <font color="#0092ff">LoadVM. </font>Schließt die Initialisierung der VM ab, einschließlich der Generierung des Chrome V8-Objekts, der Einstellung der Systemausführungsparameter, des Imports relevanter JavaScript-Klassenbibliotheken usw. Einige JavaScript-Klassenbibliotheken enthalten:

| Class Bibliothek          | Funktionen   |
| --------     | -----  |
| Blockchain   | Node.js-ähnliches modulares System, einschließlich Modul-Caching, Vorkompilierung, Zyklusaufrufe, etc.|
| Event        | Lesen/Schreiben von JavaScript mit der State Library und Zurücksetzen, wenn Contracts Fehler aufweisen.|
| NativeModule | Blockchain-bezogene Funktionen wie Übertragen, Entnehmen und Erhalten von Informationen über den aktuellen Block und Tx.|
| Storage      | Implementierung von Events. JavaScript Contracts interne Ereignisse können Rückrufe erhalten, nachdem sie On-Chain gegangen sind.|

* <font color="#0092ff">Ausführen. </font>Schließlich führt JavaScript Smart Contracts aus. IOST V8VM führt den Contract auf einem eigenständigen Thread aus, überwacht den Status des Runs und beendet (`Terminate`) den aktuellen Run, wenn ein Fehler, eine unzureichende Ressource oder ein Timeout vorliegt oder anormale Ergebnisse liefert.

