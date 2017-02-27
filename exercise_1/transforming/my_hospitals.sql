create table my_hospitals as
select
	ProviderID as Provider_ID
	HopitalName as Hospital_Name
	State
	cast(HospitalOverallRating as decimal(1,0)) as Hospital_Overall_Rating
from hospitals;
