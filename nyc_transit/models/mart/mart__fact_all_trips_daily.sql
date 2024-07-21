-- This query aggregates trip data by day to calculate the total number of trips and average trip duration.
-- The data is sourced from the fact table `mart__fact_all_trips`.

SELECT
    type, 
    date_trunc('day', started_at_ts)::date AS date,  -- Truncates the timestamp to the day level and casts to date
    COUNT(*) AS trips,  -- Counts the total number of trips for each day and type
    AVG(duration_min) AS average_trip_duration_min  -- Calculates the average trip duration in minutes
FROM
    {{ ref('mart__fact_all_trips') }}  -- References the fact table containing all trip data
GROUP BY