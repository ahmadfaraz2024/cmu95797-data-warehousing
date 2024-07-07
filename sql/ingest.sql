-- enabling the echo to print out the code
.echo on

-- ingest central_park_weather - 
create table if not exists central_park_weather as select * from read_csv_auto('./data/central_park_weather.csv', filename=True);

-- ingest citibike-tripdata - 
create table if not exists bike_data as select * from read_csv_auto('./data/citibike-tripdata.csv.gz',union_by_name=True, filename=True, all_varchar=1);

-- ingest fhv_bases - 
create table if not exists fhv_bases as select * from read_csv_auto('./data/fhv_bases.csv', filename=True);

-- ingest fhv_tripdata -
create table if not exists fhv_tripdata as select * from read_parquet('./data/taxi/fhv_tripdata.parquet', union_by_name=true, filename=true);

-- ingest fhvhv_tripdata -
create table if not exists fhvhv_tripdata as select * from read_parquet('./data/taxi/fhvhv_tripdata.parquet', union_by_name=true, filename=true);

-- ingest green_tripdata - 
create table if not exists green_tripdata as select * from read_parquet('./data/taxi/green_tripdata.parquet', union_by_name=true, filename=true);

-- ingest yellow_tripdata - 
create table if not exists yellow_tripdata as select * from read_parquet('./data/taxi/yellow_tripdata.parquet', union_by_name=true, filename=true);

-- ingest taxi_zones shapefile data
LOAD spatial;
create table if not exists taxi_zones as select * from st_read('./data/taxi_zones/taxi_zones.shp');

