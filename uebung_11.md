# Tutorium - Grundlagen Datenbanken - Blatt 11

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `Tutorium_Book.sql` benötigt, die sich in dem Verzeichnis `sql` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels `start <Dateipfad> ` in Datenbank importieren
* Beispiele
  * Linux: `start ~/Tutorium_Book.sql`
  * Windows: `start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql`

## Aufgaben

### Aufgabe 1
Gegeben ist der folgende Ausschnitt aus einer Log-Datei. Vor dem Zeitpunkt 0 sind keine Transaktionen aktiv und unmittelbar vor t0 wurde ein Backup gemacht.

BI (bzw. AI) steht für Before (bzw. After) Image. BOTx steht für Begin of Transaction  mit Nummer x; UPDx für ein Update, DELx für ein DELETE , INSx steht für ein INSERT der Transaktion x und CHK bezeichnet einen Checkpoint. Die Zahl vor den Doppelpunkten (in den Zeilen BI und AI)  gibt den Wert des Primary Keys an.

| Zeitpunkt | 0     | 1           | 2     | 3     | 4                                   | 5     |
| --------- | ----- | ----------- | ----- | ----- | ----------------------------------- | ----- |
| Aktion    | BOT02 | UPD2: EMP   | BOT01 | BOT05 | INS1:DEPT                           | BOT04 |
| BI        |       | 1:comm=100  |       |       |                                     |       |
| AI        |       | 1:comm=NULL |       |       | 60:deptno=60,dname='sales',loc='NY' |       |
