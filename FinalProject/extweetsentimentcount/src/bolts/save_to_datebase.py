from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import datetime



class SaveToDataBase(Bolt):

    def initialize(self, conf, ctx):
        self.pos_counts = Counter()
        self.neg_counts = Counter()
        #create a connection for this instance
        self.conn = psycopg2.connect(database="finalproject", user="postgres", password="pass", host="localhost", port="5432")

    def process(self, tup):
        sentiment = tup.values[0]
        date = str(datetime.date.today().year) + "-" +str(datetime.date.today().month) + "-" + str(datetime.date.today().day)
        
        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        cur = self.conn.cursor()
	
        record_count =0
        pos_record_count=0
        neg_record_count=0
        cur.execute("SELECT RecordDate, Location, PosTweets, NegTweets FROM Sentiment WHERE RecordDate=%s AND Location= %s", (date,"US"))
        records = cur.fetchall()

        for rec in records:
            pos_record_count = rec[2]
            neg_record_count = rec[3]
            record_count = 1
        
        if sentiment == "pos":
            if record_count == 0:
                cur.execute("INSERT INTO Sentiment (RecordDate, Location, PosTweets, NegTweets) VALUES (%s, %s, %s, %s)", (date,"US", 1, 0))
            else:
                cur.execute("UPDATE Sentiment SET PosTweets=%s WHERE RecordDate=%s AND Location=%s", (pos_record_count + 1, date, "US"))
            self.conn.commit()
            self.pos_counts[date] += 1
            self.emit([date, "US", 1,0])
            
        else:
            if record_count == 0:
                cur.execute("INSERT INTO Sentiment (RecordDate, Location, PosTweets, NegTweets) VALUES (%s, %s, %s, %s)", (date,"US", 0, 1))
                self.conn.commit()
            else:
                cur.execute("UPDATE Sentiment SET NegTweets=%s WHERE RecordDate=%s AND Location=%s", (neg_record_count + 1, date, "US"))
            self.conn.commit()
            self.neg_counts[date] += 1
            self.emit([date, "US", 0,1])
	    
        #self.counts[word] += 1
        #self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        #self.log('%s: %d' % (word, self.counts[word]))
        self.log('%s %s %d %d' % (date, "US", self.pos_counts[date], self.neg_counts[date]))
