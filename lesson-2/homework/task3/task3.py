import pyodbc

uid = 'WIN-VSF9TGHH5LD'
server = 'localhost'
port = 1433
database = 'master'
pwd = '1234qwerASDF'


con_str = f'DRIVER=sql server;SERVER={server};PORT={port};DATABASE={database};UID={uid};PWD={pwd};TDS_VERSION=7.3'

conn=pyodbc.connect(con_str)

cur=conn.cursor()

cur.execute("""
    SELECT * FROM products;
    """)

row=cur.fetchone()

with open('apple.png','wb') as f:
    f.write(row[1])