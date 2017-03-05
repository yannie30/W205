DROP TABLE question_4_time_measures;
CREATE TABLE question_4_time_measures as
Select Provider_ID, Measure_Score, ED_Rank
FROM my_effective_care_ED;

DROP Table question_4c;
CREATE TABLE question_4c AS
Select my_survey_responses.Provider_ID, cast(Measure_Score as double) as Measure_Score, ED_Rank, Overall_Rating
FROM question_4_time_measures
LEFT OUTER JOIN my_survey_responses ON (question_4_time_measures.Provider_ID = my_survey_responses.Provider_ID);

SELECT corr(Measure_Score, Overall_Rating)
FROM question_4c;

SELECT corr(ED_Rank, Overall_Rating)
FROM question_4c;
