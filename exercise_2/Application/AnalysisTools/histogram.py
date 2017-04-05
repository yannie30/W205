import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

#figure out the number of arguments
num_arguements = len(sys.argv) -1

#connect to the database
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

def doubleArguement(argument1, argument2):
    diff = int(argument2) - int(argument1) + 1
    for counter in range(diff):
        count = counter + int(argument1)
        cur.execute("SELECT word, count from tweetwordcount WHERE count=%s", (count,))
        records = cur.fetchall()
        for rec in records:
            print str(rec[0]) + ":", str(rec[1])
        conn.commit()

if num_arguements == 1:
    arguements = sys.argv[1].split(",")
    if len(arguements) == 2:
        doubleArguement(arguements[0], arguements[1])
    else:
        print "Arguments invalid, must be in the form K1,K2"
else:
    print 'Please specify lower and upper bounds in the form K1,K2'

conn.close()

