# Analyzing Banking Trends: Customer Transactions and Regional Impact

## Project Description
In the ever-evolving world of banking and finance, understanding customer behavior and the regional impact of transactions plays a crucial role in decision-making and strategic planning. This project, titled "Analyzing Banking Trends: Customer Transactions and Regional Impact," aims to explore and analyze the vast troves of transaction data to gain valuable insights into customer behavior patterns and their implications on different world regions.

## Objective
The primary objective of this project is to delve into customer transactions and identify trends that may impact regional economies and financial systems. By combining data cleaning techniques in Python and utilizing SQL queries on a set of interconnected tables, we aim to gain a comprehensive understanding of how customer transactions vary across different regions and the possible implications on the banking sector.

## Data Sources
### World Regions Table
This table contains data on various world regions and their corresponding codes and names. It serves as a reference to categorize customers based on their regional affiliation.

### User Nodes Table
The user_nodes table holds crucial details about consumers' banking nodes, including their unique consumer IDs, associated region IDs, node IDs, start dates, and end dates. This data enables us to identify the specific banking nodes to which customers are connected and their duration of association.

### User Transaction Table
This table is a comprehensive repository of customer transactions, containing data such as consumer IDs, transaction dates, types of transactions, and transaction amounts. Analyzing this data allows us to uncover patterns in customer spending and financial behaviors.

## Module 1:- Data Pre-processing using Python
### Task 1:- Check the Null Values
You must write the required code within the predefined function named ""check_null_values()"" located in the ""user_nodes.py"" . file should return the null values.

### Task 2:- Find the duplicate values
You must write the required code within the predefined function named ""check_duplicates()"" located in the ""user_nodes.py"" file.

### Task 3:- Remove the Duplicate Values
You must write the required code within the predefined function named ""drop_duplicates()"" located in the ""user_nodes.py"" file.

### Task 4:- Data Cleaning
You must write the required code within the predefined function named ""data_cleaning()"" located in the ""user_nodes.py"" file.

### Task 5:- Check the Null Values
You must write the required code within the predefined function named ""check_null_values()"" located in the ""user_transaction.py"" .file should return the null values. 

### Task 6:- Find the duplicate values
You must write the required code within the predefined function named ""check_duplicates()"" located in the ""user_transaction.py"" file.

### Task 7:- Remove the Duplicate Values
You must write the required code within the predefined function named ""drop_duplicates()"" located in the ""user_transaction.py"" file.

### Task 8:- Data Cleaning
You must write the required code within the predefined function named ""data_cleaning()"" located in the ""user_transaction.py"" file.

### Task 9:- Generate Tables using the Cleaned Dataset
To complete the task, enter the database information provided in the Database Info tab into the ""db.py"" file and press Ctrl+S to save it. After that, use the provided login information to access the database by clicking the ""localhost"" link located on the Database Details tab. Once there, you need to upload the required datasets in the particular database mentioned in the ""db.py"" file. and then click on ""Run test"" to complete the task.

### Solutions to Module 1:-
#### Task 1 to Task 4

``` python
import pandas as pd
import warnings
warnings.filterwarnings("ignore")


# Function to read the CSV file into a DataFrame
def read_csv():
    # read the user_nodes.csv file using pandas library and return it
    df = pd.read_csv('user_nodes.csv')
    return df


# Function to check for null (missing) values in the DataFrame
def check_null_values():
    # do not edit the predefined function name
    df = read_csv()
    # Check for null values using the isnull() method and sum them for each column
    null_values = df.isnull().sum()
    return null_values

# Function to check for duplicate rows in the DataFrame


def check_duplicates():
    # do not edit the predefined function name
    df = read_csv()
    # Calculate the number of duplicate rows using the duplicated() method and sum them
    duplicates = df.duplicated().sum()
    return duplicates


# Function to drop duplicate rows from the DataFrame
def drop_duplicates():
    # do not edit the predefined function name
    df = read_csv()
    # Drop duplicate rows using the drop_duplicates() method with inplace=True
    df.drop_duplicates(inplace=True)
    return df


def data_cleaning():

    df = drop_duplicates()

    # Step 3: Drop specified columns from the DataFrame("has_loan", "is_act")
    df.drop(['has_loan', 'is_act'], axis=1, inplace=True)
    # Rename columns names id_,area_id_,node_id_,act_date',deact_date to  consumer_id,region_id,node_id,start_date,end_date
    df.rename(columns={'id_': 'consumer_id', 'area_id_': 'region_id', 'node_id_': 'node_id',
              'act_date': 'start_date', 'deact_date': 'end_date'}, inplace=True)
    
    # Step 4: Convert the start_date and end_date columns to datetime format
    df['start_date'] = pd.to_datetime(df['start_date'], format='%d-%m-%Y').dt.strftime('%Y-%m-%d')


    df['end_date'] = pd.to_datetime(df['end_date'], format='%d-%m-%Y').dt.strftime('%Y-%m-%d')

    df.to_csv('user_nodes_cleaned.csv', index=False)
    return df
```

#### Task 5 to Task 8

``` python
import pandas as pd
import warnings
warnings.filterwarnings("ignore")


# Function to read the CSV file into a DataFrame
def read_csv():
    # read the user_transactions.csv file using pandas library and return it
    df = pd.read_csv('user_transactions.csv')
    return df


# Function to check for null (missing) values in the DataFrame
def check_null_values():
    # do not edit the predefined function name
    df = read_csv()
    # Check for null values using the isnull() method and sum them for each column
    null_values = df.isnull().sum()
    return null_values

# Function to check for duplicate rows in the DataFrame


def check_duplicates():
    # do not edit the predefined function name
    df = read_csv()
    # Calculate the number of duplicate rows using the duplicated() method and sum them
    duplicates = df.duplicated().sum()
    return duplicates


# Function to drop duplicate rows from the DataFrame
def drop_duplicates():
    # do not edit the predefined function name
    df = read_csv()
    # Drop duplicate rows using the drop_duplicates() method with inplace=True
    df.drop_duplicates(inplace=True)

    return df


def data_cleaning():
    """
    Data Cleaning Function:
    Cleans the DataFrame by dropping specified columns and renaming others.

    Returns:
    DataFrame: The cleaned DataFrame after dropping and renaming columns.
    """
    # Step 1: Get the DataFrame with duplicate rows removed and rows with null values dropped
    df = drop_duplicates()

    # Step 2: Columns to remove from the DataFrame
    # columns needs to be removed "has_credit_card" and  "account_type"
    # Drop specified columns from the DataFrame
    df.drop(columns=['has_credit_card', 'account_type'], axis=1, inplace=True)
    # Rename columns id_,t_date,t_type,t_amt to consumer_id,transaction_date,transaction_type,transaction_amount
    ren = {
        'id_': 'consumer_id',
        't_date': 'transaction_date',
        't_type': 'transaction_type',
        't_amt': 'transaction_amount'
    }

    # Step 5: Rename columns using the new column names
    df.rename(columns=ren, inplace=True)

    # Step 6: Convert the transaction_date column to datetime format
    df['transaction_date'] = pd.to_datetime(df['transaction_date'], format='%d-%m-%Y').dt.strftime('%Y-%m-%d')
    
    df.to_csv('user_transaction_cleaned.csv', index=False)
    return df
```

## Module 2:- Analyzing data using MySQL
### Task 1:- List all regions along with the number of users assigned to each region.

### Task 2:- Find the user who made the largest deposit amount and the transaction type for that deposit.

### Task 3:- Calculate the total amount deposited for each user in the "Europe" region.

### Task 4:- Calculate the total number of transactions made by each user in the "United States" region.

### Task 5:- Calculate the total number of users who made more than 5 transactions.

### Task 6:- Find the regions with the highest number of nodes assigned to them.

### Task 7:- Find the user who made the largest deposit amount in the "Australia" region.

### Task 8:- Calculate the total amount deposited by each user in each region.

### Task 9:- Retrieve the total number of transactions for each region.

### Task 10:- Write a query to find the total deposit amount for each region (region_name) in the user_transaction table. Consider only those transactions where the consumer_id is associated with a valid region in the user_nodes table.

### Task 11:- Write a query to find the top 5 consumers who have made the highest total transaction amount (sum of all their deposit transactions) in the user_transaction table.

### Task 12:- How many consumers are allocated to each region?

### Task 13:- What is the unique count and total amount for each transaction type?

### Task 14:- What are the average deposit counts and amounts for each transaction type ('deposit') across all customers, grouped by transaction type?

### Task 15:- How many transactions were made by consumers from each region?

### Solutions to Module 2

```sql
/* Task 1 
List all regions along with the number of users assigned to each region.*/

SELECT
    world_regions.region_name,
    COUNT(DISTINCT user_nodes.consumer_id) AS num_users
FROM
    world_regions
LEFT JOIN
    user_nodes
ON
    world_regions.region_id = user_nodes.region_id
GROUP BY
    world_regions.region_name
ORDER BY
    world_regions.region_name;


/* Task 2
Find the user who made the largest deposit amount and the transaction type for that deposit.*/

SELECT
    consumer_id,
    transaction_type,
    transaction_amount AS largest_deposit
FROM
    user_transaction
WHERE
    transaction_amount = (SELECT MAX(transaction_amount) FROM user_transaction);


/* Task 3
Calculate the total amount deposited for each user in the "Europe" region.*/

SELECT
    un.consumer_id,
    SUM(ut.transaction_amount) AS total_deposit_amount
FROM
    user_nodes un
JOIN
    user_transaction ut
ON
    un.consumer_id = ut.consumer_id
WHERE
    ut.transaction_type = 'deposit'
    AND un.region_id IN (SELECT region_id FROM world_regions WHERE region_name = 'Europe')
GROUP BY
    un.consumer_id;

/* Task 4
Calculate the total number of transactions made by each user in the "United States" region.*/

SELECT
    un.consumer_id,
    COUNT(*) AS total_transactions
FROM
    user_nodes un
JOIN
    user_transaction ut
ON
    un.consumer_id = ut.consumer_id
WHERE
    un.region_id IN (SELECT region_id FROM world_regions WHERE region_name = "United States")
GROUP BY
    un.consumer_id;
    
/* Task 5
Calculate the total number of users who made more than 5 transactions.*/

SELECT
	consumer_id,
    COUNT(*) AS total_transactions
FROM
	user_transaction
GROUP BY
	consumer_id
HAVING
	total_transactions > 5;

/* Task 6
Find the regions with the highest number of nodes assigned to them.*/

SELECT
	wr.region_name,
    COUNT(node_id) AS num_nodes
FROM
	user_nodes un
LEFT JOIN
	world_regions wr
ON
	un.region_id = wr.region_id
GROUP BY
	wr.region_name
ORDER BY
	num_nodes DESC;
    
/* Task 7
Find the user who made the largest deposit amount in the "Australia" region.*/

WITH AustraliaDeposits AS (
	SELECT
		un.consumer_id,
        un.region_id,
        ut.transaction_amount
	FROM
		user_nodes un
	JOIN
		world_regions wr
	ON
		un.region_id = wr.region_id
	JOIN
		user_transaction ut
	ON
		un.consumer_id = ut.consumer_id
	WHERE
		wr.region_name = "Australia"
        AND ut.transaction_type = "deposit"
)
SELECT
	DISTINCT(ad.consumer_id),
    ad.transaction_amount as largest_deposit
FROM
	AustraliaDeposits ad
WHERE
	ad.transaction_amount IN (SELECT MAX(ad.transaction_amount) FROM AustraliaDeposits ad);
    
/* Task 8
Calculate the total amount deposited by each user in each region.*/

SELECT
    un.consumer_id,
    wr.region_name,
    SUM(ut.transaction_amount) AS total_deposit_amount
FROM
    user_nodes un
JOIN
    user_transaction ut
ON
    un.consumer_id = ut.consumer_id
JOIN
	world_regions wr
ON
	un.region_id = wr.region_id
WHERE
    ut.transaction_type = 'deposit'
GROUP BY
    un.consumer_id,wr.region_name;
    
/* Task 9
Retrieve the total number of transactions for each region.*/

SELECT
    wr.region_name,
    COUNT(*) AS total_transactions
FROM
    user_nodes un
JOIN
    user_transaction ut
ON
    un.consumer_id = ut.consumer_id
JOIN
	world_regions wr
ON
	un.region_id = wr.region_id
GROUP BY
    wr.region_name;

/* Task 10
Write a query to find the total deposit amount for each region (region_name) in the user_transaction table.
Consider only those transactions where the consumer_id is associated with a valid region in the user_nodes table.*/

SELECT
    wr.region_name,
    SUM(ut.transaction_amount) AS total_deposit_amount
FROM
    user_nodes un
JOIN
    user_transaction ut
ON
    un.consumer_id = ut.consumer_id
JOIN
	world_regions wr
ON
	un.region_id = wr.region_id
WHERE
	ut.transaction_type = 'deposit'
GROUP BY
    wr.region_name;
    
/* Task 11
Write a query to find the top 5 consumers who have made the highest total transaction amount
 (sum of all their deposit transactions) in the user_transaction table.*/
 
SELECT
	consumer_id,
    SUM(transaction_amount) AS total_transaction_amount
FROM
	user_transaction ut
WHERE
	ut.transaction_type = 'deposit'
GROUP BY
	consumer_id
ORDER BY
	total_transaction_amount DESC
LIMIT 5;

/* Task 12
How many consumers are allocated to each region?*/

SELECT
	un.region_id,
    wr.region_name,
    COUNT(DISTINCT un.consumer_id) AS num_of_consumers
FROM
	user_nodes un
JOIN
	world_regions wr
ON
	un.region_id = wr.region_id
GROUP BY
	un.region_id,
    wr.region_name;

/* Task 13
What is the unique count and total amount for each transaction type?*/

SELECT
	transaction_type,
    COUNT(DISTINCT consumer_id) AS num_transactions,
    SUM(transaction_amount) AS total_amount
FROM
	user_transaction
GROUP BY
	transaction_type;
    
    
/* Task 14
What are the average deposit counts and amounts for each transaction type ('deposit') across all customers, grouped by transaction type?*/

WITH cte_deposit AS (
	SELECT 
		transaction_type,
		COUNT(transaction_type) AS deposit_count,
		SUM(transaction_amount) AS deposit_amount
	FROM user_transaction
	WHERE transaction_type = 'deposit'
	GROUP BY consumer_id
)
SELECT 
	transaction_type,
    ROUND(AVG(deposit_count),0) AS avg_deposit_count,
	ROUND(AVG(deposit_amount),0) AS avg_deposit_amount
FROM cte_deposit;

/* Task 15
How many transactions were made by consumers from each region?*/

SELECT
    wr.region_name,
    COUNT(*) AS total_transactions
FROM
    user_nodes un
JOIN
    user_transaction ut
ON
    un.consumer_id = ut.consumer_id
JOIN
	world_regions wr
ON
	un.region_id = wr.region_id
GROUP BY
    wr.region_name;
```
