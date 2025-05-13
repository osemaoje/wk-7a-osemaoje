-- answers.sql
-- Assignment: Database Design and Normalization
-- Author: ELIMIMIAN OSEMAOJE OLUSEGUN 


-- ============================================================
-- Question 1: Achieving 1NF (First Normal Form)
-- ============================================================

-- Create a normalized version of the ProductDetail table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert atomic (single product per row) values to achieve 1NF
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 101, 'John Doe', 'Laptop'
UNION ALL
SELECT 101, 'John Doe', 'Mouse'
UNION ALL
SELECT 102, 'Jane Smith', 'Tablet'
UNION ALL
SELECT 102, 'Jane Smith', 'Keyboard'
UNION ALL
SELECT 102, 'Jane Smith', 'Mouse'
UNION ALL
SELECT 103, 'Emily Clark', 'Phone';

-- ============================================================
-- Question 2: Achieving 2NF (Second Normal Form)
-- ============================================================

-- Step 1: Create the Customers table to remove partial dependency
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Populate the Customers table with unique OrderID-CustomerName pairs
INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM (
    SELECT 101 AS OrderID, 'John Doe' AS CustomerName
    UNION
    SELECT 102, 'Jane Smith'
    UNION
    SELECT 103, 'Emily Clark'
) AS temp;

-- Step 3: Create the OrderItems table to hold products and their quantities
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- Step 4: Insert product details
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES 
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
