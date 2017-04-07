These instructions assume:
* You are running an instance of AMI Name: UCB MIDS W205 EX2-FULL (AMI ID: ami-d4dd4ec3), with correct security/port settings.  This assumes hadoop is already started since it is apart of the start up script.
* You are using an EBS setup in lab 2, so that hadoop and postgres have already been set up
* You already have Twitter Credentials
* You are using Python 2.7 with tweet.py installed
* You have installed Psycopg2 version 2.6.2

-----------------------steps-----------------------
* Start your instance using the normal start up process (running code from the AWS interface to connect to your instance)
* Mount your disk by running: mount -t ext4 /dev/xvdf /data
* Start Postgres, run: /data/start_postgres.sh
* Sudo into the w205 user: su - w205
* Create a folder to download the program: mkdir YannieExercise2
* Navigate to the folder just created: cd YannieExercise2
* Clone the program: git clone https://github.com/yannie30/W205.git
* Make sure to update the following files with your twitter user credentials:
** W205/exercise_2/extweetwordcount/src/spouts/tweets.py
** W205/exercise_2/Application/SetUp/TwitterConnectionTest
** Specifically, there are 4 items to add/change in each file: consumer_key, consumer_secret, access_token, access_token_secret
* Create the database and table by running the createDatabases.py file in the /home/w205/W205/exercise_2/Application/SetUp directory from command line: python createDatabases.py
* Check your ability to connect to Twitter by running the hello-stream-twitter.py script from the /home/w205/W205/exercise_2/Application/SetUp/TwitterConnectionTest directory from command line: python hello-stream-twitter.py 
**if it works, you will see a count and run time
* Run the main program:
** Run the program from the W205/exercise_2/Application/extweetwordcount directory from command line: sparse run
* Hit control + C when you want the program to stop running
* You can use the functions defined in the finalresults.py to analyze the data.  To do this, go to the /home/w205/W205/exercise_2/Application/AnalysisTools directory:
** To look at all results (all words and their respective counts): python finalresults.py
** To look at word counts for a specific word: python finalresults.py word
** To get a list of all words with count greater than or equal to K1 and less than or equal to K2: python finalresults.py K1,K2
*Once you are finished analyzing the data, exit out of user w205: exit
*Then, stop postgres: /data/stop_postgres.sh
*You can now safely shut down your instance