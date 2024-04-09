use [Customers_Orders_Products ];
/*
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(50),
  Email VARCHAR(100)
);

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);

*/

/* Task 1 */

/* 1. Write a query to retrieve all records from the Customers table..*/

select * from Customers;

/* 2. Write a query to retrieve the names and email addresses of customers whose names start with 'J'. */

select Name, Email from Customers where Name like 'J%'

/* 3. Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders.. */

select OrderID, ProductName, Quantity from Orders;

/* 4. Write a query to calculate the total quantity of products ordered. */

select sum(Quantity) 'Total Quantity of Products Ordered' from Orders;

/* 5. Write a query to retrieve the names of customers who have placed an order. */

select Name from Customers c inner join Orders o on c.CustomerID = o.CustomerID;

/* 6. Write a query to retrieve the products with a price greater than $10.00. */

select * from Products where Price > 10.00;

/* 7. Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'. */

select c.Name, o.OrderDate from Customers c inner join Orders o on c.CustomerID = o.CustomerID where o.OrderDate >= '2023-07-05';

/* 8. Write a query to calculate the average price of all products. */

select avg(Price) 'Average Price of All Products' from Products;

/* 9. Write a query to retrieve the customer names along with the total quantity of products they have ordered */

select c.Name, sum(Quantity) 'Total Quantity of Products Ordered' from Customers c inner join Orders o on c.CustomerID = o.CustomerID
group by c.Name;

/* 10. Write a query to retrieve the products that have not been ordered. */

select ProductName from Products where ProductName not in (select ProductName from Orders);


/* Task 2 */

/* 1. Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders. */

select top 5 c.Name, sum(o.Quantity) 'Total Quantity' from Customers c inner join Orders o on c.CustomerID = o.CustomerID
group by c.Name order by sum(o.Quantity) desc;

/* 2. Write a query to calculate the average price of products for each product category. */

select ProductName, avg(Price) 'Average Price for each Product Category' from Products group by ProductName;

/* 3. Write a query to retrieve the customers who have not placed any orders. */

select Name from Customers where CustomerID not in (select CustomerID from orders); 

/* 4. Write a query to retrieve the order details (OrderID, ProductName, Quantity) for orders placed by customers whose names start with 'M'. */

select o.OrderID, o.ProductName, o.Quantity from Orders o inner join Customers c on c.CustomerID = o.CustomerID
where c.Name like 'M%'

/*  5. Write a query to calculate the total revenue generated from all orders. */

select sum(o.Quantity * p.Price) 'Total Revenue' from Orders o inner join Products p on o.ProductName = p.ProductName;

/* 6. Write a query to retrieve the customer names along with the total revenue generated from their orders. */

select c.Name, sum(o.Quantity * p.Price) 'Total Revenue' from Customers c inner join Orders o on c.CustomerID = o.CustomerID 
inner join Products p on o.ProductName = p.ProductName group by c.Name;

/* 7. Write a query to retrieve the customers who have placed at least one order for each product category. */

select c.Name from Customers c join Orders o on c.CustomerID = o.CustomerID join Products p on o.ProductName = p.ProductName
group by c.Name having count(distinct(p.ProductName)) = (select count(distinct ProductName) from Products);

/* 8. Write a query to retrieve the customers who have placed orders on consecutive days. */

select distinct c.Name from Customers c join Orders o1 on c.CustomerID = o1.CustomerID
join Orders o2 on c.CustomerID = o2.CustomerID
where DATEDIFF(DAY, o1.OrderDate, o2.OrderDate) = 1

/* 9. Write a query to retrieve the top 3 products with the highest average quantity ordered */

select top 3 ProductName, avg(Quantity) 'Average Quantity Ordered' from Orders group by ProductName order by ProductName desc;

/* 10. Write a query to calculate the percentage of orders that have a quantity greater than the average quantity. */

select 
    (count(case when o.Quantity > avg_quantity then 1 end) * 100.0) / count(*) as percentage_above_average
from 
    Orders o
cross join
    (select avg(quantity) as avg_quantity from Orders) AS avg_table;


/* Task 3 */

/* 1. Write a query to retrieve the customers who have placed orders for all products. */

select c.Name
from Customers c
where (
    select count(distinct ProductName)
    from Orders o
    where o.CustomerID = c.CustomerID
) = (
    select count(distinct ProductName)
    from Products
);

/*  2. Write a query to retrieve the products that have been ordered by all customers. */


select p.ProductName
from Products p
where (
    select count(distinct CustomerID)
    from Orders o
    where o.ProductName = p.ProductName
) = (
    select count(distinct CustomerID)
    from Customers
);

/* 3. Write a query to calculate the total revenue generated from orders placed in each month. */

select 
    month(o.OrderDate) 'Order Month',
    SUM(p.Price * o.Quantity) 'Total Revenue'
from 
    Orders o join Products p on
	o.ProductName = p.ProductName
group by 
    month(o.OrderDate);

/* 4. Write a query to retrieve the products that have been ordered by more than 50% of the customers. */

select
    p.ProductName
from 
    Products p
join 
    Orders o on p.ProductName = o.ProductName
group by 
    p.ProductName
having 
    count(distinct o.CustomerID) > (select count(distinct CustomerID) from Customers) * 0.5;

/* 5. Write a query to retrieve the top 5 customers who have spent the highest amount of money on orders. */

select top 5 c.Name, sum(p.Price * o.Quantity) 'Highest Amount of Money Spent on Orders' from Customers c join
Orders o on c.CustomerID = o.CustomerID join Products p on o.ProductName = p.ProductName
group by c.Name order by sum(p.Price * o.Quantity) desc;

/* 6. Write a query to calculate the running total of order quantities for each customer. */

SELECT 
    CustomerID,
	OrderID,
    OrderDate,
    Quantity,
    SUM(Quantity) OVER (PARTITION BY CustomerID ORDER BY OrderDate, OrderID) 'Running Total'
FROM 
    Orders 
ORDER BY 
    CustomerID, OrderDate, OrderID;

/* 7. Write a query to retrieve the top 3 most recent orders for each customer. */

WITH OrderedOrders AS (
    SELECT 
        CustomerID,
        OrderID,
        OrderDate,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS order_rank
    FROM 
        Orders
)
SELECT 
    CustomerID,
    OrderID,
    OrderDate
FROM 
    OrderedOrders
WHERE 
    order_rank <= 3;

/* 8. Write a query to calculate the total revenue generated by each customer in the last 30 days. */

SELECT 
    o.CustomerID,
    c.Name,
    SUM(p.Price * o.Quantity) 'Total Revenue in Last 30 Days'
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Products p ON o.ProductName = p.ProductName
WHERE 
    o.OrderDate >= DATEADD(day, -30, GETDATE())
GROUP BY 
    o.CustomerID,
    c.Name;

/* 9. Write a query to retrieve the customers who have placed orders for at least two different product categories. */

SELECT 
    c.CustomerID,
    c.Name
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    Products p ON o.ProductName = p.ProductName
GROUP BY 
    c.CustomerID,
    c.Name
HAVING 
    COUNT(DISTINCT p.ProductName) >= 2;

/* 10. Write a query to calculate the average revenue per order for each customer. */

SELECT c.Name, AVG(o.Quantity * p.Price) 'Average Revenue' FROM Customers c JOIN Orders o ON 
c.CustomerID = o.CustomerID JOIN Products p ON o.ProductName = p.ProductName
GROUP BY c.Name; 

/* 11. Write a query to retrieve the customers who have placed orders for every month of a specific year. */

SELECT 
    CustomerID,
    Name
FROM 
    Customers
WHERE 
    CustomerID IN (
        SELECT 
            o.CustomerID
        FROM 
            Orders o
        WHERE 
            YEAR(OrderDate) = 2023
        GROUP BY 
            o.CustomerID
        HAVING 
            COUNT(DISTINCT MONTH(OrderDate)) = 12
    );

/* 12. Write a query to retrieve the customers who have placed orders for a specific product in consecutive months. */

DECLARE @ProductName varchar(max) = 'Product A'; -- Specify the product ID (Let, Product A)
DECLARE @ConsecutiveMonths INT = 2; -- Specify the number of consecutive months

SELECT 
    c.CustomerID,
    c.Name
FROM 
    Customers c
WHERE 
    EXISTS (
        SELECT 1
        FROM Orders o1
        WHERE 
            o1.CustomerID = c.CustomerID
            AND o1.ProductName = @ProductName
            AND EXISTS (
                SELECT 1
                FROM Orders o2
                WHERE 
                    o2.CustomerID = o1.CustomerID
                    AND o2.ProductName = @ProductName
                    AND DATEDIFF(MONTH, o1.OrderDate, o2.OrderDate) = 1
            )
    );


/* 13. Write a query to retrieve the products that have been ordered by a specific customer at least twice. */

DECLARE @CustomerId INT = 1; -- Specify the customer ID (Let, it be 1)

SELECT DISTINCT
    p.ProductID,
    p.ProductName
FROM 
    Products p
JOIN 
    Orders o ON p.ProductName = o.ProductName
WHERE 
    o.CustomerID = @CustomerId
GROUP BY 
    p.ProductID,
    p.ProductName
HAVING 
    COUNT(*) >= 2;

















