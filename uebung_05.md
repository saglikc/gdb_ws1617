# Tutorium - Grundlagen Datenbanken - Blatt 5

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `Tutorium_Book.sql` benötigt, die sich in dem Verzeichnis `sql` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels `start <Dateipfad> ` in Datenbank importieren
* Beispiele
  * Linux: `start ~/Tutorium_Book.sql`
  * Windows: `start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql`

## Referenzen
* SQL-Funktionen - [datenbank-sql.de](http://www.datenbank-sql.de/sql_funktionen.htm)
* NLS-Einstellungen, interessant füt Mac und Linux Benutzer - [datenbank-sql.de](http://www.datenbank-sql.de/nls.htm)
* Reguläre Ausdrücke - [techonthenet.com](http://www.datenbank-sql.de/nls.htm)

## Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

## Data-Dictionary-Views
![Data-Dictionary-Views](./img/Constraint_Schema.png)

## Aufgaben

### Aufgabe 1
Ermittle alle Constraints der Tabelle `lib_rental`. Beantworte dabei mithilfe von SQL-Statements folgende Fragen:
* Wie heißt der Primary Key Constraint der Tabelle und für welche Spalte wurde er angelegt?
* Für welche Spalte der Tabelle `lib_rental` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?
* Welche Check Constraints wurden für die Tabelle `lib_rental` anglegt und was wird durch diese sichergestellt?
* Wurde für die Tabelle ein Unique Key Constraint angelegt?
* Hinweis: Alle Angaben können in den Data-Dictionary-Views `USER_CONSTRAINTS` und `USER_CONS_COLUMNS` gefunden werden.

### Aufgabe 1.1
Wie heißt der Primary Key Constraint der Tabelle und für welche Spalte wurde er angelegt?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 1.2
Für welche Spalte der Tabelle `lib_rental` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 1.3
Welche Check Constraints wurden für die Tabelle `lib_rental` anglegt und was wird durch diese sichergestellt?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 2
Ermittle mithilfe eines SQL-Statements, aus welchen Spalten sich der Primary-Key der Tabelle `lib_contains` zusammensetzt. Warum bezieht sich der Primary-Key hier nicht nur auf eine Spalte?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 3
Wie viele Constraints existieren im Datenbankschema?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 4
Für die Tabelle `lib_publisher` wurden keine Constraints angelegt. Ergänze die Tabelle um passende Primary-Key- und Foreign-Key-Constraints.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 5
Stelle mithilfe eines Constraints sicher, dass in einem Buchtitel in der Tabelle `lib_book` das Zeichen `?` nicht vorhanden ist.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 6
Welcher Constraint verhindert, dass in die Tabelle `lib_category` eine weitere Kategorie eingefügt werden kann? Entferne den Constraint.

#### Lösung
```sql
Deine Lösung
```

### Referenzen
* SQL-Funktionen - [datenbank-sql.de](http://www.datenbank-sql.de/sql_funktionen.htm)
* NLS-Einstellungen, interessant füt Mac und Linux Benutzer - [datenbank-sql.de](http://www.datenbank-sql.de/nls.htm)
* Reguläre Ausdrücke - [techonthenet.com](http://www.datenbank-sql.de/nls.htm)



