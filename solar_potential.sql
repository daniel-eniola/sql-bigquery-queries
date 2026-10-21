-- Solar potential queries
-- Table: bigquery-public-data.sunroof_solar.solar_potential_by_postal_code (US location)

-- 9. Used to pull out all columns from the table
SELECT
  *
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`;

-- 10. Filter results to only return rows where the state is Pennsylvania
SELECT
  *
FROM `bigquery-public-data.sunroof_solar.solar_potential_by_postal_code`
WHERE state_name = 'Pennsylvania';
