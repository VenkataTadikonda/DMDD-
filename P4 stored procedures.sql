USE onlineretail
GO
---1. Stored Procedure to CREATE OR ALTER PROCEDURE AddProduct--------
CREATE OR ALTER PROCEDURE AddProduct
    @BrandID INT,
    @CategoryID INT,
    @Price DECIMAL(10, 2),
    @Description TEXT,
    @ProductName VARCHAR(255),
    @Quantity INT,
    @Size VARCHAR(50),
    @Color VARCHAR(50),
    @Location VARCHAR(255),
    @BatchNumber VARCHAR(255),
	@NewProductID INT OUTPUT,
    @NewInventoryID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;


    -- Insert into Product table
    INSERT INTO Product (BrandID, CategoryID, Price, [Description], ProductName)
    VALUES (@BrandID, @CategoryID, @Price, @Description, @ProductName);

    -- Get the ID of the newly inserted product
    SET @NewProductID = SCOPE_IDENTITY();

    -- Insert into Inventory table
    INSERT INTO Inventory (Quantity, Size, Color)
    VALUES (@Quantity, @Size, @Color);

    SET @NewInventoryID = SCOPE_IDENTITY();

    -- Insert into InventoryProduct table
    INSERT INTO InventoryProduct (InventoryID, ProductID, [Location], BatchNumber)
    VALUES (@NewInventoryID, @NewProductID, @Location, @BatchNumber);
    
	SET NOCOUNT OFF;
END
GO
---- TO TEST ----
DECLARE @OutputProductID INT, @OutputInventoryID INT;
EXEC AddProduct 
    @BrandID = 1, 
    @CategoryID = 1, 
    @Price = 59.99, 
    @Description = 'A new exciting product', 
    @ProductName = 'Exciting Product',
    @Quantity = 100,
    @Size = 'M',
    @Color = 'Red',
	@Location = 'Warehouse A',
    @BatchNumber = 'INV0001',
    @NewProductID = @OutputProductID OUTPUT,
    @NewInventoryID = @OutputInventoryID OUTPUT;


-- 2.PROCEDURE to print sales report data according to start and end date
CREATE OR ALTER PROCEDURE GetSalesReport
    @StartDate DATE,
    @EndDate DATE,
    @ReportID NVARCHAR(50) OUTPUT
AS	
BEGIN
    SET NOCOUNT ON;
	SET @ReportID = CONCAT(CONVERT(NVARCHAR(20), GETDATE(), 112), '_', NEWID());
    -- Temp table to store the report data
    CREATE TABLE #SalesReport
    (
        ReportID NVARCHAR(50),
        OrderID INT,
        ProductID INT,
        ProductName NVARCHAR(255),
        QuantitySold INT,
        TotalSales DECIMAL(18, 2),
        ReportDate DATE DEFAULT GETDATE()
    );

    -- Insert the report data into the temp table
 INSERT INTO #SalesReport (ReportID, OrderID, ProductID, ProductName, QuantitySold, TotalSales)
    SELECT 
        @ReportID,
        od.OrderID,
        od.ProductID,
        p.ProductName,
        SUM(od.Quantity) AS QuantitySold,
        SUM(od.Quantity * od.Price) AS TotalSales
    FROM 
        OrderDetails od
    INNER JOIN 
        [Order] o ON od.OrderID = o.OrderID
    INNER JOIN 
        Product p ON od.ProductID = p.ProductID
    WHERE 
        o.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY 
        od.OrderID, od.ProductID, p.ProductName;

    SELECT * FROM #SalesReport WHERE ReportID = @ReportID;

    DROP TABLE #SalesReport;

    SET NOCOUNT OFF;
END;
GO

-- TEST GenerateSalesReport Procedure
DECLARE @MyReportID NVARCHAR(50);
EXEC GetSalesReport @StartDate = '2024-04-07', @EndDate = '2024-04-10', @ReportID = @MyReportID OUTPUT;
GO
----------------------------------------------------------------------------------------------------------------------------------------------------

-----------3. Stored Procedure to InsertOrderDetailsFromCart---------
CREATE OR ALTER PROCEDURE AddOrderDetails
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CartID INT;
    SELECT @CartID = CartID FROM [Order] WHERE OrderID = @OrderID;
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, [Size], Price)
    SELECT 
        @OrderID, 
        ci.ProductID,
        ci.Quantity,
		ci.Size,
        ci.ItemPrice
    FROM 
        CartItem ci 
    WHERE 
        ci.CartID = @CartID
		 AND NOT EXISTS (
              SELECT 1
              FROM OrderDetails od
              WHERE od.OrderID = @OrderID AND od.ProductID = ci.ProductID
           );
END;
GO

---TEST Adding OrderDeatils for any orderid ----------------
EXEC AddOrderDetails @OrderID = 1000
SELECT * FROM dbo.OrderDetails WHERE OrderID=1000
GO

--- 4.Stored Procedure to Add Customer --------------------------------------------------
CREATE OR ALTER PROCEDURE CreateCustomer
    @Username VARCHAR(50),
    @Password VARCHAR(255),
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @PhoneNumber VARCHAR(20),
    @DOB DATE
AS
BEGIN
    -- Insert the customer data
	OPEN SYMMETRIC KEY passwordEncryptionKey
    DECRYPTION BY CERTIFICATE passwordEncryptCertificate;
    INSERT INTO Customer (Username, [Password], FirstName, LastName, PhoneNumber, DOB)
    VALUES (@Username, EncryptByKey(Key_GUID('passwordEncryptionKey'), CONVERT(VARBINARY(MAX),@Password)), @FirstName, @LastName, @PhoneNumber, @DOB);
    CLOSE SYMMETRIC KEY passwordEncryptionKey;
END;
-----------------------------TO TEST------------------------------

EXEC CreateCustomer  @Username='Harshitha', @Password='Harsh123', @FirstName ='Harshitha', @LastName='Sappidi',@PhoneNumber='+1983572671', @DOB='2000-01-01';
Select * from Customer;
GO

--- 5.Stored Procedure to Create Order---------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateOrder
    @CustomerID INT,
    @AddressID INT,
	@DeliveryPersonID INT ,
    @NewOrderID INT OUTPUT,
	@NewInvoiceID INT OUTPUT,
    @NewPaymentID INT OUTPUT,
    @NewShippingID INT OUTPUT,
    @NewDeliveryID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CartID INT;
    DECLARE @TotalPrice DECIMAL(10, 2);

	SELECT @CartID = CartID FROM Cart WHERE CustomerID = @CustomerID;
	
	IF NOT EXISTS (SELECT 1 FROM CartItem WHERE CartID = @CartID)
    BEGIN
        RAISERROR( 'No items in the cart to create an order.',16,1);
        RETURN;
    END

	DECLARE @NotEnoughInventory BIT;
    SET @NotEnoughInventory = 0;
	SELECT @NotEnoughInventory = CASE WHEN EXISTS (
        SELECT 1
        FROM CartItem ci
        INNER JOIN InventoryProduct ivp ON ci.ProductID = ivp.ProductID
        INNER JOIN Inventory i ON i.InventoryID = ivp.InventoryID
        WHERE ci.CartID = @CartID
        AND i.[Size] = ci.[Size]
        GROUP BY ci.ProductID, ci.[Size]
        HAVING SUM(i.Quantity) < SUM(ci.Quantity)
    ) THEN 1 ELSE 0 END;

	IF @NotEnoughInventory = 1
    BEGIN
        RAISERROR('Not enough inventory for one or more products.',16,1);
        RETURN;
    END

	SELECT @TotalPrice = dbo.CalculateOrderTotalPrice(@CartID);

    INSERT INTO [Order] (CartID, AddressID, TotalPrice, OrderStatus, OrderDate)
    VALUES (@CartID, @AddressID, @TotalPrice,'Processing', GETDATE());

    SET @NewOrderID = SCOPE_IDENTITY();

    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, [Size], Price)
    SELECT @NewOrderID, ProductID, Quantity, Size, ItemPrice
    FROM CartItem
    WHERE CartID = @CartID;	

	INSERT INTO Invoice (OrderID, TotalAmount, InvoiceDate)
	VALUES(@NewOrderID, @TotalPrice, GETDATE())
	SET @NewInvoiceID = SCOPE_IDENTITY();

	INSERT INTO Payment (InvoiceNumber, Amount, PaymentDate,PaymentMethod, [Status])
	VALUES(@NewInvoiceID, @TotalPrice, GETDATE(),'Credit Card' ,'Pending' );
    SET @NewPaymentID = SCOPE_IDENTITY();

	INSERT INTO Shipping (InvoiceNumber, ShippingDate, ShippingStatus, TrackingNumber)
    VALUES (@NewInvoiceID, GETDATE(), 'Processing', CONCAT('TRACK123',@NewInvoiceID));
    SET @NewShippingID = SCOPE_IDENTITY();


	INSERT INTO Delivery (InvoiceNumber, DeliveryPersonID, ExpectedDeliveryDate, DeliveryStatus, DeliveryMode)
    VALUES (@NewInvoiceID, @DeliveryPersonID, DATEADD(day, 5, GETDATE()), 'Pending', 'Standard');
	SET @NewDeliveryID = SCOPE_IDENTITY();
	

END;	
GO

-----------------------------TO TEST------------------------------

DECLARE @OrderID INT, @InvoiceID INT, @PaymentID INT,   @ShippingID INT , @DeliveryID INT;
EXEC CreateOrder 
    @CustomerID = 20, 
    @AddressID = 20,
	@DeliveryPersonID = 1,
    @NewOrderID = @OrderID OUTPUT,
	@NewInvoiceID = @InvoiceID OUTPUT, 
	@NewPaymentID= @PaymentID OUTPUT,   
	@NewShippingID= @ShippingID OUTPUT , 
	@NewDeliveryID= @DeliveryID OUTPUT;
    
--6. Stored procedure to Add, Update, Manage Customer Address
CREATE PROCEDURE ManageCustomerAddresses
    @CustomerID INT,
    @Action NVARCHAR(10), -- 'Add', 'Update', or 'Delete'
    @AddressID INT = NULL,
    @RecipientName VARCHAR(255) = NULL,
    @StreetAddress1 NVARCHAR(255) = NULL,
    @StreetAddress2 NVARCHAR(255) = NULL,
    @City VARCHAR(100) = NULL,
    @State VARCHAR(100) = NULL,
    @PostalCode VARCHAR(10) = NULL,
    @Country VARCHAR(100) = NULL,
    @OutputMessage NVARCHAR(1000) OUTPUT
AS
BEGIN
    IF @Action = 'Add'
    BEGIN
        -- Insert a new address for the customer
        INSERT INTO [Address] (CustomerID, RecipientName, StreetAddress1, StreetAddress2, City, [State], PostalCode, Country)
        VALUES (@CustomerID, @RecipientName, @StreetAddress1, @StreetAddress2, @City, @State, @PostalCode, @Country);

        SET @OutputMessage = 'Address added successfully.';
    END
    ELSE IF @Action = 'Update'
    BEGIN
        -- Update an existing address
        UPDATE [Address]
        SET RecipientName = @RecipientName,
            StreetAddress1 = @StreetAddress1,
            StreetAddress2 = @StreetAddress2,
            City = @City,
            [State] = @State,
            PostalCode = @PostalCode,
            Country = @Country
        WHERE AddressID = @AddressID
        AND CustomerID = @CustomerID;

        SET @OutputMessage = 'Address updated successfully.';
    END
    ELSE IF @Action = 'Delete'
    BEGIN
        -- Delete an existing address
        DELETE FROM [Address]
        WHERE AddressID = @AddressID
        AND CustomerID = @CustomerID;

        SET @OutputMessage = 'Address deleted successfully.';
    END
    ELSE
    BEGIN
        SET @OutputMessage = 'Invalid action specified.';
    END
END;
GO

-----------------------------TO TEST------------------------------
DECLARE @CustomerID INT = 1; -- Provide the customer ID
DECLARE @Action NVARCHAR(10) = 'Add'; -- Specify the action: 'Add', 'Update', or 'Delete'
DECLARE @AddressID INT = NULL; -- Provide the address ID if needed for update or delete
DECLARE @RecipientName NVARCHAR(255) = 'Rahul'; -- Specify the recipient name for add or update
DECLARE @StreetAddress1 NVARCHAR(255) = '167 Centre St'; -- Specify the street address for add or update
DECLARE @StreetAddress2 NVARCHAR(255) = 3; -- Specify the street address 2 if needed for add or update
DECLARE @City VARCHAR(100) = 'Boston'; -- Specify the city for add or update
DECLARE @State VARCHAR(100) = 'MA'; -- Specify the state for add or update
DECLARE @PostalCode VARCHAR(10) = '12345'; -- Specify the postal code for add or update
DECLARE @Country VARCHAR(100) = 'USA'; -- Specify the country for add or update
DECLARE @OutputMessage NVARCHAR(1000); -- Output parameter to capture the result message

EXEC ManageCustomerAddresses 
    @CustomerID,
    @Action,
    @AddressID,
    @RecipientName,
    @StreetAddress1,
    @StreetAddress2,
    @City,
    @State,
    @PostalCode,
    @Country,
    @OutputMessage OUTPUT;

SELECT @OutputMessage AS ResultMessage; -- Output the result message
select * from Address

DECLARE @OutputMessage NVARCHAR(1000);

EXEC ManageCustomerAddresses 
    @CustomerID = 1, -- Replace with the actual CustomerID
    @Action = 'Delete',
    @AddressID = 21, -- Replace with the actual AddressID you want to delete
    @OutputMessage = @OutputMessage OUTPUT;

PRINT @OutputMessage;
GO


--7.To search order details and status based on customer id or order id-------

CREATE PROCEDURE GetOrderDetailsByCustomerOrOrderID
    @CustomerID INT = NULL,
    @OrderID INT = NULL

AS
BEGIN

    SELECT distinct
    O.OrderID,
    C.CartID,
    CI.ProductID,
    P.ProductName,
    CI.Quantity,
    CI.ItemPrice,
    O.OrderDate,
    O.OrderStatus
    
    FROM
        Customer AS Cust
    JOIN
        Cart AS C ON Cust.CustomerID = C.CustomerID
    JOIN
        [Order] AS O ON C.CartID = O.CartID
    JOIN
        CartItem AS CI ON C.CartID = CI.CartID
    JOIN
        Product AS P ON CI.ProductID = P.ProductID
    JOIN
        OrderDetails AS OD ON O.OrderID = OD.OrderID
    WHERE
        (@CustomerID IS NULL OR Cust.CustomerID = @CustomerID)
        and
        (@OrderID IS NULL OR O.OrderID = @OrderID);

END;

-----------------------------TO TEST------------------------------

EXEC GetOrderDetailsByCustomerOrOrderID @OrderID=1050

EXEC GetOrderDetailsByCustomerOrOrderID @CustomerID = 1
GO

--------------8.To delete a cartitem/s based on Cart id and Product id and display output message accordingly------
CREATE OR ALTER PROCEDURE RemoveCartItem
    @CartID INT,
    @ProductID INT = NULL,
    @Message NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    IF @ProductID IS NULL
    BEGIN
        -- Delete all cart items if no product ID is provided
        DELETE FROM CartItem WHERE CartID = @CartID;
        SET @Message = 'All cart items have been deleted from the cart with CartID = ' + CAST(@CartID AS NVARCHAR(10));
    END
    ELSE
    BEGIN
        -- Delete a single cart item based on the provided product ID
        DELETE FROM CartItem WHERE CartID = @CartID AND ProductID = @ProductID;
        IF @@ROWCOUNT > 0
            SET @Message = 'Cart item with ProductID = ' + CAST(@ProductID AS NVARCHAR(10)) + ' has been deleted from the cart with CartID = ' + CAST(@CartID AS NVARCHAR(10));
        END
END;
 
 -----------------------------TO TEST------------------------------
 
DECLARE @Message NVARCHAR(MAX);
 
EXEC RemoveCartItem @CartID = 1, @ProductID = 2, @Message = @Message OUTPUT;
 
SELECT @Message AS Message;
 
 
DECLARE @Message NVARCHAR(MAX);
 
EXEC RemoveCartItem @CartID = 40,  @Message = @Message OUTPUT;
 
SELECT @Message AS Message;