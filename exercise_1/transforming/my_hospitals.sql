drop table my_hospitals;
create table my_hospitals as
select
	ProviderID as Provider_ID,
	HospitalName as Hospital_Name,
	Address as Address,
	State,
	ZipCode, 
	CountyName as County_Name,
	HospitalType as Hospital_Type,
	HospitalOwnership as Hospital_Ownership,
	EmergencyServices as Emergency_Services,
	cast(HospitalOverallRating as decimal(1,0)) as Hospital_Overall_Rating
from hospitals;
