SELECT
	category,
	MAX(PRICE),
	IIF(Stock=0,'OUT OF STOCK',
		IIF(Stock BETWEEN 1 AND 10, 'LOW STOCK','IN STOCK') )AS InventoryStatus
FROM products
group by category,stock
ORDER BY max(price) DESC
OFFSET 5 ROWS;