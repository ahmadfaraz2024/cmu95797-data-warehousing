SELECT 
    DATE, 
    (LAG(PRCP, 3) OVER (ORDER BY DATE) +   -- Precipitation 3 days before
     LAG(PRCP, 2) OVER (ORDER BY DATE) +   -- Precipitation 2 days before
     LAG(PRCP, 1) OVER (ORDER BY DATE) +   -- Precipitation 1 day before
     PRCP +                                -- Precipitation on the current day
     LEAD(PRCP, 1) OVER (ORDER BY DATE) +  -- Precipitation 1 day after
     LEAD(PRCP, 2) OVER (ORDER BY DATE) +  -- Precipitation 2 days after
     LEAD(PRCP, 3) OVER (ORDER BY DATE)) / 7.0 AS moving_avg_prcp  -- Precipitation 3 days after
FROM 
    {{ ref('stg__central_park_weather') }}  -- Reference to the central park weather staging table
ORDER BY 
    DATE;  -- Ordering by date to ensure the window functions work correctly
