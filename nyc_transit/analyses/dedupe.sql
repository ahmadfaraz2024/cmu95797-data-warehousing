-- Selecting all columns from the events table
SELECT * 
FROM {{ ref('events') }} -- Refers to the events.csv data set
QUALIFY 
    -- Assigning a row number to each row within the same event_id, ordered by insert_timestamp in descending order
    ROW_NUMBER() OVER (
        PARTITION BY event_id -- For each event_id, create a separate partition
        ORDER BY insert_timestamp DESC -- Order rows within each partition by insert_timestamp in descending order
    ) = 1 -- Keep only the first row in each partition
