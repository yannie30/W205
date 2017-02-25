#!/bin/bash

#save my current working directory
my_cwd=$(pwd)

#empty and remove staging directory
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging

#remove files from hdfs
#copy the file to hdfs
hdfs dfs -rm /user/w205/hospital_compare/hospitals/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective_care/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/readmissions/readmissions.csv
hdfs dfs -rm /user/w205/hospital_compare/measures/measures.csv
hdfs dfs -rm /user/w205/hospital_compare/survey_responses/survey_responses.csv

#remove our hdfs directory
hdfs dfs -rmdir /user/w205/hospital_compare/hospitals
hdfs dfs -rmdir /user/w205/hospital_compare/effective_care
hdfs dfs -rmdir /user/w205/hospital_compare/readmissions
hdfs dfs -rmdir /user/w205/hospital_compare/measures
hdfs dfs -rmdir /user/w205/hospital_compare/survey_responses
hdfs dfs -rmdir /user/w205/hospital_compare

#change directory back to the original
cd $my_cwd

#clean exit
exit
