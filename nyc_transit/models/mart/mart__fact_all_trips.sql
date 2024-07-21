-- Define a common table expression (CTE) to unify and rename trip data from various sources
with trips_renamed as (
    -- Select data from bike data table and assign type as 'bike'
    select 
        'bike' as type, 
        started_at_ts, 
        ended_at_ts 
    from {{ ref('stg__bike_data') }}

    union all

    -- Select data from FHV trip data table and assign type as 'fhv'
    select 
        'fhv' as type, 
        pickup_datetime as started_at_ts, 
        dropoff_datetime as ended_at_ts 
    from {{ ref('stg__fhv_tripdata') }}

    union all

    -- Select data from FHVHV trip data table and assign type as 'fhvhv'
    select 
        'fhvhv' as type, 
        pickup_datetime as started_at_ts, 
        dropoff_datetime as ended_at_ts 
    from {{ ref('stg__fhvhv_tripdata') }}

    union all

    -- Select data from Green trip data table and assign type as 'green'
    select 
        'green' as type, 
        lpep_pickup_datetime as started_at_ts, 
        lpep_dropoff_datetime as ended_at_ts 
    from {{ ref('stg__green_tripdata') }}

    union all

    -- Select data from Yellow trip data table and assign type as 'yellow'
    select 
        'yellow' as type, 
        tpep_pickup_datetime as started_at_ts, 
        tpep_dropoff_datetime as ended_at_ts 
    from {{ ref('stg__yellow_tripdata') }}
)

-- Final selection from the unified trips_renamed CTE
select
    type,                       -- Trip type ('bike', 'fhv', 'fhvhv', 'green', 'yellow')
    started_at_ts,              -- Start datetime of the trip
    ended_at_ts,                -- End datetime of the trip
    datediff('minute', started_at_ts, ended_at_ts) as duration_min, -- Trip duration in minutes
    datediff('second', started_at_ts, ended_at_ts) as duration_sec  -- Trip duration in seconds
from 
    trips_renamed
