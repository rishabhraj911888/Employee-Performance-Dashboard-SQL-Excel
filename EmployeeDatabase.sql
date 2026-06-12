create database employees;
use  employees ;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    manager VARCHAR(100),
    city VARCHAR(50),
    joining_date DATE,
    salary INT,
    experience_years DECIMAL(3,1)
);
CREATE TABLE attendance (
    attendance_date DATE,
    emp_id INT,
    login_hours DECIMAL(4,1),
    status VARCHAR(20)
);
CREATE TABLE sales (
    sales_id INT PRIMARY KEY,
    sales_date DATE,
    emp_id INT,
    calls_made INT,
    target_sales INT,
    sales_amount INT
);
CREATE TABLE collections (
    collection_id INT PRIMARY KEY,
    collection_date DATE,
    emp_id INT,
    target_amount INT,
    collection_amount INT,
    pending_amount INT,
    payment_status VARCHAR(20)
);

-- 1. Total Employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. Department-wise Employee Count
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
ORDER BY total_employees DESC;

-- 3. City-wise Employee Count
SELECT city, COUNT(*) AS total_employees
FROM employees
GROUP BY city
ORDER BY total_employees DESC;

-- 4. Manager-wise Team Size
SELECT manager, COUNT(*) AS team_size
FROM employees
GROUP BY manager
ORDER BY team_size DESC;

-- 5. Average Salary by Department
SELECT department, ROUND(AVG(salary),2) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- 6. Total Attendance Records
SELECT COUNT(*) AS total_attendance_records
FROM attendance;

-- 7. Attendance Percentage
SELECT 
ROUND(
COUNT(CASE WHEN status = 'Present' THEN 1 END) * 100.0 / COUNT(*), 2
) AS attendance_percentage
FROM attendance;

-- 8. Average Login Hours
SELECT ROUND(AVG(login_hours),2) AS avg_login_hours
FROM attendance
WHERE status <> 'Absent';

-- 9. Department-wise Average Login Hours
SELECT e.department,
       ROUND(AVG(a.login_hours),2) AS avg_login_hours
FROM employees e
JOIN attendance a
ON e.emp_id = a.emp_id
WHERE a.status <> 'Absent'
GROUP BY e.department
ORDER BY avg_login_hours DESC;

-- 10. Employee-wise Attendance Percentage
SELECT e.emp_id,
       e.emp_name,
       ROUND(COUNT(CASE WHEN a.status = 'Present' THEN 1 END) * 100.0 / COUNT(*),2) AS attendance_percentage
FROM employees e
JOIN attendance a
ON e.emp_id = a.emp_id
GROUP BY e.emp_id, e.emp_name
ORDER BY attendance_percentage DESC;

-- 11. Total Sales
SELECT SUM(sales_amount) AS total_sales
FROM sales;

-- 12. Total Collection
SELECT SUM(collection_amount) AS total_collection
FROM collections;

-- 13. Collection Efficiency %
SELECT 
ROUND(SUM(collection_amount) * 100.0 / SUM(target_amount),2) AS collection_efficiency_percentage
FROM collections;

-- 14. Sales Achievement %
SELECT 
ROUND(SUM(sales_amount) * 100.0 / SUM(target_sales),2) AS sales_achievement_percentage
FROM sales;

-- 15. Department-wise Sales
SELECT e.department,
       SUM(s.sales_amount) AS total_sales
FROM employees e
JOIN sales s
ON e.emp_id = s.emp_id
GROUP BY e.department
ORDER BY total_sales DESC;

-- 16. Department-wise Collection
SELECT e.department,
       SUM(c.collection_amount) AS total_collection
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.department
ORDER BY total_collection DESC;

-- 17. Manager-wise Collection
SELECT e.manager,
       SUM(c.collection_amount) AS total_collection
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.manager
ORDER BY total_collection DESC;

-- 18. City-wise Collection
SELECT e.city,
       SUM(c.collection_amount) AS total_collection
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.city
ORDER BY total_collection DESC;

-- 19. Top 10 Collectors
SELECT e.emp_id,
       e.emp_name,
       e.department,
       SUM(c.collection_amount) AS total_collection
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.emp_id, e.emp_name, e.department
ORDER BY total_collection DESC
LIMIT 10;

-- 20. Bottom 10 Collectors
SELECT e.emp_id,
       e.emp_name,
       e.department,
       SUM(c.collection_amount) AS total_collection
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.emp_id, e.emp_name, e.department
ORDER BY total_collection ASC
LIMIT 10;

-- 21. Top 10 Sales Performers
SELECT e.emp_id,
       e.emp_name,
       e.department,
       SUM(s.sales_amount) AS total_sales
FROM employees e
JOIN sales s
ON e.emp_id = s.emp_id
GROUP BY e.emp_id, e.emp_name, e.department
ORDER BY total_sales DESC
LIMIT 10;

-- 22. Employees Below Collection Target
SELECT e.emp_id,
       e.emp_name,
       e.department,
       SUM(c.target_amount) AS total_target,
       SUM(c.collection_amount) AS total_collection,
       SUM(c.target_amount) - SUM(c.collection_amount) AS shortfall
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.emp_id, e.emp_name, e.department
HAVING total_collection < total_target
ORDER BY shortfall DESC;

-- 23. Employees Above Collection Target
SELECT e.emp_id,
       e.emp_name,
       e.department,
       SUM(c.target_amount) AS total_target,
       SUM(c.collection_amount) AS total_collection,
       SUM(c.collection_amount) - SUM(c.target_amount) AS extra_collection
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.emp_id, e.emp_name, e.department
HAVING total_collection >= total_target
ORDER BY extra_collection DESC;

-- 24. Payment Status Count
SELECT payment_status,
       COUNT(*) AS total_records
FROM collections
GROUP BY payment_status;

-- 25. Monthly Sales Trend
SELECT MONTH(sales_date) AS month_no,
       SUM(sales_amount) AS total_sales
FROM sales
GROUP BY MONTH(sales_date)
ORDER BY month_no;

-- 26. Daily Collection Trend
SELECT collection_date,
       SUM(collection_amount) AS daily_collection
FROM collections
GROUP BY collection_date
ORDER BY collection_date;

-- 27. Daily Sales Trend
SELECT sales_date,
       SUM(sales_amount) AS daily_sales
FROM sales
GROUP BY sales_date
ORDER BY sales_date;

-- 28. Employee Performance Category using CASE WHEN
SELECT e.emp_id,
       e.emp_name,
       SUM(c.collection_amount) AS total_collection,
       CASE
           WHEN SUM(c.collection_amount) >= SUM(c.target_amount) THEN 'High Performer'
           WHEN SUM(c.collection_amount) >= SUM(c.target_amount) * 0.75 THEN 'Medium Performer'
           ELSE 'Low Performer'
       END AS performance_category
FROM employees e
JOIN collections c
ON e.emp_id = c.emp_id
GROUP BY e.emp_id, e.emp_name;

-- 29. Rank Employees by Collection using Window Function
SELECT emp_id,
       emp_name,
       department,
       total_collection,
       RANK() OVER(ORDER BY total_collection DESC) AS collection_rank
FROM (
    SELECT e.emp_id,
           e.emp_name,
           e.department,
           SUM(c.collection_amount) AS total_collection
    FROM employees e
    JOIN collections c
    ON e.emp_id = c.emp_id
    GROUP BY e.emp_id, e.emp_name, e.department
) t;

-- 30. Top Performer in Each Department
SELECT *
FROM (
    SELECT e.emp_id,
           e.emp_name,
           e.department,
           SUM(c.collection_amount) AS total_collection,
           ROW_NUMBER() OVER(
               PARTITION BY e.department
               ORDER BY SUM(c.collection_amount) DESC
           ) AS rn
    FROM employees e
    JOIN collections c
    ON e.emp_id = c.emp_id
    GROUP BY e.emp_id, e.emp_name, e.department
) t
WHERE rn = 1;

-- 31. Top 3 Employees in Each Department
SELECT *
FROM (
    SELECT e.emp_id,
           e.emp_name,
           e.department,
           SUM(c.collection_amount) AS total_collection,
           DENSE_RANK() OVER(
               PARTITION BY e.department
               ORDER BY SUM(c.collection_amount) DESC
           ) AS dept_rank
    FROM employees e
    JOIN collections c
    ON e.emp_id = c.emp_id
    GROUP BY e.emp_id, e.emp_name, e.department
) t
WHERE dept_rank <= 3;

-- 32. Employees Above Department Average Collection using CTE
WITH emp_collection AS (
    SELECT e.emp_id,
           e.emp_name,
           e.department,
           SUM(c.collection_amount) AS total_collection
    FROM employees e
    JOIN collections c
    ON e.emp_id = c.emp_id
    GROUP BY e.emp_id, e.emp_name, e.department
),
dept_avg AS (
    SELECT department,
           AVG(total_collection) AS avg_dept_collection
    FROM emp_collection
    GROUP BY department
)
SELECT ec.emp_id,
       ec.emp_name,
       ec.department,
       ec.total_collection,
       da.avg_dept_collection
FROM emp_collection ec
JOIN dept_avg da
ON ec.department = da.department
WHERE ec.total_collection > da.avg_dept_collection;

-- 33. Employee Complete Employees
SELECT e.emp_id,
       e.emp_name,
       e.department,
       e.manager,
       e.city,
       a.avg_login_hours,
       s.total_sales,
       c.total_collection,
       c.collection_efficiency
FROM employees e
LEFT JOIN (
    SELECT emp_id,
           ROUND(AVG(login_hours),2) AS avg_login_hours
    FROM attendance
    WHERE status <> 'Absent'
    GROUP BY emp_id
) a
ON e.emp_id = a.emp_id
LEFT JOIN (
    SELECT emp_id,
           SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY emp_id
) s
ON e.emp_id = s.emp_id
LEFT JOIN (
    SELECT emp_id,
           SUM(collection_amount) AS total_collection,
           ROUND(SUM(collection_amount) * 100.0 / SUM(target_amount),2) AS collection_efficiency
    FROM collections
    GROUP BY emp_id
) c
ON e.emp_id = c.emp_id
ORDER BY c.collection_efficiency DESC;

-- 34. Department-wise Average Login Hours

SELECT e.department,
       ROUND(AVG(a.login_hours),2) AS avg_login_hours
FROM employees e
JOIN attendance a
ON e.emp_id = a.emp_id
WHERE a.status <> 'Absent'
GROUP BY e.department;


-- 35. Daily Sales Trend

SELECT sales_date,
       SUM(sales_amount) AS daily_sales
FROM sales
GROUP BY sales_date
ORDER BY sales_date;

-- 36. Sales Efficiency %

SELECT 
ROUND(
SUM(sales_amount) * 100.0 / SUM(target_sales),
2
) AS sales_efficiency_percentage
FROM sales;
