
-- Attempt 1-- 

/*
-- Select days with precipitation or snowfall along with trip counts
WITH weather_days AS (
    SELECT 
        date, 
        trips
    FROM 
        {{ ref('stg__daily_citi_bike_trip_counts_and_weather') }}
    WHERE 
        precipitation > 0 OR snowfall > 0
),

-- Select all days and shift the date back by one day to compare with weather days
previous_days AS (
    SELECT 
        date - INTERVAL '1 day' AS date, 
        trips
    FROM 
        {{ ref('stg__daily_citi_bike_trip_counts_and_weather') }}
),

-- Join weather days with the previous days to find the number of bike trips on the day before a weather event
weather_days_and_previous_days AS (
    SELECT 
        w.date AS weather_date, 
        w.trips AS weather_day_trips,
        p.date AS previous_date, 
        p.trips AS previous_day_trips
    FROM 
        weather_days w
    LEFT JOIN 
        previous_days p ON w.date = p.date + INTERVAL '1 day'
)

-- Calculate the average number of trips on weather days and the days immediately preceding weather days
SELECT 
    ROUND(AVG(weather_day_trips))::INTEGER AS avg_trips_on_days_with_weather,
    ROUND(AVG(previous_day_trips))::INTEGER AS avg_trips_on_days_before_weather
FROM 
    weather_days_and_previous_days;

*/