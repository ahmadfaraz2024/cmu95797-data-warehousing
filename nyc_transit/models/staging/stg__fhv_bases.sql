with source as (

    select * from {{ source('main', 'fhv_bases') }}

),
renamed as (
    select
        trim(upper(base_number)) as base_number,   -- creating uniform base number columns to maintain consistecy acorss columns to use as a foreign key
        base_name,
        dba,
        dba_category,
        filename
    from source
)
select * from renamed