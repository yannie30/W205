drop table my_measures;
create table my_measures as
select
    MeasureID as Measure_ID,
    MeasureName as Measure_Name,
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
from measures;
