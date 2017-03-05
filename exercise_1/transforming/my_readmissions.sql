drop table my_readmissions;
create table my_readmissions as
select
	ProviderID as Provider_ID,
	MeasureID as Measure_ID,
	ComparedtoNational as Compared_to_National,
	Score as Measure_Score,
	cast(Denominator as double) as Measure_Sample,
	cast(
		concat (substr(MeasureStartDate, 7,4),
		'-',
		substr(MeasureStartDate, 1,2),
		'-',
		substr(MeasureStartDate, 4,2)
		)
	as date) as Measure_Start_Date,
	cast(
		concat (substr(MeasureEndDate, 7,4),
		'-',
		substr(MeasureEndDate, 1,2),
		'-',
		substr(MeasureEndDate, 4,2)
		)
	as date) as Measure_End_Date
from readmissions;
