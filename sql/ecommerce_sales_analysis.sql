CREATE DATABASE ecommerce_project;
USE ecommerce_project;

CREATE TABLE ecommerce_data (
  InvoiceNo VARCHAR(20),
  StockCode VARCHAR(20),
  Description TEXT,
  Quantity INT,
  InvoiceDate TIMESTAMP,
  UnitPrice FLOAT,
  CustomerID FLOAT,
  Country VARCHAR(100),
  TotalPrice FLOAT,
  InvoiceMonth INT,
  InvoiceYear INT,
  InvoiceDay VARCHAR(20)
);

-- Data preview and size
SELECT * FROM ecommerce_data LIMIT 10;
SELECT COUNT(*) AS Total_Rows FROM ecommerce_data;

-- Revenue, orders, customers
SELECT ROUND(SUM(TotalPrice), 2) AS Total_Revenue FROM ecommerce_data;
SELECT COUNT(DISTINCT InvoiceNo) AS Total_Orders FROM ecommerce_data;
SELECT COUNT(DISTINCT CustomerID) AS Total_Customers FROM ecommerce_data;

-- Top countries by revenue
SELECT Country, ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data GROUP BY Country ORDER BY Revenue DESC LIMIT 10;

-- Monthly revenue
SELECT InvoiceMonth, ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data GROUP BY InvoiceMonth ORDER BY InvoiceMonth;

-- Top products by revenue
SELECT Description, ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data GROUP BY Description ORDER BY Revenue DESC LIMIT 10;

-- Top customers by spend
SELECT CustomerID, ROUND(SUM(TotalPrice),2) AS Total_Spent
FROM ecommerce_data GROUP BY CustomerID ORDER BY Total_Spent DESC LIMIT 10;

-- Average order value
SELECT ROUND(SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2) AS Avg_Order_Value
FROM ecommerce_data;

-- Most sold products by quantity
SELECT Description, SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_data GROUP BY Description ORDER BY Total_Quantity_Sold DESC LIMIT 10;

-- Annual revenue
SELECT InvoiceYear, ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data GROUP BY InvoiceYear ORDER BY InvoiceYear;

-- Ranked product revenue
SELECT Description, ROUND(SUM(TotalPrice),2) AS Revenue,
  RANK() OVER (ORDER BY SUM(TotalPrice) DESC) AS Product_Rank
FROM ecommerce_data GROUP BY Description;

-- Customer segments by spending thresholds
SELECT CustomerID, ROUND(SUM(TotalPrice),2) AS Total_Spent,
  CASE
    WHEN SUM(TotalPrice) > 5000 THEN 'VIP Customer'
    WHEN SUM(TotalPrice) > 2000 THEN 'Loyal Customer'
    ELSE 'Regular Customer'
  END AS Customer_Segment
FROM ecommerce_data GROUP BY CustomerID;
