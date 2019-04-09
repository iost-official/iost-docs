---
id: version-3.0.0-Smart-contract
title: Smart Contract
sidebar_label: Smart Contract
original_id: Smart-contract
---

## Smart Contract

Smart Contracts empfangen und führen Transaktionen innerhalb des Blocks aus, um die Variablen des Smart Contracts innerhalb der Blockchain zu erhalten und einen unwiderruflichen Nachweis zu erbringen. IOST implementiert allgemeine ABI-Schnittstellen, Plug-and-Play-Mehrsprachenunterstützung und kann das Ergebnis des Konsenses generieren. Dies hat die Benutzerfreundlichkeit der Blockchain erheblich verbessert.


## ABI Schnittstelle

IOST Smart Contracts interagieren mit dem Netzwerk über ABIs.

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
            ]
        }
    ]
}
```
Jede Transaktion beinhaltet mehrere Transaktionsaktionen, und jede Aktion ist ein Aufruf an eine ABI. Alle Transaktionen erzeugen eine strikte Serialität in der Chain und verhindern so Double-Spend-Angriffe.
```golang
type Action struct {
	Contract   string  
	ActionName string
	Data       string  // A JSON Array of args
}
```
In einem Smart Contract können Sie mit `BlockChain.call()` eine ABI-Schnittstelle aufrufen und den Rückgabewert erhalten. Das System protokolliert den Aufrufstapel und verweigert Double-Spending.


## Mehrsprachige Unterstützung

IOST hat mehrsprachige Smart Contracts umgesetzt. Derzeit öffnen wir JavaScript mit v8-Engine, und es gibt native golang VM-Module, die hochperformante Transaktionen verarbeiten.

Die Smart Contract Engine von IOST besteht aus drei Teilen: Monitor, VM, Host. Monitor ist die globale Steuereinheit, die ABI-Aufrufe über Gateways an die richtige VM übermittelt. VM ist eine Virtual Machine Implementierung von Smart Contracts. Der Host verpackt die Laufzeitumgebungen und stellt sicher, dass die Contracts im richtigen Kontext laufen.


## Smart Contract Berechtigungssystem

Transaktionen unterstützen multiple Signaturen. Innerhalb eines Contracts können Sie mit `RequireAuth()` prüfen, ob der aktuelle Kontext die Signatur einer bestimmten ID trägt. Aufrufe zwischen Smart Contracts leiten Signaturberechtigungen weiter. Wenn `A.a` beispielsweise `B.b` aufruft, ist die Autorisierung zu `B.b` von einem Benutzer implizit, wenn `A.a` aufgerufen wird.

Smart Contracts können den Stapel von Aufrufen überprüfen und Fragen wie "Wer hat diese ABI aufgerufen" beantworten. Dies ermöglicht es, dass bestimmte Vorgänge existieren.

Smart Contracts haben spezielle Berechtigungen, wie z.B. ein Upgrade. Diese können mit `can_update()` implementiert werden.


## Ergebnis eines Aufrufs (Call)

Nach der Ausführung generiert der Smart Contract einen `TxReceipt` in den Block und sucht nach einem Konsens. Sie können RPC verwenden, um die TxReceipts von On-Chain-Transaktionen zu verfolgen.

