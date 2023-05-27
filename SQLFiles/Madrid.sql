-- Create an empty Table with Year, PM10 levels as an indicator of Air Quality, and station_code
IF OBJECT_ID('dbo.MadridYearlyAQ', 'U') IS NOT NULL
DROP TABLE dbo.MadridYearlyAQ
GO
CREATE TABLE dbo.MadridYearlyAQ
(
    "YEAR" INT NOT NULL,
    AVG_PM10 FLOAT NOT NULL,
);
GO

-- Create a Temporary Table which includes the PM10 levels from august of each year, where the station code is 28079024
IF OBJECT_ID('TEMPTABLE', 'U') IS NOT NULL
DROP TABLE TEMPTABLE
SELECT YEAR("date") as "year", "PM10" INTO TEMPTABLE FROM madrid_2001
    WHERE 
        "station" = 28079024
        AND MONTH("date") = 8
        AND "PM10" IS NOT NULL
DECLARE @YearValue INT
DECLARE @YearString VARCHAR(MAX)
DECLARE @stmt VARCHAR(MAX)
SET @YearValue = 2002
WHILE @YearValue < 2018
    BEGIN
        SET @YearString = CAST(@YearValue AS VARCHAR)
        SET @stmt = 'INSERT INTO TEMPTABLE ("year", PM10) SELECT YEAR("date"), "PM10" FROM madrid_' + @YearString + ' WHERE "station" = 28079024 AND MONTH("date") = 8 AND "PM10" IS NOT NULL'
        EXEC (@stmt)
        SET @YearValue += 1
    END

-- Insert averages of PM10 values for each year into MadridYearlyAQ
INSERT INTO dbo.MadridYearlyAQ
(
[YEAR], [AVG_PM10]
)
SELECT  [year], AVG(PM10) AS PM10_AVG FROM TEMPTABLE GROUP BY [year]
SELECT * FROM dbo.MadridYearlyAQ
ORDER BY 1

DROP TABLE TEMPTABLE