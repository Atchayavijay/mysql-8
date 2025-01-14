CREATE database Ecomm;
USE Ecomm;

--create cutomers table--

CREATE TABLE customers 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    customers_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address TEXT NOT NULL
);

INSERT INTO customers (customers_name, email, address)
VALUES
('John Doe', 'john.doe@example.com', '123 Main St'),
('Jane Smith', 'jane.smith@example.com', '456 Oak St'),
('Alice Johnson', 'alice.johnson@example.com', '789 Pine St'),
('Bob Williams', 'bob.williams@example.com', '101 Elm St'),
('Chris Evans', 'chris.evans@example.com', '202 Maple St'),
('Diana Prince', 'diana.prince@example.com', '303 Birch St'),
('Ethan Hunt', 'ethan.hunt@example.com', '404 Cedar St'),
('Fiona Gallagher', 'fiona.gallagher@example.com', '505 Spruce St'),
('George Lucas', 'george.lucas@example.com', '606 Walnut St'),
('Hannah Baker', 'hannah.baker@example.com', '707 Chestnut St');

----create orders table----

CREATE TABLE orders 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
select *from orders;

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
(1, '2024-08-15', 100.00),
(2, '2024-09-01', 150.00),
(3, '2024-08-25', 200.00),
(4, '2024-09-03', 250.00),
(5, '2024-08-29', 300.00),
(6, '2024-08-20', 350.00),
(7, '2024-09-05', 400.00),
(8, '2024-08-15', 450.00),
(9, '2024-09-07', 500.00),
(10, '2024-08-22', 550.00);

---create products table---

Create TABLE products 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT NOT NULL
);
INSERT INTO products (name, price, description)
VALUES
('Product A', 25.00, 'Description for Product A'),
('Product B', 30.00, 'Description for Product B'),
('Product C', 40.00, 'Description for Product C'),
('Product D', 50.00, 'Description for Product D'),
('Product E', 60.00, 'Description for Product E'),
('Product F', 20.00, 'Description for Product F'),
('Product G', 45.00, 'Description for Product G'),
('Product H', 35.00, 'Description for Product H'),
('Product I', 55.00, 'Description for Product I'),
('Product J', 65.00, 'Description for Product J');


---Retrieve customers who placed orders in the last 30 days---

SELECT DISTINCT customers.customers_name
FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

---Get the total amount of all orders placed by each customer--

SELECT customers.customers_name, SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.customers_name;

---Update the price of Product C to 45.00---

UPDATE products
SET price = 45.00
WHERE id = 3 ;

SELECT * FROM products WHERE id = 3;

---Add a new column discount to the products table---

ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;

SELECT * FROM products;

---Retrieve the top 3 products with the highest price---

SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3; 

----create order_items table----

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 3),
(3, 5, 2),
(3, 6, 1),
(4, 1, 3),
(4, 7, 2),
(5, 8, 1),
(5, 2, 1);


SELECT * FROM ecomm.order_items;


---Get the names of customers who have ordered Product A---

SELECT DISTINCT customers.customers_name
FROM customers                                                                           
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE products.name = 'Product A';

---Join the orders and customers tables to retrieve the customers name and order date for each order---

SELECT customers.customers_name, orders.order_date
FROM customers
JOIN orders ON customers.id = orders.customer_id;

---Retrieve the orders with a total amount greater than 150.00---

SELECT id, total_amount
FROM orders
WHERE total_amount > 150.00;

---Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table---

SELECT * FROM Ecomm.order_items;

---Retrieve the average total of all orders---

SELECT AVG(total_amount) AS average_order_amount
FROM orders;