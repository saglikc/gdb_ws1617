set feedback off
set define off

drop table LIB_AUTHOR cascade constraints;

drop table LIB_BELONGS_TO_GENRE cascade constraints;

drop table LIB_BOOK cascade constraints;

drop table LIB_CATEGORY cascade constraints;

drop table LIB_CITY cascade constraints;

drop table LIB_CONTAINS cascade constraints;

drop table LIB_DID_WRITE cascade constraints;

drop table LIB_GENRE cascade constraints;

drop table LIB_LENDER cascade constraints;

drop table LIB_PUBLISHER cascade constraints;

drop table LIB_RENTAL cascade constraints;

prompt Erzeuge Tabelle lib_author...
/*==============================================================*/
/* Table: LIB_AUTHOR                                            */
/*==============================================================*/
create table LIB_AUTHOR 
(
   AUTH_ID              NUMBER(7)            not null,
   FORENAME             VARCHAR2(30),
   SURNAME              VARCHAR2(30)         not null,
   constraint PK_LIB_AUTHOR primary key (AUTH_ID)
);

prompt Erzeuge Tabelle lib_belongs_to_genre...
/*==============================================================*/
/* Table: LIB_BELONGS_TO_GENRE                                  */
/*==============================================================*/
create table LIB_BELONGS_TO_GENRE 
(
   BOOK_ID              NUMBER(7)            not null,
   GEN_ID               NUMBER(2)            not null,
   constraint PK_LIB_BELONGS_TO_GENRE primary key (BOOK_ID, GEN_ID)
);


prompt Erzeuge Tabelle lib_book...
/*==============================================================*/
/* Table: LIB_BOOK                                              */
/*==============================================================*/
create table LIB_BOOK 
(
   TITLE                VARCHAR2(25)         not null,
   YEAR                 NUMBER(4),
   EDITION              SMALLINT,
   ISBN                 CHAR(13)             not null,
   PAGES                NUMBER(5),
   BOOK_ID              NUMBER(7)            not null,
   PUB_ID               NUMBER(7)            not null,
   CAT_ID               NUMBER(2)            not null,
   constraint PK_LIB_BOOK primary key (BOOK_ID)
);

prompt Erzeuge Tabelle lib_category...
/*==============================================================*/
/* Table: LIB_CATEGORY                                          */
/*==============================================================*/
create table LIB_CATEGORY 
(
   CAT_ID               NUMBER(2)            not null,
   CAT_NAME             VARCHAR2(30),
   constraint PK_LIB_CATEGORY primary key (CAT_ID)
);

prompt Erzeuge Tabelle lib_city...
/*==============================================================*/
/* Table: LIB_CITY                                              */
/*==============================================================*/
create table LIB_CITY 
(
   C_ID                 NUMBER(5)            not null,
   NAME                 VARCHAR2(30)         not null,
   constraint PK_LIB_CITY primary key (C_ID)
);

prompt Erzeuge Tabelle lib_contains...
/*==============================================================*/
/* Table: LIB_CONTAINS                                          */
/*==============================================================*/
create table LIB_CONTAINS 
(
   BOOK_ID              NUMBER(7)            not null,
   L_ID                 INTEGER              not null,
   constraint PK_LIB_CONTAINS primary key (BOOK_ID, L_ID)
);

prompt Erzeuge Tabelle lib_did_write...
/*==============================================================*/
/* Table: LIB_DID_WRITE                                         */
/*==============================================================*/
create table LIB_DID_WRITE 
(
   BOOK_ID              NUMBER(7)            not null,
   AUTH_ID              NUMBER(7)            not null,
   constraint PK_LIB_DID_WRITE primary key (BOOK_ID, AUTH_ID)
);

prompt Erzeuge Tabelle lib_genre...
/*==============================================================*/
/* Table: LIB_GENRE                                             */
/*==============================================================*/
create table LIB_GENRE 
(
   GEN_ID               NUMBER(2)            not null,
   GEN_NAME             VARCHAR2(30)         not null,
   constraint PK_LIB_GENRE primary key (GEN_ID)
);

prompt Erzeuge Tabelle lib_lender...
/*==============================================================*/
/* Table: LIB_LENDER                                            */
/*==============================================================*/
create table LIB_LENDER 
(
   LEND_ID              NUMBER(8)            not null,
   FORENAME             VARCHAR2(17)         not null,
   SURNAME              VARCHAR2(17)         not null,
   ADDRESS              VARCHAR2(30),
   LOCATION             VARCHAR2(15),
   BIRTHDATE            DATE,
   MEMBER_SINCE         DATE                 not null,
   MEMBER_UNTIL         DATE,
   constraint PK_LIB_LENDER primary key (LEND_ID)
);

prompt Erzeuge Tabelle lib_publisher...
/*==============================================================*/
/* Table: LIB_PUBLISHER                                         */
/*==============================================================*/
create table LIB_PUBLISHER 
(
   PUB_ID               NUMBER(7)            not null,
   C_ID                 NUMBER(5)            not null,
   PUB_NAME             VARCHAR2(30)         not null,
   constraint PK_LIB_PUBLISHER primary key (PUB_ID)
);

prompt Erzeuge Tabelle lib_rental...
/*==============================================================*/
/* Table: LIB_RENTAL                                            */
/*==============================================================*/
create table LIB_RENTAL 
(
   LEND                 DATE                 not null,
   RETURN               DATE,
   L_ID                 INTEGER              not null,
   LEND_ID              NUMBER(8)            not null,
   constraint PK_LIB_RENTAL primary key (L_ID)
);


prompt Constraints anlegen ...
alter table LIB_BELONGS_TO_GENRE
   add constraint FK_LIB_BELO_BELONGS_T_LIB_BOOK foreign key (BOOK_ID)
      references LIB_BOOK (BOOK_ID);

alter table LIB_BELONGS_TO_GENRE
   add constraint FK_LIB_BELO_BELONGS_T_LIB_GENR foreign key (GEN_ID)
      references LIB_GENRE (GEN_ID);

alter table LIB_BOOK
   add constraint FK_LIB_BOOK_DID_PUBLI_LIB_PUBL foreign key (PUB_ID)
      references LIB_PUBLISHER (PUB_ID);

alter table LIB_BOOK
   add constraint FK_LIB_BOOK_IS_A_LIB_CATE foreign key (CAT_ID)
      references LIB_CATEGORY (CAT_ID);

alter table LIB_CONTAINS
   add constraint FK_LIB_CONT_CONTAINS_LIB_BOOK foreign key (BOOK_ID)
      references LIB_BOOK (BOOK_ID);

alter table LIB_CONTAINS
   add constraint FK_LIB_CONT_CONTAINS2_LIB_RENT foreign key (L_ID)
      references LIB_RENTAL (L_ID);

alter table LIB_DID_WRITE
   add constraint FK_LIB_DID__DID_WRITE_LIB_BOOK foreign key (BOOK_ID)
      references LIB_BOOK (BOOK_ID);

alter table LIB_DID_WRITE
   add constraint FK_LIB_DID__DID_WRITE_LIB_AUTH foreign key (AUTH_ID)
      references LIB_AUTHOR (AUTH_ID);

alter table LIB_PUBLISHER
   add constraint FK_LIB_PUBL_LOCATED_I_LIB_CITY foreign key (C_ID)
      references LIB_CITY (C_ID);

alter table LIB_RENTAL
   add constraint FK_LIB_RENT_LENDS_LIB_LEND foreign key (LEND_ID)
      references LIB_LENDER (LEND_ID);
	  
-- no more cities
alter table LIB_CITY
	add constraint SYS_C1023752
		CHECK(c_id < 81);


prompt Datensaetze in Tabellen einfügen...
/*==============================================================*/
/* Fill content of tables                                       */
/*==============================================================*/

SET ESCAPE '\'

-- Mass data (cities)
INSERT INTO lib_city VALUES(1,'Berlin');
INSERT INTO lib_city VALUES(2,'Hamburg');
INSERT INTO lib_city VALUES(3,'Muenchen');
INSERT INTO lib_city VALUES(4, 'Koeln');
INSERT INTO lib_city VALUES(5, 'Frankfurt');
INSERT INTO lib_city VALUES(6, 'Stuttgart');
INSERT INTO lib_city VALUES(7, 'Duesseldorf');
INSERT INTO lib_city VALUES(8, 'Dortmund');
INSERT INTO lib_city VALUES(9, 'Essen');
INSERT INTO lib_city VALUES(10, 'Bremen');
INSERT INTO lib_city VALUES(11, 'Dresden');
INSERT INTO lib_city VALUES(12, 'Leipzig');
INSERT INTO lib_city VALUES(13, 'Hannover');
INSERT INTO lib_city VALUES(14, 'Nuernberg');
INSERT INTO lib_city VALUES(15, 'Duisburg');
INSERT INTO lib_city VALUES(16, 'Bochum');
INSERT INTO lib_city VALUES(17, 'Wuppertal');
INSERT INTO lib_city VALUES(18, 'Bonn');
INSERT INTO lib_city VALUES(19, 'Bielefeld');
INSERT INTO lib_city VALUES(20, 'Mannheim');

INSERT ALL
INTO lib_city VALUES(21, 'Karlsruhe')
INTO lib_city VALUES(22, 'Muenster')
INTO lib_city VALUES(23, 'Wiesbaden')
INTO lib_city VALUES(24, 'Augsburg')
INTO lib_city VALUES(25, 'Aachen')
INTO lib_city VALUES(26, 'Moenchengladbach')
INTO lib_city VALUES(27, 'Gelsenkirchen')
INTO lib_city VALUES(28, 'Braunschweig')
INTO lib_city VALUES(29, 'Chemnitz')
INTO lib_city VALUES(30, 'Kiel')
SELECT * FROM DUAL;
INSERT ALL
INTO lib_city VALUES(31, 'Krefeld')
INTO lib_city VALUES(32, 'Halle')
INTO lib_city VALUES(33, 'Magdeburg')
INTO lib_city VALUES(34, 'Freiburg')
INTO lib_city VALUES(35, 'Oberhausen')
INTO lib_city VALUES(36, 'Luebeck')
INTO lib_city VALUES(37, 'Erfurt')
INTO lib_city VALUES(38, 'Rostock')
INTO lib_city VALUES(39, 'Mainz')
INTO lib_city VALUES(40, 'Kassel')
SELECT * FROM DUAL;
INSERT ALL
INTO lib_city VALUES(41, 'Hagen')
INTO lib_city VALUES(42, 'Hamm')
INTO lib_city VALUES(43, 'Saarbruecken')
INTO lib_city VALUES(44, 'Muelheim')
INTO lib_city VALUES(45, 'Herne')
INTO lib_city VALUES(46, 'Ludwigshafen')
INTO lib_city VALUES(47, 'Osnabrueck')
INTO lib_city VALUES(48, 'Oldenburg')
INTO lib_city VALUES(49, 'Leverkusen')
INTO lib_city VALUES(50, 'Solingen')
SELECT * FROM DUAL;
INSERT ALL
INTO lib_city VALUES(51, 'Potsdam')
INTO lib_city VALUES(52, 'Neuss')
INTO lib_city VALUES(53, 'Heidelberg')
INTO lib_city VALUES(54, 'Paderborn')
INTO lib_city VALUES(55, 'Darmstadt')
INTO lib_city VALUES(56, 'Regensburg')
INTO lib_city VALUES(57, 'Wuerzburg')
INTO lib_city VALUES(58, 'Ingolstadt')
INTO lib_city VALUES(59, 'Heilbronn')
INTO lib_city VALUES(60, 'Ulm')
SELECT * FROM DUAL;
INSERT ALL
INTO lib_city VALUES(61, 'Wolfsburg')
INTO lib_city VALUES(62, 'Goettingen')
INTO lib_city VALUES(63, 'Offenbach')
INTO lib_city VALUES(64, 'Pforzheim')
INTO lib_city VALUES(65, 'Recklinghausen')
INTO lib_city VALUES(66, 'Bottrop')
INTO lib_city VALUES(67, 'Fuerth')
INTO lib_city VALUES(68, 'Bremerhaven')
INTO lib_city VALUES(69, 'Reutlingen')
INTO lib_city VALUES(70, 'Remscheid')
SELECT * FROM DUAL;
INSERT ALL
INTO lib_city VALUES(71, 'Koblenz')
INTO lib_city VALUES(72, 'Bergisch')
INTO lib_city VALUES(73, 'Erlangen')
INTO lib_city VALUES(74, 'Moers')
INTO lib_city VALUES(75, 'Tier')
INTO lib_city VALUES(76, 'Jena')
INTO lib_city VALUES(77, 'Siegen')
INTO lib_city VALUES(78, 'Hildesheim')
INTO lib_city VALUES(79, 'Salzgitter')
INTO lib_city VALUES(80, 'Cottbus')
SELECT * FROM DUAL;

INSERT ALL
INTO lib_author VALUES(0, 'Frank', 'Schaetzing')
INTO lib_author VALUES(1, 'Lutz', 'Kruschwitz')
INTO lib_author VALUES(2, 'Jonathan', 'Gennick')
INTO lib_author VALUES(3, 'Steven', 'Feuerstein')
INTO lib_author VALUES(4, 'Bill', 'Pribyl')
INTO lib_author VALUES(5, 'Chip', 'Dawes')
INTO lib_author VALUES(6, 'Christian', 'Ullenboom')
INTO lib_author VALUES(7, 'Carlos T.', 'Bienmontana')
INTO lib_author VALUES(8, 'Johann Wilhelm Eugen', 'Schmalenbach')
INTO lib_author VALUES(9, 'Robert S.', 'Pindyck')
INTO lib_author VALUES(10, 'Daniel L.', 'Rubinfeld')
INTO lib_author VALUES(11, 'Guenther', 'Tempelmeier')
INTO lib_author VALUES(12, 'Lynn', 'Beighley')
INTO lib_author VALUES(13, 'Dirk', 'Louis')
INTO lib_author VALUES(14, 'Peter', 'Mueller')
INTO lib_author VALUES(15, 'Tim', 'Krabbé')
INTO lib_author VALUES(16, 'Stieg', 'Larsson')
INTO lib_author VALUES(17, 'George W.', 'Brush')
INTO lib_author VALUES(18, 'Fred', 'Feuerstein')
INTO lib_author VALUES(19, 'Thomas', 'Harris')
SELECT * FROM DUAL;

INSERT INTO lib_genre VALUES(0, 'Thriller');
INSERT INTO lib_genre VALUES(1, 'Science-Fiction');
INSERT INTO lib_genre VALUES(2, 'Romantik');
INSERT INTO lib_genre VALUES(3, 'Maerchen');
INSERT INTO lib_genre VALUES(4, 'Krimi');
INSERT INTO lib_genre VALUES(5, 'Komoedie');
INSERT INTO lib_genre VALUES(6, 'Gesellschaft');

INSERT INTO lib_category VALUES (0, 'Roman');
INSERT INTO lib_category VALUES (1, 'Fachbuch');
INSERT INTO lib_category VALUES (2, 'Lektuere');
INSERT INTO lib_category VALUES (3, 'Kinderbuch');

INSERT INTO lib_publisher VALUES(0, 4, 'Kiepenheuer und Witsch');
INSERT INTO lib_publisher VALUES(1, 5, 'Fischer');
INSERT INTO lib_publisher VALUES(2, 3, 'Oldenbourg Wissenschaftsverlag');
INSERT INTO lib_publisher VALUES(3, 18, 'Galileo Computing');
INSERT INTO lib_publisher VALUES(4, 4, 'O''Reilly');
INSERT INTO lib_publisher VALUES(5, 3, 'Pearson Studium');
INSERT INTO lib_publisher VALUES(6, 53, 'Springer');
INSERT INTO lib_publisher VALUES(7, 3, 'Markt + Technik Verlag');
INSERT INTO lib_publisher VALUES(8, 3, 'Droemer Knaur');
INSERT INTO lib_publisher VALUES(9, 3, 'Heyne');

INSERT INTO lib_book VALUES('Investitionsrechnung', 2008, 12, '9783486587661', 561, 0, 1, 1);
INSERT INTO lib_book VALUES('Der Schwarm', 2004, 23, '9783596164530', 992, 1, 0, 0);
INSERT INTO lib_book VALUES('Limit', 2011, 2, '9783462037043', 1312, 2, 0, 0);
INSERT INTO lib_book VALUES('Java ist auch eine Insel', 2011, 10, '9783836218023', 1308, 3, 0, 0);
INSERT INTO lib_book VALUES('SQL kurz \& gut', 2007, 2, '9783897215221', 208, 4, 4, 1);
INSERT INTO lib_book VALUES('Oracle PL/SQL kurz \& gut', 2008, 4, '9783897215382', 182, 5, 4, 1);
INSERT INTO lib_book VALUES('Mikrooekonomie ', 2009, 6, '9783827371645', 960, 6, 5, 1);
INSERT INTO lib_book VALUES('Produktion und Logistik', 2012, 9, '9783642251641', 388, 7, 6, 1);
INSERT INTO lib_book VALUES('SQL von Kopf bis Fuss', 2008, 1, '9783897217607', 608, 8, 4, 1);
INSERT INTO lib_book VALUES('Gut \& kurz SQL', 2009, 1, '9783888217607', 190, 9, 6, 1);
INSERT INTO lib_book VALUES('Java 5', 2006, 1, '9783827240149', 342, 10, 7, 1);
INSERT INTO lib_book VALUES('Java gimme 5', 2006, 1, '9783828840149', 320, 11, 7, 1);
INSERT INTO lib_book VALUES('Mikro-Oekonomie', 2010, 1, '9783827388845', 500, 12, 7, 1);
INSERT INTO lib_book VALUES('Verspaetung', 2000, 1, '9783426614624', 650, 13, 8, 0);
INSERT INTO lib_book VALUES('Verspaetung', 2009, 1, '9783558611462', 650, 14, 9, 0);
INSERT INTO lib_book VALUES('Der Faenger im Roggen', 1952, 1, '978499235399', 272, 15, 0, 0);
INSERT INTO lib_book VALUES('Das Schweigen der Laemmer', NULL, 4, '9783453432086', 376, 16, 0, 0);

INSERT INTO lib_belongs_to_genre VALUES (1, 1);
INSERT INTO lib_belongs_to_genre VALUES (2, 0);
INSERT INTO lib_belongs_to_genre VALUES (2, 1);
INSERT INTO lib_belongs_to_genre VALUES (13, 5);
INSERT INTO lib_belongs_to_genre VALUES (14, 0);
INSERT INTO lib_belongs_to_genre VALUES (14, 4);
INSERT INTO lib_belongs_to_genre VALUES (15, 6);
INSERT INTO lib_belongs_to_genre VALUES (16, 0);

INSERT ALL
INTO lib_did_write VALUES(0, 1)
INTO lib_did_write VALUES(1, 0)
INTO lib_did_write VALUES(2, 0)
INTO lib_did_write VALUES(3, 6)
INTO lib_did_write VALUES(4, 3)
INTO lib_did_write VALUES(4, 4)
INTO lib_did_write VALUES(5, 4)
INTO lib_did_write VALUES(5, 5)
INTO lib_did_write VALUES(5, 6)
INTO lib_did_write VALUES(6, 9)
INTO lib_did_write VALUES(6, 10)
INTO lib_did_write VALUES(7, 11)
INTO lib_did_write VALUES(8, 12)
INTO lib_did_write VALUES(9, 7)
INTO lib_did_write VALUES(10, 13)
INTO lib_did_write VALUES(10, 14)
INTO lib_did_write VALUES(11, 7)
INTO lib_did_write VALUES(12, 7)
INTO lib_did_write VALUES(13, 15)
INTO lib_did_write VALUES(14, 16)
INTO lib_did_write VALUES(15, 18)
INTO lib_did_write VALUES(16, 19)
-- fake entries for Java Gimme 5
INTO lib_did_write VALUES(11, 5)
INTO lib_did_write VALUES(11, 17)
-- fake entry for SQL gut \& Kurz
INTO lib_did_write VALUES(9, 17)
-- fake entry for Mikro-Oekonomie
INTO lib_did_write VALUES(12, 5)
SELECT * FROM DUAL;

INSERT INTO lib_lender VALUES(0, 'Annemarie', 'Peiner', 'Baumstrasse 22', 'Trier', TO_DATE('01.04.1988'), TO_DATE('05.12.1995'), NULL);
INSERT INTO lib_lender VALUES(1, 'Thomas', 'Bauknecht', 'Neuweg 91', 'Wittlich', TO_DATE('22.11.1974'), TO_DATE('25.01.1995'), NULL);
INSERT INTO lib_lender VALUES(2, 'Karl', 'Liebig', 'In der Au 14', 'Bitburg', TO_DATE('12.01.1966'), TO_DATE('12.05.1994'), NULL);
INSERT INTO lib_lender VALUES(3, 'Karl Theo', 'Gutberger', 'Dopplerallee 3', 'Kopiren', TO_DATE('05.12.1971'), TO_DATE('01.04.2000'), TO_DATE('21.07.2008'));
INSERT INTO lib_lender VALUES(4, 'Janine', 'Bechter', 'Friesenweg 17', 'Daleiden', TO_DATE('25.06.1990'), TO_DATE('01.04.2000'), NULL);
INSERT INTO lib_lender VALUES(5, 'Ulla', 'Rinsky', 'Dorfstrasse 2', 'Berlin', TO_DATE('05.05.1977'), TO_DATE('31.01.2001'), NULL);
INSERT INTO lib_lender VALUES(6, 'Peter', 'Domaniak', 'Kamillenweg 14', 'Trierweiler', TO_DATE('30.12.1991'), TO_DATE('28.08.2004'), NULL);
INSERT INTO lib_lender VALUES(7, 'Marina', 'Weller', 'Berglichter Strasse 8', 'Dahnen', TO_DATE('02.03.1988'), TO_DATE('07.07.2007'), NULL);
INSERT INTO lib_lender VALUES(8, 'Kalle Tiberius', 'Gantmeier', 'Dopplerallee 3', 'Kopiren', TO_DATE('06.01.1972'), TO_DATE('22.07.2008'), TO_DATE('05.04.2009'));
INSERT INTO lib_lender VALUES(9, 'Kasimir Thaddeus ', 'Gemmerich', 'Dopplerallee 3', 'Kopiren', TO_DATE('07.02.1973'), TO_DATE('06.04.2009'), TO_DATE('21.03.2010'));
INSERT INTO lib_lender VALUES(10, 'Konstantin Thilo ', 'Gauweiler', 'Dopplerallee 3', 'Kopiren', TO_DATE('08.03.1974'), TO_DATE('22.03.2010'), NULL);
INSERT INTO lib_lender VALUES(11, 'Annegret ', 'Schipfer-Menning', 'Pommernweg 38', 'Duesseldorf', TO_DATE('07.02.1991'), TO_DATE('31.12.2005'), NULL);
INSERT INTO lib_lender VALUES(12, 'Konstantin Thilo', 'Gauweiler', 'Dopplerallee 3', 'Kopiren', TO_DATE('08.03.1974'), TO_DATE('22.03.2010'), NULL);
INSERT INTO lib_lender VALUES(13, 'Lars', 'Maibach', 'Auf der Kaiserlay 54', 'Bonn', TO_DATE('12.03.1979'), TO_DATE('25.04.2000'), TO_DATE('01.08.2008'));
INSERT INTO lib_lender VALUES(14, 'Daniela', 'Kippling', 'Donnerstrasse 32', 'Isengart', TO_DATE('07.02.1991'), TO_DATE('31.12.2005'), NULL);
INSERT INTO lib_lender VALUES(15, 'Rolf-Olaf', 'Massem', 'Willigerweg 15', 'Hassloch', TO_DATE('05.12.1971'), TO_DATE('07.02.1991'), TO_DATE('21.07.2008'));

INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.01.2011'), TO_DATE('31.01.2011'), 0, 7);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.01.2011'), TO_DATE('31.01.2011'), 1, 2);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.02.2006'), TO_DATE('28.02.2006'), 2, 3);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.02.2011'), TO_DATE('28.02.2011'), 3, 4);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.03.2011'), TO_DATE('28.03.2011'), 4, 0);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.04.2007'), TO_DATE('30.04.2007'), 5, 3);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('26.01.2008'), TO_DATE('26.02.2008'), 6, 3);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('22.07.2008'), TO_DATE('22.08.2008'), 7, 8);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('06.04.2009'), TO_DATE('05.05.2009'), 8, 9);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('06.05.2009'), TO_DATE('07.06.2009'), 9, 9);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('07.06.2009'), TO_DATE('07.07.2009'), 10, 9);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.01.2011'), TO_DATE('25.03.2011'), 11, 0);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('22.07.2008'), TO_DATE('21.08.2010'), 12, 5);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('08.05.2011'), TO_DATE('07.09.2012'), 13, 14);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('17.03.2011'), TO_DATE('16.04.2012'), 14, 15);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('01.05.2013'), TO_DATE('18.05.2013'), 15, 9);
INSERT INTO LIB_RENTAL VALUES(TO_DATE('21.09.2014'), NULL, 		    16, 2);

INSERT ALL
INTO LIB_CONTAINS VALUES(0, 0)
INTO LIB_CONTAINS VALUES(14, 0)
INTO LIB_CONTAINS VALUES(3, 0)
INTO LIB_CONTAINS VALUES(4, 0)
INTO LIB_CONTAINS VALUES(1, 1)
INTO LIB_CONTAINS VALUES(1, 2)
INTO LIB_CONTAINS VALUES(14, 2)
INTO LIB_CONTAINS VALUES(3, 3)
INTO LIB_CONTAINS VALUES(0, 3)
INTO LIB_CONTAINS VALUES(1, 4)
INTO LIB_CONTAINS VALUES(5, 4)
INTO LIB_CONTAINS VALUES(1, 5)
INTO LIB_CONTAINS VALUES(3, 5)
INTO LIB_CONTAINS VALUES(14, 5)
INTO LIB_CONTAINS VALUES(0, 5)
INTO LIB_CONTAINS VALUES(4, 6)
INTO LIB_CONTAINS VALUES(6, 6)
INTO LIB_CONTAINS VALUES(7, 10)
INTO LIB_CONTAINS VALUES(8, 6)
INTO LIB_CONTAINS VALUES(9, 6)
INTO LIB_CONTAINS VALUES(13, 6)
INTO LIB_CONTAINS VALUES(10, 6)
INTO LIB_CONTAINS VALUES(3, 11)
INTO LIB_CONTAINS VALUES(4, 11)
INTO LIB_CONTAINS VALUES(14, 11)
INTO LIB_CONTAINS VALUES(6, 12)
INTO LIB_CONTAINS VALUES(14, 12)
INTO LIB_CONTAINS VALUES(12, 12)
INTO LIB_CONTAINS VALUES(4, 12)
INTO LIB_CONTAINS VALUES(14, 13)
INTO LIB_CONTAINS VALUES(13, 13)
INTO LIB_CONTAINS VALUES(13, 14)
INTO LIB_CONTAINS VALUES(2, 9)
INTO LIB_CONTAINS VALUES(7, 8)
INTO LIB_CONTAINS VALUES(4, 15)
INTO LIB_CONTAINS VALUES(6, 15)
INTO LIB_CONTAINS VALUES(2, 16)
INTO LIB_CONTAINS VALUES(1, 16)
INTO LIB_CONTAINS VALUES(13, 16)
SELECT * FROM DUAL;



COMMIT;
SET DEFINE ON
SET FEEDBACK ON 
SET ESCAPE OFF
prompt Fertig!