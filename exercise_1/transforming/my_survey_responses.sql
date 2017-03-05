drop table my_survey_responses;
create table my_survey_responses as
select
	ProviderNumber as Provider_ID,
	cast(OverallRatingofHospitalPerformanceRate as double) as Overall_Rating
from survey_responses;
