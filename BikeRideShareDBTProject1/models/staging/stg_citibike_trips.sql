{{ config(materialized='view') }}

WITH base AS (
    SELECT
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        start_station_name,
        start_station_id,
        end_station_name,
        end_station_id,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        member_casual
    FROM {{ source('citibike_data', 'citibike_trips') }}
),

-- Example: add a derived column for ride duration in minutes
enhanced AS (
    SELECT
        *,
        DATE_PART('minute', ended_at - started_at) 
          + DATE_PART('hour', ended_at - started_at)*60 
          AS ride_duration_minutes
    FROM base
)

SELECT * FROM enhanced
