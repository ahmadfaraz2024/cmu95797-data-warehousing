with source as (

    select * from {{ source('main', 'green_tripdata') }}

),
renamed as (
    select
        vendorid,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        {{convert_flag_to_boolean("store_and_fwd_flag")}} as store_and_fwd_flag,        
        ratecodeid,
        pulocationid::int as pulocationid,
        dolocationid::int as dolocationid,
        -- performing a type cast on the passenger_count so its always an integer
        passenger_count::int as passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        --The ehail_fee column needs to be excluded from the data as all values are null
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type,
        congestion_surcharge,
        filename
    from source
      WHERE lpep_pickup_datetime < TIMESTAMP '2022-12-31' -- drop rows in the future
        AND trip_distance >= 0 -- drop negative trip_distance
        AND mta_tax >= 0 -- drop negative mta_tax
        AND tip_amount >= 0 -- drop negative tip_amount
        AND tolls_amount >= 0  -- drop negative tolls amount
)
select * from renamed