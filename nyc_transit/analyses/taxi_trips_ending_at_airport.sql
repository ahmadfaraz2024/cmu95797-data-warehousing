-- Select the total number of trips that end at airports
SELECT
    count(*) AS total_trips_to_airport
FROM 
    -- Reference the fact table containing all taxi trips
    {{ ref('mart__fact_all_taxi_trips') }} AS taxi_trips
JOIN 
    -- Join with the dimension table containing location details
    {{ ref('mart__dim_locations') }} AS locations
    ON 
    -- Ensure matching location IDs after casting to integer
    CAST(taxi_trips.DOlocationID AS INT) = locations.LocationID
WHERE 
    -- Filter for trips that end in airport service zones
    locations.service_zone IN ('Airports', 'EWR');
