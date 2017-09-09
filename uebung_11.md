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
| Aktion    | BOT02 | UPD2:EMP    | BOT01 | BOT05 | INS1:DEPT                           | BOT04 |
| BI        |       | 1:comm=100  |       |       |                                     |       |
| AI        |       | 1:comm=NULL |       |       | 60:deptno=60,dname='sales',loc='NY' |       |

| Zeitpunkt | 6         | 7           | 8       | 9           | 10    | 11      | 12      |
| --------- | ----------| ----------- | -----   | ----------- | ----- | ------- | ------- |
| Aktion    | UPD4: EMP | UPD5:EMP    | COMMIT2 | CHK         | BOT3  | COMMIT1 | COMMIT4 |
| BI        | 5:mgr=8   | 3:sal=140   |         | T1, T4, T5  |       |         |         |
| AI        | 5:mgr=9   | 3:sal=1600  |         |             |       |         |         |

| Zeitpunkt | 13                          | 14    | 15              | 16          | 17                        |
| --------- | ----------------------------| ----- | --------------- | ----------- | ------------------------- |
| Aktion    | INS3:EMP                    | BOT6  | UPD3:DEPT       | UPD5:EMP    | INS6:EMP                  |
| BI        |                             |       | 20:loc='boston' | 10:sal=1900 | 12:empno=11, .., deptno20 |
| AI        | 11:empno=10, .., deptno=30  |       | 20:loc='dallas' | 10:sal=2200 |                           |

* Beschreibe was passiert, wenn zum Zeitpunkt 18 ein abnormales Ende der Transaktion 5 auftritt.
* Beschreibe was passiert, wenn zum Zeitpunkt 18 ein SYSTEM CRASH auftritt.
* Beschreibe was passiert, wenn zum Zeitpunkt 18 ein Media Failure auftritt?
