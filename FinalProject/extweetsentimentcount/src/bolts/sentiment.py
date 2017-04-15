from __future__ import absolute_import, print_function, unicode_literals

import re
from streamparse.bolt import Bolt
import nltk

################################################################################
# NLTK Functions
################################################################################
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

################################################################################
# Function to check if the string contains only ascii chars
################################################################################
def ascii_string(s):
  return all(ord(c) < 128 for c in s)

class TweetSentimentAnalyzer(Bolt):

    def process(self, tup):
        tweet = tup[1].values[0]  # extract the tweet

        # Split the tweet into words
        #words = tweet.split()
        sentiment = []
        sentiment = classifier.classify(format_sentence(tweet))

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
        self.emit(tup[0], sentiment)

        # tuple acknowledgement is handled automatically
