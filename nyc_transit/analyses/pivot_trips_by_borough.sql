-- Pivot the trips by borough from the 'mart__fact_trips_by_borough' table.

WITH pivot_data AS (
    SELECT 
        borough,
        trips
    FROM 
        {{ ref('mart__fact_trips_by_borough') }}
)

-- Use dbt_utils to dynamically generate columns for each borough.
SELECT 
    {{ dbt_utils.pivot(
        'borough', 
        dbt_utils.get_column_values(ref('mart__fact_trips_by_borough'), 'borough'), 
        then_value='trips'
    ) }}
FROM 
    pivot_data;
