-- Salary Data Project

CREATE DATABASE salary_database;

-- Create Table

CREATE TABLE salary_table
	(
	age INT,
	gender TEXT,
	education_level TEXT,
	job_title TEXT,
	years_of_experience INT,
	salary INT
	);

--Data cleaning

-- Looking at distinct education levels

SELECT DISTINCT education_level
FROM salary_table;

-- Standardizing the education level column 

UPDATE salary_table
SET education_level = CASE
	WHEN education_level ILIKE '%bachelors degree%' THEN 'bachelors'
	WHEN education_level ILIKE '%masters degree%' THEN 'masters'
	WHEN education_level ILIKE '%PhD%' THEN 'phD'
	WHEN education_level LIKE '%Master%' THEN 'masters'
	WHEN education_level LIKE 'Bachelors' THEN 'bachelors'
	WHEN education_level LIKE '%High School%' THEN 'high school'
	ELSE education_level
END;

-- Checking for NULL data

SELECT *
FROM salary_table
WHERE age IS NULL
	OR gender IS NULL
	OR education_level IS NULL
	OR job_title IS NULL
	OR years_of_experience IS NULL
 	OR salary IS NULL;

-- Removing NULL data

DELETE FROM salary_table
WHERE age IS NULL
	OR gender IS NULL
	OR education_level IS NULL
	OR job_title IS NULL
	OR years_of_experience IS NULL
	OR salary IS NULL;

-- Exploratory analysis

-- Job Title Analysis

-- Count of distinct job titles

SELECT DISTINCT job_title,
	COUNT(*)
FROM salary_table
GROUP BY 1;

-- What is the top 10 paying job titles?

SELECT job_title,
	MAX(salary) AS "top salaries"
FROM salary_table
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Experience Analysis

-- How does year of experience effect the average salary?

SELECT years_of_experience,
	ROUND(AVG(salary)::numeric, 1) AS "avg salary"
FROM salary_table
GROUP BY 1
ORDER BY 1;

-- Experience vs. salary trend

SELECT
	FLOOR(years_of_experience / 5) * 5 AS "exp_range_start",
	COUNT(*) AS "num records",
	ROUND(AVG(salary):: numeric, 1) AS "avg_salary"
FROM salary_table
GROUP BY 1
ORDER BY 1;

-- Education Analysis

-- What is the percent of degree holders per degree?

SELECT 
  education_level,
  COUNT(*) AS "total degree holders",
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS "degree percentage"
FROM salary_table
GROUP BY 1;

-- How does education level effect salary on average?

SELECT education_level,
	ROUND(AVG(salary)::numeric, 1) AS "avg salary"
FROM salary_table
GROUP BY 1
ORDER BY 2;

-- How does education level and experience effect salary?

SELECT years_of_experience, education_level,
	ROUND(AVG(salary)::numeric, 1) AS "avg salary"
FROM salary_table
GROUP BY 1, 2
ORDER BY 1;

-- Enabling the tablefunc extension

CREATE EXTENSION IF NOT EXISTS tablefunc;

-- Crosstab comparing average salaries and experience buckets 

SELECT *
FROM crosstab(
	$$
	SELECT
	education_level,
	CASE
		WHEN years_of_experience BETWEEN 0 AND 5 THEN '0-5 yrs'
		WHEN years_of_experience BETWEEN 6 AND 10 THEN '6-10 yrs'
		WHEN years_of_experience BETWEEN 11 AND 15 THEN '11-15 yrs'
		ELSE '16+ yrs'
		END AS "exp bucket",
		ROUND(AVG(salary), 2) AS "avg salary"
	FROM salary_table
	GROUP BY 1, 2
	ORDER BY 1, 2
$$,
$$ VALUES ('0-5 yrs'), ('6-10 yrs'), ('11-15 yrs'), ('16 yrs') $$
) AS ct (
	education_level text,
	"0-5 yrs" numeric,
	"6-10" numeric,
	"11-15" numeric,
	"16+" numeric
);

-- Gender Analysis

-- Gender count

SELECT gender,
	COUNT(*) AS "total"
FROM salary_table
GROUP BY 1;
	
-- How does gender effect salary?

SELECT gender,
	ROUND(AVG(salary)::numeric, 1) AS "avg salary"
FROM salary_table
GROUP BY 1
ORDER BY 2;

-- Gender averages, medians, and range

SELECT gender,
	ROUND(AVG(salary)::numeric, 2) AS "avg salary",
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS "median salary",
	MIN(salary) AS "min salary",
	MAX(salary) AS "max salary"
FROM salary_table
GROUP BY 1;

-- Pay gap by gender and job title

SELECT
  job_title,
  MAX(CASE WHEN gender = 'Male' THEN years_of_experience END) AS "male experience",
  MAX(CASE WHEN gender = 'Female' THEN years_of_experience END) AS "female experience",
  MAX(CASE WHEN gender = 'Male' THEN salary END) AS "male salary",
  MAX(CASE WHEN gender = 'Female' THEN salary END) AS "female salary",
  ROUND(
    MAX(CASE WHEN gender = 'Male' THEN salary END) -
    MAX(CASE WHEN gender = 'Female' THEN salary END), 2
  ) AS "gender gap"
FROM salary_table
GROUP BY 1
HAVING
  MAX(CASE WHEN gender = 'Male' THEN salary END) IS NOT NULL AND
  MAX(CASE WHEN gender = 'Female' THEN salary END) IS NOT NULL;

-- Gender pay gap by experience bracket

SELECT
  CASE
    WHEN years_of_experience < 3 THEN '0–2 years'
    WHEN years_of_experience BETWEEN 3 AND 5 THEN '3–5 years'
    WHEN years_of_experience BETWEEN 6 AND 10 THEN '6–10 years'
    ELSE '10+ years'
  END AS "experience level",
  ROUND(AVG(CASE WHEN gender = 'Male' THEN salary ELSE NULL END), 2) AS "avg male salary",
  ROUND(AVG(CASE WHEN gender = 'Female' THEN salary ELSE NULL END), 2) AS "avg female salary",
  ROUND(
    100.0 * (
      AVG(CASE WHEN gender = 'Male' THEN salary ELSE NULL END) -
      AVG(CASE WHEN gender = 'Female' THEN salary ELSE NULL END)
	 ) / NULLIF(AVG(CASE WHEN gender = 'Female' THEN salary ELSE NULL END), 0), 2) AS "percent gap vs female"
FROM salary_table
GROUP BY 1
ORDER BY 1;

-- Age Analysis

-- Does age effect the average salary?

SELECT age,
	ROUND(AVG(salary)::numeric, 1) AS "avg salary"
FROM salary_table
GROUP BY 1
ORDER BY 2;

-- Pay gap by age group

SELECT
  CASE
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 34 THEN '25–34'
    WHEN age BETWEEN 35 AND 44 THEN '35–44'
    WHEN age BETWEEN 45 AND 54 THEN '45–54'
    ELSE '55+'
  END AS "age group",
  ROUND(AVG(CASE WHEN gender = 'Male' THEN salary ELSE NULL END), 2) AS "avg male salary",
  ROUND(AVG(CASE WHEN gender = 'Female' THEN salary ELSE NULL END), 2) AS "avg female salary",
  ROUND(
    100.0 * (
      AVG(CASE WHEN gender = 'Male' THEN salary ELSE NULL END) -
      AVG(CASE WHEN gender = 'Female' THEN salary ELSE NULL END)
    ) / NULLIF(AVG(CASE WHEN gender = 'Female' THEN salary ELSE NULL END), 0), 2
  ) AS "percent gap male vs female"
FROM salary_table
GROUP BY 1
ORDER BY 1;





