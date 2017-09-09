# Tutorium - Grundlagen Datenbanken - Blatt 6

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
  * Linux: ```start ~/Tutorium_Book.sql```
  * Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Data-Dictionary-Views
![Data-Dictionary-Views](./img/Constraint_Schema.png)

### Aufgabe 1
Welche Bücher (`title`, `year`) wurden von Verlegern herausgegeben, die mit `O` beginnen?

#### Lösung
```sql
SELECT title, year
FROM lib_book
WHERE pub_id IN   (
  SELECT pub_id
  FROM lib_publisher
  WHERE pub_name LIKE 'O%'
);
```

#### Alternative Lösung
```sql
SELECT b.title, b.year
FROM lib_book b
  INNER JOIN lib_publisher p ON (b.pub_id = p.pub_id)
WHERE pub_name LIKE 'O%';
```

### Aufgabe 2
Welche Autoren (`forename`, `surname`) haben Bücher verfasst, die im Jahr `2009` veröffentlicht und von `Heyne` herausgegeben wurden?

#### Lösung
```sql
SELECT forename, surname
FROM lib_author
WHERE auth_id IN (
  SELECT auth_id
  FROM lib_did_write
  WHERE book_id IN (
    SELECT book_id
    FROM lib_book
    WHERE year = 2009
    AND pub_id = (
      SELECT pub_id
      FROM lib_publisher
      WHERE pub_name = 'Heyne'
    )
  )
);
```

#### Alternative Lösung
```sql
SELECT a.forename, a.surname
FROM lib_author a
  INNER JOIN lib_did_write w ON (a.auth_id = w.auth_id)
  INNER JOIN lib_book b ON (w.book_id = b.book_id)
  INNER JOIN lib_publisher p ON (b.pub_id = p.pub_id)
WHERE p.pub_name = 'Heyne'
AND b.year = 2009;
```

### Aufgabe 3
Welcher Verleger (`pub_name`) hat keine Bücher veröffentlicht?

#### Lösung
```sql
SELECT pub_name
FROM lib_publisher
WHERE pub_id NOT IN (
  SELECT DISTINCT pub_id
  FROM lib_book
);
```

### Aufgabe 4
Lege einen neuen Autor `Max Moeller` an. Wähle dabei eine Autor-ID, die bisher nicht vergeben wurde.
Trage ihn als zusätzlichen Autor für das Buch `Java 5` ein.

#### Lösung
```sql
-- Anlegen eines neuen Autors
INSERT INTO lib_author (forename, surname, auth_id)
VALUES('Max','Moeller',20);

-- Eintrag als Autor für das Buch Java 5
INSERT INTO lib_did_write(auth_id, book_id)
VALUES (20,(SELECT book_id FROM lib_book WHERE title = 'Java 5'));
```

### Aufgabe 5
Lösche alle Städte (Einträge in der Tabelle lib_city), in denen kein Herausgeber ansässig ist.

#### Lösung
```sql
DELETE FROM lib_city
WHERE c_id NOT IN (
  SELECT DISTINCT c_id
  FROM lib_publisher
);
```

### Aufgabe 6
Ändere den Vornamen des Autors, der Limit verfasst hat, in „Peter“ um.

#### Lösung
```sql
UPDATE lib_author
SET forename = 'Peter'
WHERE auth_id IN (
  SELECT auth_id
  FROM lib_did_write
  WHERE book_id IN (
    SELECT book_id
    FROM lib_book
    WHERE title = 'Limit'
  )
);
```

### Aufgabe 7
Lege eine neue Tabelle lib_game für Videospiele an. Diese soll folgende Spalten haben:
* `g_id`: 4stellige ID
* `g_name`: bis zu 30 Zeichen langer Name
* `g_date`: Datum der Erstveröffentlichung
* `price`: Preisangabe (4 Stellen vor und 2 Stellen nach dem Komma)
ID, Name und Erscheinungsdatum sollen für jedes Spiel Pflichtangaben sein, während der Preis nicht unbedingt angegeben werden muss.

#### Lösung
```sql
CREATE TABLE lib_game (
  g_id NUMBER(4) NOT NULL,
  g_name VARCHAR2(30) NOT NULL,
  g_date DATE NOT NULL,
  price NUMBER(6,2)
);

```

### Aufgabe 8
Füge eine Spalte `usk` hinzu, in der die Altersbeschränkung (2-stellige Zahl) eingetragen werden soll.

#### Lösung
```sql
ALTER TABLE lib_game
ADD (
  usk NUMBER(2)
);
```

### Aufgabe 9
Ermittle, warum du SELECT-Rechte auf die Tabelle `CREDIT` des Nutzers `Richard` im Schema `Richard` hast. Beantworte dazu schrittweise folgende Fragen:
* Wurden die Tabellen-Rechte direkt an dich bzw. an `PUBLIC` vergeben?
* Welche Rollen besitzt du direkt?
* Welche Rollen sind diesen Rollen zugeordnet?
Haben Student oder BAstudent weitere Rollen?
Alle Rollen, die dem User direkt/indirekt in dieser Session zugeordnet sind

### Aufgabe 9.1
Wurden die Tabellen-Rechte direkt an dich bzw. an `PUBLIC` vergeben?

#### Lösung
```sql
SELECT table_name, privilege, grantee
FROM all_tab_privs
WHERE table_name = 'CREDIT'
AND table_schema = 'RICHARD'
AND grantee IN ('PESCHM', 'PUBLIC');
```

### Aufgabe 9.2
Welche Rollen besitzt du direkt?

#### Lösung
```sql
SELECT granted_role, default_role
FROM user_role_privs;
```

### Aufgabe 9.3
Welche Rollen sind diesen Rollen zugeordnet?

#### Lösung
```sql
SELECT role, granted_role
FROM role_role_privs
WHERE role IN ('BW_STUDENT', 'FH_TRIER');
```

### Aufgabe 9.4
Haben Student oder BAstudent weitere Rollen?

#### Lösung
```sql
SELECT role, granted_role
FROM role_role_privs
WHERE role IN ('STUDENT', 'BASTUDENT');
```

### Aufgabe 9.5
Alle Rollen, die dem User direkt/indirekt in dieser Session zugeordnet sind

#### Lösung
```sql
SELECT  *
FROM session_roles;
```

### Aufgabe 9.6
Haben die dir direkt bzw. indirekt (über Zuordnung von Rollen zu Rollen) zugewiesenen Rollen Rechte an der Tabelle `CREDIT`?

#### Lösung
```sql
SELECT role, privilege
FROM role_tab_privs
WHERE role in ('BW_STUDENT','STUDENT','BASTUDENT','FH_TRIER')
AND owner = 'RICHARD'
AND table_name = 'CREDIT';
```

### Aufgabe 10
Wie viele Seiten hat jeder Verleger (`pub_id`, `pub_name`) insgesamt veröffentlicht?
(Beachte, dass bei einer Gruppierung nur Spalten in der `SELECT`-Liste angegeben werden dürfen, nach denen im `GROUP BY` gruppiert wird)

#### Lösung
```sql
SELECT p.pub_id, p.pub_name, SUM(pages)
FROM lib_book b
  INNER JOIN lib_publisher p ON (b.pub_id = p.pub_id)
GROUP BY p.pub_id, p.pub_name;
```

### Aufgabe 11
Erhöhe bei allen Büchern, deren Erscheinungsjahr mehr als 10 Jahre zurückliegt, die Edition um 1.

#### Lösung
```sql
UPDATE lib_book
SET edition = edition + 1
WHERE TO_CHAR(SYSDATE, 'yyyy') -10 > year;
```

### Aufgabe 12
Welche Kunden (`forename`, `surname`) sind mindestens 25 Jahre alt und haben im Februar Geburtstag?

#### Lösung
```sql
SELECT forename, surname
FROM lib_lender
WHERE TO_CHAR(birthdate,'mm') = '02'
AND birthdate + INTERVAL '25' YEAR <= TRUNC(SYSDATE);
```

#### Alternative Lösung
```sql
SELECT forename, surname
FROM lib_lender
WHERE TO_CHAR(birthdate,'mm') = '02'
AND ADD_MONTHS(birthdate, 12*25) <= TRUNC(SYSDATE);
```

### Aufgabe 13
Ermittle, wie viele Kunden in den einzelnen Monaten Geburtstag haben.

#### Lösung
```sql
SELECT TO_CHAR(birthdate, 'mm') mon, COUNT(lend_id) anz
FROM lib_lender
GROUP BY  TO_CHAR(birthdate, 'mm');
```

### Aufgabe 14
In welcher Kategorie wurden wie viele Bücher nicht zurückgegeben (Kategorie-ID und Anzahl der bisher nicht zurückgegebenen Bücher je Kategorie)? Sortiere die Ausgabe absteigend nach der Anzahl nicht zurückgegebener Bücher.

#### Lösung
```sql
SELECT b.cat_id, COUNT(*) anz
FROM lib_book b
  INNER JOIN lib_contains c ON (b.book_id = c.book_id)
  INNER JOIN lib_rental r ON (c.l_id = r.l_id)
WHERE r.return IS NULL
GROUP BY b.cat_id
ORDER BY anz DESC;
```

### Aufgabe 15
Lege für die Tabelle `lib_contains` alle Primary- und Foreign-Key-Constraints an.

#### Lösung
```sql
ALTER TABLE lib_contains
ADD CONSTRAINT pk_lib_contains PRIMARY KEY (book_id, l_id);

ALTER TABLE lib_contains
ADD CONSTRAINT fk_contains_book FOREIGN KEY (book_id) REFERENCES lib_book (book_id);

ALTER TABLE lib_contains
ADD CONSTRAINT fk_contains_rental FOREIGN KEY (l_id) REFERENCES lib_rental (l_id);
```

### Aufgabe 16
Stelle sicher, dass in der Tabelle `lib_rental` das Rückgabedatum (return) eines Ausleihvorgangs entweder `NULL` oder größer/gleich dem Ausleihdatum (`lend`) ist.

#### Lösung
```sql
ALTER TABLE lib_rental
ADD CONSTRAINT c_lendrerturn
CHECK ((return-lend >= 0) OR (return IS NULL));
```

### Aufgabe 17
Überprüfe, wie die Informationen für die angelegten Constraints aus den Aufgaben im Data Dictionary dargestellt werden.
Überprüfe dabei schrittweise mithilfe von SQL-Statements folgendes:
* Wie heißt der Primary Key Constraint der Tabelle `lib_contains` und für welche Spalten wurde er angelegt?
* Für welche Spalten der Tabelle `lib_contains` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?
* Welche Check Constraints wurden für die Tabelle `lib_rental` anglegt und was wird durch diese sichergestellt?


### Aufgabe 17.1
Wie heißt der Primary Key Constraint der Tabelle `lib_contains` und für welche Spalten wurde er angelegt?

#### Lösung
```sql
SELECT constraint_name, column_name, position
FROM user_cons_columns
WHERE constraint_name = (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name LIKE 'LIB_CONTAINS'
  AND constraint_type LIKE 'P'
);

```

### Aufgabe 17.2
Für welche Spalten der Tabelle `lib_contains` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?

#### Lösung
```sql
SELECT constraint_name, column_name, table_name
FROM user_cons_columns
WHERE constraint_name IN (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name LIKE 'LIB_CONTAINS'
  AND constraint_type = 'R'
);

SELECT constraint_name, column_name, table_name
FROM user_cons_columns
WHERE constraint_name IN (
  SELECT r_constraint_name
  FROM user_constraints
  WHERE table_name LIKE 'LIB_CONTAINS'
  AND constraint_type = 'R'
);

```

### Aufgabe 17.3
Welche Check Constraints wurden für die Tabelle `lib_rental` anglegt und was wird durch diese sichergestellt?

#### Lösung
```sql
SELECT constraint_name, search_condition
FROM user_constraints
WHERE table_name LIKE 'LIB_RENTAL'
AND constraint_type LIKE 'C';

```

