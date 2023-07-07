# Fatalities Data Analysis

This repository contains code snippets and SQL queries for analyzing fatalities data from a cleaned dataset named `fatalities_cleaned.csv`. The data was processed and loaded into a MySQL database table named `fatalities_cleaned`.

## Data Preprocessing

The initial dataset, `fatalities.csv`, was passed through the `data_preprocessing.py` script to clean and export the dataset to `fatalities_cleaned.csv`.

The `data_preprocessing.py` script performs the following tasks:

### Task 1: Read the given dataset

```python
import pandas as pd

def read_data_from_csv():
    df = pd.read_csv('fatality.csv')
    return df
```

### Task 2: Clean the given dataset

```python
def data_cleaning():
    df = read_data_from_csv()
    df.drop(columns=['Unnamed'], inplace=True)
    return df
```

### Task 3: Export the cleaned dataset to `fatalities_cleaned.csv`

```python
def export_the_dataset():
    df = data_cleaning()
    df.to_csv('fatalities_cleaned.csv', index=False)
```

---

## In depth-analysis

The following tasks were performed on the cleaned dataset using SQL queries:

### Task 1: Number of Reported Incidents

```sql
SELECT COUNT(*)
FROM fatalities_cleaned;
```

### Task 2: Yeae-to-Year Change in Fatal Incidents

```sql
SELECT
    EXTRACT(YEAR FROM incident_date) AS incident_year,
    COUNT(*) AS fatalities,
    LAG(COUNT(*)) OVER (ORDER BY EXTRACT(YEAR FROM incident_date)) AS previous_year,
    ROUND(((COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY EXTRACT(YEAR FROM incident_date))) / LAG(COUNT(*)) OVER (ORDER BY EXTRACT(YEAR FROM incident_date))) * 100) AS year_to_year
FROM fatalities_cleaned
WHERE EXTRACT(YEAR FROM incident_date) <> 2022
GROUP BY EXTRACT(YEAR FROM incident_date)
ORDER BY incident_year;
```

### Task 3: Number of fatalities with Citations

```sql
SELECT citation, COUNT(*)
FROM fatalities_cleaned
GROUP BY citation;
```

### Task 4: Day of the Week with Most Fatalities

```sql
SELECT
    day_of_week,
    COUNT(*) AS n_fatalities,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM fatalities_cleaned)) * 100, 2) AS percentage
FROM fatalities_cleaned
GROUP BY day_of_week
ORDER BY n_fatalities DESC;
```

### Task 5: Number of fatalities involving welding

```sql
SELECT COUNT(*)
FROM fatalities_cleaned
WHERE description LIKE '%weld%';
```

### Task 6: Last 5 Incidents involving welding

```sql
SELECT *
FROM fatalities_cleaned
WHERE description LIKE '%weld%'
ORDER BY incident_date DESC
LIMIT 5;
```

### Task 7: Top 5 States with Most fatal incidents

```sql
SELECT state, COUNT(*) AS n_fatalities
FROM fatalities_cleaned
GROUP BY state
ORDER BY n_fatalities DESC
LIMIT 5;
```

### Task 8: Top 5 States with the Most Fatal Stabbings

```sql
SELECT state, COUNT(*) AS n_fatalities
FROM fatalities_cleaned
WHERE description LIKE '%stabbed%'
GROUP BY state
ORDER BY n_fatalities DESC
LIMIT 5;
```

### Task 9: Top 10 States with the Most Fatal Shootings

```sql
SELECT state, COUNT(*) AS n_fatalities
FROM fatalities_cleaned
WHERE description LIKE '%shot%'
GROUP BY state
ORDER BY n_fatalities DESC
LIMIT 10;
```

### Task 10: Total Number of Shooting Deaths per Year

```sql
SELECT
    EXTRACT(YEAR FROM incident_date) AS incident_year,
    COUNT(*) AS total_deaths
FROM fatalities_cleaned
WHERE description LIKE '%shot%'
GROUP BY EXTRACT(YEAR FROM incident_date)
ORDER BY total_deaths DESC;
```
