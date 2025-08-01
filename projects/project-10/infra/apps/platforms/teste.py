import pyodbc

conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=sqlserver,1433;"
    "DATABASE=master;"
    "UID=<usuario>;"
    "PWD=<senha>"
)

cursor = conn.cursor()
cursor.execute("SELECT @@VERSION")
row = cursor.fetchone()
print(row[0])