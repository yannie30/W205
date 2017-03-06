Drop Table question_4d;
Create Table question_4d as
Select my_survey_responses.Provider_ID, Hospital_Overall_Rating, Overall_Rating
FROM my_hospitals
LEFT OUTER JOIN my_survey_responses ON (my_hospitals.Provider_ID = my_survey_responses.Provider_ID);

SELECT corr(Hospital_Overall_Rating, Overall_Rating)
FROM question_4d;

