# Tutorium - Grundlagen Datenbanken - Blatt 2

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
  * Linux: ```start ~/Tutorium_Book.sql```
  * Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Aufgabe 1
Erfasse einen Ausleihvorgang für Marina Weller (Ausleihdatum heute – noch keine Rückgabe) mit der l_id (Primärschlüssel) 17. Sie leiht sich die Bücher „Der Schwarm“ und „Limit“.

#### Lösung
```sql
INSERT INTO lib_rental(lend, return, l_id, lend_id)
VALUES (sysdate, null, 17, 7);
```

#### Alternative Lösung mittels Unterabfrage
```sql
INSERT INTO lib_rental(lend, return, l_id, lend_id)
VALUES (
  sysdate,
  null,
  17,
  (
    SELECT l.lend_id
    FROM lib_lender l
    WHERE l.forename = 'Marina'
    AND l.surname = 'Weller'
  )
);
```

### Aufgabe 2
Lösche den Kategorie-Eintrag „Kinderbuch“ in der Tabelle lib_category.

#### Lösung
```sql
DELETE FROM lib_category
WHERE cat_name LIKE 'Kinderbuch';
```

### Aufgabe 3
Welche Bücher (Titel und Erscheinungsjahr) wurden bisher noch nie ausgeliehen?

#### Lösung
```sql
SELECT b.book_id, b.title, b.year
FROM lib_book b
WHERE b.book_id NOT IN (
  SELECT DISTINCT c.book_id
  FROM lib_contains c
);
```

### Aufgabe 4
Ändere bei allen Büchern, die von "Heyne" herausgegeben wurden, den Verleger in „Fischer“ um.
> Versuche die Aufgabe mit mehr als einen Lösungsweg zu lösen!
> Tipp: Ändere *nicht* den Datensatz "Heyne" in der Tabelle lib_publisher in "Fischer" um. Dies ist falsch.

#### Lösung
```sql
SELECT pub_id FROM lib_publisher WHERE pub_name LIKE 'Fischer';
SELECT pub_id FROM lib_publisher WHERE pub_name LIKE 'Heyne';

UPDATE lib_book
SET pub_id = 1
WHERE pub_id = 9;
```

#### Alternative und schönere Lösung
```sql
UPDATE lib_book
SET pub_id = (
  SELECT pub_id
  FROM lib_publisher
  WHERE pub_name LIKE 'Fischer'
)
WHERE pub_id = (
  SELECT pub_id
  FROM lib_publisher
  WHERE pub_name LIKE 'Heyne'
);
```

### Aufgabe 5
Gebe alle Bücher aus (Titel und Erscheinungsjahr), deren Titel an sechster Stelle einen Bindestrich beinhaltet.
> Optional: Löse die Aufgabe auch mit Regulären Ausdrücken.

#### Lösung
```sql
SELECT b.title, b.year
FROM b.lib_book
WHERE b.title like '_____-%';
```

#### Lösung mit Regulärem Ausdruck (REGEXP_LIKE)
```sql
SELECT b.title, b.year
FROM b.lib_book
WHERE REGEXP_LIKE(b.title, '^.{5}-');
```

### Aufgabe 6
Welche Personen (Vorname und Nachname) haben sich bisher das Buch „Investitionsrechnung“ ausgeliehen?
> Versuche die Aufgabe mit mehr als einen Lösungsweg zu lösen!

#### Lösung - INNER JOIN
```sql
SELECT l.forename, l.surname
FROM lib_lender l
  INNER JOIN lib_rental r ON (l.lend_id = r.lend_id)
  INNER JOIN lib_contains c ON (r.l_id = c.l_id)
  INNER JOIN lib_book b ON(b.book_id = c.book_id)
WHERE b.title = 'Investitionsrechnung';
```

#### Lösung - Unterabfrage
```sql
SELECT l.forename, l.surname
FROM lib_lender l
WHERE l.lend_id IN (
  SELECT r.lend_id
  FROM lib_rental r
  WHERE r.l_id IN (
    SELECT c.l_id
    FROM lib_contains c
    WHERE c.book_id IN (
      SELECT b.book_id
      FROM lib_book b
      WHERE title = 'Investitionsrechnung'
    )
  )
);
```

### Aufgabe 7
Reduziere die Seitenzahl aller Bücher der Autoren mit dem Nachnamen „Feuerstein“ um 100.

#### Lösung
```sql
UPDATE lib_book
SET pages = pages - 100
WHERE book_id IN (
  SELECT book_id
  FROM lib_did_write
  WHERE auth_id IN(
    SELECT auth_id
    FROM lib_author
    WHERE surname LIKE 'Feuerstein'
  )
);
```
