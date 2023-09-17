-- use b7980799;



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