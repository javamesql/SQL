--Write a solution to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.
SELECT DISTINCT author_id AS id
FROM Views
WHERE viewer_id = author_id
ORDER BY author_id ASC;

--Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
SELECT product_name, year, price
FROM Sales s
INNER JOIN Product p ON 
    s.product_id = p.product_id;

--Write a solution to find managers with at least five direct reports.
SELECT name 
FROM Employee 
WHERE id IN (
    SELECT managerId 
    FROM Employee 
    GROUP BY managerId 
    HAVING COUNT(*) >= 5);

--Write a solution to find the employees who are high earners in each of the departments.
SELECT D.name AS 'Department', E.name AS 'Employee', E.salary AS 'Salary' 
FROM Employee E
JOIN Department D
ON E.departmentId = D.id 
WHERE
    3 > (SELECT COUNT(DISTINCT E2.salary)
        FROM Employee E2
        WHERE E2.salary > E.salary AND E.departmentId = E2.departmentId);

--Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who: have the same tiv_2015 value as one or more other policyholders, 
--and are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique). Round tiv_2016 to two decimal places.
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN
    (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1)
    AND (lat,lon) IN (SELECT lat,lon FROM Insurance GROUP BY lat,lon HAVING COUNT(*) = 1);

--Write a solution to calculate the number of bank accounts for each salary category. The salary categories are: 
--"Low Salary": All the salaries strictly less than $20000.
--"Average Salary": All the salaries in the inclusive range [$20000, $50000].
--"High Salary": All the salaries strictly greater than $50000.
(SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count 
FROM accounts 
WHERE income < 20000)
UNION
(SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count 
FROM accounts 
WHERE income BETWEEN 20000 AND 50000)
UNION
(SELECT 'High Salary' AS category, COUNT(*) AS accounts_count 
FROM accounts 
WHERE income > 50000);

--Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
SELECT customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_id;

--Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
SELECT A.id
FROM Weather A
LEFT JOIN Weather B
    ON DATE(A.recordDate) = DATE(B.recordDate + INTERVAL 1 DAY)
WHERE A.temperature > B.temperature;

--There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.
--The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
--The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
SELECT a1.machine_id, ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM Activity a1
JOIN Activity a2
ON a1.machine_id = a2.machine_id
    AND a1.process_id = a2.process_id
    AND a1.activity_type = 'start'
    AND a2.activity_type = 'end'
GROUP BY a1.machine_id;



