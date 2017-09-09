# Tutorium - Grundlagen Datenbanken - Blatt 9

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `Tutorium_Book.sql` benötigt, die sich in dem Verzeichnis `sql` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels `start <Dateipfad> ` in Datenbank importieren
* Beispiele
  * Linux: `start ~/Tutorium_Book.sql`
  * Windows: `start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql`

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
Deine schriftliche Lösung.

### Aufgabe 2
Schreibe einen Trigger, der sicherstellt, dass ein Ausleihvorgang nur für eine Kunden angelegt werden kann, der aktuell Mitglied der Bücherei ist.
> Hinweis, Mitglied: `member_until` ist `NULL` oder Datum liegt in der Zukunft.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 3
Schreibe einen Trigger, der sicherstellt, dass beim Einfügen in `lib_category` als Kategorie-ID eine fortlaufende Nummer aus einer Sequenz vergeben wird. Diese Nummer soll bei 5 beginnen.

#### Lösung
```sql
Deine Lösung
```

