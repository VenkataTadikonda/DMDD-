-- Table-level CHECK Constraints
USE [onlineretail]
GO

ALTER TABLE [Address]
ADD CONSTRAINT CHK_PostalCode CHECK (LEN(PostalCode) >= 5);

ALTER TABLE Product
ADD CONSTRAINT CHK_Price CHECK (Price >= 0);

ALTER TABLE Customer
ADD CONSTRAINT CHK_PhoneNumber_Format CHECK (
    PhoneNumber LIKE '+[0-9]%' OR PhoneNumber LIKE '[0-9]%'
);

ALTER TABLE [Order]
ADD CONSTRAINT CHK_OrderStatus_Valid CHECK (OrderStatus IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled','Ready to Ship','Failed','In Transit'))

ALTER TABLE CartItem
ADD CONSTRAINT CHK_Quantity_Positive CHECK (Quantity > 0)

ALTER TABLE CartItem
ADD CONSTRAINT CHK_Discount_Range CHECK (Discount BETWEEN 0 AND 100)

ALTER TABLE Payment
ADD CONSTRAINT CHK_Status CHECK (Status IN ('Success', 'Pending', 'Failed'))

ALTER TABLE Delivery
ADD CONSTRAINT CHK_DeliveryStatus CHECK (DeliveryStatus IN ('Pending', 'In Transit', 'Delivered', 'Failed'))

ALTER TABLE Review
ADD CONSTRAINT UQ_Customer_OrderDetails UNIQUE (CustomerID, OrderDetailsID);
