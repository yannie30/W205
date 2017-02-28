drop table my_survey_responses;
create table my_survey_responses as
select
	ProviderNumber as Provider_ID,
	cast(OverallRatingofHospitalPerformanceRate as decimal(1,0)) as OverallRating
from survey_responses;
