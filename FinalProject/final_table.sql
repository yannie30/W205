drop table final_with_slope;

create table final_with_slope as
select 
a.zip as zip,
a.sum_change as percent_negatiive_change,
b.slope as slope
from sum_pay_change94_14 a 
inner join regression b on 
a.zip=b.zip
;

drop table final;
drop table combined;
drop table cleaned_zips;
drop table jobs07_09;
drop table jobs10_14;
drop table jobs94_06;     
drop table new_zips;           
drop table pay_change07_09;    
drop table pay_change10_14;    
drop table pay_change94_06;    
drop table pay_change94_14;              
drop table sum_pay_change07_09; 
drop table sum_pay_change10_14;
drop table sum_pay_change94_06;
drop table zip_lat_long;        
