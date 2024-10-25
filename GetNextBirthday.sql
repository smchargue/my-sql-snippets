CREATE FUNCTION dbo.GetNextBirthday(@Month INT, @Day INT)
RETURNS DATE
AS
BEGIN
    DECLARE @Today DATE = GETDATE();
    DECLARE @Year INT = YEAR(@Today);
    DECLARE @NextBirthday DATE;

    IF (@Month = 2 AND @Day = 29)
    BEGIN
        IF (DATEFROMPARTS(@Year, 2, 28) >= @Today OR @Year % 4 = 0 AND @Year % 100 != 0 OR @Year % 400 = 0)
            SET @NextBirthday = DATEFROMPARTS(@Year, 2, 29);
        ELSE
            SET @NextBirthday = DATEFROMPARTS(@Year + 1, 2, 29);
    END
    ELSE
    BEGIN
        SET @NextBirthday = DATEFROMPARTS(@Year, @Month, @Day);
        IF @NextBirthday < @Today
            SET @NextBirthday = DATEFROMPARTS(@Year + 1, @Month, @Day);
    END

    RETURN @NextBirthday;
END
