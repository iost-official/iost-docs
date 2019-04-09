---
id: version-3.0.0-Economic-model
title: Wirtschaftsmodell
sidebar_label: Wirtschaftsmodell
original_id: Economic-model
---
# Zusammenfassung

Die beiden am häufigsten verwendeten Wirtschaftsmodelle sind das Wirtschaftsmodell des Eigentumsmodells von ETH und das Mietwirtschaftsmodell von EOS.

Das Beitragswirtschaftsmodell des IOST zielt darauf ab, die Vorteile ausgereifter Wirtschaftsmodelle zu übernehmen und deren Mängel zu vermeiden. Implementierung eines frei nutzbaren Wirtschaftsmodells, das für groß angelegte kommerzielle DAPPs geeignet ist.

Das Wirtschaftsmodell wird wie folgt verglichen:
 
 System | Modell | Vorteile | Nachteile | 
| :---: | :----: | ----- | ----- |
ETH | Eigentum | 1. Erstellung eines kostenlosen Kontos <br>2. konkurrieren Sie mit Ressourcen, um die Netzauslastung auszugleichen <br>3.Gaspreise sind feiner und genauer. | 1. Wenn das System ausgelastet ist, wird der Preis für die Netzwerknutzung sehr teuer sein. Die Systemleistung ist gering, und die Entwicklung, Bereitstellung und Nutzung des Netzwerks wird weiterhin kostenpflichtig sein, es ist schwierig, große DAPP-Anwendungen zu unterstützen.<br>3. Der Speicherplatz kann keine Rückerstattung vornehmen, und der Benutzer hat nicht die Motivation, den Speicher freizugeben. Viele Abfall-Daten<br>4.CPU-Ressourcen und Speicherressourcen, einheitliche Zahlung mit Gas, was zu zwei sich gegenseitig beeinflussenden Ressourcen und einer niedrigen Nutzungsrate führt |
EOS | Miete | 1. wie viele Token im gesamten Netzwerk, wie viele Ressourcen sind im gesamten Netzwerk verfügbar?<br>2. Das System muss Token verpfänden, verbraucht keine Token, unterstützt große DAPP-Anwendungen <br>3. Leasing RAM, Benutzer haben die Motivation, Speicherplatz freizugeben, Token einzulösen und Blockchain-Datenerweiterungsprobleme zu mindern | 1. Erstellung komplexer Konten mit hohen Gebühren <br>2. Wenn große Verbraucher Token verpfänden um Ressourcen zu erhalten, wird dies zu einer Verwässerung der Retail-Ressourcen führen, selbst wenn das Netzwerk auf einem niedrigen Nutzungsniveau ist, Kleinanleger können sich keine Transaktionen im EOS-Netzwerk leisten.<br>3. Es gibt zu viele Arten von Ressourcen zu mieten (NET, CPU und RAM), und die Schwelle für den normalen Benutzerbetrieb ist hoch.
| IOST | Beitrag | 1. Erstellung eines Kontos ist einfach, kostengünstig <br>2. Je größer der Beitrag, desto mehr Systemressourcen können Sie nutzen.<br>3. Das System muss Token verpfänden, um GAS zu erhalten, es wird Token nicht verbrauchen, wirklich freie öffentliche Chain<br>4. mit Gas-Preisgestaltung kann es effektiv EOS großen Token-Verwässerung von Retail-Ressourcen vermeiden, viel fairer <br>5. Die Systemressourcen werden in CPU und Speicher aufgeteilt, die Ressourcenaufteilung ist günstiger für eine differenzierte Preisgestaltung Um das Problem der niedrigen ETH-Ressourcennutzung zu vermeiden, wird die Ressourcenauslastung reduziert. | Die Komplexität des Wirtschaftsmodells ist hoch |

# Zusätzliche Emissionen

Das System gibt alle 24 Stunden eine zusätzliche Emission aus.

Der anfängliche Gesamtbetrag des IOST-Blockchain-Systems beträgt 21 Milliarden, mit einer festen jährlichen Emission von 2%, die zur Belohnung der Produzentenknoten, Partnerknoten und Wähler verwendet wird.

### Emissionshäufigkeit

Jede weitere Erhöhung = jährlicher Inflationskoeffizient (1,98%) * aktuelle IOST-Summe * zwei zusätzliche Zeitintervalle (in Millisekunden) / Gesamtzeit pro Jahr (in Millisekunden)

Formel zur Berechnung des jährlichen Inflationskoeffizienten: (1+x)^n = 214.2/210

Daraus ergibt sich x = ln1.02 = 1.98%

x ist der Inflationskoeffizient, n ist die Anzahl der zusätzlichen Emissionen und 21,42 Milliarden ist der Gesamtbetrag der Token nach einem Jahr Inflation.

# Belohnung

Das Belohnungsmodell ist ein wichtiger Bestandteil des gesamten Wirtschaftsmodells. Es gibt vier Arten von Belohnungen: blockproduzierende Belohnung, Abstimmungsbelohnung, Hypothekenbelohnung und Verpfändungsbelohnung.

Der durch die Blockproduktion erhaltene Beitragswert kann für die Token-Belohnung aus dem Prämienpool eingelöst werden. Verpfändete Token bekommen GAS um die Transaktion zu bezahlen.

Wenn der Knoten Stimmen über einem bestimmten Schwellenwert erhält und die Zertifizierung besteht, dann können der Knoten und der Wähler des Knotens gleichzeitig die Belohnung erhalten.

Der Produzentenknoten kann die Token-Belohnung aus dem Belohnungspool jederzeit mit dem Beitragswert einlösen.

Der Beitragswert beträgt 1 zu 1 für Token, und die Hälfte des Rücknahmebonus wird dem Wähler gewährt.

Der Wert des Beitrags wird nach der Einlösung vernichtet und kann einmal alle 24 Stunden eingelöst werden.

### Gas Belohnung
    
Ein normaler Knoten kann Gas durch Pfand-Token erhalten, 1Token = 100.000 Gas/Tag, und der Pfand-Token ist gesperrt und kann nicht gehandelt werden.

Regel:

- Verpfänden Sie 1 IOST, erhalten Sie 100.000 GAS auf einmal und erzeugen Sie 100.000 GAS pro Tag
- Der Produktionsprozess ist reibungslos und die Gasproduktionsgeschwindigkeit beträgt 100.000 Gas/Token/Tag
- Die Obergrenze des GAS pro Benutzer beträgt das 300.000-fache der Gesamtzahl der Pfand-Token, d.h. 2 Tage nach Abschluss der Verrechnung
- Wenn Gas verwendet wird, ist es weniger als das 300.000fache des Pfand-Tokens, und Gas wird weiterhin entsprechend der Gasproduktionsgeschwindigkeit erzeugt
- Die IOST-Rücknahme kann jederzeit eingeleitet werden. Token, die eine Einlösung beantragen, erzeugen keinen GAS mehr. Die Rückzahlung dauert 72 Stunden
- Wird der IOST eingelöst, wird die Obergrenze des Belohnungsgases entsprechend reduziert und das die Obergrenze überschreitende Gas zerstört. Wenn das Pfand eingelöst wird, wird das Gas gelöscht

### Gas Benutzung

- Die Ausführung der Transaktion erfordert den Verbrauch von Gas
- Anzahl der von der Transaktion verbrauchten Gase = CGas (Command Gas) Verbrauch des Befehls * Anzahl der Befehle * Gasrate
- Gas kann nicht gehandelt werden

### Gas Sammlung

- Jedes Mal, wenn eine Transaktion eingeleitet wird, wird zunächst die Gasmenge berechnet, die der Benutzer derzeit hat, und dann der aktuellste Gasstand verwendet, um die Transaktion zu bezahlen
  
# Ressourcen
    
Die Systemressourcen werden in NET, CPU und RAM unterteilt. Wir abstrahieren das NET und die CPU in die GAS-Zahlung. Der Benutzer kauft und verkauft RAM mit dem System.

RAM:

- Die anfängliche RAM-Grenze des Systems beträgt 128G.
- Der Benutzer kauft und verkauft RAM mit dem System. Der Kauf von RAM wird mit 2% der Bearbeitungsgebühr berechnet, und die Bearbeitungsgebühr wird vernichtet
- Je weniger RAM im System verbleibt, desto teurer ist der Preis und umgekehrt
- Der Pfand-Token soll Benutzer ermutigen, ungenutzten RAM-Speicherplatz freizugeben und den Pfand-Token einzulösen
- Erhöhen Sie den RAM um 64G pro Jahr und fügen Sie jedes Mal RAM hinzu, wenn Sie ein Konto haben, um RAM zu kaufen
- Der vom System erworbene RAM kann an andere Benutzer weitergegeben werden und kann nach dem Geschenk nicht mehr abgerufen werden
- Der RAM, den der Benutzer erhält, kann nicht an das System verkauft und nicht wieder an andere Benutzer weitergegeben werden, d.h. der RAM kann nur einmal gehandelt werden
- Das System verwendet vorzugsweise den gespendeten RAM. Wenn das RAM freigegeben wird, bleibt das RAM-Attribut (gegeben, vom System gekauft) unverändert
- Beim Aufruf eines System-Contracts ist es möglich, das RAM des Benutzers zu verwenden

# Zirkulation
    
Die Liquidität von Token spiegelt den Wohlstand des Wirtschaftssystems wider. Die Erhöhung der Token-Mobilität ist eines der Ziele des wirtschaftlichen Modelldesigns.

Die IOST Public Chain ist eine neue Generation einer leistungsstarken, kostenlosen öffentlichen Blockchain. Benutzer können das System kostenlos nutzen, was den Wohlstand von DAPP und die Nutzung von C2C-Transfer erheblich fördern kann.

# Recycling

Token-Recycling dient vor allem dem Ausgleich von Angebot und Nachfrage.

- Abstimmen, RAM kaufen und Gas beziehen, alles muss Token verpfänden
- Die Gebühr für den Kauf von RAM wird vernichtet
- Das bei der Durchführung der Transaktion verbrauchte Gas wird vernichtet
- Mit zunehmender Anzahl der Nutzer des Systems werden auch die verpfändeten und vernichteten Token zunehmen, so dass das IOST-Wirtschaftsmodell deflationär ist
