SELECT 
    t.*
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} t
LEFT JOIN 
    {{ ref('mart__dim_locations') }} lo ON t.PUlocationID = lo.LocationID
WHERE 
    lo.LocationID IS NULL