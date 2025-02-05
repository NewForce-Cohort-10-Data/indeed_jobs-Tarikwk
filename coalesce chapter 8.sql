-- Display Country name, 4-digit year, count of Nobel prize winners (where the count is ≥ 1), and country size:
-- Large: Population > 100 million
-- Medium: Population between 50 and 100 million (inclusive)
-- Small: Population < 50 million
-- Sort results so that the country and year with the largest number of Nobel prize winners appear at the top.

SELECT c.country,
	   DATE_PART ('YEAR',cs.year::DATE) AS year,
	   SUM (cs.nobel_prize_winners) AS nobel_winners,
	   CASE
	   		WHEN cs.pop_in_millions::NUMERIC > 100 THEN 'Large'
			WHEN cs.pop_in_millions::NUMERIC BETWEEN 50 AND 100 THEN 'Medium'
			WHEN cs.pop_in_millions::NUMERIC < 50 THEN 'SMALL'
 		END AS Population 
FROM country_stats AS cs
INNER JOIN countries AS c
ON c.id = cs.country_id
WHERE cs.nobel_prize_winners >= 1
GROUP BY c.country, cs.year, cs.pop_in_millions
ORDER BY nobel_winners DESC; 

SELECT countries.country,
	   DATE_PART ('YEAR',country_stats.year::DATE) AS year,
	   COALESCE (country_stats.gdp::VARCHAR, 'unknown') AS gdp_amount
FROM country_stats
INNER JOIN countries
ON countries.id = country_stats.country_id;
