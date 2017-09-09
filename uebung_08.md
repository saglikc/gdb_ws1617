# Tutorium - Grundlagen Datenbanken - Blatt 8

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `Tutorium_Book.sql` benötigt, die sich in dem Verzeichnis `sql` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels `start <Dateipfad> ` in Datenbank importieren
* Beispiele
  * Linux: `start ~/Tutorium_Book.sql`
  * Windows: `start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql`

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Aufgabe 1
Was bewirkt die folgende Prozedur?

```sql
CREATE OR REPLACE PROCEDURE get_cat_name(in_book_id IN NUMBER, out_cat_name OUT VARCHAR2)
AS
  v_cat_name lib_category.cat_name%TYPE;
BEGIN
  SELECT cat_name INTO v_cat_name
  FROM lib_book b
    INNER JOIN lib_category c ON (b.cat_id = c.cat_id)
  WHERE book_id = in_book_id;

  out_cat_name := v_cat_name;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20009,'Buch nicht vorhanden');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20010,'proc:get_cat_name: ' || substr(SQLERRM,1,80));
END;
```

#### Lösung
Deine schriftliche Lösung.


### Aufgabe 2
Schreibe eine Prozedur, die bei Eingabe einer `lend_id` (IN-Parameter) das aktuellste Ausleihdatum für diesen Kunden zurückgibt (OUT-Parameter). Rufe die Prozedur auf und lasse dir das aktuellste Ausleihdatum für den Kunden mit der `lend_id` `3` ausgeben (mithilfe von PL/SQL oder über SQLPlus).

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 3
Was bewirkt die folgende Funktion?

```sql
CREATE OR REPLACE FUNCTION get_c_name(in_pub_id IN NUMBER) RETURN VARCHAR2
AS
  v_c_name lib_city.name%TYPE;
BEGIN
  SELECT c.name INTO v_c_name
  FROM lib_city c
    INNER JOIN lib_publisher p ON (c.c_id = p.c_id)
  WHERE pub_id = in_pub_id;

  RETURN v_c_name;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20009,'Publisher nicht vorhanden');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20010,'proc' || 'get_cat_name: '|| SUBSTR(SQLERRM,1,80));
END;
```

#### Lösung
Deine schriftliche Lösung.


### Aufgabe 4
Schreibe eine PL/SQL-Funktion, die bei Eingabe einer Autor-ID die insgesamt veröffentlichten Seiten des Autors ausgibt. Baue deine Funktion so in eine Select-Abfrage ein, dass du eine Liste aller Autoren (`forename` und `surname`) inklusive der vom jeweiligen Autor insgesamt veröffentlichten Seiten erhältst.

#### Lösung
```sql
Deine Lösung
```
