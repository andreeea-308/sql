CREATE DATABASE shop;
USE shop;
CREATE TABLE products
(
product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
brand VARCHAR(50),
name VARCHAR(30),
price DECIMAL(40,2),
stock INTEGER
);

CREATE TABLE orders
(
order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_rows
(
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    product_quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SHOW COLUMNS FROM products;
SHOW COLUMNS FROM orders;
SHOW COLUMNS FROM order_rows;

ALTER TABLE orders ADD COLUMN order_total FLOAT(30,2) DEFAULT 0.00;
ALTER TABLE products RENAME COLUMN name TO product_name; 
ALTER TABLE products DROP COLUMN brand;
ALTER TABLE products ADD COLUMN product_brand VARCHAR(30) DEFAULT 'my_brand';
ALTER TABLE products MODIFY COLUMN product_brand TEXT;

INSERT INTO products (product_brand, product_name, price, stock) 
VALUES ('Nestle', 'ciocolata', 10.25, 200);

INSERT INTO products (product_name, price, stock) 
VALUES ('pix', 5.25, 500);

INSERT INTO products (product_brand, product_name, price, stock) 
VALUES ('Pantene', 'sampon', 20.5, 100);

INSERT INTO orders (order_date) 
VALUES ('2023-01-23');

INSERT INTO orders (order_date) 
VALUES ('2023-01-25');

INSERT INTO orders (order_date) 
VALUES ('2023-01-29');

INSERT INTO order_rows (order_id, product_id, product_quantity) 
VALUES (1,1,20);

INSERT INTO order_rows (order_id, product_id, product_quantity) 
VALUES (1,1,50);

INSERT INTO order_rows (order_id, product_id, product_quantity) 
VALUES (2,2,20);

USE shop;

INSERT INTO products (product_brand, product_name, price, stock) VALUES ('Pantene2', 'sampon', 20.5, 100);
INSERT INTO orders (order_date) VALUES ('2023-02-23');
INSERT INTO orders (order_date) VALUES ('2026-02-25');
INSERT INTO orders (order_date) VALUES ('2026-07-29');

SELECT * FROM products ORDER BY stock ASC;
SELECT * FROM orders LIMIT 4;
SELECT * FROM products WHERE stock BETWEEN 200 AND 300;
SELECT * FROM products WHERE product_brand LIKE 'Pantene%';

SET SQL_SAFE_UPDATES = 0;
UPDATE products SET product_brand = 'Unknown' WHERE product_id = 3;
UPDATE products SET product_brand = 'Unknown' WHERE product_id = 4;

UPDATE products SET price = 1.20*10.25 WHERE product_id = 1;

INSERT INTO products (product_brand, product_name, price, stock) VALUES ('Pantene', 'sampon', 20.5, 100);
INSERT INTO products (product_brand, product_name, price, stock) VALUES ('Pantene', 'sampon', 26, 400);
INSERT INTO products (product_brand, product_name, price, stock) VALUES ('Pantene Subsidiary 1', 'sampon', 26, 400);
INSERT INTO products (product_brand, product_name, price, stock) VALUES ('Pantene Subsidiary 2', 'sampon', 26, 400);

DELETE FROM products WHERE product_brand LIKE 'Pantene%';
SELECT * FROM products;

USE shop;

DROP TABLE order_rows;
DROP TABLE products;
DROP TABLE orders;

CREATE TABLE products
(
    product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    product_brand VARCHAR(30),
		product_name VARCHAR(30),
		product_price FLOAT NOT NULL,
		product_stock INTEGER
);

CREATE TABLE orders
(
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_rows
(
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    product_quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

INSERT INTO products (product_brand, product_name, product_price, product_stock) VALUES
('Pantene', 'sampon', 20.5, 100),
('Nestle', 'ciocolata milka', 10.25, 200),
('Nestle', 'ciocolata godiva', 10.25, 300);
INSERT INTO products (product_name, product_price, product_stock) VALUES
('pix albastru', 5.25, 500),
('pix rosu', 10.25, 1000);

INSERT INTO orders (order_date) VALUES
('2023-01-23'),
('2023-01-25'),
('2023-01-29');

INSERT INTO order_rows (order_id, product_id, product_quantity) VALUES
(1,2,20),
(1,4,20),
(1,3,50),
(2,5,20),
(2,4,20),
(2,1,20),
(2,4,20),
(2,5,20);

SELECT *
FROM order_rows
INNER JOIN products ON products.product_id = order_rows.product_id
WHERE order_rows.order_id = 1;

SELECT *
FROM order_rows
INNER JOIN products ON products.product_id = order_rows.product_id;

SELECT *
FROM products
LEFT JOIN order_rows ON products.product_id = order_rows.product_id;

SELECT *
FROM products
LEFT JOIN order_rows ON products.product_id = order_rows.product_id
UNION ALL
SELECT *
FROM products
RIGHT JOIN order_rows ON products.product_id = order_rows.product_id;

USE shop;
SELECT COUNT(*) FROM order_rows WHERE order_id = 2;
SELECT order_id, COUNT(*) AS 'number of rows' FROM order_rows GROUP BY order_id;
SELECT product_brand, AVG(product_stock) AS 'stock_mediu' FROM products GROUP BY product_brand;

SELECT products.product_id, products.product_name, COUNT(order_rows.order_id) AS 'number of orders'
FROM products 
JOIN order_rows ON products.product_id = order_rows.product_id
GROUP BY products.product_id, products.product_name;

SELECT orders.order_id, SUM(order_rows.product_quantity * products.product_price) AS 'order_total'
FROM orders
JOIN order_rows ON orders.order_id = order_rows.order_id
JOIN products ON order_rows.product_id = products.product_id
GROUP BY orders.order_id;

SELECT orders.order_id, SUM(order_rows.product_quantity * products.product_price) AS 'order_total'
FROM orders
JOIN order_rows  ON orders.order_id = order_rows.order_id
JOIN products ON order_rows.product_id = products.product_id
GROUP BY orders.order_id
HAVING order_total > 1000;


USE shop;
DELIMITER //
CREATE TRIGGER brand_validator
BEFORE INSERT ON products FOR EACH ROW
BEGIN 
if NEW.product_brand IS NULL THEN SET NEW.product_brand = 'unknown';
END if;
END //

DELIMITER ;
INSERT INTO products(product_id, product_name, product_price, product_stock) VALUES (6, 'Bike', 278.99, 300);

USE shop;
DELIMITER //
CREATE PROCEDURE get_most_popular_product(IN id INT)
BEGIN 
SELECT order_id, product_id, SUM(product_quantity) AS cantitate_totala 
FROM order_rows 
WHERE order_id = id 
GROUP BY order_id, product_id 
ORDER BY cantitate_totala DESC; 
END //

DELIMITER ;
USE shop;
CALL get_most_popular_product(2);