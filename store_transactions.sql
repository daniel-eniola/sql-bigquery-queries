-- Store transactions queries
-- Table: project-cc781377-6842-4add-a3a.customer_data.customer_purchase (US location)
-- Setup: the table was created from the Store Transaction .csv inside the existing customer_data dataset,
-- with the schema edited as text (see customer_purchase_schema.json) and "Header rows to skip" set to 1.
-- Columns: date (DATETIME); transaction_id, customer_id, purchase_size (INTEGER);
-- product, product_code, product_color (STRING); product_price, revenue (FLOAT);
-- purchase_price (STRING, deliberately, so that CAST can be practised).

-- 44. Sort purchase_price from highest to lowest
-- Note: purchase_price is stored as a STRING, so ORDER BY sorts it as text, character by character.
-- That is why "89.85" appears above "799.99" and "1000" ends up at the bottom of the 29 rows. See #45 for the fix.
SELECT
  purchase_price
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_purchase`
ORDER BY purchase_price DESC;

-- 45. Sort purchase_price from highest to lowest as a number
-- CAST(purchase_price AS FLOAT64) converts the text to a number first, so the sort is numeric and 1000.0 comes first.
-- Note: there is no alias, so BigQuery names the output column f0_. Add "AS purchase_price_num" for a clearer name.
SELECT
  CAST(purchase_price AS FLOAT64)
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_purchase`
ORDER BY CAST(purchase_price AS FLOAT64) DESC;

-- 46. Return the date and purchase price of transactions made in December 2020
-- BETWEEN includes both end dates. Returned 4 rows (12 Dec, 28 Dec twice, 30 Dec).
-- Note: date is a DATETIME, so '2020-12-31' means 2020-12-31 00:00:00. A purchase made later on 31 Dec would be left out.
SELECT
  date,
  purchase_price
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_purchase`
WHERE date BETWEEN '2020-12-01' AND '2020-12-31';

-- 47. Return the December 2020 transactions with the date only (no time)
-- Same filter as #46, but CAST(date AS date) converts the DATETIME to a DATE, so 2020-12-12T00:00:00 shows as 2020-12-12.
-- Returned the same 4 rows. The alias date_only names the new column.
SELECT
  CAST(date AS date) AS date_only,
  purchase_price
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_purchase`
WHERE date BETWEEN '2020-12-01' AND '2020-12-31';

-- 48. Build a new product code for couches by joining the product code and the colour
-- CONCAT() joins text values with no separator, so SKU31871 + grey becomes SKU31871grey.
-- Returned 9 rows. Every couch shares the code SKU31871, so the colour (grey, blue, purple, white, brown, black) tells the variants apart.
SELECT
  CONCAT(product_code, product_color) AS new_product_code
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_purchase`
WHERE product = 'couch';

-- 49. Show the product name, or the product code when the name is missing
-- COALESCE() returns the first value that is not NULL, so it uses product where there is one and falls back to product_code.
-- Returned 29 rows. The last two (SKU77417 and SKU13351) are rows where product is NULL.
SELECT
  COALESCE(product, product_code) AS product_info
FROM `project-cc781377-6842-4add-a3a.customer_data.customer_purchase`;
