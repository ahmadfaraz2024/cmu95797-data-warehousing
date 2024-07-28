-- Selecting the fare amount and calculating averages using window functions
SELECT 
    yt.fare_amount, -- Individual fare amount from yellow taxi trip data
    AVG(yt.fare_amount) OVER (PARTITION BY l.Zone) AS avg_fare_zone, -- Average fare per zone
    AVG(yt.fare_amount) OVER (PARTITION BY l.Borough) AS avg_fare_borough, -- Average fare per borough
    AVG(yt.fare_amount) OVER () AS avg_fare_overall -- Overall average fare
FROM 
    {{ ref('stg__yellow_tripdata') }} yt -- Yellow taxi trip data
JOIN
    {{ ref('mart__dim_locations') }} l ON yt.PUlocationID = l.LocationID; -- Joining with location data to get zone and borough information
