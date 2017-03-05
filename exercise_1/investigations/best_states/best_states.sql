DROP TABLE question_2;
CREATE TABLE question_2 AS
SELECT State, avg(Mean_Rank) as Average_State_Rank, stddev_pop(Mean_Rank) as SD_State_Rank 
FROM question_1 
WHERE Measure_Count > 2 
GROUP BY State;

Select *
From question_2
WHERE Average_State_Rank IS NOT NULL
Order by Average_State_Rank
limit 10;
