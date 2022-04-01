# Cyclistic Bike-share Analysis

## Introduction
Cyclistic bike-share analysis case study is a capstone project for Google Data Analytics Certificate.

In this case study, I performed real-world tasks of a junior data analyst for the marketing team of a fictional company, Cyclistic, a bike-share company in Chicago. In order to answer the key business questions, I followed the steps of the data analysis process: ask, prepare, process, analyze, share, and act.

### About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that
are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the
pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will
be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a
very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic
program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to
do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why
casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are
interested in analyzing the Cyclistic historical bike trip data to identify trends.

## Step 1 - Ask

### Business Task
Design marketing strategies aimed at converting casual riders into annual members.

### Stakeholders 
- Director of marketing - Lily Moreno
- Cyclistic executive team

### Question to analyse 
How do annual members and casual riders use Cyclistic bikes differently?

### Deliverables
- Clear statement of the business task.
- Description of all data sources used.
- Documentation of cleaning or manipulation of data.
- Summary of analysis.
- Supporting visualizations and key findings.
- Top three recommendations based on your analysis.

## Step 2 - Prepare

I downloaded previous 12 months bike share trip datasets  - March, 2021 to February, 2022 **<a href="https://divvy-tripdata.s3.amazonaws.com/index.html">here</a>**.  (Data is made available by Motivate International Inc. under this **<a href="https://ride.divvybikes.com/data-license-agreement">licence</a>**.)

## Step 3 - Process

#### Tools Used - Microsoft  Excel and BigQuery SQL

I used Microsoft Excel to familiarise myself with the monthly datasets and check for inconsistencies in format and missing/null values. I couldn't merge the monthly datasets in Microsoft Excel because there are over 5 million rows in total, so I imported the dataset to BigQuery to clean and manipulate the datasets. 

#### Data Cleaning and Manipulation using BigQuery SQL 

I used UNION DISTINCT to merge the monthly datasets into a year dataset (March, 2021 to February, 2022) and removed all duplicates — it leaves the dataset with 13 columns and 5,667,986 rows.

I removed null values from the rows, leaving dataset with 13 columns and 4,631,103 rows.

I removed ride ids that were longer than 16 characters, rides that lasted less than a minute, and rides that lasted more than 24 hours, leaving the dataset with 13 columns and 4,569,456 rows.

I removed rides with the station ids "TEST", "Test" and "test". It leaves the dataset with 13 columns and 4,568,957 rows.

Link to the SQL code **<a href="https://github.com/johnesho/Cyclistic-bike-share-analysis/blob/b574548c7e9c0aec1b633c0902100fea2fce747a/Cyclistic%20bike-share%20analysis.sql">here</a>**

## Step 4 - Analyse 

#### Tools Used - BigQuery SQL

I found out the number of casual and member rides then I proceeded to check the number of rides per start and end stations,
I calculated the average ride time for both casual and member riders and I also found out the total number of ride per day of the week and per month.

Link to the SQL code **<a href="https://github.com/johnesho/Cyclistic-bike-share-analysis/blob/b574548c7e9c0aec1b633c0902100fea2fce747a/Cyclistic%20bike-share%20analysis.sql">here</a>** (From line 162)


## Step 5 - Share

#### Tools Used - Tableau Public

I exported the cleaned dataset to Tableau Public and created visualizations for the data.

Link to the interactive dashboard on Tableau Public **<a href="https://public.tableau.com/app/profile/johnesho/viz/GoogleDataAnalyticsCertificateCapstone-CyclisticCaseStudy/TripCountperRiderType">here</a>**

## Step 6 - Act

### Key Findings
- Average ride time of casual riders (28 minutes) is more than twice the average ride time of members (13 minutes)
- Casual riders tend to start and end their trips near coast area.
- Members tend to start and end their trips in the city.
- The number of rides is at its highest during the summer. 
- The weekend is often a peak for casual riders. 

### Recommendations
- Casual riders' usage increases on weekends, the marketing campaign could include a discounted weekend-only membership subscription to tempt casual riders to become members. 
- Average ride time of casual riders is more than twice the average ride time of members, membership subscription should include ride time-based charges which charges lesser as ride time increases. It could encourage casual riders to sign up for membership subscription.
- The best time to launch a marketing campaign is during the summer, this is when the number of rides is at its peak. On weekends, a marketing campaign can be carried out at stations with high volume of rides.
