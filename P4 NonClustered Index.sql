use onlineretail

CREATE NONCLUSTERED INDEX IX_Customer_Username ON Customer(Username);
CREATE NONCLUSTERED INDEX IX_Invoices_InvoiceNumber ON Invoice(InvoiceNumber);
CREATE NONCLUSTERED INDEX IX_Orders_OrderID ON [Order](OrderID);