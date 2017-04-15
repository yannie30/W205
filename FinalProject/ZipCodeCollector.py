import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import csv
import tweepy
import nltk
from nltk.classify import NaiveBayesClassifier
import datetime


#####getting rid of ssl security warnings#####
import requests.packages.urllib3
requests.packages.urllib3.disable_warnings()


####Zip to Lat Long code####
zipToLatLong = {}
with open('ZipCodeLookup.csv', mode='r') as infile:
    reader = csv.reader(infile)
    for row in reader:
        zipToLatLong[row[0]]= row[1]

def findLatLong(zip):
    try:
        return zipToLatLong[zip]
    except:
        return None

##### search twitter #####
consumer_key = "45ho6BOOnTd7E5Psptlns9CU2"
consumer_secret = "8JeTtZAmjXmC6kdBm13bIBlMig51xhDV7ciRZ961zc52BD0Q9V"
access_token = "843619900023226368-6nYCTJwnQSjospaZgZutk7A17JxmpPt"
access_token_secret = "zkmMJGaFxDenRQOsX5pwmfaomjz5CgPupY7fX1sCmWlU2"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)

def TweetsinZip(query, date, listOfZips):
    returnThis = []
    for Zip in listOfZips:
        if findLatLong(Zip) != None:
            LatLong = findLatLong(Zip)+",1mi"
            searched_tweets = api.search(q = query, lang="en", count=1, geocode = LatLong, result_type='recent', until = date)
            for tweet in searched_tweets:
                returnThis.append([Zip,tweet])
    return returnThis


##### NLTK #####
neg = []
pos = []

#defining funciton to format sentences
def format_sentence(sent):
    return({word: True for word in nltk.word_tokenize(sent)})

#import positive sentiment data
with open("pos_tweets.txt") as f:
    for i in f:
        pos.append([format_sentence(i), 'pos'])

#import negative sentiment data
with open("neg_tweets.txt") as f:
    for i in f:
        neg.append([format_sentence(i), 'neg'])

training = pos[:int((.9)*len(pos))] + neg[:int((.9)*len(neg))]
test = pos[int((.1)*len(pos)):] + neg[int((.1)*len(neg)):]

classifier = NaiveBayesClassifier.train(training)

def searchAndAnalyze(serachterm, day, zipcodes):
    classifierResults = []
    pos_summarizedReults = {}
    neg_summarizedReults = {}
    for tweet in TweetsinZip(serachterm, day, zipcodes):
        Zip = tweet[0]
        Sentiment =  classifier.classify(format_sentence(tweet[1].text))
        classifierResults.append([Zip, Sentiment])
        if Sentiment == 'pos':
            pos_summarizedReults.setdefault(Zip, 0)
            pos_summarizedReults[tweet[0]] = pos_summarizedReults[tweet[0]] + 1
        else:
            neg_summarizedReults.setdefault(Zip, 0)
            neg_summarizedReults[tweet[0]] = neg_summarizedReults[tweet[0]] + 1
    return pos_summarizedReults, neg_summarizedReults


#figure out the number of arguments  :searchterm, zipcodes (list)
today_year = datetime.date.today().year
today_month = datetime.date.today().month
today_day = datetime.date.today().day
today = str(today_year) +"," + str(today_month) +"," + str(today_day)
print today
num_arguements = len(sys.argv) -1

#connect to the database
conn = psycopg2.connect(database="finalproject", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

#save results to database
pos_results, neg_results = searchAndAnalyze(sys.argv[1], today, sys.argv[2].split(","))

def updateTable(zipcode, pos_number, neg_number):
    record_count=0
    pos_record_count=0
    neg_record_count=0
    cur.execute("SELECT RecordDate, Location, PosTweets, NegTweets FROM Sentiment WHERE RecordDate=%s AND Location= %s", (today,zipcode))
    records = cur.fetchall()
    for rec in records:
        pos_record_count = rec[2]
        neg_record_count = rec[3]
        record_count = 1
    if record_count == 0:
        cur.execute("INSERT INTO Sentiment (RecordDate, Location, PosTweets, NegTweets) VALUES (%s, %s, %s, %s)", (today,zipcode, pos_number, neg_number))
    else:
        cur.execute("UPDATE Sentiment SET PosTweets=%s, NegTweets=%s WHERE RecordDate=%s AND Location=%s", (pos_record_count + pos_number, neg_record_count + neg_number, today, zipcode))
    conn.commit()

for positiveresult in pos_results.items():
    print "positive result"
    zipcode = positiveresult[0]
    pos_number = positiveresult[1]
    updateTable(zipcode, pos_number, 0)

for negativeresult in neg_results.items():
    print "negative result"
    zipcode = negativeresult[0]
    neg_number = negativeresult[1]
    updateTable(zipcode, 0, neg_number)

conn.close()
