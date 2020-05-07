USE dw_northwind;

INSERT INTO local_dim(country, city)
SELECT country, city FROM sa_northwind.sa_supplier
UNION DISTINCT SELECT country, city FROM sa_northwind.sa_client
UNION DISTINCT SELECT country, city FROM sa_northwind.sa_shipper;

SELECT * FROM local_dim;

INSERT INTO time_dim(full_date, day, month, year, week_day)
SELECT submitted_date, DAY(submitted_date), MONTH(submitted_date), YEAR(submitted_date), WEEKDAY(submitted_date) FROM sa_northwind.sa_purchase
UNION DISTINCT SELECT order_date, DAY(order_date), MONTH(order_date), YEAR(order_date), WEEKDAY(order_date) FROM sa_northwind.sa_sale;

SELECT * FROM time_dim;

INSERT INTO client_dim(company, full_name, key_local, id_client)
SELECT c.company, c.full_name, l.key_local, c.id_client
FROM sa_northwind.sa_client c, local_dim l
WHERE l.country = c.country AND l.city = c.city;

SELECT * FROM client_dim;

INSERT INTO employee_dim(id_employee, company, full_name)
SELECT * FROM sa_northwind.sa_employee;

SELECT * FROM employee_dim;

INSERT INTO product_dim(id_product, name, code, category, quantity_per_unit, standard_cost, list_price)
SELECT * FROM sa_northwind.sa_product;

SELECT * FROM product_dim;

INSERT INTO shipper_dim(company, key_local, id_shipper)
VALUES ('Unknown', 1, 0);

INSERT INTO shipper_dim(company, key_local, id_shipper)
SELECT s.company, l.key_local, s.id_shipper
FROM sa_northwind.sa_shipper s, local_dim l
WHERE s.city = l.city AND s.country = l.country;

SELECT * FROM shipper_dim;

INSERT INTO supplier_dim(company, key_local, id_supplier)
SELECT s.company, l.key_local, s.id_supplier
FROM sa_northwind.sa_supplier s, local_dim l
WHERE s.city = l.city AND s.country = l.country;

SELECT * FROM supplier_dim;

INSERT INTO purchase_fact(quantity, total_cost, key_supplier, key_product, key_time, id_purchase, id_purchase_details)
SELECT p.quantity, p.total_cost, sd.key_supplier, pd.key_product, td.key_time, p.id_purchase, p.id_purchase_details
FROM sa_northwind.sa_purchase p, supplier_dim sd, product_dim pd, time_dim td
WHERE p.id_supplier = sd.id_supplier AND p.id_product = pd.id_product AND p.submitted_date = td.full_date;

SELECT * FROM purchase_fact;

INSERT INTO sale_fact(quantity, total_cost, discount, key_product, key_time, key_client, key_shipper, key_employee, id_sale, id_sale_details)
SELECT s.quantity, s.total_cost, s.discount, pd.key_product, td.key_time, cd.key_client, sd.key_shipper, ed.key_employee, s.id_sale, s.id_sale_details
FROM sa_northwind.sa_sale s, product_dim pd, time_dim td, client_dim cd, shipper_dim sd, employee_dim ed
WHERE s.id_product = pd.id_product AND s.order_date = td.full_date AND s.id_client = cd.id_client AND s.id_shipper = sd.id_shipper AND s.id_employee = ed.id_employee;

SELECT * FROM sale_fact;
