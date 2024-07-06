import duckdb
# Path to the DuckDB database
database_path = '../nyc_transit.db'

# Connect to DuckDB database
try:
    connection = duckdb.connect(database_path)
    '''
    #Code to test SQL Connection
    connection.sql(" show bike_data;" ).show()
    connection.sql("select count(*) as "Number of rows" from bike_data;" ).show()
    '''

    tables = [
            'central_park_weather',
            'bike_data',
            'fhv_bases',
            'fhv_tripdata',
            'fhvhv_tripdata',
            'green_tripdata',
            'yellow_tripdata',
            'taxi_zones'
        ]
    for table in tables:
        print(f"Table: {table}")
        '''
        #Code if we want to print the structure of the tables as well
        # Show table structure (describe)
        describe_query = f"describe {table};"
        connection.execute(describe_query)
        describe_result = connection.fetchall()
        print("Table structure:")
        for row in describe_result:
            print(row)
        '''
        # Count rows in the table
        count_query = f"select count(*) as \"Number of rows\" from {table};"
        connection.execute(count_query)
        count_result = connection.fetchone()[0]
        print(f"Number of rows: {count_result}")
        print("-------------------------------------")

except:
    print("Error encountered in establishing connection")

