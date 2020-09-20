CREATE SCHEMA test;

-- Removed Price from the items table and moved it into the store_item_settings table

CREATE TABLE test.items(
id SERIAL NOT NULL CONSTRAINT items_pkey PRIMARY KEY,
upc INTEGER,  
name TEXT,  
size TEXT,  
taxable BOOLEAN,  
sold_by TEXT);

CREATE UNIQUE INDEX items_id_uindex  ON test.items (id);

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (4, 30273, 'Apple', 'per lb', false, 'weight');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (1, 4738561, 'Milk', '1 gallon', false, 'count');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (2, 8897585, 'Bread', '1 loaf', false, 'count');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (5, 3342, 'Banana', '1 each', false, 'count');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (6, 908345, 'Cashews', '16 oz', false, 'count');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (3, 908347, 'Yogurt', '1 container', true, 'count');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (7, 30273, 'Apple', 'per lb', false, 'weight');

INSERT INTO test.items (id, upc, name, size, taxable, sold_by)  VALUES (8, 3342, 'Banana', 'per lb', true, 'weight');

-- Created stores table for each individual store ids and names

CREATE TABLE test.stores
(id SERIAL NOT NULL CONSTRAINT stores_pkey PRIMARY KEY,
 name TEXT
);

INSERT INTO test.stores
(name) VALUES('publix');

INSERT INTO test.stores
(name) VALUES('target');

INSERT INTO test.stores
(name) VALUES('meijer');


-- Created store_item_settings  to hold variations in item prices

CREATE TABLE test.store_item_settings(
id SERIAL NOT NULL CONSTRAINT store_item_settings_pkey PRIMARY KEY,
item_id INT,
store_id INT CONSTRAINT orders_store_id_fk REFERENCES test.stores,
price DOUBLE PRECISION,
availability BOOLEAN,
CONSTRAINT fk_item
	FOREIGN KEY(item_id)
		REFERENCES test.items(id)
);

CREATE UNIQUE INDEX store_item_settings_id_uindex ON test.store_item_settings (id);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(1, 1, 0.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(1, 2, 1.19, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(1, 3, 1.19, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(2, 1, 5.99, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(2, 2, 5.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(2, 3, 4.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(3, 1, 2.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(3, 2, 2.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(3, 3, 2.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(4, 1, 0.17, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(4, 2, 0.29, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(4, 3, 0.35, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(5, 1, 0.67, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(5, 2, 0.67, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(5, 3, 0.67, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(6, 1, 7.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(6, 2, 100.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(6, 3, 7.99, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(7, 1, 3.59, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(7, 2, 3.59, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(7, 3, 3.59, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(8, 1, 2.29, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(8, 2, 2.29, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(8, 3, 2.29, true);

-- added the store_id to the orders table so that we can now the price on the store_items_settings

CREATE TABLE test.orders
(id SERIAL NOT NULL CONSTRAINT orders_pkey PRIMARY KEY,
order_id INTEGER,  
customer_id INTEGER,
store_id INTEGER CONSTRAINT orders_store_id_fk REFERENCES test.stores,
item_id INTEGER CONSTRAINT orders_items_id_fk REFERENCES test.items,
name TEXT,
phone TEXT,
address TEXT,
delivered BOOLEAN,
quantity DOUBLE PRECISION);
CREATE UNIQUE INDEX orders_id_uindex  ON test.orders (id);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (3, 23, 3456, 1, 1, 'Bob', null, null, false, 2);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (4, 23, 3456, 1,  2, 'Bob', null, null, false, 1);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (5, 23, 3456, 1,  3, 'Bob', null, null, false, 6);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (6, 23, 3456, 1,  5, 'Bob', null, null, false, 3);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (7, 89, 2239, 2,  4, 'Alice', null, null, false, 2);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (8, 89, 2239, 2,  6, 'Alice', null, null, false, 1);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (9, 65, 2239,  2, 1, 'Alice', null, null, true, 1);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (10, 65, 2239, 2, 3, 'Alice', null, null, true, 4);

INSERT INTO test.orders (id, order_id, customer_id, store_id, item_id, name,  phone, address, delivered, quantity)  VALUES (11, 65, 2239, 2, 2, 'Alice', null, null, true, 1);



CREATE TABLE test.store_item_settings(
id SERIAL NOT NULL CONSTRAINT store_item_settings_pkey PRIMARY KEY,
item_id INT,
store_id INT CONSTRAINT orders_store_id_fk REFERENCES test.stores,
price DOUBLE PRECISION,
availability BOOLEAN,
CONSTRAINT fk_item
	FOREIGN KEY(item_id)
		REFERENCES test.items(id)
);

CREATE UNIQUE INDEX store_item_settings_id_uindex ON test.store_item_settings (id);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(1, 1, 0.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(1, 2, 1.19, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(1, 3, 1.19, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(2, 1, 5.99, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(2, 2, 5.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(2, 3, 4.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(3, 1, 2.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(3, 2, 2.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(3, 3, 2.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(4, 1, 0.17, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(4, 2, 0.29, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(4, 3, 0.35, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(5, 1, 0.67, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(5, 2, 0.67, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(5, 3, 0.67, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(6, 1, 7.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(6, 2, 100.99, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(6, 3, 7.99, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(7, 1, 3.59, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(7, 2, 3.59, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(7, 3, 3.59, false);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(8, 1, 2.29, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(8, 2, 2.29, true);

INSERT INTO test.store_item_settings
(item_id, store_id, price, availability) 
VALUES(8, 3, 2.29, true);


