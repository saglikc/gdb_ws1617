/*	
	Author:			Markus Pesch, (Birgit Kirsch)
	Modul:			Tutorium Datenbanken WS1617
	Datum:			29.09.2016
	Übungsblatt:		1

	SQL-Dump-Datei:		01_SQL-Dump_-_Tutorium_Book.sql
	Vorbereitung:		Die SQL-Dump Datei in SQL-PLUS mittels start-Befehl (start "<pfad/zur/Datei.sql>")  in Datenbank importieren.
	
	Editor:			Notepad++ (https://notepad-plus-plus.org/) für Windows oder gedit für Linux
	Dateiendung:		.sql
	Kodierung:		UTF-8
	Tabulatorbreite:	8
*/


-- Aufgabe 1
-- Welche Bücher (mit Titel und Erscheinungsjahr) wurden vom Heyne-Verlag herausgegeben?
-- Versuche mehr als einen Lösungsweg an zu wenden(!)

-- Lösung per INNER JOIN
SELECT 		b.title, b. year 
FROM 		lib_book b
INNER JOIN 	lib_publisher p ON (b.pub_id = p.pub_id)
WHERE 		pub_name LIKE  'Heyne';

-- Lösung per Unterabfrage (Subquery)
SELECT title, year
FROM lib_book
WHERE pub_id =	(
			SELECT 	pub_id 
	 		FROM 	lib_publisher 
	 		WHERE 	pub_name  LIKE  'Heyne'
		);

-- Aufgabe 2
-- Welche Bücher (mit Titel und Erscheinungsjahr) wurden nicht von Verlegern aus Koeln herausgegeben?
-- Versuche mehr als einen Lösungsweg an zu wenden(!)

-- Lösung per INNER JOIN
SELECT 		b.title, b.year 
FROM 		lib_book b 
INNER JOIN 	lib_publisher p ON (b.pub_id = p.pub_id)
INNER JOIN 	lib_city c 	ON (p.c_id = c.c_id)
WHERE 		c.name NOT LIKE 'Koeln';

-- Lösung per Unterabfrage (Subquery)
SELECT 	title, year 
FROM 	lib_book 
WHERE 	pub_id IN	(
				SELECT 	pub_id 
			 	FROM 	lib_publisher
				WHERE 	c_id IN	(
							SELECT 	c_id 
					 		FROM 	lib_city
					 		WHERE 	name NOT LIKE 'Koeln')
			);

-- Aufgabe 3
-- Zu welchen Kategorien sind keine Bücher vorhanden?

-- Lösung per Unterabfrage (Subquery)
SELECT 	cat_name
FROM 	lib_category
WHERE 	cat_id NOT IN 	(
				SELECT 	cat_id
	 	 		FROM 	lib_book
				WHERE	book_id IS NOT NULL
			);

-- Lösung per INNER JOIN
SELECT 		c.cat_name 
FROM 		lib_category c
LEFT JOIN 	lib_book b ON (c.cat_id = b.cat_id)
WHERE 		b.book_id IS NULL;

-- Aufgabe 4
-- Ermittle alle Jahre, in denen Bücher erschienen sind.

SELECT 		DISTINCT b.year 
FROM 		lib_book b
ORDER BY	b.year ASC;

-- Aufgabe 5
-- Welche Bücher (Titel  und Erscheinungsjahr) wurden vom „Fischer“-Verlag herausgegeben oder gehören zur Kategorie „Fachbuch“?
-- Versuche mehr als einen Lösungsweg an zu wenden.

-- Lösung per INNER JOIN
SELECT 		b.title, b.year
FROM 		lib_book b 
INNER JOIN 	lib_publisher p 	ON (b.pub_id = p.pub_id)
INNER JOIN 	lib_category c 		ON (c.cat_id=b.cat_id)
WHERE 		p.pub_name LIKE 'Fischer'
OR 		c.cat_name LIKE 'Fachbuch';

-- Lösung per Unterabfrage (Subquery)
SELECT 	title, year 
FROM 	lib_book b
WHERE 	b.pub_id IN	(
				SELECT 	pub_id
		 		FROM 	lib_publisher
		 		WHERE 	pub_name LIKE 'Fischer'
			)
OR 	b.cat_id IN	(
				SELECT 	cat_id
		 		FROM 	lib_category
		 		WHERE 	cat_name LIKE 'Fachbuch'
			);

-- Aufgabe 6
-- Welche Bücher (mit Titel und Erscheinungsjahr) wurden von einem Autor verfasst, dessen Nachname mit „F“ beginnt und mit „ein“ endet?  Achtung, es soll kein Buch mehrfach aufgelistet werden.

-- Lösung INNER JOIN
SELECT 		b.title, b.year
FROM 		lib_book b
INNER JOIN 	lib_did_write w ON(b.book_id = w.book_id)
INNER JOIN 	lib_author a 	ON (w.auth_id = a.auth_id)
WHERE 		a.surname LIKE 'F%ein';

-- Lösung per Unterabfrage (Subquery)	
SELECT 	b.title, b.year
FROM 	lib_book b
WHERE 	b.book_id IN (
			SELECT 	book_id 
			FROM 	lib_did_write
			WHERE 	auth_id IN (
						SELECT 	a.auth_id
						FROM 	lib_author a
						WHERE 	a.surname LIKE 'F%ein' 
					   )
		     );

