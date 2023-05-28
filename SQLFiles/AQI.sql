-- Looking at only the interesting columns (Country, City, AQI Value, AQI Category, Lat and Lng)
-- Where there are no null values
SELECT Country, City, "AQI Value", "AQI Category", lat, lng FROM AQI_Original
WHERE 
    Country IS NOT NULL
    AND City IS NOT NULL
    AND "AQI Value" IS NOT NULL
    AND "AQI Category" IS NOT NULL
    AND lat IS NOT NULL
    AND lng IS NOT NULL
ORDER BY Country, City

-- Checking for duplicate values in the above statement (There are none)
WITH cte AS (
    SELECT 
        Country, 
        City, 
        "AQI Value", 
        "AQI Category", 
        lat, 
        lng,
        ROW_NUMBER() OVER (
            PARTITION BY 
                Country,
                City
            ORDER BY
                Country,
                City
        ) row_num
     FROM 
        AQI_Original
    WHERE 
        Country IS NOT NULL
        AND City IS NOT NULL
        AND "AQI Value" IS NOT NULL
        AND "AQI Category" IS NOT NULL
        AND lat IS NOT NULL
        AND lng IS NOT NULL
)

SELECT * FROM cte
WHERE row_num > 1
ORDER BY Country, City