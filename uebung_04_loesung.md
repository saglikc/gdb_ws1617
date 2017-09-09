# Tutorium - Grundlagen Datenbanken - Blatt 4

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
  * Linux: ```start ~/Tutorium_Book.sql```
  * Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Aufgabe 1
An wie vielen Tagen wurden bisher Bücher ausgeliehen?

#### Lösung
```sql
SELECT COUNT(DISTINCT TRUNC(lend)) anz_tage
FROM lib_rental;
```

### Aufgabe 2
Welche Bücher (```title```, ```year```, ```pages```) haben mehr Seiten als der Durchschnitt der Bücher der Bibliothek? Ordne die Bücher aufsteigend nach dem Titel und innerhalb des Titels absteigend nach dem Erscheinungsjahr.

#### Lösung
```sql
SELECT title, year, pages
FROM lib_book b
WHERE b.pages > (
  SELECT AVG(pages)
  FROM lib_book
)
ORDER BY title ASC, year DESC;
```

### Aufgabe 3
Erzeuge eine Ausgabe, in der jeder Autor (nur ```auth_id```) mit der Anzahl der von ihm verfassten Bücher gelistet wird. Dabei sollen nur Autoren berücksichtigt werden, deren Nachname (```surname```) länger als 9 Zeichen ist und die mehr als ein Buch verfasst haben.

#### Lösung
```sql
SELECT auth_id, COUNT(*) anzahl
FROM lib_author a
  INNER JOIN lib_did_write w ON (a.auth_id = w.auth_id)
WHERE LENGTH(a.surname) > 9
GROUP BY a.auth_id
HAVING COUNT(*) > 1;
```

### Aufgabe 4
In welcher Stadt wurde mehr als ein Buch herausgegeben. Erzeuge eine Ausgabe, die die ```c_id``` der Stadt und die Anzahl der dort herausgegebenen Bücher beinhaltet.

#### Lösung
```sql
SELECT p.c_id, COUNT(*) anzahl_buecher
FROM lib_publisher p
  INNER JOIN lib_book b ON (p.pub_id = b.pub_id)
GROUP BY p.c_id
HAVING COUNT(*) > 1;
```

### Aufgabe 5
Ermittle für jedes Jahr, in dem Bücher erschienen sind, die in diesem Jahr veröffentlichten Buchseiten und ordne die Ausgabe absteigend nach der Seitenzahl.
> Optional: Versuche Spaltennamen neu zu benennen!

#### Lösung
```sql
SELECT year Jahr, SUM(pages) Seiten
FROM lib_book
WHERE year IS NOT NULL
GROUP BY year
ORDER BY Seiten DESC;
```

### Aufgabe 6
Erstelle eine View, in der alle Kunden der Bibliothek (nur ```lend_id```) mit Datum ihres aktuellsten Ausleihvorgangs erfasst werden. Ermittle mithilfe der View alle Kunden (```forename``` und ```surname```), die länger als 2 Jahre keine Bücher mehr ausgeliehen haben. Lasse dir dabei das Datum des letzten Ausleihvorgangs im folgenden Format ausgeben: ```dd-mm-yy```.
```sql
-- Tipp: Nutze die TRUNC Funktion.
TRUNC ( date [, format ] )
TRUNC(SYSDATE)                        -- Ergebnis: 29-SEP-03
TRUNC(TO_DATE('22-AUG-03'), 'YEAR')   -- Ergebnis: 01-JAN-03
TRUNC(TO_DATE('22-AUG-03'), 'Q')      -- Ergebnis: 01-JUL-03
TRUNC(TO_DATE('22-AUG-03'), 'MONTH')  -- Ergebnis: 01-AUG-03
TRUNC(TO_DATE('22-AUG-03'), 'DDD')    -- Ergebnis: 22-AUG-03
TRUNC(TO_DATE('22-AUG-03'), 'DAY')    -- Ergebnis: 17-AUG-03
```
[Referenz](https://www.techonthenet.com/oracle/functions/trunc_date.php)

#### Lösung
```sql
CREATE OR REPLACE VIEW last_rental AS
  SELECT lend_id, max(lend) max_lend
  FROM lib_rental
  GROUP BY lend_id;

SELECT l.forename, l.surname, TO_CHAR(r.max_lend, 'dd-mm-yy') Datum
FROM lib_lender l
  INNER JOIN last_rental r ON (l.lend_id = r.lend_id)
WHERE TRUNC(SYSDATE) > TRUNC(max_lend) + 365*2;
```

#### Alternative Lösung: Sauberer
```sql
SELECT l.forename, l.surname, TO_CHAR(r.max_lend, 'dd-mm-yy') Datum
FROM lib_lender l
  INNER JOIN last_rental r ON (l.lend_id = r.lend_id)
WHERE TRUNC(SYSDATE) > TRUNC(max_lend) + INTERVAL '2' YEAR;
```
