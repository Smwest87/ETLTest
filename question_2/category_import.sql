CREATE TABLE test.imported_products
(product_id INTEGER NOT NULL CONSTRAINT products_pkey PRIMARY KEY,
upc INTEGER,
name TEXT,
size TEXT,
category TEXT);


INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (4, 30273, 'Apple', 'per lb', '2_PRODUCE_FRUITS');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (1, 4738561, '2% Milk', '1 gallon', '54_DAIRY_MILK');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (2, 8897585, 'Skim Milk', '1 gallon', '55_DAIRY_LOWFATMILK');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (5, 3342, 'Banana', '1 each', '2_PRODUCE_FRUITS');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (6, 908345, 'Organic Peas', '1 head', '4_PRODUCE_ORG_VEGETABLES');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (3, 908347, 'Yogurt', '1 container', '52_DAIRY_YOGURT');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (7, 30273, 'Oranges', 'per lb', '3_PRODUCE_VEGETABLES');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (8, 3342, 'Potatoes', 'per lb', '3_PRODUCE_VEGETABLES');

INSERT INTO test.imported_products (product_id, upc, name, size, category)  VALUES (9, 30275, 'Organic Apple', 'per lb', '2_PRODUCE_ORG_FRUITS');



CREATE TABLE test.category_map(
id INTEGER NOT NULL CONSTRAINT category_pkey PRIMARY KEY,
category_key TEXT,
category_name TEXT,
parent_category_id INTEGER);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (600, '1_PRODUCE', 'Produce', null);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (604, '2_PRODUCE_FRUITS', 'Produce/Fruits', 600);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (608, '3_PRODUCE_VEGETABLES', 'Produce/Vegetables', 600);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (606, '4_PRODUCE_ORG_VEGETABLES', 'Produce/Vegetables', 600);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (800, '50_DAIRY', 'Dairy', null);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (803, '52_DAIRY_YOGURT', 'Dairy/Yogurt', 800);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (801, '54_DAIRY_MILK', 'Dairy/Milk', 800);

INSERT INTO test.category_map (id, category_key, category_name, parent_category_id)  VALUES (802, '55_DAIRY_LOWFATMILK', 'Dairy/Milk', 800);


CREATE TABLE test.product_categorizations(
id INTEGER NOT NULL CONSTRAINT categorizations_pkey PRIMARY KEY,
product_id INTEGER NOT NULL,
category_id INTEGER NOT NULL);