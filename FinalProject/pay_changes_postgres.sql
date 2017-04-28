drop table pay_change07_09;

create table pay_change07_09 as
select 
a.zip as zip, 
cast((a.annual_pay-b.annual_pay)/a.annual_pay as real) as diff 
from 
jobs07_09 as a, 
jobs07_09 as b 
where a.zip=b.zip 
AND b.year=a.year+1 
AND b.year between 2007 and 2009
AND a.annual_pay>0
;


drop table sum_pay_change07_09;

create table sum_pay_change07_09 as
select 
zip,
sum(diff) as change
from pay_change07_09 
where diff <> 1 and diff <>-1 
group by zip
;



drop table pay_change10_14;

create table pay_change10_14 as
select 
a.zip as zip, 
cast((a.annual_pay-b.annual_pay)/a.annual_pay as real) as diff 
from 
jobs10_14 as a, 
jobs10_14 as b 
where a.zip=b.zip 
AND b.year=a.year+1 
AND b.year between 2010 and 2014
AND a.annual_pay>0
;


drop table sum_pay_change10_14;

create table sum_pay_change10_14 as
select 
zip,
sum(diff) as change
from pay_change10_14 
where diff <> 1 and diff <>-1 
group by zip
;


drop table pay_change94_06;

create table pay_change94_06 as
select 
a.zip as zip, 
cast((a.annual_pay-b.annual_pay)/a.annual_pay as real) as diff 
from 
jobs94_06 as a, 
jobs94_06 as b 
where a.zip=b.zip 
AND b.year=a.year+1 
AND b.year between 1994 and 2006
AND a.annual_pay>0
;


drop table sum_pay_change94_06;

create table sum_pay_change94_06 as
select 
zip,
sum(diff) as change
from pay_change94_06 
where diff <> 1 and diff <>-1 
group by zip
;

drop table combined;

create table combined as
select 
a.zip as zip,
a.change as change94,
b.change as change07,
c.change as change10
from sum_pay_change10_14 as c
inner join sum_pay_change94_06 as a
on c.zip=a.zip
inner join sum_pay_change07_09 as b
on b.zip=c.zip
;


drop table final;

create table final as
select zip, 
change94+change07+change10 as tot 
from combined 
order by tot desc
;


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



