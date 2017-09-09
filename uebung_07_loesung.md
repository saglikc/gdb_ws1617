# Tutorium - Grundlagen Datenbanken - Blatt 7

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
* Linux: ```start ~/Tutorium_Book.sql```
* Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)


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
DECLARE
  v_lend lib_rental.lend%TYPE;
  v_date_diff NUMBER;
  v_name VARCHAR(40);
BEGIN
  SELECT MAX(lend) INTO v_lend
  FROM lib_rental
  WHERE lend_id = 9
  GROUP BY lend_id;

  v_date_diff := TRUNC(SYSDATE - v_lend);

  SELECT forename || ' ' || surname INTO v_name
  FROM lib_lender
  WHERE lend_id = 9;

  DBMS_OUTPUT.PUT_LINE('Kunde '|| v_name ||' mit der ID 9 hat seit ' || v_date_diff || ' Tagen keine Bücher mehr ausgeliehen');

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001, 'Kunde mit der ID 9 hat bisher keine Bücher ausgeliehen!');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
```

### Aufgabe 2.1
Schreibe einen anonymen Codeblock, der den Titel und das Erscheinungsjahr des Buchs mit der `book_id` `2` ausgibt.

#### Lösung
```sql
DECLARE
  v_title lib_book.title%TYPE;
  v_year lib_book.year%TYPE;
BEGIN
  SELECT title, year INTO v_title, v_year
  FROM lib_book
  WHERE book_id = 2;

  DBMS_OUTPUT.PUT_LINE('Das Buch '|| v_title || ' ist ' || v_year || ' erschienen.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001, 'Buch mit der ID 2 konnte nicht gefunden werden.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
    RAISE;
END;
```

### Aufgabe 2.2
Ergänze den Block aus Aufgabe 2.1 mithilfe eines `IF-ELSE`-Konstrukts so, dass abhängig vom Erscheinungsjahr das Buch in der Ausgabe als Klassiker (mindestens 15 Jahre alt) oder als Neuheit (jünger als 15 Jahre) bezeichnet wird.

#### Lösung
```sql
DECLARE
  v_title lib_book.title%TYPE;
  v_year lib_book.year%TYPE;
  v_age VARCHAR(10);

BEGIN
  SELECT title, year INTO v_title, v_year
  FROM lib_book
  WHERE book_id = 2;

  IF (EXTRACT(YEAR FROM SYSDATE) – v_year) < 15 THEN
    v_age := 'Neuheit';
  ELSE
    v_age := 'Klassiker';
  END IF;

  DBMS_OUTPUT.PUT_LINE( v_age || ' ' ||  v_title || ' ist ' || v_year ||' erschienen.');

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001, 'Buch mit der ID 2 konnte nicht gefunden werden.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
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
DECLARE
  CURSOR cur_book (pub_id_in NUMBER) IS
    SELECT title, year, pages
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

    FOR rec_book IN cur_book(
      rec_pub.pub_id
    )
    LOOP
      DBMS_OUTPUT.PUT_LINE('---'||rec_book.year || ' ' || rec_book.title || ' – Seiten: ' || rec_book.pages);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('---');
  END LOOP;
END;
```

### Aufgabe 4.1
Schreibe einen anonymen PL/SQL-Codeblock, der für den Kunden mit der `ID` `9` ausgibt, welche Bücher (`title` und `year`) wann ausgeliehen (`lend`) und zurückgegeben (`return`) wurden.

#### Lösung
```sql
-- Lösung
DECLARE
  CURSOR cur_book (l_id_in NUMBER) IS
    SELECT b.title, b.year
    FROM lib_book b
      INNER JOIN lib_contains c ON (b.book_id = c.book_id)
    WHERE c.l_id = l_id_in;

BEGIN
  FOR rec_lend IN (
    SELECT l_id, lend, return
    FROM lib_rental
    WHERE lend_id = 9
    ORDER BY lend ASC
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Geliehen: ' || rec_lend.lend || '; Rueckgabe: ' || rec_lend.return);
    FOR rec_book IN cur_book(
      rec_lend.l_id
    )
    LOOP
      DBMS_OUTPUT.PUT_LINE('---'||rec_book.title|| ', ' || rec_book.year);
    END LOOP;
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Daten wurden nicht gefunden');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
    RAISE;
END;
```

#### Alternative Lösung
```sqö
DECLARE
BEGIN
  FOR rec_len IN (
    SELECT lend, return, title, year
    FROM lib_rental r
      INNER JOIN lib_contains C ON (r.l_id = c.l_id)
      INNER JOIN  lib_book b ON (c.book_id = b.book_id)
    WHERE lend_id = 9
    ORDER BY  lend ASC
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE( rec_len.title||'('||rec_len.year||') Geliehen:' || rec_len.lend || '; Rueckgabe:' || rec_len.return);
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Daten wurden nicht gefunden');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
```

### Aufgabe 4.2
Ergänze den Code so, dass bei Büchern, die noch nicht zurückgegeben wurden, das voraussichtliche Rückgabedatum angegeben wird (`lend` + 31 Tage). Zur Ermittlung kann das `CASE WHEN`-Konstrukt verwendet werden.

```sql
DECLARE
  v_rueck varchar2(300);
BEGIN
  FOR rec_len IN (
    SELECT lend, return, title, year
    FROM lib_rental r
      INNER JOIN lib_contains c ON (r.l_id = c.l_id)
      INNER JOIN lib_book b ON (c.book_id = b.book_id)
    WHERE lend_id = 9
    ORDER BY  lend ASC
  )
  LOOP
    CASE WHEN rec_len.return IS NULL THEN
      v_rueck :=(';vorrauss. Rueckgabe:'||(rec_len.lend + INTERVAL '31' DAY));
    ELSE
      v_rueck := ('; Rueckgabe:' || rec_len.return);
    END CASE;
    DBMS_OUTPUT.PUT_LINE(rec_len.title || '(' ||rec_len.year|| ') Geliehen:'||rec_len.lend || v_rueck);
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Daten wurden nicht gefunden');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
    RAISE;
END;

```

#### Alternative Lösung
```sql
DECLARE
BEGIN
  FOR rec_len IN (
    SELECT lend, return, title, year
    FROM lib_rental r
      INNER JOIN lib_contains c ON (r.l_id = c.l_id)
      INNER JOIN lib_book b ON (c.book_id = b.book_id)
    WHERE lend_id = 9
    ORDER BY  lend ASC
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(rec_len.title || '(' ||rec_len.year|| ') Geliehen:' ||rec_len.lend ||
      CASE WHEN rec_len.return IS NULL THEN
        '; vorrauss. Rueckgabe: ' || (rec_len.lend + INTERVAL '31' DAY)
      ELSE
        '; Rueckgabe:' || rec_len.return
      END CASE);
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Daten wurden nicht gefunden');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
    RAISE;
END;
```
