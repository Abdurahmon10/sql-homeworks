import pyodbc

conn=pyodbc.connect("driver={sql server};Server=localhost\MSSQLSERVER01;Database=task3;Trusted_Connection=True;")

cur=conn.cursor()

cur.execute("""
    SELECT * FROM products;
    """)

row=cur.fetchone()

with open('apple.png','wb') as f:
    f.write(row[1])