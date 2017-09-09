# Tutorium - Grundlagen Datenbanken - Blatt 9

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
*  Linux: ```start ~/Tutorium_Book.sql```
*  Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Aufgabe 1
Was bewirkt der folgende Trigger?

```sql
CREATE OR REPLACE TRIGGER lib_book_isbn_u BEFORE UPDATE OF ISBN ON lib_book FOR EACH ROW
DECLARE

BEGIN
  IF :NEW.ISBN != :OLD.ISBN THEN
    RAISE_APPLICATION_ERROR(-20001, 'ISBN darf nachträglich nicht geändert werden');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20010,'Trigger lib_book_isbn_u' || SUBSTR(SQLERRM,1,80));
END;
```

#### Lösung
Der Trigger `lib_book_isbn_u` bewirkt, dass wenn auf die Tabelle `Lib_Book` und deren Spalte `ISBN` ein Update erfolgt, der Trigger anschlägt. Die Variable `:NEW.ISBN` wird mit `:OLD.ISBN` verglichen. Besteht hier ein Unterschied wird eine Fehlermeldung ausgegeben und der Update Befehl abgebrochen.


### Aufgabe 2
Schreibe einen Trigger, der sicherstellt, dass ein Ausleihvorgang nur für eine Kunden angelegt werden kann, der aktuell Mitglied der Bücherei ist.
> Hinweis, Mitglied: `member_until` ist `NULL` oder Datum liegt in der Zukunft.

#### Lösung
```sql
CREATE OR REPLACE TRIGGER lib_rental_i
BEFORE INSERT ON lib_rental
FOR EACH ROW
DECLARE
  v_member_until lib_lender.member_until%TYPE;

BEGIN
  SELECT member_until INTO v_member_until
  FROM lib_lender
  WHERE lend_id = :NEW.lend_id;

  IF (v_member_until IS NOT NULL AND v_member_until < SYSDATE ) THEN
    RAISE_APPLICATION_ERROR(-20001, 'Kunde ist kein Mitglied mehr');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20010,'Trigger lib_rental_i' || SUBSTR(SQLERRM,1,80));
END;
```

### Aufgabe 3
Schreibe einen Trigger, der sicherstellt, dass beim Einfügen in `lib_category` als Kategorie-ID eine fortlaufende Nummer aus einer Sequenz vergeben wird. Diese Nummer soll bei 5 beginnen.

#### Lösung
```sql
CREATE SEQUENCE category_seq
START WITH 5;

CREATE OR REPLACE TRIGGER lib_cat_pk_i BEFORE insert ON lib_category FOR EACH ROW
BEGIN
  :NEW.cat_id := category_seq.NEXTVAL;
END;
```

