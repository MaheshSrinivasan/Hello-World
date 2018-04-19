libname Day9 "F:\Student\Mahesh\Data1";

/************************Multiple values of Sub Queries**********************/

proc sql;
select name "country", population format comma25.
from day9.countries
where name not in (select country from day9.oilprod);
quit;

data table1;
input x y;
datalines;
1 4 
2 6
3 8
4 9
;
run;

data table2;
input s t;
datalines;
5 7
6 10
4 7 
2 6
8 10
;
run;

                    /**** UNION OPERATOR*******************************/

proc sql;
select * from table1 /**** Union Operator will Merge the two dataset and sort the dataset by the first variable in the first dataset and gives the 
heading of first dataset******************/
union
select * from table2;
quit;

proc sql;
select * from table1
intersect                    /************INTERSECT OPERATOR*************/
select * from table2;
quit;

proc sql;
select * from table1
except                      /************EXCEPT OPERATOR***************/
select * from table2;
quit;

/*******************INSERTING NEW ROWS**********************/

proc sql;
create table mahesh as
select * from day9.candy;
quit;

proc sql;
create table newcountries as
select * from day9.countries;
insert into newcountries set name ="India",
capital = "NewDelhi",
Population = 1e9,
Area = 5500,
Continent = "Asia"
set name ="Pakistan",
Capital = "Islamabad",
population = 1e9,
area = 1000,
continent ="Asia";
select * from newcountries;
quit;

/************UPDATING TABLES********************************/

Proc sql;
create table newcountries1 as select * from day9.countries;
update newcountries1
set population = population * 2,
Area =5500,
Continent="Asia"
Where name like "%B";
select * from newcountries1;
quit;

/******DELETING ROWS******************************/

Proc sql;
create table newcountries2 as select * from day9.countries;
delete from newcountries2
where name like "A%";
select * from newcountries2;
quit;

/****************DELETING COLUMNS**********************/
proc sql;
create table newcountries3 as select * from day9.countries;
alter table newcountries3
drop area;
select * from newcountries;
quit;

/***************************SQL JOINS***************************/

proc sql;
create table innerjoin as select * from day9.oilprod as  A inner join /************INNER JOIN*************/
day9.oilrsvrs as B
on A.country=B.country;
select * from innerjoin;
quit;

proc sql;
create table fulljoin as select * from day9.countries as A full join /****FULL JOIN***************/
day9.worldcitycoords as B
on A.capital = B.city;
select * from fulljoin;
quit;

proc sql;
create table leftjoin as select * from day9.countries as A left join /****LEFT JOIN***************/
day9.worldcitycoords as B
on A.capital = B.city;
select * from leftjoin;
quit;


proc sql;
create table rightjoin as select * from day9.countries as A right join /****RGHT JOIN***************/
day9.worldcitycoords as B
on A.capital = B.city;
select * from rightjoin;
quit;
