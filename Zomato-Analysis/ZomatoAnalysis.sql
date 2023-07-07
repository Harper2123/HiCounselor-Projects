-- create database zomato;

-- use zomato


-- Creating Table zomato
CREATE TABLE `zomato` (
  `ID` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `online_order` varchar(255) DEFAULT NULL,
  `book_table` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `votes` int DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `rest_type` varchar(255) DEFAULT NULL,
  `dish_liked` varchar(255) DEFAULT NULL,
  `cuisines` varchar(255) DEFAULT NULL,
  `approx_cost` int DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
);

/*-------------------- Task 1 -------------------------------------------------------
 Provide us the top 5 most voted hotels in the delivery category.*/
 SELECT name, votes, rating
 FROM zomato
 WHERE type = 'Delivery'
 ORDER BY votes DESC
 LIMIT 5;
 
 /*-------------------- Task 2 -------------------------------------------------------
 For a particular location called Banashankari, Find out the top 5 highly rated hotels in the delivery category.*/
 SELECT name, rating, location, type
 FROM zomato
 WHERE type = 'Delivery' and location = 'Banashankari'
 ORDER BY rating DESC
 LIMIT 5;
 
 /*-------------------- Task 3 -------------------------------------------------------
 Compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service.*/
 WITH ordering_cte AS (
  SELECT SUM(votes) AS ordering_total
  FROM zomato
  WHERE online_order = 'Yes'
),
non_ordering_cte AS (
  SELECT SUM(votes) AS non_ordering_total
  FROM zomato
  WHERE online_order = 'No'
)
SELECT ordering_cte.ordering_total AS total_votes, 'Yes' AS online_order
FROM ordering_cte
UNION all
SELECT non_ordering_cte.non_ordering_total AS total_votes, 'No' AS online_order
FROM non_ordering_cte;

 /*-------------------- Task 4 -------------------------------------------------------
For each Restaurant type, find out the number of restaurants, total votes, and average rating.
Display the data with the highest votes on the top( if the first row of output is NA display the remaining rows).*/
SELECT type, COUNT(name) as number_of_restaurants, SUM(votes) as total_votes, AVG(rating) as avg_rating 
FROM zomato
WHERE type <> 'NA'
GROUP BY type 
ORDER BY total_votes DESC;

/*-------------------- Task 5 -------------------------------------------------------
What is the most liked dish of the most-voted restaurant on Zomato.*/
SELECT name, dish_liked, rating, votes
FROM zomato
ORDER BY votes DESC
LIMIT 1;

/*-------------------- Task 6 -------------------------------------------------------
To increase the maximum profit, Zomato is in need to expand its business.
For doing so Zomato wants the list of the top 15 restaurants which have min 150 votes, have a rating greater than 3,
and is currently not providing online ordering. Display the restaurants with highest votes on the top.*/
SELECT name, rating, votes, online_order
FROM zomato
WHERE votes >= 150 and rating > 3 and online_order = 'No'
ORDER BY votes DESC
LIMIT 15;