-- Customer address cleaning queries
-- Table: project-cc781377-6842-4add-a3a.customer_data.customer_address

-- 1. List every customer_id in the address table (duplicates included).
SELECT
  customer_id
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`;

-- 2. List unique customer IDs only.
-- DISTINCT removes repeats, so each customer appears once even if they have several addresses.
SELECT
  DISTINCT customer_id
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`;

-- 3. Count the characters in each country value.
-- LENGTH() returns the string length; used here to spot inconsistent entries, e.g. "US" vs "USA".
SELECT
  LENGTH(country) AS letters_in_country
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`;

-- 4. Find country values longer than 2 characters.
-- Data-cleaning check: country codes should be 2 letters, so anything longer is suspect.
SELECT
  country
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`
WHERE LENGTH(country) > 2;

-- 5. Get customer IDs where the country starts with "US".
-- SUBSTR(country, 1, 2) takes the first two characters, so this catches "US", "USA", etc.
SELECT
  customer_id
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`
WHERE SUBSTR(country, 1, 2) = 'US';

-- 6. Same as the previous query, but unique customers only.
-- Preferred version: DISTINCT prevents counting a customer twice.
SELECT
  DISTINCT customer_id
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`
WHERE SUBSTR(country, 1, 2) = 'US';

-- 7. Find state values longer than 2 characters.
-- Data-cleaning check: US state abbreviations should be 2 letters, so this flags full names or typos.
SELECT
  state
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`
WHERE LENGTH(state) > 2;

-- 8. Get unique customer IDs in Ohio, ignoring stray spaces.
-- TRIM() strips leading/trailing spaces so " OH" or "OH " still matches 'OH'.
SELECT
  DISTINCT customer_id
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_address`
WHERE TRIM(state) = 'OH';

-- ---------------------------------------------------------------------------
-- Data-changing (DML) queries
-- INSERT, UPDATE and DELETE change the data in a table, so they don't work in the
-- free BigQuery sandbox. These two were run after upgrading from the sandbox.
-- ---------------------------------------------------------------------------

-- 28. Insert a new customer address record
-- Adds a new row to the customer_address table for a customer with their name, address, city, state, zipcode, and country.
-- Result: added 1 row. A SELECT for customer_id 2645 afterwards returned exactly 1 row.
-- Note: zipcode is a number column, so 49202 is written without quotes (a STRING column would need '49202').
INSERT INTO `project-cc781377-6842-4add-a3a.customer_data.customer_address`
  (customer_id, name, address, city, state, zipcode, country)
VALUES
  (2645, 'Rachel DeSantos', '333 SQL Road', 'Jackson', 'MI', 49202, 'US');

-- 29. Update an existing customer's address
-- Updates the address field for the customer with customer_id = 2645 in the customer_address table.
-- Result: modified 1 row. A SELECT for customer_id 2645 afterwards showed the address "123 New Address".
-- Note: the WHERE clause is essential. Without it, every row's address would be overwritten.
UPDATE `project-cc781377-6842-4add-a3a.customer_data.customer_address`
SET address = '123 New Address'
WHERE customer_id = 2645;
