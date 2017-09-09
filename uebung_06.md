# Tutorium - Grundlagen Datenbanken - Blatt 6

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `Tutorium_Book.sql` benötigt, die sich in dem Verzeichnis `sql` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels `start <Dateipfad> ` in Datenbank importieren
* Beispiele
  * Linux: `start ~/Tutorium_Book.sql`
  * Windows: `start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql`

## Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

## Data-Dictionary-Views
![Data-Dictionary-Views](./img/Constraint_Schema.png)

## Aufgaben

### Aufgabe 1
Welche Bücher (`title`, `year`) wurden von Verlegern herausgegeben, die mit `O` beginnen?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 2
Welche Autoren (`forename`, `surname`) haben Bücher verfasst, die im Jahr `2009` veröffentlicht und von `Heyne` herausgegeben wurden?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 3
Welcher Verleger (`pub_name`) hat keine Bücher veröffentlicht?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 4
Lege einen neuen Autor `Max Moeller` an. Wähle dabei eine Autor-ID, die bisher nicht vergeben wurde.
Trage ihn als zusätzlichen Autor für das Buch `Java 5` ein.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 5
Lösche alle Städte (Einträge in der Tabelle `lib_city`), in denen kein Herausgeber ansässig ist.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 6
Ändere den Vornamen des Autors, der `Limit` verfasst hat, in `Peter` um.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 7
Lege eine neue Tabelle `lib_game` für Videospiele an. Diese soll folgende Spalten haben:
* `g_id`: 4stellige ID
* `g_name`: bis zu 30 Zeichen langer Name
* `g_date`: Datum der Erstveröffentlichung
* `price`: Preisangabe (4 Stellen vor und 2 Stellen nach dem Komma)
ID, Name und Erscheinungsdatum sollen für jedes Spiel Pflichtangaben sein, während der Preis nicht unbedingt angegeben werden muss.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 8
Füge eine Spalte `usk` hinzu, in der die Altersbeschränkung (2-stellige Zahl) eingetragen werden soll.

#### Lösung
```sql
Deine Lösung
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
Deine Lösung
```

### Aufgabe 9.2
Welche Rollen besitzt du direkt?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 9.3
Welche Rollen sind diesen Rollen zugeordnet?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 9.4
Haben Student oder BAstudent weitere Rollen?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 9.5
Alle Rollen, die dem User direkt/indirekt in dieser Session zugeordnet sind

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 9.6
Haben die dir direkt bzw. indirekt (über Zuordnung von Rollen zu Rollen) zugewiesenen Rollen Rechte an der Tabelle `CREDIT`?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 10
Wie viele Seiten hat jeder Verleger (`pub_id`, `pub_name`) insgesamt veröffentlicht?
(Beachte, dass bei einer Gruppierung nur Spalten in der `SELECT`-Liste angegeben werden dürfen, nach denen im `GROUP BY` gruppiert wird)

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 11
Erhöhe bei allen Büchern, deren Erscheinungsjahr mehr als 10 Jahre zurückliegt, die Edition um 1.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 12
Welche Kunden (`forename`, `surname`) sind mindestens 25 Jahre alt und haben im Februar Geburtstag?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 13
Ermittle, wie viele Kunden in den einzelnen Monaten Geburtstag haben.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 14
In welcher Kategorie wurden wie viele Bücher nicht zurückgegeben (Kategorie-ID und Anzahl der bisher nicht zurückgegebenen Bücher je Kategorie)? Sortiere die Ausgabe absteigend nach der Anzahl nicht zurückgegebener Bücher.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 15
Lege für die Tabelle `lib_contains` alle Primary- und Foreign-Key-Constraints an.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 16
Stelle sicher, dass in der Tabelle `lib_rental` das Rückgabedatum (return) eines Ausleihvorgangs entweder `NULL` oder größer/gleich dem Ausleihdatum (`lend`) ist.

#### Lösung
```sql
Deine Lösung
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
Deine Lösung
```

### Aufgabe 17.2
Für welche Spalten der Tabelle `lib_contains` wurde ein Foreign Key angelegt und welche Spalte in welcher Tabelle  wird referenziert?

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 17.3
Welche Check Constraints wurden für die Tabelle `lib_rental` anglegt und was wird durch diese sichergestellt?

#### Lösung
```sql
Deine Lösung
```

