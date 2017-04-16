from __future__ import absolute_import, print_function, unicode_literals

import re
from streamparse.bolt import Bolt
import nltk
from nltk.classify import NaiveBayesClassifier


class TweetSentimentAnalyzer(Bolt):
    training = []

    #defining funciton to format sentences
    def format_sentence(sent):
        return({word: True for word in nltk.word_tokenize(sent)})

    #import positive sentiment data
    with open("/root/W205 GIT/W205/FinalProject/extweetsentimentcount/src/bolts/pos_tweets.txt") as f:
        for i in f:
            training.append([format_sentence(i), 'pos'])

    #import negative sentiment data
    with open("/root/W205 GIT/W205/FinalProject/extweetsentimentcount/src/bolts/neg_tweets.txt") as f:
        for i in f:
            training.append([format_sentence(i), 'neg'])

    classifier = NaiveBayesClassifier.train(training)
    
    def process(self, tup):
        tweet = tup.values[0]  # extract the tweet
        

        # Split the tweet into words
        #words = tweet.split()
        sentiment = []
        sentiment.append(classifier.classify(format_sentence(tweet)))

        if not sentiment: return

        # Emit all the words
        self.emit(sentiment)

        self.log('%s' % (sentiment))

        # tuple acknowledgement is handled automatically
