CREATE DATABASE [onlineretail]
GO

USE [onlineretail]
GO

-- 1.Customer Table
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    [Password] VARBINARY(MAX) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255)NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    DOB DATE NULL
);

GO
--2.Create Address Entity Table

CREATE TABLE [Address] (
   AddressID INT IDENTITY(1,1) PRIMARY KEY,
   CustomerID INT NOT NULL,
   RecipientName VARCHAR(255) NOT NULL,
   StreetAddress1 NVARCHAR(255) NOT NULL,
   StreetAddress2 NVARCHAR(255) NULL,
   City VARCHAR(100) NOT NULL,
   [State] VARCHAR(100) NOT NULL,
   PostalCode VARCHAR(10) NOT NULL,
   Country VARCHAR(100) NOT NULL,
   CONSTRAINT FK_Address_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

GO
-- 3.Cart Table
CREATE TABLE Cart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CONSTRAINT FK_Cart_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO
--4.Brand Table
CREATE TABLE Brand (
    BrandID INT PRIMARY KEY IDENTITY(1,1),
    BrandName VARCHAR(255) NOT NULL,
    [Description] TEXT NULL,
    CompanyInfo TEXT NULL
);
GO
--5.Category Table
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    [Type] VARCHAR(255) NOT NULL,
    [Description] TEXT NULL,
    BrandName VARCHAR(255) NOT NULL
);
GO
--6.Product Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
	BrandID INT NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    [Description] TEXT NULL,
    ProductName VARCHAR(255) NOT NULL,
    CONSTRAINT FK_Product_CategoryID FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
	CONSTRAINT FK_Product_BrandID FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO
-----------------------------------------------------------------------------------
CREATE FUNCTION dbo.GetDiscountedPrice
(
    @ProductID INT,
    @Discount DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Price DECIMAL(10, 2);

    SELECT @Price = Price FROM Product WHERE ProductID = @ProductID;

    RETURN @Price - (@Price * @Discount / 100);
END;
GO

----------------------------------------------------------------------------------------------

--7.Create CartItem Entity Table
CREATE TABLE CartItem (
   CartItemID INT IDENTITY(1,1) PRIMARY KEY,
   CartID INT NOT NULL,
   ProductID INT NOT NULL,
   [Size] VARCHAR(50) NULL,
   Discount DECIMAL(5, 2) NULL DEFAULT 0.00,
   ItemPrice AS dbo.GetDiscountedPrice(ProductID,Discount),
   Quantity INT NOT NULL,
   CONSTRAINT FK_CartItem_CartID FOREIGN KEY (CartID) REFERENCES Cart(CartID),
   CONSTRAINT FK_CartItem_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
GO

--8.Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    Quantity INT NOT NULL,
    [Size] VARCHAR(50) NULL,
    Color VARCHAR(50) NULL,
);
GO
--9.InventoryProduct Table
CREATE TABLE InventoryProduct (
    InventoryID INT NOT NULL,
    ProductID INT NOT NULL,
    [Location] NVARCHAR(255) NULL,
    BatchNumber VARCHAR(255) NULL,
    CONSTRAINT PK_InventoryProduct PRIMARY KEY (InventoryID, ProductID),
    CONSTRAINT FK_InventoryProduct_InventoryID FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID),
    CONSTRAINT FK_InventoryProduct_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
GO
---------------------------------------------------------------------------------------------------------------------------
CREATE FUNCTION dbo.CalculateOrderTotalPrice
(
    @CartID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalPrice DECIMAL(10, 2);

    SELECT @TotalPrice = ISNULL(SUM((ItemPrice - (ItemPrice * Discount / 100)) * Quantity), 0)
    FROM CartItem
    WHERE CartID = @CartID;

    RETURN @TotalPrice;
END;
GO
------------------------------------------------------------------------------------------------------------------------------------------
--10.Order Table
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1000,10),
    CartID INT NOT NULL,
	AddressID INT NOT NULL,
	TotalPrice DECIMAL(10, 2) NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(50) NOT NULL DEFAULT 'Processing',
    CONSTRAINT FK_Order_CartID FOREIGN KEY (CartID) REFERENCES Cart(CartID),
	CONSTRAINT FK__Order_AddressID FOREIGN KEY (AddressID) REFERENCES [Address](AddressID)
    );
GO


-- 11.OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailsID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
	[Size] VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_OrderDetails_OrderID FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    CONSTRAINT FK_OrderDetails_ProductID FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
GO

--12.Invoice Table
CREATE TABLE Invoice (
    InvoiceNumber INT PRIMARY KEY IDENTITY(10000,1),
    OrderID INT NOT NULL UNIQUE,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    InvoiceDate DATE NOT NULL,
    CONSTRAINT FK_Invoice_OrderID FOREIGN KEY (OrderID) REFERENCES [Order](OrderID)
);
GO
-- 13.Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceNumber INT NOT NULL UNIQUE,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NULL,
    PaymentMethod VARCHAR(255) NULL,
    [Status] VARCHAR(50) NOT NULL,
	CONSTRAINT FK_Payment_InvoiceNumber FOREIGN KEY (InvoiceNumber) REFERENCES Invoice(InvoiceNumber)
    );
GO

--14. DeliveryPerson Table
CREATE TABLE DeliveryPerson (
    DeliveryPersonID INT PRIMARY KEY IDENTITY(1,1),
    DeliveryPersonFName NVARCHAR(255) NOT NULL,
    DeliveryPersonLName NVARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL
);
GO
--15.Delivery Table
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY IDENTITY(100,5),
    InvoiceNumber INT NOT NULL UNIQUE,
    DeliveryPersonID INT NOT NULL,
    ExpectedDeliveryDate DATE NOT NULL,
    ActualDeliveryDate DATE NULL,
    DeliveryStatus VARCHAR(50) NOT NULL,
    DeliveryMode VARCHAR(255) NULL,
    CONSTRAINT FK_Delivery_InvoiceNumber FOREIGN KEY (InvoiceNumber) REFERENCES Invoice(InvoiceNumber),
    CONSTRAINT FK_Delivery_DeliveryPersonID FOREIGN KEY (DeliveryPersonID) REFERENCES DeliveryPerson(DeliveryPersonID)
    );

GO

--16. Review Table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(100,1),
    CustomerID INT NOT NULL,
    OrderDetailsID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT NULL,
    [Date] DATE NOT NULL ,
    CONSTRAINT FK_Review_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT FK_Review_OrderDetailsID FOREIGN KEY (OrderDetailsID) REFERENCES OrderDetails(OrderDetailsID)
);



GO
--17. Shipping Table	
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1000,1),
    InvoiceNumber INT NOT NULL UNIQUE,
    ShippingDate DATE NOT NULL,
    ShippingStatus VARCHAR(50) NOT NULL,
    TrackingNumber VARCHAR(255) NOT NULL,
    CONSTRAINT FK_Shipping_InvoiceNumber  FOREIGN KEY (InvoiceNumber) REFERENCES Invoice(InvoiceNumber)
    );
GO

-------------------------------------------------------------------Encryption---------------------------------------------------------------------------------------
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DataManagement@6205';

CREATE CERTIFICATE passwordEncryptCertificate WITH SUBJECT = 'Customer Password Encryption';

CREATE SYMMETRIC KEY passwordEncryptionKey WITH ALGORITHM = AES_256

ENCRYPTION BY CERTIFICATE passwordEncryptCertificate;

