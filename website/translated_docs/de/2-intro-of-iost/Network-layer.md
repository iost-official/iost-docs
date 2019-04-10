---
id: version-3.0.0-Network-layer
title: Netzwerkebene
sidebar_label: Netzwerkebene
original_id: Network-layer
---

P2P (Peer-to-Peer)-Netzwerk oder Peer-Netzwerk ist eine dezentrale Struktur, die Aufgaben und Arbeitsbelastung unter den Peers verteilt. In P2P-Netzwerken sind die verbundenen Computer gleichberechtigt, und jeder Knoten ist sowohl Anbieter als auch Verbraucher von Ressourcen, Diensten und Inhalten. Im Gegensatz zu herkömmlichen Client-Server-Netzwerkmodellen haben P2P-Netze die Vorteile, dezentral, skalierbar, angriffsresistent und privat zu sein. Diese Vorteile sichern den Betrieb des Blockchain-Systems und sind Eckpfeiler einer freien, autonomen und dezentralen Blockchain.

## Design der IOST-Netzwerkebene

Unser Ziel ist es, eine vollständig dezentrale Netzwerktopologie mit schneller Erkennung von Knoten und schneller Übertragung von Transaktionen und Blöcken im gesamten Netz aufzubauen. Gleichzeitig hoffen wir, die Redundanz innerhalb des Netzwerks zu begrenzen und eine sichere Datenübertragung zwischen den Knoten zu erreichen. Durch Forschung und Tests haben wir uns entschieden, die leistungsstarke Bibliothek [libp2p](https://github.com/libp2p/go-libp2p) als unsere Netzwerkebene zu nutzen.

### Knotenerkennung und Konnektivität

Das Basisprotokoll ist TCP/IP. Um Lauschangriffe und unerwünschte Manipulationen von Daten zu verhindern, sichern wir die Daten mit einer TLS-Schicht auf TCP. Um jede einzelne TCP-Verbindung besser ausnutzen zu können, setzen wir Stream-Multiplexing zum Senden und Empfangen von Daten ein, indem wir dynamisch mehrere Streams zwischen Knoten aufbauen und die Bandbreite maximieren.

Bei Knoten verwenden wir [Kademlia](https://en.wikipedia.org/wiki/Kademlia), um ihre Gateway-Tabellen zu pflegen. Der Kademlia-Algorithmus verwendet den XOR-Wert zwischen den IDs der Knoten, um den Abstand dazwischen zu berechnen. Die Knoten werden in Form von Bereichen abgelegt, die sich nach ihren Abständen zu anderen Knoten unterscheiden. Wenn ein Knoten abgefragt wird, müssen wir nur den nächsten Knoten innerhalb des entsprechenden Bereichs finden. Mit einer bestimmten Anzahl von Abfragen können wir garantieren, dass die Informationen für den Knoten gefunden werden. Kademlia zeichnet sich durch Schnelligkeit und Vielseitigkeit aus.

### Datenübertragung

Um die Bandbreite zu reduzieren und die Datenübertragung zu beschleunigen, serialisieren wir alle strukturierten Daten mit Protocol Buffer und komprimieren sie mit dem Snappy-Algorithmus. Während unserer Tests hat diese Richtlinie die Datenmenge um über 80% reduziert.

Die Übertragung führt zu einer redundanten Datenübertragung und damit zur Verschwendung von Bandbreite und Rechenleistung. Viele Projekte verhindern die unbestimmte Übertragung von Daten, indem sie die "Hops " begrenzen (oder wie oft bestimmte Daten erneut übertragen wurden). Der Nachteil der Richtlinie ist, dass eine bestimmte Anzahl von Rebroadcasts nicht garantieren kann, dass die Daten das gesamte Netzwerk erreichen, insbesondere wenn das Netzwerk groß ist. Die Art und Weise, wie EOS mit dem Problem umgeht, ist, dass die Netzwerkebene Transaktionen und Blöcke der Nachbarn jedes einzelnen Knotens protokolliert und entscheidet, ob Daten an einen bestimmten Knoten gesendet werden sollen oder nicht. Dieses Design kann die redundante Übertragung bis zu einem gewissen Grad reduzieren, ist aber nicht sehr elegant und erhöht die Belastung des Speichers.

Die Art und Weise, wie wir damit umgehen, ist die Verwendung eines Filteralgorithmus, um doppelte Informationen zu filtern. Nach dem Vergleich von [Bloom Filter](https://en.wikipedia.org/wiki/Bloom_filter), [Cuckoo Filter](https://brilliant.org/wiki/cuckoo-filter) und vielen anderen haben wir uns für Bloom entschieden. Wir können eine doppelte Filterung von einer Million Datenpaketen erreichen, mit nur 1,7 MB Speicherplatz und 0,1% False Negative. Um die redundante Datenübertragung weiter zu reduzieren, haben wir eine spezielle Richtlinie für Blöcke und große Transaktionen festgelegt: Ihr Hash wird zuerst übertragen. Die Knoten können dann mit dem Hash fehlende Daten herunterladen.

### LAN-Penetration

Wir verwenden das [UPnP](https://en.wikipedia.org/wiki/Universal_Plug_and_Play) Protokoll, um eine LAN-Penetration zu erreichen. UPnP unterscheidet sich von anderen Richtlinien, wie z.B. [UDP Hole Punching](https://en.wikipedia.org/wiki/UDP_hole_punching) und [STUN](https://en.wikipedia.org/wiki/STUN); es erfordert keine Port Exposure ohne Veröffentlichung des Servers. Das bedeutet, dass Sie mit Ihrem Heimcomputer auf unser Netzwerk zugreifen und mit anderen Knoten kommunizieren können, ohne einen Cloud-Server verwenden zu müssen.

## Ein Easter Egg

Im P2P-Netzwerkpaket unseres Code-Repository befindet sich ein Verzeichnis `/example`. Wir haben mit unserem Netzwerkpaket eine Instant Messaging-App erstellt. Navigieren Sie zum Verzeichnis und führen Sie `go build` aus, um die Binärdatei `./example` zu kompilieren. Jetzt kannst du mit anderen im Netzwerk chatten. Viel Spaß dabei!
