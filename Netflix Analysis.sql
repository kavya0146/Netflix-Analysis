create database netflix_new;
use netflix_new;

select * from netflix_titles;

# DATA CLEANING:
select * from netflix_titles where show_id is NULL;
select * from netflix_titles where type is NULL;
select * from netflix_titles where title is NULL;
select * from netflix_titles where director is NULL;
set sql_safe_updates=0;
UPDATE netflix_titles set director= 'Unknown' where director is NULL;
select * from netflix_titles where cast is NULL;
UPDATE netflix_titles set cast= 'Unknown' where cast is NULL;
select count(*) from netflix_titles where cast is NULL;
select count(*) from netflix_titles where country is NULL;
UPDATE netflix_titles set country= 'Unknown' where country is NULL;
select count(*) from netflix_titles where country is NULL;
select count(*) from netflix_titles where date_added is NULL;
# to convert the date column:
SELECT STR_TO_DATE(date_added, '%m %d ,%Y') AS date
FROM netflix_titles ;
UPDATE netflix_titles
SET date_added = STR_TO_DATE(date_added, '%M %d, %Y');


# DATA ANALYSIS
# Count the Number of Movies vs TV Shows:
SELECT type, COUNT(*) as total FROM netflix_titles GROUP BY type;

#Find the Most Common Rating for Movies and TV Shows:
-- Find the most common rating for Movies
SELECT rating, COUNT(*) AS rating_count
FROM netflix_titles
WHERE type = 'Movie'
GROUP BY rating
ORDER BY rating_count DESC
LIMIT 1;

-- Find the most common rating for TV Shows
SELECT rating, COUNT(*) AS rating_count
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY rating
ORDER BY rating_count DESC
LIMIT 1;

#  Find out the top 5 countries with the most content on Netflix:
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country, ',', n.n), ',', -1)) AS new_country,
       COUNT(show_id) AS total_count
FROM netflix_titles
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION 
      SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) n 
ON CHAR_LENGTH(country) - CHAR_LENGTH(REPLACE(country, ',', '')) >= n.n - 1
GROUP BY new_country
ORDER BY total_count DESC 
LIMIT 5;

#  Most popular Genres on Netflix:


SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre,
       COUNT(*) AS total_count
FROM netflix_titles
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION 
      SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) n 
ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1
GROUP BY genre
ORDER BY total_count DESC 
LIMIT 5;

#  Which Year had the most releases?
select release_year,count(*) from netflix_titles group by release_year order by count(*) desc limit 5;

#  To identify the Longest Movie:
SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;

# To find the most prolific directors
SELECT director, COUNT(*) AS title_count
FROM netflix_titles
WHERE director IS NOT NULL AND director != 'Unspecified'
GROUP BY director
ORDER BY title_count DESC
LIMIT 5;

# Directors Creating Both Horror and Comedy Movies:
SELECT director
FROM netflix_titles
WHERE director IS NOT NULL
  AND type = 'Movie'
  AND (listed_in LIKE '%Horror%' OR listed_in LIKE '%Comedy%')
GROUP BY director
HAVING SUM(listed_in LIKE '%Horror%') > 0
   AND SUM(listed_in LIKE '%Comedy%') > 0;




