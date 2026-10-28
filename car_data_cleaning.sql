-- Car data cleaning queries
-- Table: project-cc781377-6842-4add-a3a.cars.car_info (US location)
-- Note: UPDATE and DELETE change the data in a table, so they don't work in the free BigQuery sandbox.
-- These queries were run after upgrading from the sandbox.
-- The number of rows each one changed is written in its note below.
-- After each fix, the matching check query was run again to confirm the result (the notes say what it returned).

-- 30. Check the unique values in fuel_type
-- Expected: only "gas" and "diesel". The result confirms there are no unexpected values.
SELECT
  DISTINCT fuel_type
FROM `project-cc781377-6842-4add-a3a.cars.car_info`;

-- 31. Check the minimum and maximum car length
-- Result: 141.1 to 208.1, which matches the data description, so no length outliers.
SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM `project-cc781377-6842-4add-a3a.cars.car_info`;

-- 32. Find rows with a missing num_of_doors value
-- Returns 2 rows (a Dodge gas sedan and a Mazda diesel sedan), which need to be filled in.
SELECT
  *
FROM `project-cc781377-6842-4add-a3a.cars.car_info`
WHERE num_of_doors IS NULL;

-- 33. Fill in num_of_doors for Dodge gas sedans
-- The sales manager confirmed all Dodge gas sedans sold had four doors.
-- Result: modified 3 rows. Re-running the missing num_of_doors check afterwards returned 1 row (the Mazda).
-- Note: this updates every matching row, not just the null one, which is fine here because they all have four doors.
UPDATE `project-cc781377-6842-4add-a3a.cars.car_info`
SET num_of_doors = 'four'
WHERE make = 'dodge'
  AND fuel_type = 'gas'
  AND body_style = 'sedan';

-- 34. Fill in num_of_doors for Mazda diesel sedans
-- The sales manager confirmed all Mazda diesel sedans sold had four doors.
-- Result: modified 2 rows (BigQuery counts every row the WHERE clause matches, including one that already had a door value).
-- Re-running the missing num_of_doors check afterwards returned 0 rows, so no missing num_of_doors values remain.
UPDATE `project-cc781377-6842-4add-a3a.cars.car_info`
SET num_of_doors = 'four'
WHERE make = 'mazda'
  AND fuel_type = 'diesel'
  AND body_style = 'sedan';

-- 35. Check the unique values in num_of_cylinders
-- Returns 8 rows, but "two" appears twice: once spelled correctly and once as "tow" (a typo).
-- After the fix below, re-running it returns 7 rows.
SELECT
  DISTINCT num_of_cylinders
FROM `project-cc781377-6842-4add-a3a.cars.car_info`;

-- 36. Fix the "tow" typo in num_of_cylinders
-- Result: modified 1 row. Re-running the previous check afterwards returned 7 rows, with "two" appearing once.
UPDATE `project-cc781377-6842-4add-a3a.cars.car_info`
SET num_of_cylinders = 'two'
WHERE num_of_cylinders = 'tow';

-- 37. Check the minimum and maximum compression_ratio
-- Expected range is 7 to 23, but the max is 70.0, which is an error.
SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM `project-cc781377-6842-4add-a3a.cars.car_info`;

-- 38. Re-check compression_ratio excluding the value 70
-- Result: 7.0 to 23.0, which confirms 70 is the only value outside the expected range.
SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM `project-cc781377-6842-4add-a3a.cars.car_info`
WHERE compression_ratio <> 70;

-- 39. Count how many rows have the erroneous compression_ratio of 70
-- Safety check before deleting: confirms only 1 row is affected, not a large share of the data.
-- Result: 1. Re-running it after the delete below returned 0.
SELECT
  COUNT(*) AS num_of_rows_to_delete
FROM `project-cc781377-6842-4add-a3a.cars.car_info`
WHERE compression_ratio = 70;

-- 40. Delete the row with the erroneous compression_ratio of 70
-- The sales manager confirmed this row was entered in error. I counted the affected rows first, so only 1 row is deleted.
-- Result: removed 1 row.
DELETE `project-cc781377-6842-4add-a3a.cars.car_info`
WHERE compression_ratio = 70;

-- 41. Check the unique values in drive_wheels
-- Returns 4 rows: rwd, fwd, and "4wd" twice. DISTINCT shows it twice because one has a hidden extra space.
-- After the TRIM update below, re-running it returns 3 rows.
SELECT
  DISTINCT drive_wheels
FROM `project-cc781377-6842-4add-a3a.cars.car_info`;

-- 42. Check the length of each drive_wheels value
-- Confirms the cause: one "4wd" has 4 characters instead of 3, so it contains an extra space.
-- After the TRIM update below, every value has length 3 and "4wd" appears once.
SELECT
  DISTINCT drive_wheels,
  LENGTH(drive_wheels) AS string_length
FROM `project-cc781377-6842-4add-a3a.cars.car_info`;

-- 43. Remove extra spaces from drive_wheels
-- TRIM() strips leading/trailing spaces. WHERE TRUE applies the update to every row (BigQuery requires a WHERE clause).
-- Result: modified 202 rows (every row in the table, since WHERE TRUE matches all of them, not just the one with the extra space).
-- Re-running the first drive_wheels check afterwards returned 3 unique values: fwd, rwd, 4wd.
UPDATE `project-cc781377-6842-4add-a3a.cars.car_info`
SET drive_wheels = TRIM(drive_wheels)
WHERE TRUE;
