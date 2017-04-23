#python ExtractZipCodeData.py "/root/W205 GIT/W205/FinalProject/AnalysisOutput/" "baseline"

import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import csv


def pull_data_by_zip(path, zips):
    #connect to the database
    conn = psycopg2.connect(database="finalproject", user="postgres", password="pass", host="localhost", port="5432")
    cur = conn.cursor()
    path_ext = ""
 
    if zips[0] == "all":
        #what to do if all zips are requested
        zips = []
        cur.execute("SELECT Location, sum(PosTweets) from Sentiment GROUP BY Location;")
        records_dup = cur.fetchall()
        for record in records_dup:
            zips.append(record[0])
        path_ext = "all"
    elif zips[0] == "top25":
        zips = []
        cur.execute("select zip, sum_change from sum_pay_change94_14 order by sum_change desc limit 25;")
        records_dup = cur.fetchall()
        for record in records_dup:
            zips.append(str(record[0]))
        path_ext = "top25"
    elif zips[0] == "bottom25":
        zips = []
        cur.execute("select zip, sum_change from sum_pay_change94_14 order by sum_change desc limit 25;")
        records_dup = cur.fetchall()
        for record in records_dup:
            zips.append(str(record[0]))
        path_ext = "bottom25"
    elif zips[0] == "top25bottom25":
        zips = []
        cur.execute("select zip, sum_change from sum_pay_change94_14 order by sum_change desc limit 25;")
        records_dup = cur.fetchall()
        for record in records_dup:
            zips.append(str(record[0]))
        cur.execute("select zip, sum_change from sum_pay_change94_14 order by sum_change desc limit 25;")
        records_dup = cur.fetchall()
        for record in records_dup:
            zips.append(str(record[0]))
        path_ext = "top25bottom25"
    elif zips[0] == "baseline":
        print "###baseline"
        zips = []
        zips.append("US")
        path_ext = "baseline"
    else:
        #making sure to pull baseline as well
        zips.append("US")
        path_ext = "customWBaseine"

    print_this = []
    
    for zip in zips:
        print "processing zip", zip
        record_count=0
        
        #pull data
        cur.execute("SELECT RecordDate, Location, PosTweets, NegTweets from Sentiment WHERE Location=%s", (zip, ))
        records = cur.fetchall()
        
        #check to see if there were results
        for rec in records:
            record_count = 1
        
        #check if zip exists, if doesn't let user know. if the zip does exist in the database, save to zip file
        if record_count == 0:
            print "we have not collected any data on " + zip
        else:
            for rec in records:
                print_this.append(rec)
        

    with open(path + 'ExtractZipCodeData_'+ path_ext +'.csv', 'wb') as csvfile:
        filewriter = csv.writer(csvfile, delimiter=',',quotechar='|', quoting=csv.QUOTE_MINIMAL)
        filewriter.writerow(["Date","Location","Positive_Tweets", "Negative_Tweets"])
        for rec in print_this:
            print rec
            filewriter.writerow([rec[0],rec[1],rec[2],rec[3]])
                        
    conn.close()

#figure out the number of arguments
num_arguements = len(sys.argv) -1
if num_arguements == 2:
    Path = sys.argv[1]
    Zips = sys.argv[2].split(",")
    pull_data_by_zip(Path, Zips)
    print "Your file has been saved"
else :
    print "Please enter the output path for the first argument and a list of zip codes as comma separated strings as the second argument (example - \"94105\",\"94105\",\"94105\")"
