import pyodbc # SQL SERVER

con_str = "DRIVER={SQL SERVER};SERVER=DESKTOP-U5NSLOC\SQLEXPRESS;DATABASE=class2;Trusted_Connection=yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute(
    """
    SELECT * FROM photos;
    """
)

row = cursor.fetchone()
id,  photo = row

with open('image.png', 'wb') as f:
    f.write(photo)