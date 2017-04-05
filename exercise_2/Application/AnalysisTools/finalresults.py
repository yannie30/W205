import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

#figure out the number of arguments
num_arguements = len(sys.argv) -1  

#connect to the database
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

def noArguement():
    cur.execute("SELECT word, count from tweetwordcount")
    records = cur.fetchall()
    records.sort(key=lambda x: x[0].lower())
    for rec in records:
        print "word=" +  rec[0] +  " count=", rec[1]
        conn.commit()

def singleArguement(argument1):
    cur.execute("SELECT word, count from tweetwordcount WHERE word=%s", (argument1,))
    records = cur.fetchall()
    num_occurance = 0
    for rec in records:
        num_occurance =  rec[1]
    if num_occurance == 0:
        print "\"" + argument1 + "\" did not have any occurances."
    else:
   	print "Total number of occurances of \"" + argument1 + "\":", num_occurance
    conn.commit()

if num_arguements == 0:
    noArguement()
elif num_arguements == 1:
    singleArguement(sys.argv[1])
else:
    print 'Not a valid number of arguements'

conn.close()
