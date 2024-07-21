SELECT 
    l.borough,  -- The borough where the pickup location is situated
    COUNT(t.*) AS trips  -- Total number of trips for each borough
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} t  -- Fact table containing taxi trip details
JOIN 
    {{ ref('mart__dim_locations') }} l  -- Dimension table containing location details
ON 
    t.pulocationid = l.locationid  -- Join condition: matching pickup location ID from fact table to location ID in dimension table
-- Including borough information by joining on the pickup location ID
GROUP BY all