---
id: version-3.0.0-Account
title: Konto
sidebar_label: Konto
original_id: Account
---


# Berechtigungssystem für Konten

## Überblick

Das Konto-Berechtigungssystem von IOST basiert auf dem Mechanismus von öffentlich-privaten Schlüsselpaaren. Durch die Einrichtung von Owner Schlüssel und Active Schlüssel können Benutzer bequem mehrere Account-Systeme verwalten und gleichzeitig nach Belieben neue Berechtigungen und geheime Gewichtungen einrichten. Dies ermöglicht viele kundenspezifische Managementfunktionen.

## Grundlagen des Systems für Konten

Ein IOST-Konto wird mit ID und Berechtigungen erstellt. Ein Konto kann mehrere Berechtigungen haben und hat mindestens die Berechtigungen `owner` und `active`. Jede Berechtigung registriert mehrere Elemente, wobei ein Element ein base58-kodierter öffentlicher Schlüssel oder ein Berechtigungspaar von einem anderen Konto ist.

Das Berechtigungspaar kann eine Zeichenkette aus account_name@permission_name sein.

Jedes Element hat eine bestimmte Gewichtung, entsprechend hat jede Berechtigung einen Grenzwert. Wenn eine Transaktionsposition ein Gewicht hat, das größer als der Grenzwert ist, geht die Transaktion von dieser Berechtigung aus.

Die Methode zur Überprüfung des Eigentums an Elementen besteht darin, zu überprüfen, ob die Transaktionssignaturen die Signatur für den öffentlichen Schlüssel eines bestimmten Elements enthalten (wenn es sich bei dem Element um einen öffentlichen Schlüssel handelt), oder rekursiv zu prüfen, ob die Transaktion das Konto-Berechtigungspaar des Elements enthält (wenn es sich bei dem Element um ein Konto-Berechtigungspaar handelt).

Im Allgemeinen werden Smart Contracts bei der Validierung von Berechtigungen ihre Konto-ID und Berechtigungs-ID angeben. Das System prüft die Signaturen der Transaktion, berechnet die Gewichte der Positionen und validiert die Transaktion, wenn die Signatur die Grenzwertanforderungen erfüllt. Andernfalls schlägt die Validierung fehl.

Die `active` Berechtigung kann alle anderen Berechtigungen mit Ausnahme der `owner`-Berechtigung gewähren. Die Berechtigung `owner` gewährt den gleichen Satz von Berechtigungen und erlaubt Änderungen an Elementen unter den Berechtigungen `owner` und `active`. Für das Einreichen einer Transaktion ist eine `active` Berechtigung erforderlich.

Berechtigungen können mit Gruppen arbeiten. Sie können Berechtigungen zu einer Gruppe hinzufügen sowie Elemente zu dieser Gruppe hinzufügen. Auf diese Weise erhalten die Elemente alle Berechtigungen der Gruppe.

## Kontensystem Nutzung

Bei Smart Contracts gibt es eine einfache API zum Aufruf.

```
blockchain.requireAuth(id, permission_string)
```

Dies gibt einen booleschen Wert zurück, damit Sie entscheiden können, ob der Vorgang fortgesetzt werden soll.

Im Allgemeinen sollten Sie bei der Verwendung von Ram und Token zunächst nach der `active` Berechtigung des Benutzers suchen, da der Smart Contract sonst unerwartet ausfallen kann. Wählen Sie eine eindeutige Zeichenkette für `permission_string`, um die Berechtigung zu minimieren.

Normalerweise sollten Sie keine `owner` Berechtigungen benötigen, da Benutzer nicht nach dem Besitzerschlüssel gefragt werden sollten, es sei denn, Sie ändern die Berechtigungen `owner` und `active`.

Es ist nicht erforderlich, einen Transaktionssender zu definieren, da er immer die Berechtigung `active` hat.

Auf Benutzerebene, nur durch die Bereitstellung der Signatur, sehen wir, wie Benutzer Berechtigungen hinzufügen. Nehmen wir zwei Konten an (und nehmen wir 1 für alle Gewichtungen und Grenzwerte der Schlüssel an):

```
User0
├── Groups
│   └── grp0: key3
└── Permissions
    ├── owner: key0
    ├── active: key1
    ├── perm0: key2, grp0
    ├── perm1: User1@active, grp0
    ├── perm2(threshold = 2): key4, key5, grp0
    ├── perm3: key8
    └── perm4(threshold = 2): User@perm3, key9

User1
└── Permissions
    ├── owner: key6
    └── active: key7
```

RequireAuth form

Parameter	|Sig Schlüssel	  |Ausgabe    |Anmerkungen
-----	      |----				|------	    |-------
User0, perm0		|key2			|true			|Berechtigung erteilt, wenn die Signatur für den öffentlichen Schlüssel vorliegt
User0, perm0		|key3			|true			|Berechtigung erteilt, wenn die Signatur für die Gruppe vorliegt
User0, perm0		|key1			|true			|Berechtigung erteilt (außer `owner` Berechtigung), wenn `active` Schlüssel vorliegt
User0, perm1		|key7			|true			|key7 stellt User1@active Berechtigung zur Verfügung und gewährt damit perm1
User0, owner		|key1			|false		|`active` stellt keine `owner`-Berechtigung zur Verfügung
User0, active		|key0			|true			|`owner` gewährt alle Berechtigungen
User0, perm2		|key4			|false		|Signaturen haben den Grenzwert nicht erreicht
User0, perm2		|key4,key5	|true			|Signaturen haben den Grenzwert erreicht
User0, perm2		|key3			|true			|Berechtigungsgruppe berechnet und prüft nicht den Grenzwert
User0, perm2		|key1			|true			|`active` prüft nicht den Grenzwert
User0, perm4		|key8			|false		|Kann bei der Berechnung der Gewichtung der Berechtigungsgruppe implementiert werden

## Erstellen und Verwalten von Konten

Die Kontoführung basiert auf dem Contract von `auth.iost`. Die ABI ist wie folgt:

```js
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "signUp", // Create account
      "args": ["string", "string", "string"] // Username, ownerKey ID, activeKey ID
    },
    {
      "name": "addPermission", // Add permission
      "args": ["string", "string", "number"] // Username, permission name, threshold
    },
    {
      "name": "dropPermission", // Drop permission
      "args": ["string", "string"] // Username, permission name
    },
    {
      "name": "assignPermission", // Assign permission to an item
      "args": ["string", "string", "string","number"] // Username, permission, public key ID or account_name@permission_name, weight
    },
    {
      "name": "revokePermission",    // Revoke permission
      "args": ["string", "string", "string"] // Username, permission, public key ID or account_name@permission_name
    },
    {
      "name": "addGroup",   // Add permission group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "dropGroup",   // Drop group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "assignGroup", // Assign item to group
      "args": ["string", "string", "string", "number"] // Username, group name, public key ID or account_name@permission_name, weight
    },
    {
      "name": "revokeGroup",    // Revoke group
      "args": ["string", "string", "string"] // Username, group name, public key ID or account_name@permission_name
    },
    {
      "name": "assignPermissionToGroup", // Assign permission to group
      "args": ["string", "string", "string"] // Username, permission name, group name
    },
    {
      "name": "revokePermissionInGroup", // Revoke permissions from a group
      "args": ["string", "string", "string"] // Username, permission name, group name
    }
  ]
}
```

Kontonamen sind nur gültig mit `[a-z0-9_]`, mit einer Länge zwischen 5 und 11. Berechtigungsname und Gruppennamen sind nur gültig mit `[a-zA-Z0-9_]` mit einer Länge zwischen 1 und 32.

Normalerweise müssen Konten bei Antrag IOST einzahlen, oder das Konto kann nicht verwendet werden. Eine Möglichkeit, dies zu tun, ist mit `iost.js`:

```js
newAccount(name, ownerkey, activekey, initialRAM, initialGasPledge) {
    const t = new Tx(this.config.gasPrice, this.config.gasLimit, this.config.delay);
    t.addAction("iost.auth", "signUp", JSON.stringify([name, ownerkey, activekey]));
    t.addAction("iost.ram", "buy", JSON.stringify([this.publisher, name, initialRAM]));
    t.addAction("iost.gas", "pledge", JSON.stringify([this.publisher, name, initialGasPledge]));
    return t
}
```

Um den Prozess der Kontoerstellung zu optimieren, werden die Gebühren wie folgt abgezogen: Kontoerstellungskosten GAS vom Publisher und der Ram des neuen Kontos wird vom Publisher bezahlt. Wenn der Ram den gleichen Betrag ansammelt, erhält der Publisher den Ram zurück. Das erstellte Konto "bezahlt" dann für die Kontoerstellung.

Wenn Sie ein Konto eröffnen, können Sie Ram und Einzahlungs-Token für das erstellte Konto kaufen. Wir empfehlen, mindestens 10 Token einzuzahlen, damit das neue Konto über genügend Gas für die Nutzung des Netzes verfügt. Das deponierte GAS sollte nicht weniger als 10 Token betragen, um sicherzustellen, dass genügend GAS vorhanden ist, um Ressourcen zu kaufen.
