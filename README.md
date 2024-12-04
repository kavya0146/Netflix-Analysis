📊 Netflix Content Analysis Using SQL  

🎯 **Project Overview**  
In this project, we analyze Netflix's extensive content catalog to gain insights into its composition, trends, and audience preferences. Leveraging SQL, 
the analysis uncovers patterns in content types, ratings, genres, geographic diversity, and creative contributions.  By exploring the dataset, this project demonstrates
the potential of data-driven approaches in optimizing content libraries and understanding viewer behavior, offering actionable insights for the entertainment industry.  

🛠️ **Objectives**  
- Analyze the distribution of content types (Movies vs. TV Shows).  
- Identify the most common ratings and genres for Netflix titles.  
- Examine trends in release years, durations, and countries of origin.  
- Highlight contributions of top directors and cross-genre creators.  

📂 **About the Dataset**  
The dataset used for this project was sourced from Kaggle comprising details about Netflix's titles, including:  
- **Attributes**: Title, Type, Director, Cast, Country, Release Year, Rating, Duration, Genre, Description, and more.  
- **Coverage**: Over 8000 movies and TV shows available on Netflix as of mid-2021.  

📝 **Methodology**  

1. **Data Collection**  
   Dataset sourced from Kaggle, providing comprehensive information about Netflix's offerings.  

2. **Data Cleaning & Preprocessing**  
   Addressed missing values, removed duplicates, and ensured data integrity for accurate analysis.  

3. **Exploratory Data Analysis (EDA)**  
   Conducted SQL queries to identify patterns, trends, and anomalies in content types, ratings, genres, and contributions by country.  

4. **Data Visualization**  
   Created insightful visualizations to effectively communicate findings, using bar charts and pie charts for trends and comparisons.  

 📊 **Key Findings**  

- **Content Types**: Movies dominate the catalog, constituting 69.6% of the total content.  
- **Popular Ratings**: TV-MA is the most common rating for both movies and TV shows, reflecting a focus on mature audiences.  
- **Top Genres**: International Movies (2752) and Dramas (2427) are the most popular, followed by Comedies (1674).  
- **Geographic Diversity**: The U.S. leads in content contribution, followed by India and the U.K., highlighting Netflix’s global strategy.  
- **Prolific Directors**: Rajiv Chilaka leads with 22 titles, followed by Raúl Campos (18) and Marcus Raboy (16).  

 🔧 **SQL Queries Highlights**  

 1. **Count Movies vs. TV Shows** 
SELECT type, COUNT(*) as total FROM netflix_titles GROUP BY type;  

2. **Most Common Ratings**   
SELECT rating, COUNT(*) AS rating_count  
FROM netflix_titles  
WHERE type = 'Movie'  
GROUP BY rating  
ORDER BY rating_count DESC  
LIMIT 1;

SELECT rating, COUNT(*) AS rating_count
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY rating
ORDER BY rating_count DESC
LIMIT 1;

3. **Top 5 Countries by Content**  
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country, ',', n.n), ',', -1)) AS country,  
       COUNT(show_id) AS total_count  
FROM netflix_titles  
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) n  
ON CHAR_LENGTH(country) - CHAR_LENGTH(REPLACE(country, ',', '')) >= n.n - 1  
GROUP BY country  
ORDER BY total_count DESC  
LIMIT 5;  
 
4. **Top Genres**   
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre,  
       COUNT(*) AS total_count  
FROM netflix_titles  
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) n  
ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1  
GROUP BY genre  
ORDER BY total_count DESC  
LIMIT 5;

5. **Which Year had the most releases**
SELECT release_year, COUNT(*) as Count from netflix_titles GROUP BY release_year ORDER BY Count DESC LIMIT 5;

6. **Find the most prolific directors**
SELECT director, COUNT(*) AS title_count
FROM netflix_titles
WHERE director IS NOT NULL AND director != 'Unspecified'
GROUP BY director
ORDER BY title_count DESC
LIMIT 5;

7. **Directors Creating Both Horror and Comedy Movies**
SELECT director
FROM netflix_titles
WHERE director IS NOT NULL
  AND type = 'Movie'
  AND (listed_in LIKE '%Horror%' OR listed_in LIKE '%Comedy%')
GROUP BY director
HAVING SUM(listed_in LIKE '%Horror%') > 0
   AND SUM(listed_in LIKE '%Comedy%') > 0;

📈 **Visualizations**  
- Distribution of Movies vs. TV Shows.  
- Top 10 Countries by Content Contribution.  
- Genre Preferences across Movies and TV Shows.  
- Prolific Directors and their Contributions.  

🚀 **Conclusion**  
This analysis highlights the global and diverse nature of Netflix's content library, emphasizing its focus on international content, mature ratings,
and varied genres. By examining trends in production and audience preferences, the project provides actionable insights for improving content strategies in the
streaming industry.  
