import sqlite3
con = sqlite3.connect("AQIVsTemp.db")
cur = con.cursor()
res = cur.execute('SELECT PM10 FROM MadridYearlyAQI')
res.fetchone()