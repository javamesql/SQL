--Write a solution to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.
SELECT DISTINCT author_id AS id
FROM Views
WHERE viewer_id = author_id
ORDER BY author_id ASC;

--Write a solution to find managers with at least five direct reports.
SELECT name 
FROM Employee 
WHERE id IN (
    SELECT managerId 
    FROM Employee 
    GROUP BY managerId 
    HAVING COUNT(*) >= 5);

--Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
SELECT product_name, year, price
FROM Sales s
INNER JOIN Product p ON 
    s.product_id = p.product_id;

--Write a solution to find the employees who are high earners in each of the departments.
SELECT D.name AS 'Department', E.name AS 'Employee', E.salary AS 'Salary' 
FROM Employee E
JOIN Department D
ON E.departmentId = D.id 
WHERE
    3 > (SELECT COUNT(DISTINCT E2.salary)
        FROM Employee E2
        WHERE E2.salary > E.salary AND E.departmentId = E2.departmentId);
