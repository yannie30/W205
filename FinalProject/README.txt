# Ensure you are in the directoy of this README
# and Run the following commands:
bash ./setup.sh
#setup will take approx 15 minutes

# Once setup is done run:
cd extweetsentimentcount
sparse run

# duplicate session and run
cd /root/w205/FinalProject/ZipCodeData
python new_Bot25Top25.py

# After letting some data collect, duplicate session and run:
python ExtractZipCodeData.py "/root/w205/FinalProject/AnalysisOutput/" "all"
# then you can grab the csv file from /root/w205/FinalProject/AnalysisOutput/



# If you want to look at the tables of data, run
psql -U postgres
\c finalproject
select * from final_with_slope limit 10;
select * from sentiment;
