-- Baby names queries
-- Tables: project-cc781377-6842-4add-a3a.babynames.names_2014 / names_2015 / names_2016

-- 11. Return the top 5 most popular male baby names in 2014, ranked by count
SELECT
  name,
  count
FROM `project-cc781377-6842-4add-a3a.babynames.names_2014`
WHERE gender = 'M'
ORDER BY count DESC
LIMIT 5;

-- 12. Return the top 5 most popular male baby names in 2015, ranked by count
-- Same as #11 but for 2015. DESC puts the highest counts first; LIMIT 5 keeps the top five.
SELECT
  name,
  count
FROM `project-cc781377-6842-4add-a3a.babynames.names_2015`
WHERE gender = 'M'
ORDER BY count DESC
LIMIT 5;

-- 13. Return the top 5 most popular female baby names in 2015, ranked by count
-- (The original note said 2014, but the table is names_2015, so the note was corrected.)
SELECT
  name,
  count
FROM `project-cc781377-6842-4add-a3a.babynames.names_2015`
WHERE gender = 'F'
ORDER BY count DESC
LIMIT 5;

-- 14. Return the 5 least common female baby names in 2016
-- ORDER BY count ASC sorts from lowest to highest, so LIMIT 5 returns the rarest names.
SELECT
  name,
  count
FROM `project-cc781377-6842-4add-a3a.babynames.names_2016`
WHERE gender = 'F'
ORDER BY count ASC
LIMIT 5;

-- 15. Return the top 5 most popular female baby names in 2014, ranked by count
-- Counterpart to #13 (female, 2015) and #11 (male, 2014).
SELECT
  name,
  count
FROM `project-cc781377-6842-4add-a3a.babynames.names_2014`
WHERE gender = 'F'
ORDER BY count DESC
LIMIT 5;
