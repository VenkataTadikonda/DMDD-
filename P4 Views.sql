
Use onlineretail

--View 1--
  CREATE VIEW Top5CostliestItemsSold AS
SELECT TOP 5
  p.ProductName,
  od.Price,
  SUM(od.Quantity) AS TotalQuantitySold,
  SUM(od.Price * od.Quantity) AS TotalSalesValue
FROM 
  OrderDetails od
INNER JOIN 
  Product p ON od.ProductID = p.ProductID
GROUP BY 
  p.ProductName,
  od.Price
ORDER BY 
  TotalSalesValue DESC;

  SELECT * FROM Top5CostliestItemsSold;

--View 2--
CREATE VIEW DeliveryPersonSuccessCount AS
SELECT 
  dp.DeliveryPersonID,
  dp.DeliveryPersonFName,
  COUNT(d.DeliveryID) AS NumberOfSuccessfulDeliveries
FROM 
  DeliveryPerson dp
INNER JOIN 
  Delivery d ON dp.DeliveryPersonID = d.DeliveryPersonID
WHERE 
  d.DeliveryStatus = 'Delivered' -- Replace with your actual success status
GROUP BY 
  dp.DeliveryPersonID,
  dp.DeliveryPersonFName;


  SELECT *
FROM DeliveryPersonSuccessCount
ORDER BY NumberOfSuccessfulDeliveries DESC;


--View 3--
CREATE VIEW Top5HighestRatedItems AS
SELECT TOP 5
  od.ProductID,
  p.ProductName,
  AVG(r.Rating) AS AverageRating
FROM 
  OrderDetails od
INNER JOIN 
  Review r ON od.OrderDetailsID = r.OrderDetailsID
INNER JOIN
  Product p ON od.ProductID = p.ProductID
GROUP BY 
  od.ProductID, p.ProductName
ORDER BY 
  AverageRating DESC, od.ProductID;

SELECT * FROM Top5HighestRatedItems 
