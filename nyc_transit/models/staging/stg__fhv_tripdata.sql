with source as (
    select * from {{ source('main', 'fhv_tripdata') }}
),
renamed as (
    select
        --convert all id's to uppercase for uniformity
        trim(upper(dispatching_base_num)) as  dispatching_base_num, 
        pickup_datetime,
        dropoff_datetime,
        --type casting columns to int for uniformity
        pulocationid::int as pulocationid,
        dolocationid::int as dolocationid,
        trim(upper(affiliated_base_number)) as affiliated_base_number,
        --exclude sr_flag as it is always null
        filename
    from source
)
select * from renamed