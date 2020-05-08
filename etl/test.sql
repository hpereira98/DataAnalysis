USE northwind;

INSERT INTO customers(id, company, last_name, first_name, city, country_region)
VALUES(30, 'MiEI', 'Pereira', 'Henrique', 'Braga', 'PT');

UPDATE suppliers
SET	company = 'EC',
	last_name = 'Silva',
    first_name = 'Sarah'
WHERE id = 4;

INSERT INTO purchase_orders(id, supplier_id, submitted_date)
VALUES(150, 4, NOW());

INSERT INTO purchase_order_details(id, purchase_order_id, product_id, quantity, unit_cost)
VALUES(300, 150, 1, 10, 2);