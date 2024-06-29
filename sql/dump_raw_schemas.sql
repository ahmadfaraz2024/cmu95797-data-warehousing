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