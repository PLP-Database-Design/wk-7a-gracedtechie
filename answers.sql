-- Question 1: Achieving 1NF (First Normal Form)
-- Split the Products column so that each product gets its own row
-- Note: This example uses PostgreSQL syntax with regexp_split_to_table.
-- If you use another DBMS, the function might differ.

SELECT
  OrderID,
  CustomerName,
  TRIM(product) AS Product
FROM
  ProductDetail,
  regexp_split_to_table(Products, ',') AS product;

-- This query transforms the Products column from comma-separated values 
-- into multiple rows, each containing one product, satisfying 1NF.

----------------------------------------------------------

-- Question 2: Achieving 2NF (Second Normal Form)
-- Step 1: Create Orders table to remove partial dependency on CustomerName

CREATE TABLE Orders AS
SELECT DISTINCT
  OrderID,
  CustomerName
FROM OrderDetails;

-- Step 2: Create OrderItems table with product details

CREATE TABLE OrderItems AS
SELECT
  OrderID,
  Product,
  Quantity
FROM OrderDetails;

-- Now, CustomerName depends only on OrderID in Orders table (no partial dependency)
-- and OrderItems contains product info per order, ensuring full functional dependency.
