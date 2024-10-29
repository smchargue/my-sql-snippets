CREATE FUNCTION [dbo].[TryDate]
(
	@year as INT,
	@month as INT,
	@day as INT
)
RETURNS DATE AS 
BEGIN
	RETURN TRY_CONVERT(DATE,CONCAT(FORMAT(@year,'D4'), FORMAT(@month,'D2'), FORMAT(@day,'D2')))
END
GO

CREATE FUNCTION [dbo].[GetNextBirtyday]
(
	@month as INT,
	@day as INT
) 
RETURNS DATE AS
BEGIN

	DECLARE @today DATE = GetDATE(); 
    DECLARE @year INT = YEAR(@today);
    DECLARE @returnDate DATE = NULL;

	IF ISNULL(@month,0) BETWEEN 1 AND 12 AND ISNULL(@day,0) BETWEEN 1 AND 31
	BEGIN
		IF (@month = 2 AND @day = 29)
		BEGIN 
			SET @returnDate = ISNULL(dbo.TryDate(@year,@month,@day), DATEFROMPARTS(@year,@month,28))
			IF @returnDate < @today 
				SET @returnDate = ISNULL(dbo.TryDate(@year+1,@month,@day), DATEFROMPARTS(@year+1,@month,28))
			RETURN @returnDate
		END

		SET @returnDate = DATEFROMPARTS(@year, @month, @day) 

		IF @returnDate < @today 
			SET @returnDate = DATEFROMPARTS(@year+1, @month, @day) 		
	END

	RETURN @returnDate
END
