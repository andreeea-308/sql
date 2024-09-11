/* 
Databases
-> este o colectie de date care ajuta la colectarea si organizarea informatiilor
-> ea poate stoca informatii despre persoane, produse, categorii de produse, promotii, comenzi
-> o baza de date poate fi accesata printr-un sistem de management al bazelor de date = tool-ul MySQL, SQL Server, SQL Server Management Studio
-> datele sunt stocate in tabele( poate fi corelat cu un excel )
-> SQL = structured query language
-> SQL ANSI - Oracle dbs
*/

/*
MySQL
-> sistem de management al bazelor de date / sistem de gestiune a bazelor de date
-> se foloseste pentru site-uri web/aplicatii web
-> este conceput pentru a procesa milioane de date si se pot executa mii de tranzactii SQL intr-un timp scurt
-> poate rula pe orice platforma si sisteme de operare diferite: Windows / MacBook
*/

/*
Entity-Relationship Model
-> E-R model
-> este folosit sa dezvolte modelul conceptual al babei de date (ddiagrama)
-> entity - este orice lucru cere face obiectul modelarii bazei de date
-> relationship - legatura intre 2 entitati sau mai multe entitati
-> entity = table(baze de date)
-> diagrama conceptuala - se poate face in tool-uri de genu draw.io
*/

/*
Tables
-> stocheza datele in forma de linii si coloane
-> fiecare linie descrie o singura inregistrare (record) - o singura informatie despre acel obiect
*/

/*
Data Types
-> exista 3 categorii de data types folosite:
		- numeric: INTEGER, FLOAT(28,4), DOUBLE(30,2), DECIMAL()
			~ in paranteza sunt cate cifre vrei inainte de virgula si cate cifre vrei dupa virgula
            ~ suma din paranteza trebuie sa fie 32
            ~ daca am incerca sa inseram un numar care nu se potriveste tiparului din paranteza, 
              atunci baza de date ar da eroatre deoarece nu poate pastra toate cifrele numarului si nune lasa sa inseram
			~ INTEGER este cuprins in intervalul [-2^31; 2^31] ~ [-2147483648; 2147483647]
            ~ DECIMAL are suma din paranteza 65
		- string/text: CHAR(size); VARCHAR(size); TEXT
			~ size = numarul de caractere permise
            ~ CHAR indiferent de cate caractere dai el ocupa numarul maxim de caractere
            ~ VARCHAR este flexibil deoarece el ecupa exact cate caractere ai dat
		- date and time: DATE, DATETIME(6)
			~ DATE: YYYY-MM-DD
            ~ DATETIME: YYYY-MM-DD HH:MM:SS
            ~ range(limita) suportat: 1000-01-01 to 9999-12-31
            ~ 9999-12-31 data trecuta default ca si necunoscut, pana cand aflam data concreta si suprascriem cu ea
*/

/*
SQL
-> exista 4 categorii de comenzi in SQL:
		- DDL(data definition language): folosim ca sa definim obiecte (tabele, view-uri, stored procedures, functions etc)
			~ putem crea obiecte
            ~ alterare obiect (putem adauga coloane ulterior) - putem modifica obiectul dupa ce l-am creat -> ALTER
            ~ putem sterge obiecte din baza de date -> DROP
		- DML(data manipulaton language): folosim ca sa lucram cu date
			~ adaugare de date noi intr-un tabel -> INSERT
            ~ modificare de date care deja exista in tabel -> UPDATE
            ~ stergere de date -> DELETE(sa stergem o linie sau cateva linii); TRUNCATE(sa stergem toate liniile)
            ~ sa afisam datele -> SELECT
		-DCL(data control language): se foloseste pentru a da access (GRANT) sau a lua accesul pe o anumita baze de date (REVOKE)
        -TCL(transaction control language): se foloseste pentru lucrul cu tranzactii
			~ tranzactii -- commit(salvam ce am inserat)
						 -- rollback(inseamna ca aduce baza de date la versiunea dinaintea tranzactiei noastre)
*/

/*
Create Database Syntax

CREATE DATABASE db_name;
DROP DATABASE db_name;
SHOW DATABASES;
USE db_name;
*/

CREATE DATABASE modul_sql; 
USE modul_sql;

/*
CREATE TABLE table_name
(
column_name1 datatype(size) [attributes],
column_name2 datatype [attributes],
...
column_nameN datatype(size) [attributes]
);
*/

CREATE TABLE product 
(
productid int, 
name varchar(50), 
productnumber varchar(255), 
color varchar(20), 
listprice decimal(38,2), 
size varchar(6), 
productcategoryid int, 
modifieddate date
); 

/*
Keys & Relationships
-> relationship - legatura intre 2 sau mai multe tabele
-> primary key (pk) - este o coloana din tabele care trebuie sa indeplineasca 2 conditii:
			~ sa aiba valori unice pentru fiecre rand
            ~ valori non-nule pentru fiecare rand
-> foreign key (fk) - este o coloana din tabela prin care se face legatura cu o alta tabela
			~ fk-ul trebuie sa aiba aceleasi date care se regasesc si in pk-ul celeleltei tabele
-> tipuri de relatii intre tabele
		- One to one (1:1): un rand din tabelul A are corespondent un  singur rand din tabelul B 
        - One to many (1:M): un rand din tabelul A are mai multe randuri corespondente in tabelul B dar un rand din tabelul B are un singur corespondent in tabelul A 
        - Many to many (M:M): mai multe randuri din tabeleul A are mai multe randuri coresondente in tabelul B 
                              si mai multe randuri sin tabelul B are mai multe randuri corespondente in tabelul A 
*/

/*
CREATE TABLE table_name
(
column_name1 datatype(size) PRIMARY KEY,
column_name2 datatype,
...
column_nameN datatype
);

OR

CREATE TABLE table_name
(
column_name1 datatype(size) ,
column_name2 datatype,
...
column_nameN datatype
PRIMARY KEY(column_name1)
);
*/

CREATE TABLE product_category
(
productcategoryid int PRIMARY KEY, 
name varchar(50)
);

ALTER TABLE product 
ADD PRIMARY KEY(productid); 

ALTER TABLE product 
ADD FOREIGN KEY(productcategoryid) REFERENCES product_category(productcategoryid); 

/*
INSERT INTO table [(column1, column2, ..., columnN)]
VALUES (values1, values2, ..., valuesN);
*/
insert into product_category(productcategoryid, name)
values
(21, 'Belts'),
(14, 'Balls');
INSERT INTO product(productid, name, productnumber, color, listprice, size, productcategory, modifieddate)
VALUES
(1, 'Adjustable Belt', 'AB-100', 'Black', '782.99', '62cm', 21, '2024-04-13'),
(2, 'Bearing Ball', 'BB-200', 'Silver', '337.22', NULL, 14, '2024-04-13');

INSERT INTO product_category(productcategoryid, name)
VALUES 
(15, 'Toys'); 

ALTER TABLE product_category
ALTER name SET DEFAULT 'General';  

INSERT INTO product_category(productcategoryid)
VALUES (30); 

ALTER TABLE product 
MODIFY COLUMN name varchar(50) NOT NULL; 

INSERT INTO product(productid, name, productnumber, color, listprice, size, productcategory, modifieddate) 
VALUES 
(3, 'Dress', 'CD-100', 'Red', 58.99, 'EU36', 30, '2024-04-13');
/*
SHOW COLUMNS FROM table [LIKE 'table_pattern']
*/

SHOW COLUMNS FROM product; 
SHOW COLUMNS FROM product_category;
SHOW COLUMNS FROM product LIKE 'p%'; 

/*
ALTER TABLE table_name change1 [change2...]
*/

ALTER TABLE product_category ADD COLUMN details TEXT;
ALTER TABLE product_category MODIFY COLUMN details VARCHAR(20); 
ALTER TABLE product_category RENAME COLUMN details TO description; 
ALTER TABLE product_category DROP COLUMN description;
ALTER TABLE product_category DROP PRIMARY KEY; 
ALTER TABLE product DROP primary key; 
ALTER TABLE product ADD PRIMARY KEY(productid);

/*
DROP TABLE [IF EXISTS] table_name1 
*/

CREATE TABLE product_category_test 
(
productcategoryid int, 
name varchar(50)
);

DROP TABLE product_category_test;
DROP TABLE IF EXISTS product_category_test;

/*
DML - data manipulation language, folosim pentru lucru cu date 
-> INSERT pentru adaugare de date 
-> UPDATE pentru modificarea datelor existente
-> DELETE pentru stergere de linii de date (selectiv) 
-> TRUNCATE sterge toate liniile 
-> SELECT afisam datele 
*/

/*
SELECT syntax 

SELECT [DISTINCT] column1, column2, ..., columnN [LIMIT x]
FROM table_name 
[WHERE condition] 
[ORDER BY column1, column2, ...,columnN [ASC/DESC]-- asc by default daca nu punem optiune de ASC sau DESC] 
*/

USE modul_sql; 
SELECT * FROM product; 
-- * inseamna ca vrem sa returnam toate coloanele tabelei 

SELECT * FROM product ORDER BY name DESC; 


INSERT INTO product(productid, name, productnumber, color, listprice, size, productcategory, modifieddate) 
VALUES 
(5, 'Dress', 'MD-100', 'BLue', 75.99, 'EU36', 30, '2024-04-13'); 

SELECT * FROM product ORDER BY name, listprice DESC; 

INSERT INTO product_category(productcategoryid, name) 
VALUES (40,'Accesories'), (41,'Clothes'), (42,'Gifts'); 

SELECT * FROM product_category; 
SELECT * FROM product_category LIMIT 3; 

SELECT name FROM product_category; 

SELECT name AS product_category_name FROM product_category;

SELECT * FROM product;


INSERT INTO product(productid,name,productnumber,color,listprice,size,productcategory,modifieddate)
VALUES 
(6,'Dress','D-300','Green',50 , 'EUR36', 41, '2024-02-01'),
(7,'Skirt','S-400','Purple',20.99, 'S', 41, '2024-02-01'),
(8,'Jacket','J-500','Purple',200.56, 'M', 41, '2024-02-01'),
(9,'Shirt','S-500','Green',75.90, 'L', 41, '2024-02-01'),
(10,'Dress','D-700','Blue', 150 , 'EUR38', 41, '2024-02-01'),
(11,'Dress','D-800','Light Green', 50 , 'EUR36', 41, '2024-02-01');

SELECT * FROM product;

SELECT *, UPPER(name) as product_name FROM product WHERE UPPER(name) = 'DRESS'; 

SELECT * FROM product WHERE name = 'Dress' AND color LIKE '%Green%';

SELECT * FROM product WHERE listprice BETWEEN 35.99 AND 200.00;
SELECT * FROM product WHERE listprice >= 35.99 AND listprice <=200.00;
SELECT * FROM product WHERE name IN ('Dress','Jacket');

/*
UPDATE command syntax

UPDATE table_name
SET column1 = value1, column2 = value2, columnN = valueN
[WHERE condition];
*/
USE modul_sql;
SELECT * FROM product WHERE name = 'Bearing Ball';
UPDATE product SET listprice = 250.99 WHERE product_id = 4;
SET SQL_SAFE_UPDATES = 0;

/*
DELETE FROM table_name -- daca scriem asa va sterge toate liniile din tabel pentru ca nu stie pe care linie sa se pozitioneze
[WHERE condition]; -- daca adaugam where va sterge doar liniile care indeplinesc conditia
*/

USE modul_sql; 
SELECT * FROM product; 

SET SQL_SAFE_UPDATES = 0; 
DELETE FROM product WHERE name IN ('Skirt','Shirt');  -- WHERE name LIKE '%Skirt%' OR name LIKE '%Shirt%' / WHERE name ='Skirt' OR name = 'Shirt'

/*
TRUNCATE TABLE table_name; -- va sterge toate liniile din tabel
-> este similar cu DELETE, insa nu putem folosi WHERE
-> este mai rapid decat DELETE
*/

USE modul_sql;

CREATE TABLE cnp
(
cnp VARCHAR(30) PRIMARY KEY,
expiration_date TIMESTAMP
);

CREATE TABLE clients
(
client_id VARCHAR(30) PRIMARY KEY,
name VARCHAR(30) NOT NULL,
surname VARCHAR(30),
address TEXT, 
city VARCHAR(30) DEFAULT 'Cluj', 
FOREIGN KEY(client_id) REFERENCES cnp(cnp) ON DELETE CASCADE
);

INSERT INTO cnp  VALUES
('1990101234567', '2025-01-23'),
('2990101234569', '2028-08-23'),
('2980101234569', '2024-01-23'),
('1990101234569', '2026-08-23'),
('2890101234569', '2023-08-23'),
('1990101234000', '2026-08-23'),
('2890101234000', '2023-08-23'),
('1910101234569', '2023-08-23');

INSERT INTO clients VALUES
('2990101234569', 'Andra', 'Pop', 'Aviatorilor', 'Bucuresti');

INSERT INTO clients (client_id, name, surname, address) VALUES
('1990101234567', 'Andrei', 'Popescu', 'Primaverii');

INSERT INTO clients VALUES
('2980101234569', 'Mirela', 'Ion', 'Berceni', 'Bucuresti'),
('1990101234569', 'Mirel', 'Manole', 'Titan', 'Bucuresti'),
('1910101234569', 'Mirel', 'Man', 'Titan', 'Bucuresti'),
('2890101234569', 'Mariana', 'Popa', 'Militari', 'Bucuresti');

SELECT clients.name, clients.surname, cnp.cnp, cnp.expiration_date
FROM cnp
INNER JOIN clients ON cnp.cnp = clients.client_id
WHERE YEAR(cnp.expiration_date) = 2023;


SELECT clients.name, clients.surname, cnp.cnp, cnp.expiration_date
FROM cnp
LEFT JOIN clients ON cnp.cnp = clients.client_id
WHERE YEAR(cnp.expiration_date) = 2023;


SELECT clients.name, clients.surname, cnp.cnp, cnp.expiration_date
FROM clients
RIGHT JOIN cnp ON cnp.cnp = clients.client_id
WHERE YEAR(cnp.expiration_date) = 2023;


SELECT * FROM clients
LEFT JOIN cnp ON clients.client_id = cnp.cnp
UNION ALL
SELECT * FROM clients
RIGHT JOIN cnp ON clients.client_id = cnp.cnp
WHERE YEAR(cnp.expiration_date) = 2023;

USE modul_sql;
SELECT COUNT(*) FROM product;
SELECT COUNT(productid) FROM product;

SELECT COUNT(*) AS 'Numbers of products' FROM product;
SELECT COUNT(*) AS 'Numbers of Dress products' FROM product WHERE name = 'Dress';

SELECT MIN(listprice) AS 'Minimum value product' FROM product;

SELECT MAX(listprice) AS 'Miximum value product' FROM product;

SELECT CAST(AVG(listprice) AS DECIMAL(38,2)) AS 'Avrage value product' FROM product;
SELECT AVG(listprice) AS 'Avrage value of Dress product' FROM product WHERE name = 'Dress';

SELECT SUM(listprice) AS 'Total value of Dress''s product' FROM product WHERE name = 'Dress';
SELECT SUM(listprice) AS 'Total value of Dress''s product',
COUNT(*) AS 'Numbers of Dress''s', 
MIN(listprice) AS 'Minimum value of Dress', 
MAX(listprice) AS 'Miximum value of Dress' FROM product WHERE name = 'Dress';
USE modul_sql;
SELECT COUNT(*) FROM product GROUP BY productcategory;
SELECT COUNT(*), productcategory FROM product GROUP BY productcategory;

SELECT MIN(listprice), MAX(listprice), COUNT(*), productcategory FROM product GROUP BY productcategory;
SELECT MIN(listprice), MAX(listprice), COUNT(*), productcategory FROM product GROUP BY productcategory HAVING MIN(listprice)>=50;

SELECT COUNT(*) AS 'Numbers of products', productcategory FROM product GROUP BY productcategory HAVING COUNT(*)>2;

USE modul_sql;
SELECT * FROM product_category;

START TRANSACTION;
UPDATE product_category SET name = 'General_Transaction' WHERE productcategoryid = 30;
COMMIT;

SELECT * FROM product_category;

SET SQL_SAFE_UPDATES = OFF;
START TRANSACTION;
UPDATE cnp SET expiration_date = NOW() WHERE cnp LIKE '%569';
UPDATE cnp SET expiration_date = NOW() WHERE cnp LIKE '%567';
ROLLBACK;

SELECT * FROM cnp;

USE shop;

CREATE VIEW order_total
AS
(
SELECT order_rows.order_id, SUM(order_rows.product_quantity * products.product_price) AS order_total
FROM products 
INNER JOIN order_rows ON products.product_id = order_rows.order_id
GROUP BY order_rows.order_id
);

CREATE TEMPORARY TABLE temp_order_total
AS
(
SELECT order_rows.order_id, SUM(order_rows.product_quantity * products.product_price) AS order_total
FROM products 
INNER JOIN order_rows ON products.product_id = order_rows.order_id
GROUP BY order_rows.order_id
);
SELECT * FROM temp_order_total;

USE modul_sql;
DELIMITER //
CREATE TRIGGER address_validator
BEFORE INSERT ON clients FOR EACH ROW
BEGIN 
if NEW.address IS NULL THEN SET NEW.address = 'unknown';
END if;
END //

DELIMITER ;

INSERT INTO cnp(cnp, expiration_date) VALUES ('1999191234511', NOW());
INSERT INTO clients(client_id, name, surname, city) VALUES ('1999191234511', 'Dan', 'Popescu', 'Bucuresti');

USE modul_sql;
DELIMITER //
CREATE PROCEDURE update_product_category(IN id INT, IN category_name VARCHAR(50))
BEGIN 
UPDATE product_category
SET name = category_name
WHERE productcategoryid = id;
END //

DELIMITER ;

CALL update_product_category(14, 'Test');

USE modul_sql;
INSERT INTO cnp  VALUES
('1990101234511', '2022-01-23'),
('2990101234511', '2021-08-23');

DELIMITER //
CREATE FUNCTION func_expired_cnp(param_cnp TEXT)
RETURNS VARCHAR(10)
READS SQL DATA
deterministic
BEGIN 
DECLARE result VARCHAR(10);
DECLARE extrated_expiration_date TIMESTAMP;
SET extrated_expiration_date = (SELECT expiration_date FROM cnp WHERE cnp = param_cnp);
IF extrated_expiration_date < CURRENT_DATE THEN
SET result = 'Expirat';
ELSE
SET result = 'Valid';
END IF;
RETURN(result);
END //

DELIMITER ;

SELECT func_expired_cnp('1990101234511');
SELECT func_expired_cnp('1990101234000');
