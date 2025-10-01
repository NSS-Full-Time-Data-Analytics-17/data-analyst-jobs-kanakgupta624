-- Q1 How many rows are in the data analyst table?
--A: 1793
SELECT COUNT(*) AS row_count
FROM data_analyst_jobs;

--Q2 Look at the first 10 rows. What company is associated with the tenth row?
--A:ExxonMobil
SELECT *
FROM data_analyst_jobs
LIMIT 10;

--Q3 How many postings are in TN? How many in TN or KY?
--A: 21 for TN, 27 for TN and KY
SELECT COUNT(title) AS tn_jobs
FROM data_analyst_jobs
WHERE location ILIKE 'TN';

SELECT COUNT(title) AS tn_jobs
FROM data_analyst_jobs
WHERE (location ILIKE 'TN') OR (location ILIKE 'KY');

--Q4 How many TN postings have star rating above 4?
-- A: 3
 SELECT COUNT(title) AS tn_4star_jobs
 FROM data_analyst_jobs
 WHERE (location ILIKE 'TN') AND (star_rating > 4);

 --Q5 How many postings have a 500-1000 review count?
 -- A: 151
 SELECT COUNT(title) as highreviewjobs
 FROM data_analyst_jobs
 WHERE review_count BETWEEN 500 AND 1000;

 --Q6 Show AVG star rating for companies in each state. Which state has the hightest avg rating?
-- A: Nevada
SELECT location AS state,
 		AVG(star_rating) as avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY AVG(star_rating) DESC;

--Q7 Show unique job titles. How many?
-- A: 881
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--Q8 How many unique jobs are there in California?
--A: 230
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location LIKE 'CA';

--Q9 List the name and avg star rating for companies with more than 5000 reviews. How many? 
-- A: 40
SELECT company,
		AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;

--Q10 Rank #9 from highest to lowest. What company
--has the highest rating? What is the rating?
-- A: General Motors with 4.2
SELECT company,
		ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;

--Q11 Find all job titles that have "Analyst". How many jobs?
--A: 1669
SELECT COUNT(title) AS analyst_jobtitles
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--Q12 How many jobs do not have "Analyst" or "Analytics"? What word do these jobs have in common?
--A: 4; Tableau
SELECT title
FROM data_analyst_jobs
WHERE (title NOT ILIKE '%Analyst%') AND (title NOT ILIKE '%Analytics%');

--Bonus:Find the # of jobs that require SQL and have been posted longer than 3 weeks.
--A: 643
--Which industries are in the top 4?
--A:Internet&Software, Banks&FinancialServices, Consulting&BusinessServices, Healthcare

SELECT COUNT(title) AS number_of_jobs
FROM data_analyst_jobs
WHERE (skill ILIKE '%SQL%') AND (days_since_posting/7 >= 3);

SELECT domain,
    COUNT(title) AS job_count
FROM data_analyst_jobs
WHERE (skill ILIKE '%SQL%') AND (days_since_posting / 7 >= 3)
GROUP BY domain
ORDER BY job_count DESC
LIMIT 5;