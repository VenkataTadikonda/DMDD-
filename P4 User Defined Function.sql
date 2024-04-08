use onlineretail
GO

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