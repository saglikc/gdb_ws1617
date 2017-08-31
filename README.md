# Grundlagen Datenbanken
Dieses git repository beinhaltet alle Aufgaben des Tutoriums Grundlagen Datenbanken der Hochschule Trier für den Studiengang Wirtschaftsinformatik nach der PO2016.
Die einzelnen Aufgabenblätter sind als git branch hinterlegt und müssen ausgecheckt werden. Es ist zu empfehlen git auf dem eigenen Rechner zu installieren.


## Installation
### Debin/Ubuntu/Linux Mint
Das Programm git kann über die offiziellen Paketquellen bezogen werden. Dazu reicht der folgende Terminalbefehl.
```bash
sudo apt-get update && \
sudo apt-get dist-upgrade && \
sudo apt-get install git
```

### MacOS
Für MacOS steht ein offizieller [Download](https://git-scm.com/download/mac) auf [git-scm.com](https://git-scm.com) bereit.

### Windows
Für Windows können die Binärdateien wie bei MacOS von der offiziellen Website [https://git-scm.com/download/win heruntergeladen] werden.

## Repository clonen
Um das Repository zu klonen finden Sie auf der Projektseite einen HTTPS und SSH Link. Den Download des Projekts mit SSH können Sie insofern durchführen, wenn Sie einen SSH-Key in Ihren Profileinstellunges des Github-Accounts hinterlegt haben. Durch den SSH-Key werden Sie beim Authentifizieren gegenüber der Seite github.com nicht nach ihrem Benutzernamen und ihrem Passwort gefragt.

Startet Sie die neu installierte git-bash und navigieren Sie in ein beliebiges Verzeichnis mittels ```cd``` um dort das repository herunter zu laden. Der Vorgang das git Repository zu klonen kann mittels ```git clone git@github.com:volker-raschek/grundlagen_datenbanken.git``` für SSH oder mittels ```git clone https://github.com/volker-raschek/grundlagen_datenbanken.git``` für HTTPS gestartet werden. Sie sollten nun ein Verzeichnis haben, dass ```grundlagen_datenbanken``` heißt und dem online repository entspricht. Sie können nun die Datei [./uebung.md uebung.md] öffnen um die Aufgaben zu bearbeiten.

## Wechseln in einen anderen branch
Alle Aufgabenblätter sind in einem eigenen git branch hinterlegt und müssen ausgechekt werden. So können Sie mit dem Befehl ```git branch -a``` sich alle Branches anzeigen lassen und mit ```git checkout -b <name des branches>``` einen Branch zum ersten mal auschecken. Das erneute wechseln zwischen Brachnes erfolgt ohne die Option ```-b``` mit ```git checkout <name des branches>```

## Warum als git repository?
Dies dient als gute Grundlage den Studenten git als auch die Auszeichnissprache Markdown näher zu bringen. Das Programm git kann als Revisionssystem übergreifend auch für andere Fächer wie beispielsweise Programmierung dienen und ermöglicht die Zusammenarbeit mit anderen Kommilitoten und Entwicklern.
Es ist zu empfehlen einen eigenen Account auf [github.com] zu erstellen, dieses Projekt zu forken und seine eigenen Lösungen online zu stellen. Der Github-Account kann in späteren Bewerbungunterlagen als online Referenz angegeben werden um Unternehmen direkt vermitteln zu können, welche Kentnisse vorhanden sind.

## Einige Programmiersprachen oder Scriptsprachen die sich mit git visionieren lassen während des Studiums
* java
* Latex (.tex)
* SQL-Dump (.sql)
* R (.r)
* HTML (.html)
* PHP (.php)





