# Tutorium - Grundlagen Datenbanken - Blatt 1

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt
* Die SQL-Dump Datei in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank 	importieren
* Beispiele
  * Linux: ```start ~/Tutorium_Book.sql```
  * Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```


### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Aufgabe 1
Welche Bücher (mit Titel und Erscheinungsjahr) wurden vom Heyne-Verlag herausgegeben?
> Versuche mehr als einen Lösungsweg an zu wenden!

#### Lösung per INNER JOIN
```sql
SELECT b.title, b. year
FROM lib_book b
  INNER JOIN lib_publisher p ON (b.pub_id = p.pub_id)
WHERE pub_name LIKE 'Heyne';
```

#### Lösung per Unterabfrage
```sql
SELECT title, year
FROM lib_book
WHERE pub_id = (
 SELECT pub_id
 FROM lib_publisher
 WHERE pub_name LIKE 'Heyne'
);
```

### Aufgabe 2
Welche Bücher (mit Titel und Erscheinungsjahr) wurden nicht von Verlegern aus Koeln herausgegeben?
> Versuche mehr als einen Lösungsweg an zu wenden!

#### Lösung per INNER JOIN
```sql
SELECT b.title, b.year
FROM lib_book b
 INNER JOIN lib_publisher p ON (b.pub_id = p.pub_id)
 INNER JOIN lib_city c 	ON (p.c_id = c.c_id)
WHERE c.name NOT LIKE 'Koeln';
```

#### Lösung per Unterabfrage
```sql
SELECT title, year
FROM lib_book
WHERE pub_id IN (
 SELECT pub_id
 FROM lib_publisher
 WHERE c_id IN (
  SELECT c_id
  FROM lib_city
  WHERE name NOT LIKE 'Koeln'
 )
);
```

### Aufgabe 3
Zu welchen Kategorien sind keine Bücher vorhanden?

#### Lösung per Unterabfrage (Subquery)
```sql
SELECT cat_name
FROM lib_category
WHERE cat_id NOT IN (
 SELECT cat_id
 FROM lib_book
 WHERE book_id IS NOT NULL
);
```

#### Lösung per INNER JOIN
```sql
SELECT c.cat_name
FROM lib_category c
  LEFT JOIN lib_book b ON (c.cat_id = b.cat_id)
WHERE b.book_id IS NULL;
```

### Aufgabe 4
Ermittle alle Jahre, in denen Bücher erschienen sind.

#### Lösung
```sql
SELECT DISTINCT b.year
FROM lib_book b
ORDER BY b.year ASC;
```

### Aufgabe 5
Welche Bücher (Titel  und Erscheinungsjahr) wurden vom „Fischer“-Verlag herausgegeben oder gehören zur Kategorie „Fachbuch“?
> Versuche mehr als einen Lösungsweg an zu wenden!

#### Lösung per INNER JOIN
```sql
SELECT b.title, b.year
FROM lib_book b
  INNER JOIN lib_publisher p ON (b.pub_id = p.pub_id)
  INNER JOIN lib_category c ON (c.cat_id=b.cat_id)
WHERE p.pub_name LIKE 'Fischer'
OR c.cat_name LIKE 'Fachbuch';
```

#### Lösung per Unterabfrage (Subquery)
```sql
SELECT title, year
FROM lib_book b
WHERE b.pub_id IN (
 SELECT pub_id
 FROM lib_publisher
 WHERE pub_name LIKE 'Fischer'
)
OR b.cat_id IN (
 SELECT cat_id
 FROM lib_category
 WHERE cat_name LIKE 'Fachbuch'
);
```

### Aufgabe 6
Welche Bücher (mit Titel und Erscheinungsjahr) wurden von einem Autor verfasst, dessen Nachname mit „F“ beginnt und mit „ein“ endet?  Achtung, es soll kein Buch mehrfach aufgelistet werden!

#### Lösung INNER JOIN
```sql
SELECT b.title, b.year
FROM lib_book b
  INNER JOIN lib_did_write w ON(b.book_id = w.book_id)
  INNER JOIN lib_author a ON (w.auth_id = a.auth_id)
WHERE a.surname LIKE 'F%ein';
```

#### Lösung per Unterabfrage (Subquery)
```sql
SELECT b.title, b.year
FROM lib_book b
WHERE b.book_id IN (
  SELECT book_id
  FROM lib_did_write
  WHERE auth_id IN (
    SELECT a.auth_id
    FROM lib_author a
    WHERE a.surname LIKE 'F%ein'
  )
);
```
