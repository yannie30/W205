from __future__ import absolute_import, print_function, unicode_literals

import re
from streamparse.bolt import Bolt
import nltk
from nltk.classify import NaiveBayesClassifier



################################################################################
# NLTK Functions
################################################################################
neg = []
pos = []

#defining funciton to format sentences
def format_sentence(sent):
    return({word: True for word in nltk.word_tokenize(sent)})

#import positive sentiment data
with open("/root/W205 GIT/W205/FinalProject/extweetsentimentcount/src/bolts/pos_tweets.txt") as f:
    for i in f:
        pos.append([format_sentence(i), 'pos'])

#import negative sentiment data
with open("/root/W205 GIT/W205/FinalProject/extweetsentimentcount/src/bolts/neg_tweets.txt") as f:
    for i in f:
        neg.append([format_sentence(i), 'neg'])

training = pos[:int((.9)*len(pos))] + neg[:int((.9)*len(neg))]
test = pos[int((.1)*len(pos)):] + neg[int((.1)*len(neg)):]
classifier = NaiveBayesClassifier.train(training)

################################################################################
# Function to check if the string contains only ascii chars
################################################################################
def ascii_string(s):
  return all(ord(c) < 128 for c in s)

class TweetSentimentAnalyzer(Bolt):

    def process(self, tup):
        tweet = tup.values[0]  # extract the tweet
        

        # Split the tweet into words
        #words = tweet.split()
        sentiment = []
        sentiment.append(classifier.classify(format_sentence(tweet)))

        # Filter out the hash tags, RT, @ and urls
        #valid_words = []
        #for word in words:

            # Filter the hash tags
            #if word.startswith("#"): continue

            # Filter the user mentions
            #if word.startswith("@"): continue

            # Filter out retweet tags
            #if word.startswith("RT"): continue

            # Filter out the urls
            #if word.startswith("http"): continue

            # Strip leading and lagging punctuations
            #aword = word.strip("\"?><,'.:;)")

            # now check if the word contains only ascii
            #if len(aword) > 0 and ascii_string(word):
            #    valid_words.append([aword])

        if not sentiment: return

        # Emit all the words
        self.emit(sentiment)

        # tuple acknowledgement is handled automatically
