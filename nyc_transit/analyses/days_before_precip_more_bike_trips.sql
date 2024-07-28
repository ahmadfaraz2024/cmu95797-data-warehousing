

-- Joining weather days with non-weather days of the previous day could be problematic since it doesn't consider only the day before precipitation therefore a Lag function can help. 

-- Attempt 2--


WITH weather_info AS (
    SELECT
        date,
        (prcp + snow) > 0 AS weather_occurred
    FROM 
        {{ ref('stg__central_park_weather') }}
),

trip_comparison AS (
    SELECT
        w.date,
        w.weather_occurred,
        LAG(w.weather_occurred) OVER (ORDER BY w.date) AS previous_day_weather,
        t.trips AS current_day_trips,
        LEAD(t.trips) OVER (ORDER BY t.date) AS next_day_trips
    FROM 
        weather_info w
    JOIN 
        {{ ref('mart__fact_all_trips_daily') }} t ON w.date = t.date AND t.type = 'bike'
)

SELECT 
    AVG(next_day_trips - current_day_trips) AS avg_trip_change_before_weather
FROM 
    trip_comparison
WHERE 
    weather_occurred AND NOT previous_day_weather;



