import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the database
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

#Create the Database
try:
    # CREATE DATABASE can't run inside a transaction
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute("CREATE DATABASE FinalProject")
    cur.close()
    conn.close()
except:
    print "Could not create tcount"

#Connecting to tcount
conn = psycopg2.connect(database="FinalProject", user="postgres", password="pass", host="localhost", port="5432")

#Create a Table
#The first step is to create a cursor. 

cur = conn.cursor()
cur.execute('''CREATE TABLE Sentiment
       (RecordDate DATE      NOT NULL,
       Location TEXT     NOT NULL,
       PosTweets INT     NOT NULL
       NegTweets INT     NOT NULL);''')
conn.commit()

print "Success! The database and table have been set up"
