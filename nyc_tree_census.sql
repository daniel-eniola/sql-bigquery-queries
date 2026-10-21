-- NYC tree census queries
-- Tables: bigquery-public-data.new_york_trees.tree_census_1995 / 2005 / 2015 (US location)

-- 16. Average tree trunk diameter (tree_dbh) in the 2015 NYC tree census
-- Note: LIMIT 1000 only limits the output rows. AVG() already returns a single row,
-- so the average is calculated across the whole table, not just 1,000 rows.
SELECT
  AVG(tree_dbh)
FROM `bigquery-public-data.new_york_trees.tree_census_2015`
LIMIT 1000;

-- 17. Average tree diameter in the 1995 NYC tree census
-- Uses the column "diameter" rather than "tree_dbh", which appears to be the 1995 table's naming.
-- Note: LIMIT 1000 has no effect on the average, as in #16.
SELECT
  AVG(diameter)
FROM `bigquery-public-data.new_york_trees.tree_census_1995`
LIMIT 1000;

-- 18. Average tree trunk diameter (tree_dbh) in the 2005 NYC tree census
-- Note: LIMIT 1000 has no effect on the average, as in #16.
SELECT
  AVG(tree_dbh)
FROM `bigquery-public-data.new_york_trees.tree_census_2005`
LIMIT 1000;

-- 19. Preview the first 1,000 rows of the 2005 NYC tree census
-- LIMIT 1000 keeps the preview small instead of returning the whole table.
SELECT
  *
FROM `bigquery-public-data.new_york_trees.tree_census_2005`
LIMIT 1000;
