with source as (
    select * from {{ source('main', 'yellow_tripdata') }}
),
renamed as (
    select
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count::int as passenger_count,
        trip_distance,
        ratecodeid,
        {{convert_flag_to_boolean("store_and_fwd_flag")}} as store_and_fwd_flag,
        pulocationid::int as pulocationid,
        dolocationid::int as dolocationid,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        congestion_surcharge,
        airport_fee,
        filename
    from source
        -- drop rows beyond the specified end date as they could be eroneous values
        WHERE tpep_pickup_datetime < TIMESTAMP '2022-12-31' 
        -- trip_distance should always be positive
          AND trip_distance >= 0 
          AND mta_tax >= 0 -- drop negative mta_tax
          AND tip_amount >= 0 -- drop negative tip_amount
          AND tolls_amount >= 0 -- drop negative tolls_amount
)
select * from renamed