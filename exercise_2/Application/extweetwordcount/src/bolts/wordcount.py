from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT



class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
	
    #create a connection for this instance
	self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    def process(self, tup):
        word = tup.values[0]
	
        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        cur = self.conn.cursor()
	
        record_count=0
        cur.execute("SELECT word, count FROM tweetwordcount WHERE word=%s", (word,))
	records = cur.fetchall()
	for rec in records:
	    record_count = rec[1]
        
	if record_count == 0:
	    cur.execute("INSERT INTO tweetwordcount (word, count) VALUES (%s, %s)", (word,1))
            self.conn.commit()
        else:
            cur.execute("UPDATE tweetwordcount SET count=%s WHERE word=%s", (record_count + 1, word))
            self.conn.commit()
	    
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
