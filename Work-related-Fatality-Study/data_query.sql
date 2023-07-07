/* The project involves 10 tasks which are to be performed on the cleaned dataset 'fatalities_cleaned.csv'
Before these tasks are performed, it is to be ensured that the required dataset is loaded in a MySQL database table.*/

-- Task 1
/*What is the number of reported incidents?*/

SELECT COUNT(*)
FROM fatalities_cleaned;

-- Task 2
/*What is the year to year change for the number of fatal incidents?*/

SELECT
    incident_year,
    fatalities AS n_fatalities,
    lag_fatalities AS previous_year,
    ROUND(((fatalities - lag_fatalities) / lag_fatalities) * 100) AS year_to_year
FROM
    (SELECT
        EXTRACT(YEAR FROM incident_date) AS incident_year,
        COUNT(*) AS fatalities,
        LAG(COUNT(*)) OVER (ORDER BY EXTRACT(YEAR FROM incident_date)) AS lag_fatalities
    FROM
        fatalities_cleaned
    WHERE
        EXTRACT(YEAR FROM incident_date) <> 2022
    GROUP BY
        EXTRACT(YEAR FROM incident_date)
    ) AS subquery
ORDER BY
    incident_year

-- Task 3
/*What is the number of fatalities that received a citation?*/

SELECT citation,COUNT(*)
FROM fatalities_cleaned
GROUP BY citation;

-- Task 4
/*What day of the week has the most fatalities and what is the overall percentage?*/

SELECT
    day_of_week,
    COUNT(*) AS n_fatalities,
    ROUND((COUNT(*) / total_fatalities) * 100, 2) AS percentage
FROM
    fatalities_cleaned
JOIN
    (SELECT
        COUNT(*) AS total_fatalities
    FROM
        fatalities_cleaned) AS subquery
GROUP BY
    day_of_week
ORDER BY
    n_fatalities DESC;

-- Task 5
/*What is the number of fatalities involving welding?*/

SELECT COUNT(*)
FROM fatalities_cleaned
WHERE description LIKE '%weld%';

-- Task 6
/*Select the last 5 from the previous query*/

SELECT *
FROM fatalities_cleaned
WHERE description LIKE '%weld%'
ORDER BY incident_date DESC
LIMIT 5;

-- Task 7
/*Select the top 5 states with the most fatal incidents.*/

SELECT state,COUNT(*) AS n_fatalities
FROM fatalities_cleaned
GROUP BY state
ORDER BY n_fatalities DESC
LIMIT 5;

-- Task 8
/*What are the top 5 states that had the most workplace fatalities from stabbings?*/

SELECT state,COUNT(*) AS n_fatalities
FROM fatalities_cleaned
WHERE description LIKE '%stabbed%'
GROUP BY state
ORDER BY n_fatalities DESC
LIMIT 5;

-- Task 9
/*What are the top 10 states that had the most workplace fatalities from shootings?*/

SELECT state,COUNT(*) AS n_fatalities
FROM fatalities_cleaned
WHERE description LIKE '%shot%'
GROUP BY state
ORDER BY n_fatalities DESC
LIMIT 10;

-- Task 10
/*What is the total number of shooting deaths per year?*/

SELECT
    EXTRACT(YEAR FROM incident_date) AS incident_year,
    COUNT(*) AS total_deaths
FROM
    fatalities_cleaned
WHERE
    description LIKE '%shot%'
GROUP BY
    EXTRACT(YEAR FROM incident_date);
ORDER BY total_deaths DESC;
