SELECT 
    DATE,
    -- Calculating the 7-day moving minimum for precipitation
    MIN(PRCP) OVER seven_days AS moving_min_prcp,
    -- Calculating the 7-day moving maximum for precipitation
    MAX(PRCP) OVER seven_days AS moving_max_prcp,
    -- Calculating the 7-day moving average for precipitation
    AVG(PRCP) OVER seven_days AS moving_avg_prcp,
    -- Calculating the 7-day moving sum for precipitation
    SUM(PRCP) OVER seven_days AS moving_sum_prcp,
    -- Calculating the 7-day moving minimum for snow
    MIN(SNOW) OVER seven_days AS moving_min_snow,
    -- Calculating the 7-day moving maximum for snow
    MAX(SNOW) OVER seven_days AS moving_max_snow,
    -- Calculating the 7-day moving average for snow
    AVG(SNOW) OVER seven_days AS moving_avg_snow,
    -- Calculating the 7-day moving sum for snow
    SUM(SNOW) OVER seven_days AS moving_sum_snow
FROM 
    {{ ref('stg__central_park_weather') }}  -- Reference to the central park weather staging table
WINDOW seven_days AS (
    -- Defining the window for the moving calculations
    ORDER BY DATE ASC
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND
                  INTERVAL 3 DAYS FOLLOWING
    )
ORDER BY 
    DATE;  -- Ordering by date to ensure the calculations are based on the correct date sequence
    