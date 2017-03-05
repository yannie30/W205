DROP TABLE question_4a;
Create Table question_4a as
SELECT question_1.Provider_ID, Mean_Rank, Overall_Rating 
FROM question_1 LEFT OUTER JOIN my_survey_responses ON (question_1.Provider_ID = my_survey_responses.Provider_ID);

SELECT corr(Mean_Rank, Overall_Rating)
FROM question_4a;


Drop Table question_4_provider_measure_var;
CREATE TABLE question_4_provider_measure_var as 
Select Provider_ID, avg(Measure_Score) as Average_Provider_Condition_Score, stddev_pop(Measure_Score) as SD_Provider_Condition_Score
FROM my_hospital_evaluation
GROUP BY Provider_ID;

Drop TABLE question_4b;
Create Table question_4b as 
Select my_survey_responses.Provider_ID, Average_Provider_Condition_Score, SD_Provider_Condition_Score, Overall_Rating
FROM question_4_provider_measure_var
LEFT OUTER JOIN my_survey_responses ON (question_4_provider_measure_var.Provider_ID = my_survey_responses.Provider_ID);

SELECT corr(Average_Provider_Condition_Score, Overall_Rating)
FROM question_4b;

SELECT corr(SD_Provider_Condition_Score, Overall_Rating)
FROM question_4b;

DROP TABLE question_4_time_measures;
CREATE TABLE question_4_time_measures as

FROM my_effective_care_ED
GROUP BY Provider_ID;
