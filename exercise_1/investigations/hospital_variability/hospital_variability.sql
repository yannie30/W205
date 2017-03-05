
Select condition, avg(Measure_Score) as Average_Condition_Score, stddev_pop(Measure_Score) as SD_Condition_Score
FROM my_hospital_evaluation
GROUP BY condition
Order BY SD_Condition_Score Desc;
