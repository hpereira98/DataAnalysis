USE sa_northwind;

INSERT INTO sa_client(company, full_name,  country, city, id_client)
SELECT company, (concat(first_name, ' ', last_name)), country_region, city, id
FROM northwind.customers;

SELECT * from sa_client;

INSERT INTO sa_employee(company, full_name, id_employee)
SELECT company, (concat(first_name, ' ', last_name)), id
FROM northwind.employees;

SELECT * FROM sa_employee;

INSERT INTO sa_product(name, code, category, quantity_per_unit, standard_cost, list_price, id_product)
SELECT product_name, product_code, category, coalesce(quantity_per_unit, 'Unknown'), standard_cost, list_price, id
FROM northwind.products;

SELECT * FROM sa_product;

INSERT INTO sa_purchase(quantity, total_cost, id_supplier, id_product, submitted_date, id_purchase)
SELECT pod.quantity, pod.quantity*pod.unit_cost, po.supplier_id, pod.product_id, po.submitted_date, po.id
FROM northwind.purchase_orders po, northwind.purchase_order_details pod
WHERE po.id = pod.purchase_order_id;

SELECT * FROM sa_purchase;

INSERT INTO sa_sale(quantity, total_cost, discount, id_product, id_client, id_shipper, id_employee, order_date, id_sale)
SELECT od.quantity, od.quantity * od.unit_price, od.discount, od.product_id, o.customer_id, coalesce(o.shipper_id, 0), o.employee_id, o.order_date, o.id
FROM northwind.orders o, northwind.order_details od
WHERE o.id = od.order_id;

SELECT * FROM sa_sale;

INSERT INTO sa_shipper(company, country, city, id_shipper)
SELECT company, country_region, city, id
FROM northwind.shippers;

SELECT * FROM sa_shipper;

INSERT INTO sa_supplier(company, country, city, id_supplier)
SELECT company, coalesce(country_region, 'Unknown'), coalesce(city, 'Unknown'), id
FROM northwind.suppliers;

SELECT * FROM sa_supplier;
