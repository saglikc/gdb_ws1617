# Tutorium Grundlagen Datenbanken WS1617
Dieses git repository beinhaltet alle Aufgaben des Tutoriums Grundlagen Datenbanken der Hochschule Trier für den Studiengang Wirtschaftsinformatik nach der PO2016.
Die einzelnen Aufgabenblätter sind in dem git repository hinterlegt und steht den Studenten zur Verfügung. Anstatt die Aufgaben alle herunterzuladen ist es ratsam git auf den Heimrechner zu installieren, sich einen github Account anzulegen und das repository zu forken um Lösungen oder Verbesserungen der Aufgabenstellung an den Master-Branch weiterzuleiten.

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
Für Windows können die Binärdateien wie bei MacOS von der offiziellen Website [heruntergeladen](https://git-scm.com/download/win) werden.

## Repository klonen
Um das Repository zu klonen finden Sie auf der Projektseite einen HTTPS und SSH Link. Den Download des Projekts mit SSH können Sie insofern durchführen, wenn Sie einen Github-Account haben und einen SSH-Key in Ihren Profileinstellunges ihres Accounts hinterlegt haben. Durch den SSH-Key werden Sie beim Authentifizieren gegenüber der Seite [github.com](github.com) nicht nach ihrem Benutzernamen und ihrem Passwort gefragt.

Startet Sie die neu installierte git-bash unter Windows und navigieren Sie in ein beliebiges Verzeichnis mittels ```cd``` um dort das Repository herunter zu laden. Für Linux und Mac nutzer findet eine automatische Integration von git in das Bash-Terminal statt. Der Vorgang das git Repository zu klonen kann mittels ```git clone git@github.com:fh-trier/gdb_ws1617.git``` für SSH oder mittels ```git clone https://github.com/fh-trier/gdb_ws1617.git``` für HTTPS gestartet werden. Sie sollten nun ein Verzeichnis haben, dass ```gdb_ws1617``` heißt und dem Online-Repository entspricht. Sie können nun die Datei [uebung_01.md](./uebung_01.md) öffnen um die Aufgaben zu bearbeiten.

## Weitere git Befehle
Wenn Sie nicht schon die gängigen git Befehle beherrschen lernen Sie diese im wöchentlichen Tutorium. Die offizielle Dokumentation zu git finden Sie auf [git-scm.com](https://git-scm.com/docs). Es ist zu empfehlen sich folgende Grundbefehle für das Arbeiten mit git anzueignen.
* [git status](https://git-scm.com/docs/git-status)
* [git commit](https://git-scm.com/docs/git-commit)
* [git branch](https://git-scm.com/docs/git-branch)
* [git checkout](https://git-scm.com/docs/git-checkout)
* [git log](https://git-scm.com/docs/git-log)
* [git fetch](https://git-scm.com/docs/git-fetch)
* [git push](https://git-scm.com/docs/git-push)
* [git rebase](https://git-scm.com/docs/git-rebase)
* [git merge](https://git-scm.com/docs/git-merge)

Falls Sie die englische online Dokumentation stört und Sie nicht damit zurecht kommen, empfehle ich Ihnen das Buch Git von Valentin Haenel und Julius Plenz - ISBN 978-3-95539-119-5.

## Warum als git repository?
Dies dient als gute Grundlage den Studenten git als auch die Auszeichnugssprache [Markdown](https://guides.github.com/features/mastering-markdown/) näher zu bringen. Das Programm git kann als Revisionssystem übergreifend auch für andere Fächer wie beispielsweise Programmierung dienen und ermöglicht die Zusammenarbeit mit anderen Kommilitoten und Entwicklern weltweit.
Es ist zu empfehlen einen eigenen Account auf [github.com](https://github.com) zu erstellen, dieses Projekt zu forken und seine eigenen Lösungen online zu stellen. Der Github-Account kann in späteren Bewerbungunterlagen als online Referenz angegeben werden um Unternehmen direkt vermitteln zu können, welche Kentnisse vorhanden sind. Dies sollte Sie von anderen Mitbewerbern hervorheben.

## Möglichkeiten
Während des Studiums werden Sie folgende Programmier- und Scriptspachen kennen lernen, die sich mit git versionieren lassen.
* java (.java) - Java 1 und 2. Java Design Pattern
* Latex (.tex) - Interessant für Seminar-, Bachelor- und Masterarbeiten
* SQL-Dump (.sql) - Grundlagen Datenbanken, Datenbanken, Seminar Datenbanken
* R (.r) - Data Mining
* HTML (.html) - Clientseitige Internettechnologien
* PHP (.php) - Serverseitige Internettechnologien
* Bash (.sh) - Linux 1 und 2
* Perl (.pl) - Linux 1 und 2
* Ruby (.rb) - Linux 1 und 2

Neben diesen Programmiersprachen ist git in der Entwicklungsumgebung [IDE Intellij](https://www.jetbrains.com/idea/) integriert. Studenten erhalten über Nachweis ihres Studentenausweises eine Ultimate Version.
