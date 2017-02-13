#!/bin/bash

#Save my current directory
my_cwd=$(pwd)

#creating staging directory
mkdir ~/staging
mkdir ~/staging/exercise_1

#change to staging directory
cd ~/staging/exercise_1

#get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget "$MY_URL" -O medicare_data.zip

#unzip the medicare data
unzip medicare_data.zip

#Create our hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare

#remove fist line of files and rename
Old_File1="Hospital General Information.csv"
New_File1="hospitals.csv"
tail -n +2 "$Old_File1" > $New_File1

Old_File2="Timely and Effective Care - Hospital.csv"
New_File2="effective_care.csv"
tail -n +2 "$Old_File2" > $New_File2

Old_File3="Readmissions and Deaths - Hospital.csv"
New_File3="readmissions.csv"
tail -n +2 "$Old_File3" > $New_File3

Old_File4="Measure Dates.csv"
New_File4="measures.csv"
tail -n +2 "$Old_File4" > $New_File4

Old_File5="hvbp_hcahps_11_10_2016.csv"
New_File5="survey_responses.csv"
tail -n +2 "$Old_File5" > $New_File5

#copy the file to hdfs
hdfs dfs -put $New_File1 /user/w205/hospital_compare/hospitals
hdfs dfs -put $New_File2 /user/w205/hospital_compare/effective_care
hdfs dfs -put $New_File3 /user/w205/hospital_compare/readmissions
hdfs dfs -put $New_File4 /user/w205/hospital_compare/measures
hdfs dfs -put $New_File5 /user/w205/hospital_compare/survey_responses

#change directory back to the original
cd $my_cwd

#clean exit
exit
