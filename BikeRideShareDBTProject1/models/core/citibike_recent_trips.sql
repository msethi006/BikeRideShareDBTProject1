{{ config(materialized='view') }}

WITH recent_trips AS (
    SELECT
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        start_station_name,
        end_station_name,
        member_casual
    FROM {{ source('citibike_data', 'citibike_trips') }}
    ORDER BY started_at DESC  -- Sort by the most recent rides first
    LIMIT 100  -- Fetch the last 100 records (adjust as needed)
)

SELECT * FROM recent_trips
