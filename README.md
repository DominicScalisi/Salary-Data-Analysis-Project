# Salary-Data-Analysis-Portfolio-Project
Project Status: Completed

Project Objective

This project explores the relationship between professional and demographic factors—such as age, experience, gender, education, and job title—on salary. The dataset used comes from Kaggle, with approximately 6,700 entries. The goal is to uncover valuable insights for both professionals and employers to better understand how these factors influence salaries. The analysis was performed using PostgreSQL for data manipulation and Tableau for data visualization.

Original Dataset: Kaggle Salary Data

SQL Queries for Data Cleaning & Analysis: SQL Queries

Interactive Tableau Dashboard: Tableau Dashboard

Data Overview

The dataset used in this project is from Kaggle's Salary_Data, which was collected from surveys, job posting sites, and other publicly available sources. It contains the following columns:

Age

Gender

Education Level

Job Title

Years of Experience

Salary

Before cleaning, the dataset had 6,704 rows. After cleaning, it was reduced to 6,698 rows by removing entries with missing or incomplete data. The Education Level column contained various formats like "bachelor's degree," "Bachelors," and "Masters." This inconsistency was resolved by standardizing these categories.

Tools & Technologies Used

PostgreSQL: Used for data cleaning, organization, and analysis.

Tableau: Used for creating an interactive and visual dashboard for data exploration and presentation.

Insights

1. Experience and Salary

Years of experience had a significant impact on salary. 

After 5 years of experience, average salaries increased by 89.2%. From $63,409 to $120,029 dollars.

After 10 years, average salary increased by 141.4%. From $63,409 to $153,000 dollars.

<img width="268" height="157" alt="image" src="https://github.com/user-attachments/assets/892fd761-9dea-43e6-8528-a3dd5dbb73c4" />

2. Education Level

Individuals with a degree tend to start with a higher salary. 

In the dataset, there was 448 high school graduates, 3021 bachelor's degrees, 1860 master's degrees, and 1369 phD holders. 

A Bachelor's Degree (compared to a high school diploma) resulted in an average salary increase of $41,916.

A Master's Degree (compared to a high school diploma) resulted in an average salary increase of $93,406.

A Pivot Table was created to get a detailed view of how education level and years of experience affect salary. This provided insight into how individuals with different levels of education earn at various stages of their careers.

<img width="295" height="100" alt="image" src="https://github.com/user-attachments/assets/bc7b000b-9703-4944-9e3f-ec5322a1e29f" />

3. Gender and Salary

In the dataset, there was 3,671 males, 3,013 females, and 14 others. With only 14 entries for others, this gender group was not included in the analysis.

A gender pay gap was observed. On average, females earned $107,889, while males earned $121,395. The median earnings did not stray from the average with females earning $105,000, while males earned $120,000. However, the gap varied significantly by job title and years of experience.

<img width="392" height="83" alt="image" src="https://github.com/user-attachments/assets/c7b4d824-8a31-46fa-8281-76c03e717308" />

In a Data Analyst role, where both males and females had comparable years of experience-11 years for males and 13 years for females-males earned $195,000, while females earned $150,000.

In roles like Sales Director, the gap was even more noticeable because of experience-the male had 22 years and the female had 8 years-with males earning $180,000 compared to $90,000 for females.

In some cases, females earned more. For example, a female Senior Data Scientist with 16 years of experience earned $200,000, while a male with 21 years of experience earned $190,000.

4. Age and Salary

The age range within the dataset was from 21 to 62 years old.

On average, younger employees earned less than their older peers, likely due to the higher-paying roles being held by those with more experience.

6. Age vs. Gender

Age was broken up into groups: under 25, 25-34, 35-44, 45-54, and 55+.

Age groups 25-34, 35-44, 45-54, and 55+ were more consistent in salary across the board for males and females.

The age group with the largest salary disparity was "under 25," where the average salary gap was 59.87%.

<img width="434" height="120" alt="image" src="https://github.com/user-attachments/assets/3857684a-1dd9-47c8-90cd-4ecf217e092a" />
