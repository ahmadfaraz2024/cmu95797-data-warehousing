-- Select the zone and the count of trips originating from each zone
SELECT 
    lo.Zone, 
    COUNT(t.PUlocationID) AS trip_count
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} t
-- Join the fact table with the location dimension table on the pickup location ID
JOIN 
    {{ ref('mart__dim_locations') }} lo ON t.PUlocationID = lo.LocationID
-- Group the results by zone
GROUP BY 
    lo.Zone
-- Filter to include only those zones with fewer than 100,000 trips
HAVING 
    COUNT(t.PUlocationID) < 100000
-- Order the results alphabetically by zone
ORDER BY 
    lo.Zone ASC
