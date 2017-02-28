drop table my_effective_care;
create table my_effective_care as
select
	ProviderID as Provider_ID,
	Condition,
	MeasureID as Measure_ID,
	cast(Score as decimal(1,0)) as Measure_Score,
	cast(Sample as decimal(1,0)) as Measure_Sample,
	cast(
		concat (substr(MeasureStartDate, 7,4),
		'-',
		substr(MeasureStartDate, 1,2),
		'-',
		substr(MeasureStartDate, 4,2)
		)
	as date) Measure_Start_Date,
	cast(
		concat (substr(MeasureEndDate, 7,4),
		'-',
		substr(MeasureEndDate, 1,2),
		'-',
		substr(MeasureEndDate, 4,2)
		)
	as date) Measure_End_Date
from effective_care;
