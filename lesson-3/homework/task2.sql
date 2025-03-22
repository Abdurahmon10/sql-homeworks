SELECT 
    COUNT(DISTINCT OrderID) AS TotalOrders,  
    SUM(TotalAmount) AS TotalRevenue,             
    CASE 
        WHEN Status = 'Shipped' OR Status = 'Delivered' THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
        ELSE 'Other' 
    END AS OrderStatus
FROM orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status = 'Shipped' OR Status = 'Delivered' THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
        ELSE 'Other'
    END
HAVING SUM(TotalAmount) > 5000  
ORDER BY TotalRevenue DESC;