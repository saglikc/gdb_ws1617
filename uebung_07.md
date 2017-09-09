# Tutorium - Grundlagen Datenbanken - Blatt 7

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `Tutorium_Book.sql` benötigt, die sich in dem Verzeichnis `sql` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels `start <Dateipfad> ` in Datenbank importieren
* Beispiele
  * Linux: `start ~/Tutorium_Book.sql`
  * Windows: `start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql`

## Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

## Aufgaben

### Aufgabe 1
Passe den Block so an, dass außerdem der Name des Kunden mit der ID `9` ausgegeben wird.
```sql
DECLARE
  v_lend lib_rental.lend%TYPE;
  v_date_diff NUMBER;
BEGIN
  SELECT MAX(lend) INTO v_lend
  FROM lib_rental
  WHERE lend_id = 9
  GROUP BY lend_id;

  v_date_diff := TRUNC(SYSDATE - v_lend);

  DBMS_OUTPUT.PUT_LINE('Kunde mit der ID 9 hat seit ' || v_date_diff || ' Tagen keine Bücher mehr ausgeliehen');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001, 'Kunde mit der ID 9 hat bisher keine Bücher ausgeliehen!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
    RAISE;
END;
```

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 2.1
Schreibe einen anonymen Codeblock, der den Titel und das Erscheinungsjahr des Buchs mit der `book_id` `2` ausgibt.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 2.2
Ergänze den Block aus Aufgabe 2.1 mithilfe eines `IF-ELSE`-Konstrukts so, dass abhängig vom Erscheinungsjahr das Buch in der Ausgabe als Klassiker (mindestens 15 Jahre alt) oder als Neuheit (jünger als 15 Jahre) bezeichnet wird.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 3.1
Analysiere den untenstehenden anonymen PL/SQL-Codeblock. Was macht er?

```sql
DECLARE
  CURSOR cur_book (pub_id_in NUMBER) IS
    SELECT title, year
    FROM lib_book
    WHERE pub_id = pub_id_in
    ORDER BY year ASC;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Liste aller Verleger in Koeln');
  DBMS_OUTPUT.PUT_LINE('____________________________________________');

  FOR rec_pub IN (
    SELECT pub_name, pub_id
    FROM lib_city c
      INNER JOIN lib_publisher p ON (c.c_id = p.c_id)
    WHERE UPPER(name) = 'KOELN'
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(rec_pub.pub_name||'; ID: ' || rec_pub.pub_id);
    FOR rec_book IN cur_book (
      rec_pub.pub_id
    )
    LOOP
      DBMS_OUTPUT.PUT_LINE('---'||rec_book.year || ' ' || rec_book.title);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('---');
  END LOOP;
END;
```
#### Lösung
Deine schriftliche Lösung.

### Aufgabe 3.2
Ergänze den Codeblock aus Aufgabe 3.1 so, dass zusätzlich für jedes Buch die Seitenzahl ausgegeben wird.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 4.1
Schreibe einen anonymen PL/SQL-Codeblock, der für den Kunden mit der `ID` `9` ausgibt, welche Bücher (`title` und `year`) wann ausgeliehen (`lend`) und zurückgegeben (`return`) wurden.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 4.2
Ergänze den Code so, dass bei Büchern, die noch nicht zurückgegeben wurden, das voraussichtliche Rückgabedatum angegeben wird (`lend` + 31 Tage). Zur Ermittlung kann das `CASE WHEN`-Konstrukt verwendet werden.

```sql
Deine Lösung
```
