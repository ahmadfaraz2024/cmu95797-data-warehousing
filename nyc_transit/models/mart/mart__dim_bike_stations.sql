SELECT
    DISTINCT  -- Ensures only unique rows are returned
    start_station_id AS station_id,  -- Maps start station ID to a generic column name
    start_station_name AS station_name,  -- Maps start station name to a generic column name
    start_lat AS station_lat,  -- Maps start latitude to a generic column name
    start_lng AS station_lng  -- Maps start longitude to a generic column name
FROM 
    {{ ref('stg__bike_data') }}  -- References the staging table with bike trip data
UNION
SELECT
    DISTINCT  -- Ensures only unique rows are returned
    end_station_id AS station_id,  -- Maps end station ID to a generic column name
    end_station_name AS station_name,  -- Maps end station name to a generic column name
    end_lat AS station_lat,  -- Maps end latitude to a generic column name
    end_lng AS station_lng  -- Maps end longitude to a generic column name
FROM 
    {{ ref('stg__bike_data') }}  -- References the same staging table with bike trip data
