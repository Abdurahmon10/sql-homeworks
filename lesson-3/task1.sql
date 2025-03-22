SELECT 
    department,
    AVG(salary) AS AverageSalary,
    CASE 
        WHEN AVG(salary) > 80000 THEN 'High'
        WHEN AVG(salary) BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM (
    SELECT 
        *,
        PERCENT_RANK() OVER (ORDER BY salary DESC) AS pr
    FROM employees
) AS top_employees
WHERE pr <= 1
GROUP BY department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;
