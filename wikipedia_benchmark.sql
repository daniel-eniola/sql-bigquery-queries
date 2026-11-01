-- Wikipedia page views queries
-- Tables: bigquery-samples.wikipedia_benchmark.Wiki10B / Wiki100B (US location)

-- 51. Count how many times each Wikipedia page with "Google" in its title was viewed, by language
-- The table has 10 billion rows. LIKE '%Google%' matches any title containing "Google"; SUM(views) with GROUP BY adds up the views by language and title.
-- ORDER BY views DESC puts the most viewed pages first. Returned 214,710 rows.
SELECT
  language,
  title,
  SUM(views) AS views
FROM
  `bigquery-samples.wikipedia_benchmark.Wiki10B`
WHERE
  title LIKE '%Google%'
GROUP BY
  language,
  title
ORDER BY
  views DESC;

-- 52. Return the top 10 most viewed English Wikipedia pages with "Google" in the title
-- Adds language = 'en' to keep English pages only, so GROUP BY title is enough. LIMIT 10 keeps just the top 10 rows.
SELECT
  title,
  SUM(views) AS views
FROM
  `bigquery-samples.wikipedia_benchmark.Wiki10B`
WHERE
  language = 'en'
  AND title LIKE '%Google%'
GROUP BY
  title
ORDER BY
  views DESC
LIMIT 10;
