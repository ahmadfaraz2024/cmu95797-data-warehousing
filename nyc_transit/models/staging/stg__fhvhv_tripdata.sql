with source as (

    select * from {{ source('main', 'fhvhv_tripdata') }}

),

renamed as (
    select
        hvfhs_license_num,
        --creating a uniform set of base numbers across all columns
        trim(upper(dispatching_base_num)) as dispatching_base_num,
        trim(upper(originating_base_num)) as originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid::int as pulocationid,
        dolocationid::int as dolocationid,
        trip_miles,
        trip_time,
        base_passenger_fare,
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        {{convert_flag_to_boolean("shared_request_flag")}} as shared_request_flag,
        {{convert_flag_to_boolean("shared_match_flag")}} as shared_match_flag,
        {{convert_flag_to_boolean("access_a_ride_flag")}} as access_a_ride_flag,
        {{convert_flag_to_boolean("wav_request_flag")}} as wav_request_flag,
        {{convert_flag_to_boolean("wav_match_flag",)}} as wav_match_flag,
        filename

    from source

)
select * from renamed