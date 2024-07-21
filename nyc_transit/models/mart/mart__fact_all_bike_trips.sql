SELECT
    started_at_ts,  -- Timestamp when the bike trip started
    ended_at_ts,    -- Timestamp when the bike trip ended
    datediff('minute', started_at_ts, ended_at_ts) AS duration_min,  -- Calculates the duration of the trip in minutes
    datediff('second', started_at_ts, ended_at_ts) AS duration_sec,   -- Calculates the duration of the trip in seconds
    start_station_id,  -- ID of the station where the trip started
    end_station_id     -- ID of the station where the trip ended
FROM 
    {{ ref('stg__bike_data') }}  -- References the staging table containing bike trip data
