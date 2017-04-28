drop table jobs94_14;

create table jobs94_14 as
select zip, 
name,
annual_pay,
year
from jobs94_06
UNION
select zip, 
name,
annual_pay,
year
from jobs07_09
UNION
select zip, 
name,
annual_pay,
year
from jobs10_14
;


drop table cleaned_zips;

create table cleaned_zips as
select zip, 
count(zip) as count_zip 
from jobs94_14 
where annual_pay>0 
group by zip 
;

drop table new_zips;

create table new_zips as
select zip
from cleaned_zips
where count_zip=21 
;

drop table cleaned_jobs94_14;

create table cleaned_jobs94_14 as
select a.zip as zip, 
name, 
annual_pay, 
year 
from jobs94_14 a
inner join  
new_zips b
on b.zip=a.zip
;


drop table pay_change94_14;

create table pay_change94_14 as
select 
a.zip as zip, 
cast((a.annual_pay-b.annual_pay)/a.annual_pay as real) as perc_pay_diff,
a.year as From_Year,
b.year as To_Year
from 
cleaned_jobs94_14 as a, 
cleaned_jobs94_14 as b 
where a.zip=b.zip 
AND b.year=a.year+1 
AND b.year<=2014
;


drop table sum_pay_change94_14;

create table sum_pay_change94_14 as
select 
zip,
sum(perc_pay_diff) as sum_change
from pay_change94_14
group by zip
order by sum_change desc
;


create table regression(zip integer, 
slope real)
;








