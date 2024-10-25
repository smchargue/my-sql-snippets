CREATE FUNCTION dbo.IsWorkAnniversary
(
  @HireDate DATE, 
  @LowerLimit INT, /* days back to consider */
  @UpperLimit INT /* how far forward in days to consider */
)
RETURNS INT
/* 
	Returns 0 is this is a recent hire, -1 if it is not a work anniversary, or the number of years for the anniversary 
   	SELECT dbo.IsWorkAnniversary('10/12/2000', -3, 14)
*/
AS
BEGIN
    DECLARE @Today DATE = GETDATE();
    DECLARE @CurrentYear INT = YEAR(@Today);
    DECLARE @HireMonthDay DATE = DATEFROMPARTS(@CurrentYear, MONTH(@HireDate), DAY(@HireDate));
    DECLARE @DaysDifference INT;

    IF @HireMonthDay < @Today
        SET @DaysDifference = DATEDIFF(DAY, @HireMonthDay, @Today);
    ELSE
        SET @DaysDifference = DATEDIFF(DAY, @Today, @HireMonthDay);

    IF @DaysDifference BETWEEN @LowerLimit AND @UpperLimit
	    RETURN DATEDIFF(YEAR, @HireDate, @Today) 

	RETURN -1;
END;
GO
SELECT dbo.IsWorkAnniversary('10/24/2000',-3,14)
, dbo.IsWorkAnniversary('10/24/2024',-3,14)
, dbo.IsWorkAnniversary('12/24/2000',-3,14)