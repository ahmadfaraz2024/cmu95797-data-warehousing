-- sql/dump_raw_schemas.sql
.echo on

-- show table names
pragma show_tables;

-- describe the schema for each of the tables
describe central_park_weather;
describe bike_data;
describe fhv_bases;
describe fhv_tripdata;
describe fhvhv_tripdata;
describe green_tripdata;
describe yellow_tripdata;
describe taxi_zones;

-- views in week 2
describe main_staging.stg__fhv_bases;
describe main_staging.stg__fhv_tripdata;       
describe main_staging.stg__fhvhv_tripdata;    
describe main_staging.stg__green_tripdata;    
describe main_staging.stg__yellow_tripdata;              
describe main_staging.stg__bike_data;                  
describe main_staging.stg__central_park_weather;
