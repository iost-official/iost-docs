---
id: version-3.0.0-Database
title: Datenbank
sidebar_label: Datenbank
original_id: Database
---

Die Datenbankschicht von IOST ist wie folgt aufgebaut:

![statedb](assets/2-intro-of-iost/Database/statedb.png)

Die unterste Ebene ist die Speicherebene, die die endgültige Persistenz der Daten gewährleistet. Wir verwenden den einfachsten Key-Value-Datenbank-Formfaktor und erreichen den Zugriff auf verschiedene Datenbanken, indem wir in verschiedene Datenbank-Backends schreiben.

Aufgrund des Paradigmas des Datenhandlings auf der Blockchain verwenden wir den MVCC-Cache, um Anfragen zu verarbeiten und gleichzeitig im Speicher zwischenzuspeichern. Dies verbessert die Benutzerfreundlichkeit und Performance.

Die äußerste Ebene ist der Commit Manager, der sich um die Verwaltung und Pflege von Daten in mehreren Versionen kümmert. Höhere Schichten können die Schnittstelle daher wie eine typische Datenbank behandeln und nach Belieben auf jede beliebige Version wechseln.

