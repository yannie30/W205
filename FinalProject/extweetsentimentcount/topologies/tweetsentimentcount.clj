(ns tweetwordcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetwordcount [options]
   [
    ;; spout configuration
    {"tweet-spout" (python-spout-spec
          options
          "spouts.tweets.Tweets"
          ["date" "tweet"]
          :p 3
          )
    }
    ;; bolt configuration
    {"tweet-sentiment-analyzer-bolt" (python-bolt-spec
          options
          {"tweet-spout" :shuffle}
          "bolts.sentiment.TweetSentimentAnalyzer"
          ["date" "sentiment"]
          :p 3
          )
     "save-to-db-bolt" (python-bolt-spec
          options
          {"tweet-sentiment-analyzer-bolt" ["date" "sentiment"]}
          "bolts.save_to_datebase.SaveToDataBase"
          ["date" "US" "pos_tweets" "neg_tweets"]
          :p 2
          )
    }
  ]
)
