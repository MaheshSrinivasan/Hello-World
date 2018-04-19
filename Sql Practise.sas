libname Practise "F:\OrangeTree SAS\SAS\Datasets";
proc sql;
create table innerjoin as select * from practise.oilprod as  A inner join /************INNER JOIN*************/
practise.oilrsvrs as B
on A.country=B.country;
select * from innerjoin;
quit;
proc sql ps =2000;
create table fulljoin as select * from practise.countries as A full join /****FULL JOIN***************/
practise.worldcitycoords as B
on A.capital = B.city;
select * from fulljoin;
quit;

proc sql;
create table leftjoin as select * from practise.countries as A left join /****LEFT JOIN***************/
practise.worldcitycoords as B
on A.capital = B.city;
select * from leftjoin;
quit;
proc sql;
create table rightjoin as select * from practise.countries as A right join /****RGHT JOIN***************/
practise.worldcitycoords as B
on A.capital = B.city;
select * from rightjoin;
quit;
proc sql;
select * from practise.uscitycoords;
quit;

proc sql;
select city,state from practise.uscitycoords;
quit;

proc sql;
select distinct continent from practise.unitedstates;
quit;
 proc sql;
create table mahesh as select * from practise.As_items where QUANTITY =2;
run;
proc sort data = practise.As_items;
by Quantity;
run;
