CREATE DATABASE RetailSalesDB;
GO

USE RetailSalesDB;
GO

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_name, city) VALUES
('Captain', 'Dubai'),
('Prabakaran', 'Chennai'),
('Rishi', 'Coimbatore'),
('Naveen', 'Armenia');

INSERT INTO Products (product_name, category, price) VALUES
('Laptop', 'Electronics', 50000),
('Phone', 'Electronics', 20000),
('Shoes', 'Fashion', 3000),
('Watch', 'Accessories', 4000);

INSERT INTO Orders (customer_id, product_id, order_date, quantity) VALUES
(1, 1, '2024-01-01', 1),
(2, 3, '2024-01-03', 2),
(3, 2, '2024-01-05', 1),
(4, 4, '2024-01-07', 3),
(1, 2, '2024-01-10', 1);

SELECT SUM(p.price * o.quantity) AS Total_Revenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id;

SELECT p.category,
       SUM(p.price * o.quantity) AS Revenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.category;

SELECT c.customer_name,
       SUM(p.price * o.quantity) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY Total_Spent DESC;

SELECT MONTH(order_date) AS Month,
       SUM(p.price * o.quantity) AS Monthly_Revenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY MONTH(order_date);

