------------------------------------------ Update Order and Shipping Status---------------------------------------
Use onlineretail
GO

CREATE OR ALTER TRIGGER UpdateOrderAndShippingStatus
ON Delivery
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(DeliveryStatus)
    BEGIN
        UPDATE [Order]
        SET OrderStatus = CASE
                            WHEN d.DeliveryStatus IN ('Delivered', 'In Transit','Shipped', 'Failed') THEN d.DeliveryStatus
                            ELSE 'Unknown'
                          END
        FROM [Order] o
        INNER JOIN Invoice i ON o.OrderID = i.OrderID
        INNER JOIN inserted d ON i.InvoiceNumber = d.InvoiceNumber;
        
        UPDATE Shipping
        SET ShippingStatus = CASE
                                WHEN inn.DeliveryStatus IN ('Delivered', 'In Transit', 'Shipped', 'Failed') THEN inn.DeliveryStatus
                                ELSE 'Unknown'
                             END
        FROM Shipping s
        INNER JOIN inserted inn ON s.InvoiceNumber = inn.InvoiceNumber;
    END
END;
GO

UPDATE Delivery
SET DeliveryStatus = 'Delivered'
WHERE InvoiceNumber = 10002;
SELECT * from Delivery

-----------------------------------------------------------------------------------------------------------------------------

--------------------------------------Required Procedure for below trigger------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------

------------------------------------------ Update Order Status upon successful payment---------------------------------------
CREATE OR ALTER TRIGGER UpdateOrderStatusOnPaymentSuccess
ON Payment
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE([Status])
    BEGIN
	    DECLARE @OrderID INT;
        SELECT @OrderID = o.OrderID
        FROM [Order] o
		INNER JOIN Invoice inv ON o.OrderID = inv.OrderID
        INNER JOIN inserted i ON inv.InvoiceNumber = i.InvoiceNumber
        WHERE i.[Status] = 'Success';

        IF @OrderID IS NOT NULL
        BEGIN
            EXEC AddOrderDetails @OrderID;
        END

        UPDATE [Order]
        SET OrderStatus = 'Ready to Ship'
        WHERE OrderID = @OrderID;
	
    END
END;
GO
------------------------------------------ Update Inventory after order creation-----------------------------------------
CREATE OR ALTER TRIGGER UpdateInventoryOnPaymentSuccess
ON Payment
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
	PRINT 'Trigger fired for UpdateInventoryOnPaymentSuccess'; -- For debugging

   IF(SELECT [Status] FROM inserted)=  'Success'
    BEGIN
         UPDATE inv
         SET inv.Quantity = inv.Quantity - od.Quantity
        FROM Inventory inv
        INNER JOIN InventoryProduct invp ON inv.InventoryID = invp.InventoryID
        INNER JOIN OrderDetails od ON invp.ProductID = od.ProductID
        INNER JOIN [Order] o ON od.OrderID = o.OrderID
        INNER JOIN Invoice invc ON o.OrderID = invc.OrderID
        INNER JOIN inserted i ON invc.InvoiceNumber = i.InvoiceNumber
		WHERE inv.[Size] = od.[Size]
        AND inv.Quantity >= od.Quantity
		AND i.[Status] = 'Success';
    END
END;
GO

---------------------------------------------- Clear Cart After Order---------------------------------------
CREATE OR ALTER TRIGGER ClearCartOnOrderPlaced
ON [Order]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN
        -- Define a cursor to process multiple orders that might have been updated simultaneously
        DECLARE curOrders CURSOR FOR 
            SELECT i.CartID
            FROM inserted i
            INNER JOIN Cart c ON i.CartID = c.CartID;

        DECLARE @CartID INT;

        OPEN curOrders;

        -- Loop through all orders that have been inserted
        FETCH NEXT FROM curOrders INTO @CartID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
		DECLARE @OrderID INT;
        -- Get the OrderID corresponding to the CartID
        SELECT @OrderID = OrderID
        FROM [Order]
        WHERE CartID = @CartID;
		 IF @OrderID IS NOT NULL
        BEGIN
            EXEC AddOrderDetails @OrderID;
        END;
            DELETE FROM CartItem
            WHERE CartID = @CartID;

            FETCH NEXT FROM curOrders INTO @CartID;
        END;

        CLOSE curOrders;
        DEALLOCATE curOrders;
    END
END;
GO
----------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Create Cart for Customer -------------------------------------------------
CREATE OR ALTER TRIGGER CreateCartForNewCustomer
ON Customer
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Cart (CustomerID)
        SELECT CustomerID
        FROM inserted i
		WHERE NOT EXISTS (
        SELECT 1
        FROM Cart c
        WHERE c.CustomerID = i.CustomerID
    );
    END
END;
