-- DATA CLEANING AND MANIPULATION

WITH
  -- Join twelve months datasets to a year dataset
  year_data AS (
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_03`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_04`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_05`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_06`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_07`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_08`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_09`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_10`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_11`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2021_12`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2022_01`
  UNION DISTINCT
  SELECT
    *
  FROM
    `fleet-goal-340618.Cyclistic.2022_02`),
  -- Remove values with nulls
  year_data_without_null AS (
  SELECT
    *
  FROM
    year_data
  WHERE
    ride_id IS NOT NULL
    AND rideable_type IS NOT NULL
    AND started_at IS NOT NULL
    AND ended_at IS NOT NULL
    AND start_station_name IS NOT NULL
    AND start_station_id IS NOT NULL
    AND end_station_name IS NOT NULL
    AND end_station_id IS NOT NULL
    AND start_lat IS NOT NULL
    AND start_lng IS NOT NULL
    AND end_lat IS NOT NULL
    AND end_lng IS NOT NULL
    AND member_casual IS NOT NULL ),
  -- Add a new column to calculate the ride length for each id in minutes
  year_data_with_ride_length AS (
  SELECT
    *,
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length
  FROM
    year_data_without_null ),
  -- Remove rides with less than a minute duration and more than 24 hours duration
  year_data_with_valid_rides_and_ids AS (
  SELECT
    *
  FROM
    year_data_with_ride_length
  WHERE
    LENGTH(ride_id) = 16
    AND ride_length >= 1
    AND ride_length <= 1440 ),
  -- Add new column for day for the ride
  year_data_with_day_of_week AS (
  SELECT
    *,
    EXTRACT(DAYOFWEEK
    FROM
      started_at) AS day_of_week
  FROM
    year_data_with_valid_rides_and_ids ),
  -- Add a new column to change the day of the ride from numbers to words
  year_data_with_days_in_week AS (
  SELECT
    *,
    CASE
      WHEN day_of_week = 1 THEN 'Sunday'
      WHEN day_of_week = 2 THEN 'Monday'
      WHEN day_of_week = 3 THEN 'Tuesday'
      WHEN day_of_week = 4 THEN 'Wednesday'
      WHEN day_of_week = 5 THEN 'Thursday'
      WHEN day_of_week = 6 THEN 'Friday'
      WHEN day_of_week = 7 THEN 'Saturday'
    ELSE
    'Error'
  END
    AS day
  FROM
    year_data_with_day_of_week),
  -- Trim start station name to ensure no extra space and remove start station id with "Test", "TEST" and "test"
  year_data_start_trimmed AS (
  SELECT
    *,
    TRIM(start_station_name, ' ') AS start_station_name_trimmed
  FROM
    year_data_with_days_in_week
  WHERE
    start_station_id NOT LIKE '%Test%'
    AND start_station_id NOT LIKE '%TEST%'
    AND start_station_id NOT LIKE '%test%' ),
  -- Trim end station name to ensure no extra space and remove end station id with "Test", "TEST" and "test"
  year_data_start_and_end_trimmed AS (
  SELECT
    *,
    TRIM(end_station_name, ' ') AS end_station_name_trimmed
  FROM
    year_data_start_trimmed
  WHERE
    end_station_id NOT LIKE '%Test%'
    AND end_station_id NOT LIKE '%TEST%'
    AND end_station_id NOT LIKE '%test%'),
  year_data_clean AS (
  SELECT
    *
  FROM
    year_data_start_and_end_trimmed )
SELECT
  *
FROM
  year_data_clean


-- DATA ANALYSIS

-- Number of casual rides 
SELECT
  count(member_casual) as number_of_casual_rides 
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'casual'
  
 -- Number of member rides
SELECT
  count(member_casual) as number_of_member_rides 
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'member'

-- Number of casual rides per start station in descending order 
SELECT
  start_station_name,
  COUNT(start_station_name) AS number_of_casual_rides_per_start_startion
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'casual'
GROUP BY
  start_station_name
ORDER BY
  number_of_casual_rides_per_start_startion DESC
  
 -- Number of member rides per start station in descending order
 SELECT
  start_station_name,
  COUNT(start_station_name) AS number_of_member_rides_per_start_startion
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'member'
GROUP BY
  start_station_name
ORDER BY
  number_of_member_rides_per_start_startion DESC

-- Number of casual rides per end station in descending order 
SELECT
  end_station_name,
  COUNT(end_station_name) AS number_of_casual_rides_per_end_startion
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'casual'
GROUP BY
  end_station_name
ORDER BY
  number_of_casual_rides_per_end_startion DESC

-- Number of member rides per end station in descending order 
SELECT
  end_station_name,
  COUNT(end_station_name) AS number_of_member_rides_per_end_startion
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'member'
GROUP BY
  end_station_name
ORDER BY
  number_of_member_rides_per_end_startion DESC

-- Number of casual rides per day of the week
SELECT 
  day,
  COUNT(day) AS number_of_casual_rides_per_day_of_the_week
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'casual'
GROUP BY
  day
ORDER BY
  number_of_casual_rides_per_day_of_the_week DESC

-- Number of member rides per day of the week
SELECT
  day,
  COUNT(day) AS number_of_member_rides_per_day_of_the_week
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'member'
GROUP BY
  day
ORDER BY
  number_of_member_rides_per_day_of_the_week DESC

-- Average ride time of casual riders
SELECT
  AVG(ride_length) AS average_ride_time_of_casual_riders
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'casual'
  
-- Average ride time of member riders
SELECT
  AVG(ride_length) AS average_ride_time_of_member_riders
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'member'
  
 -- Number of casual rides per month
SELECT
  DATE_TRUNC(started_at, MONTH) AS month,
  COUNT(started_at) AS casual_rides_in_month
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'casual'
GROUP BY
  month
ORDER BY
  casual_rides_in_month DESC
 
 -- Number of member rides per month 
SELECT
  DATE_TRUNC(started_at, MONTH) AS month,
  COUNT(started_at) AS member_rides_in_month
FROM
  `fleet-goal-340618.Cyclistic_clean.year_data_clean`
WHERE
  member_casual = 'member'
GROUP BY
  month
ORDER BY
  member_rides_in_month DESC