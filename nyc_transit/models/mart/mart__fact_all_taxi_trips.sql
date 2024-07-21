-- common table expression for renaming and unifying trip data
with trips_renamed as (
    -- Select data from FHV trip table and assign type as 'fhv'
    select 
        'fhv' as type, 
        pickup_datetime, 
        dropoff_datetime, 
        pulocationid, 
        dolocationid
    from {{ ref('stg__fhv_tripdata') }}

    union all

    -- Select data from FHVHV trip table and assign type as 'fhvhv'
    select 
        'fhvhv' as type, 
        pickup_datetime, 
        dropoff_datetime, 
        pulocationid, 
        dolocationid
    from {{ ref('stg__fhvhv_tripdata') }}

    union all

    -- Select data from Green trip table and assign type as 'green'
    select 
        'green' as type, 
        lpep_pickup_datetime as pickup_datetime, 
        lpep_dropoff_datetime as dropoff_datetime, 
        pulocationid, 
        dolocationid
    from {{ ref('stg__green_tripdata') }}

    union all

    -- Select data from Yellow trip table and assign type as 'yellow'
    select 
        'yellow' as type, 
        tpep_pickup_datetime as pickup_datetime, 
        tpep_dropoff_datetime as dropoff_datetime, 
        pulocationid, 
        dolocationid
    from {{ ref('stg__yellow_tripdata') }}
)

-- Final selection from the unified trips_renamed CTE
select
    type,                       -- Trip type ('fhv', 'fhvhv', 'green', 'yellow')
    pickup_datetime,            -- Pickup datetime of the trip
    dropoff_datetime,           -- Dropoff datetime of the trip
    datediff('minute', pickup_datetime, dropoff_datetime) as duration_min, -- Trip duration in minutes
    datediff('second', pickup_datetime, dropoff_datetime) as duration_sec, -- Trip duration in seconds
    pulocationid,               -- Pickup location ID
    dolocationid                -- Dropoff location ID
from 
    trips_renamed
