---
id: version-3.0.0-Vote
title: Abstimmung
sidebar_label: Abstimmung
original_id: Vote
---

# Zusammenfassung

Die Abstimmung ist ein wichtiger autonomer Mechanismus für Blockchain-Systeme. Wenn ein Knoten weiterhin der IOST-Community dient, Code beisteuert und an der Governance teilnimmt, dann wird dieser Knoten sicherlich mehr Community-Stimmen erhalten. Knoten mit mehr Stimmen haben die Möglichkeit, an der Produktion der Blöcke teilzunehmen und Belohnungen zu erhalten. Die aktive Teilnahme an der Abstimmung ist für die Entwicklung der Community sehr wichtig, so dass das System die Wähler mit Token belohnen wird.

## Knotenart
In unserem Abstimmungsmechanismus gibt es drei Arten von Knoten: Kandidatenknoten, Partnerknoten und Dienstknoten.  
Durch den Aufruf der Methode [applyRegister](../6-Referenz/SystemContract.html#applyregister) des Abstimmungscontracts können Sie zum Kandidatenknoten werden. Wenn die Anzahl der Stimmen mehr als 2,1 Millionen beträgt und das Audit genehmigt wird, wird der Kandidatenknoten zu einem Partnerknoten oder einem Dienstknoten (bestimmt durch den letzten beim Aufruf des applyRegisters übergebenen Parameter, true ist ein Dienstknoten, false ist ein Partnerknoten). Der Dienstknoten muss Blöcke produzieren, der Partnerknoten nicht.



## Abstimmungsregeln

- 1 Token hat 1 Stimmrecht, 1 Stimmrecht kann nur für 1 registrierten Knoten, Partnerknoten oder Dienstknoten gewählt werden.
- Ein Konto kann für mehr als einen Knoten stimmen, und der Knoten kann für sich selbst stimmen.
- Nur Partnerknoten und Dienstknoten und deren Wähler können an den Abstimmungsboni teilnehmen.
- Token, die verpfändet sind, um Ressourcen zu kaufen, haben kein Stimmrecht.
- Nach dem Abbrechen der Abstimmung müssen Sie 7 Tage warten, um den Token einzulösen, Token in Einlösung erhält keine Stimmbelohnung.

## Belohnung
Das System wird jedes Jahr 2% Token ausgeben. 1% Token sind Blockbelohnungen nur für Dienstknoten. 1% Token sind Stimmrechte, von denen die Hälfte an Partner und Dienstleistungsknoten und die andere Hälfte an ihre Wähler vergeben wird.

### Blockbelohnung
- Blockbelohnungen werden entsprechend der Anzahl der Blöcke vergeben, die ein Knoten produziert hat. Die Belohnung für jeden Block beträgt etwa 3,3 IOST, die sich aus der Ausgaberate (2% pro Jahr) und der Rate der Blockproduktion (1 Block pro 0,5 Sekunde) berechnen lassen.
- Blockbelohnung erfordert, dass der Knoten die Initiative zum Empfangen ergreift, und der Weg zum Empfangen ist der Aufruf der Methode [exchangeIOST](../6-Referenz/SystemContract.html#exchangeiost) des Systemcontracts.


### Abstimmungsbelohnung

#### Knotenbelohnung

- Das System stellt alle 24 Stunden automatisch Token aus. Die ausgegebenen Token gehen in den Knoten-Belohnungspool und werden proportional nach der Anzahl der Stimmen verteilt, die jeder Knoten zum Zeitpunkt der Ausgabe erhalten hat.
- Jedes Konto kann den Knoten-Belohnungspool aufladen, indem es die Methode [topupCandidateBonus](../6-Referenz/SystemContract.html#topupcandidatebonus) des Abstimmungscontracts aufruft, und die Token werden proportional nach der Anzahl der Stimmen verteilt, die jeder Knoten zum Zeitpunkt des Aufladens erhält.
- Die Abstimmungsprämie benötigt den Knoten, um die Initiative zum Empfangen zu ergreifen, und die Art und Weise, wie er sie erhält, ist die Aufrufmethode [candidateWithdraw](.../6-reference/SystemContract.html#candidatewithdraw) des Abstimmungscontracts.
- 50% der stimmberechtigten Belohnung gehen in den Wähler-Belohnungspool, wenn die Belohnung vom Knoten erhalten wird.
- Die erzielten, aber noch nicht erhaltenen Belohnungen sind von den Änderungen der Knotenattribute und Stimmen nicht betroffen und können jederzeit ohne Verfall erhalten werden.

#### Wählerbelohnung

- Wenn ein Knoten eine Belohnung erhält, gehen 50% der Belohnung in den Wähler-Belohnungspool des Knotens und die Belohnung wird proportional nach der Stimmenzahl jedes Wählers zu diesem Zeitpunkt verteilt.
- Jedes Konto kann den Wähler-Belohnungspool aufladen, indem es die Methode [topupVoterBonus](../6-Referenz/SystemContract.html#topupvoterbonus) des Abstimmungscontracts aufruft, und die Token werden proportional nach der Abstimmungszahl jedes Wählers zum Zeitpunkt des Aufladens verteilt.
- Die Abstimmungsprämie benötigt den Knoten, um die Initiative zum Empfangen zu ergreifen, und die Art und Weise, wie er empfangen wird, ist die Aufrufmethode [voterWithdraw](.../6-reference/SystemContract.html#voterwithdraw) des Abstimmungscontracts.
- Die bereits erzielten, aber noch nicht erhaltenen Belohnungen sind von den zusätzlichen oder annullierten Abstimmungen der Wähler nicht betroffen und können jederzeit ohne Verfall erhalten werden.

