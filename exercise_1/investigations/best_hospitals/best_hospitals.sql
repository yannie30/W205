DROP TABLE my_effective_care_flu;
CREATE TABLE my_effective_care_flu AS
SELECT Provider_ID, Condition, Measure_ID, Measure_Sample,
        CASE WHEN Measure_Score = "Not Available" THEN NULL
        	ELSE RANK() OVER (ORDER BY cast(Measure_Score as double) DESC) END AS Flu_Rank,
	CASE WHEN Measure_Score = "Not Available" THEN NULL ELSE Measure_Score END AS Measure_Score
FROM my_effective_care
WHERE measure_ID = 'IMM_2';

DROP TABLE my_effective_care_heart_attack;
CREATE TABLE my_effective_care_heart_attack AS
SELECT Provider_ID, Condition, Measure_ID, Measure_Sample,
        CASE WHEN Measure_Score = "Not Available" THEN NULL
        	ELSE RANK() OVER (ORDER BY cast(Measure_Score as double) DESC) END AS Heart_Attack_Rank,
	CASE WHEN Measure_Score = "Not Available" THEN NULL ELSE Measure_Score END AS Measure_Score
FROM my_effective_care
WHERE measure_ID = 'OP_2';

DROP TABLE my_effective_care_ED;
CREATE TABLE my_effective_care_ED AS
SELECT Provider_ID, Condition, Measure_ID, Measure_Sample,
        CASE WHEN Measure_Score = "Not Available" THEN NULL
        	ELSE RANK() OVER (ORDER BY cast(Measure_Score as double) ASC) END AS ED_Rank,
	CASE WHEN Measure_Score = "Not Available" THEN NULL ELSE Measure_Score END AS Measure_Score
FROM my_effective_care
WHERE measure_ID = 'OP_20';

DROP TABLE my_effective_care_colonoscopy;
CREATE TABLE my_effective_care_colonoscopy AS
SELECT Provider_ID, Condition, Measure_ID, Measure_Sample,
        CASE WHEN Measure_Score = "Not Available" THEN NULL
        	ELSE RANK() OVER (ORDER BY cast(Measure_Score as double) DESC) END AS Colonoscopy_Rank,
	CASE WHEN Measure_Score = "Not Available" THEN NULL ELSE Measure_Score  END AS Measure_Score
FROM my_effective_care
WHERE measure_ID = 'OP_29';

DROP TABLE my_effective_care_cataract;
CREATE TABLE my_effective_care_cataract AS
SELECT Provider_ID, Condition, Measure_ID, Measure_Sample,
        CASE WHEN Measure_Score = "Not Available" THEN NULL
        	ELSE RANK() OVER (ORDER BY cast(Measure_Score as double) DESC) END AS Cataract_Rank,
	CASE WHEN Measure_Score = "Not Available" THEN NULL ELSE Measure_Score END AS Measure_Score
FROM my_effective_care
WHERE measure_ID = 'OP_31';

DROP TABLE my_effective_care_blood_clot_prevention;
CREATE TABLE my_effective_care_blood_clot_prevention AS
SELECT Provider_ID, Condition, Measure_ID, Measure_Sample,
        CASE WHEN Measure_Score = "Not Available" THEN NULL
        	ELSE RANK() OVER (ORDER BY Measure_Score DESC) END AS Blood_Clot_Prevention_Rank,
	CASE WHEN Measure_Score = "Not Available" THEN NULL ELSE Measure_Score END AS Measure_Score
FROM my_effective_care
WHERE measure_ID = 'VTE_5';

DROP TABLE my_hospital_evaluation;
CREATE TABLE my_hospital_evaluation AS
SELECT * FROM 
        (
        SELECT my_hospitals.Provider_ID as Provider_ID, Hospital_Name, State, ZipCode, Condition, Measure_ID, Measure_Sample, Flu_Rank as Measure_Rank, Measure_Score
        FROM my_hospitals
        LEFT OUTER JOIN my_effective_care_flu on (my_hospitals.Provider_ID = my_effective_care_flu.Provider_ID)

        UNION ALL

        SELECT my_hospitals.Provider_ID as Provider_ID, Hospital_Name, State, ZipCode, Condition, Measure_ID, Measure_Sample, Heart_Attack_Rank as Measure_Rank, Measure_Score
        FROM my_hospitals
        LEFT OUTER JOIN my_effective_care_heart_attack on (my_hospitals.Provider_ID = my_effective_care_heart_attack.Provider_ID)

        UNION ALL

        SELECT my_hospitals.Provider_ID as Provider_ID, Hospital_Name, State, ZipCode, Condition, Measure_ID, Measure_Sample, ED_Rank as Measure_Rank, Measure_Score
        FROM my_hospitals
        LEFT OUTER JOIN my_effective_care_ED on (my_hospitals.Provider_ID = my_effective_care_ED.Provider_ID)

        UNION ALL

        SELECT my_hospitals.Provider_ID as Provider_ID, Hospital_Name, State, ZipCode, Condition, Measure_ID, Measure_Sample, Colonoscopy_Rank as Measure_Rank, Measure_Score
        FROM my_hospitals
        LEFT OUTER JOIN my_effective_care_colonoscopy on (my_hospitals.Provider_ID = my_effective_care_colonoscopy.Provider_ID)

        UNION ALL

        SELECT my_hospitals.Provider_ID as Provider_ID, Hospital_Name, State, ZipCode, Condition, Measure_ID, Measure_Sample, Cataract_Rank as Measure_Rank, Measure_Score
        FROM my_hospitals
        LEFT OUTER JOIN my_effective_care_cataract on (my_hospitals.Provider_ID = my_effective_care_cataract.Provider_ID)

        UNION ALL

        SELECT my_hospitals.Provider_ID as Provider_ID, Hospital_Name, State, ZipCode, Condition, Measure_ID, Measure_Sample, Blood_Clot_Prevention_Rank as Measure_Rank, Measure_Score
        FROM my_hospitals
        LEFT OUTER JOIN my_effective_care_blood_clot_prevention on (my_hospitals.Provider_ID = my_effective_care_blood_clot_prevention.Provider_ID)
        ) UNIONRESULT;


DROP TABLE question_1;
CREATE TABLE question_1 AS
SELECT Provider_ID, Hospital_Name, State, avg(Measure_Rank) as Mean_Rank, stddev_pop(Measure_Rank) as SD_Rank, count(Measure_Rank) as Measure_Count
FROM my_hospital_evaluation
GROUP BY Provider_ID, Hospital_Name, State
ORDER BY Mean_Rank, SD_Rank ASC;

select * from question_1 WHERE Mean_Rank is not NUll and Measure_Count > 2 limit 10;
