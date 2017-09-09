# Tutorium - Grundlagen Datenbanken - Blatt 3

## Vorbereitung

* Für dieses Aufgabenblatt wird die SQL-Dump-Datei ```Tutorium_Book.sql``` benötigt, die sich in dem Verzeichnis ```sql``` befindet
* Die SQL-Dump Datei wird in SQL-PLUS mittels ```start <Dateipfad> ```  in Datenbank   importieren
* Beispiele
  * Linux: ```start ~/Tutorium_Book.sql```
  * Windows: ```start C:\Users\max.mustermann\Desktop\Tutorium_Book.sql```

### Datenbankmodell
![Datenbankmodell](./img/Schema_mit_Beziehungen.png)

### Aufgabe 1
Ermittle, warum du ```INSERT```-Rechte auf die Tabelle ```SCOTT.EMP``` und ```UPDATE```-Rechte auf die Tabelle ```SCOTT.DEPT``` besitzt.
Beantworte dazu schrittweise folgende Fragen:
* Wurden die Tabellen-Rechte direkt an dich bzw. an PUBLIC vergeben?
* Welche Rollen besitzt du direkt?
* Welche Rollen sind diesen Rollen zugeordnet?
* Haben die dir direkt bzw. indirekt (über Zuordnung von Rollen zu Rollen) zugewiesenen Rollen Rechte an den Tabellen ```EMP``` und ```DEPT``` des Users ```SCOTT```?

> Hilfestellung: Die benötigten Informationen können in den Data Dictionary-Tabellen ```ALL_TAB_PRIVS```, ```USER_ROLE_PRIVS```, ```ROLE_ROLE_PRIVS```, ```SESSION_ROLES``` und ```ROLE_TAB_PRIVS``` gefunden werden.

#### Aufgabe 1.1 - Wurden die Tabellen-Rechte direkt an dich bzw. an ```PUBLIC``` vergeben?

#### Lösung
```sql
SELECT table_name, privilege, grantee
FROM all_tab_privs
WHERE table_name IN ('DEPT','EMP')
AND table_schema LIKE 'SCOTT'
AND grantee IN ('PESCHM', 'PUBLIC');

-- Styling für sqlplus
COLUMN SCHEMA FORMAT a15
COLUMN Tabelle FORMAT a15
COLUMN Recht FORMAT a15
COLUMN GRANTEE FORMAT a15

SELECT table_schema Schema, table_name Tabelle, privilege Recht, grantee
FROM all_tab_privs
WHERE table_name IN ('DEPT','EMP')
AND table_schema LIKE 'SCOTT'
AND grantee IN (
  (
    SELECT USER
    FROM DUAL
  ),
  (
    SELECT granted_role
    FROM user_role_privs
  ),
  'PUBLIC'
);
```

#### Aufgabe 1.2 - Welche Rollen besitzt du direkt?

#### Lösung
```sql
SELECT granted_role, default_role
FROM user_role_privs;
```

#### Aufgabe 1.3.1 - Welche Rollen haben diese Rollen?

#### Lösung
```sql
SELECT role , granted_role
FROM role_role_privs
WHERE role IN ('BW_STUDENT', 'FH_TRIER');
```

#### Aufgabe 1.3.2 - Haben Student oder BAstudent weitere Rollen?

#### Lösung
```sql
SELECT role , granted_role
FROM role_role_privs
WHERE role IN ('STUDENT', 'BASTUDENT')
```

#### Aufgabe 1.3.3 - Alle Rollen, die dem User direkt/indirekt in dieser Session zugeordnet sind.

#### Lösung
```sql
SELECT  *
FROM  session_roles;
```

#### Aufgabe 1.4 - Haben diese Rollen Rechte an SCOTT.EMP oder SCOTT.DEPT?

#### Lösung
```sql
SELECT *
FROM role_tab_privs
WHERE role IN ('BW_STUDENT','STUDENT','BASTUDENT','FH_TRIER')
AND owner LIKE 'SCOTT'
AND table_name IN ('EMP','DEPT');
```

### Aufgabe 2
Erstelle eine Tabelle ```lib_Video``` mit den Spalten ```vid_id``` (4stellige ID), ```vid_name``` (bis zu 30 Zeichen lang), ```year``` (4stellige Nummer) und ```vid_code``` (genau 12 Zeichen langer Code, bestehend aus Zahlen und Buchstaben).
Entscheide selbst über passende Datentypen für die einzelnen Spalten. Name, ID und Vid_Code sollen dabei Pflichtangaben sein, während YEAR nicht unbedingt angegeben werden muss.

#### Lösung
```sql
CREATE TABLE lib_video (
  vid_id NUMBER(4,0)   NOT NULL,
  vid_name VARCHAR2(30)  NOT NULL,
  year NUMBER(4),
  vid_code CHAR(12) NOT NULL
);
```

### Aufgabe 3
Räume dem Nutzer Scott das Recht ein, ein Update auf die Spalten year, vid_code und vid_name der lib_Video-Tabelle durchzuführen.

#### Lösung
```sql
GRANT UPDATE(year, vid_code, vid_name)
ON lib_video
TO scott;
```

### Aufgabe 4
Entziehe dem Nutzer Scott die Update-Rechte auf die Tabelle lib_video.

#### Lösung
```sql
REVOKE UPDATE
ON lib_video
FROM scott;
```
