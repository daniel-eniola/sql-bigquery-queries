-- London bicycles queries
-- Table: bigquery-public-data.london_bicycles.cycle_hire (EU location)

-- 20. Return the end station name for the bike trip with rental_id 57635395
SELECT
  end_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE rental_id = 57635395;

-- 21. Return the bike model for bike_id 58782
SELECT
  DISTINCT bike_model
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE bike_id = 58782;

-- 22. Return the rental_ids, start station ID, and start station name for all trips made by bike_id 1710
SELECT
  rental_id,
  start_station_id,
  start_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE bike_id = 1710;

-- 23. Return the station name for start_station_id 111
-- Note: many trips share the same start station, so DISTINCT returns the name once instead of one row per trip.
SELECT
  DISTINCT start_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE start_station_id = 111;

-- 24. Return the unique end station names across all bike trips
-- DISTINCT removes repeats, so each station appears once instead of once per trip (millions of rows).
-- IS NOT NULL leaves out trips with no end station recorded. Returned 957 stations.
SELECT
  DISTINCT end_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE end_station_name IS NOT NULL;

-- 25. Return duration and start station for bike trips lasting 20 minutes (1200 seconds) or longer
SELECT
  duration,
  start_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE duration >= 1200;

-- 26. Return full trip details (start and end station IDs and names) for all trips made by bike_id 1710
-- Extends the bike_id 1710 query above by adding the end station columns.
SELECT
  rental_id,
  start_station_id,
  end_station_id,
  start_station_name,
  end_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE bike_id = 1710;

-- 27. Return duration and start station for bike trips LONGER than 20 minutes (1200 seconds)
-- Variation of the 20-minutes-or-longer query: uses > instead of >=, so trips of exactly 1200 seconds are excluded.
SELECT
  duration,
  start_station_name
FROM `bigquery-public-data.london_bicycles.cycle_hire`
WHERE duration > 1200;
