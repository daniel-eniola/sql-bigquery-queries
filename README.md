# BigQuery Practice Queries

A collection of 49 SQL queries I ran in Google BigQuery (sandbox), grouped by topic. Each query has a short note explaining what it does.

| File | Queries | Dataset |
|---|---|---|
| `customer_address_cleaning.sql` | #1-8, #28-29 | `customer_data.customer_address` (my own project) |
| `solar_potential.sql` | #9-10 | `bigquery-public-data.sunroof_solar` |
| `baby_names.sql` | #11-15 | `babynames.names_2014/2015/2016` (my own project) |
| `nyc_tree_census.sql` | #16-19 | `bigquery-public-data.new_york_trees` |
| `london_bicycles.sql` | #20-27 | `bigquery-public-data.london_bicycles` |
| `car_data_cleaning.sql` | #30-43 | `cars.car_info` (my own project, from the Coursera "Clean data using SQL" activity) |
| `store_transactions.sql` | #44-49 | `customer_data.customer_purchase` (my own project) |
| `customer_purchase_schema.json` | setup, no queries | Schema for `customer_data.customer_purchase` |

## Skills practised

- Selecting columns, `DISTINCT`, `WHERE` filters
- String functions: `LENGTH`, `SUBSTR`, `TRIM`
- Sorting and limiting: `ORDER BY`, `ASC`/`DESC`, `LIMIT`
- Aggregation: `AVG`
- Comparison operators: `>` vs `>=`
- Data changes: `INSERT INTO ... VALUES`, `UPDATE ... SET ... WHERE` and `DELETE ... WHERE`
- Data cleaning checks: `IS NULL`, `COUNT(*)`, spotting typos and hidden spaces with `DISTINCT` and `LENGTH`, fixing with `TRIM`
- Type conversion and dates: `CAST` (to FLOAT64 and DATE) and `BETWEEN` on a DATETIME column
- Combining and filling values: `CONCAT` and `COALESCE`

## Notes

- **DML in the sandbox:** queries #28 (`INSERT`), #29, #33, #34, #36 and #43 (`UPDATE`), and #40 (`DELETE`) did not run, because BigQuery's free sandbox does not allow DML. They fail with "Billing has not been enabled for this project". They are included for reference.
- **Locations:** the London bicycles dataset lives in the EU, so those queries run in the EU location. The others run in the US.
- **`LIMIT` with `AVG`:** in `nyc_tree_census.sql`, `LIMIT 1000` does not restrict how many rows are averaged. `AVG()` already returns one row, so it averages the whole table.
- **Numbers stored as text:** in `customer_purchase`, `purchase_price` is a STRING on purpose. Sorting it directly orders it alphabetically ("89.85" above "799.99"), so convert it with `CAST(purchase_price AS FLOAT64)` first.

## Table setup: `customer_purchase`

The `customer_purchase` table (used in `store_transactions.sql`) was created in the `customer_data` dataset by uploading the Store Transaction .csv, with the schema edited as text instead of auto-detected. The full schema is saved in `customer_purchase_schema.json`.

`purchase_price` is a STRING on purpose, so it can be converted with `CAST` in the queries.

**Header rows to skip:** in Advanced options, set **Header rows to skip** to `1`. Don't skip this step, or you will get parsing errors, because BigQuery will try to apply the schema to the title row.
