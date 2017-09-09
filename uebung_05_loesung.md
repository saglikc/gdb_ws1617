# Tutorium - Grundlagen Datenbanken - Blatt 5

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
  * Linux: ```start ~/Tutorium_Book.sql```
  * Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

## Referenzen
* SQL-Funktionen - [datenbank-sql.de](http://www.datenbank-sql.de/sql_funktionen.htm)
* NLS-Einstellungen, interessant füt Mac und Linux Benutzer - [datenbank-sql.de](http://www.datenbank-sql.de/nls.htm)
* Reguläre Ausdrücke - [techonthenet.com](http://www.datenbank-sql.de/nls.htm)

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Data-Dictionary-Views
![Data-Dictionary-Views](./img/Constraint_Schema.png)

### Aufgabe 1
Ermittle alle Constraints der Tabelle ```lib_rental```. Beantworte dabei mithilfe von SQL-Statements folgende Fragen:
* Wie heißt der Primary Key Constraint der Tabelle und für welche Spalte wurde er angelegt?
* Für welche Spalte der Tabelle ```lib_rental``` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?
* Welche Check Constraints wurden für die Tabelle ```lib_rental``` anglegt und was wird durch diese sichergestellt?
* Wurde für die Tabelle ein Unique Key Constraint angelegt?
* Hinweis: Alle Angaben können in den Data-Dictionary-Views ```USER_CONSTRAINTS``` und ```USER_CONS_COLUMNS``` gefunden werden.

### Aufgabe 1.1
Wie heißt der Primary Key Constraint der Tabelle und für welche Spalte wurde er angelegt?

#### Lösung
```sql
-- Gibt den Namen des Primärschlüssels aus
SELECT constraint_name
FROM  ser_constraints
WHERE table_name LIKE 'LIB_RENTAL'
AND constraint_type LIKE 'P';

-- Gibt die Spalte(n) des Primärschlüssels aus
SELECT column_name, position
FROM user_cons_columns
WHERE constraint_name LIKE (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name LIKE 'LIB_RENTAL'
  AND constraint_type LIKE 'P'
);
```

### Aufgabe 1.2
Für welche Spalte der Tabelle ```lib_rental``` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?

#### Lösung
```sql
-- Gibt den Namen des Fremdschlüssels aus
SELECT constraint_name
FROM user_constraints
WHERE table_name LIKE 'LIB_RENTAL'
AND constraint_type LIKE 'R';

-- Gibt die Spalte(n) des Fremdschlüssels aus
SELECT column_name
FROM user_cons_columns
WHERE constraint_name LIKE (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name LIKE 'LIB_RENTAL'
  AND constraint_type LIKE 'R'
);

-- Gibt die Tabelle und Spalte aus, auf die der Fremdschlüssel zeigt
SELECT column_name, table_name
FROM user_cons_columns
WHERE constraint_name = (
  SELECT r_constraint_name
  FROM user_constraints
  WHERE table_name ='LIB_RENTAL'
  AND constraint_type ='R'
);
```

### Aufgabe 1.3
Welche Check Constraints wurden für die Tabelle ```lib_rental``` anglegt und was wird durch diese sichergestellt?

#### Lösung
```sql
SELECT constraint_name, search_condition
FROM user_constraints
WHERE table_name LIKE 'LIB_RENTAL'
AND constraint_type LIKE 'C';
```

### Aufgabe 1.4
Wurde für die Tabelle ein Unique Key Constraint angelegt?

#### Lösung
```sql
SELECT constraint_name
FROM user_constraints
WHERE table_name LIKE 'LIB_RENTAL'
AND constraint_type LIKE 'U';
```

### Aufgabe 2
Ermittle mithilfe eines SQL-Statements, aus welchen Spalten sich der Primary-Key der Tabelle ```lib_contains``` zusammensetzt. Warum bezieht sich der Primary-Key hier nicht nur auf eine Spalte?

#### Lösung
```sql
SELECT column_name, position
FROM user_cons_columns
WHERE constraint_name LIKE (
  SELECT constraint_name
  FROM user_constraints
  WHERE table_name LIKE 'LIB_CONTAINS'
  AND constraint_type LIKE 'P'
);
```

### Aufgabe 3
Wie viele Constraints existieren im Datenbankschema?

#### Lösung
```sql
SELECT COUNT(*)
FROM user_constraints
WHERE table_name LIKE 'LIB%';
```

#### Lösung mit escape
```sql
SELECT COUNT(*)
FROM user_constraints
WHERE table_name LIKE 'LIB\_%';
```

### Aufgabe 4
Für die Tabelle ```lib_publisher``` wurden keine Constraints angelegt. Ergänze die Tabelle um passende Primary-Key- und Foreign-Key-Constraints.

#### Lösung
```sql
-- Primärschlüssel
ALTER TABLE lib_publisher
ADD CONSTRAINT PK_LIB_PUBLISHER PRIMARY KEY (pub_id);

-- Fremdschlüssel
ALTER TABLE lib_publisher
ADD CONSTRAINT FK_LIB_PUBL_LOCATED_I_LIB_CITY FOREIGN KEY (c_id) REFERENCES lib_city(c_id);

ALTER TABLE lib_book
ADD CONSTRAINT FK_LIB_BOOK_DID_PUBLI_LIB_PUBL FOREIGN KEY(pub_id) REFERENCES lib_publisher(pub_id);
```

### Aufgabe 5
Stelle mithilfe eines Constraints sicher, dass in einem Buchtitel in der Tabelle ```lib_book``` das Zeichen ```?``` nicht vorhanden ist.

#### Lösung
```sql
ALTER TABLE lib_book
ADD CONSTRAINT c_title
CHECK(title NOT LIKE '%?%');
```

### Aufgabe 6
Welcher Constraint verhindert, dass in die Tabelle ```lib_category``` keine weitere Kategorie eingefügt werden kann? Entferne den Constraint.

#### Lösung
```sql
-- Auffinden
SELECT constraint_name, search_condition
FROM user_constraints
WHERE table_name LIKE 'LIB_CATEGORY'
AND constraint_type LIKE 'C';

-- Löschen
ALTER TABLE lib_category
DROP CONSTRAINT C_CATID;
```


### Referenzen
* SQL-Funktionen - [datenbank-sql.de](http://www.datenbank-sql.de/sql_funktionen.htm)
* NLS-Einstellungen, interessant füt Mac und Linux Benutzer - [datenbank-sql.de](http://www.datenbank-sql.de/nls.htm)
* Reguläre Ausdrücke - [techonthenet.com](http://www.datenbank-sql.de/nls.htm)



