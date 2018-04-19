libname Day8 "F:\Student\Mahesh\Data1";


/**************SQL Structured Query Language********************************/

proc sql;
select * from day8.uscitycoords;
quit;

proc sql;
select city,state from day8.uscitycoords;
quit;

proc sql;
select distinct continent from day8.unitedstates;
quit;

Proc sql;
select city, (avglow-32)*5/9 as low "Low in Celcius" format 4.1 from day8.worldtemps;
quit;
Proc sql;
select city, (avglow-32)*5/9 as low "Low in Celcius" format 4.1, (avghigh-32)*5/9 as high "High in Celcius" format 4.1 from day8.worldtemps;
quit;
Proc sql;
select city, (avglow-32)*5/9 as low "Low in Celcius" format 4.1, (avghigh-32)*5/9 as high "High in Celcius" format 4.1,
(calculated high-calculated low) as Range "Diff of Highc & Lowc" format 4.1 from day8.worldtemps;
quit;

/*********Assigning values conditionally*****************/

proc sql;
select city,country,latitude,
case
when latitude > 67 then "North Frigid"
when 67 >= latitude >=23 then "North Temprate"
when 23 > latitude >-23 then "Torrid"
when 23 >= latitude >=-67 then "South Template"
else "South Frigid"
end
as climate_zone from day8.worldcitycoords;
quit;
proc sql;
select Name,Capital,population,Area, continent,statehood,
case 
when continent = "North America" then "US"
when continent = "Oceania" then "PacificIsland"
else "None"
end
as Region from day8.unitedstates;
quit;

/***** Replacing Missing Values*****************************/

proc sql;
select name, highpoint,
coalesce (highpoint,"NA") as HighP,
area,
coalesce (area,0) as NewArea,
depth,
coalesce (depth,mean(depth)) as NewDepth
from day8.Continents;
quit;

/***** Sorting*********/

proc sql;
select name,population format comma12.
from day8.countries
order by population desc;
quit;

/*** Sorting by Calculated Column***********/

proc sql;
select name, population format comma12.,
area format comma8., population/area as 
Density format 10.
from day8.countries
order by density;
quit;

/****** Ordering by Column Position**************/

proc sql;
select name, population format comma12.,
area format comma8.
from day8.countries
order by 1;
quit;


/*** Ordering by unselected column****/

proc sql;
select name, population format comma12.
from day8.countries
order by area;
quit;


/****** Grouping of Observation********************/

proc sql;
select continent,sum(population)as totalpop
format comma16.,count(*)as count
from day8.countries
group by continent
having count gt 2
order by continent;
quit;


proc sql;
select continent,sum(population)as totalpop
format comma16.,count(*)as count
from day8.countries
group by continent
order by continent;
quit;


/*****************Using Where Clause**************************************/

proc sql;
select continent,name,population format comma12.
from day8.countries
where continent ="Europe";
quit;

/*******************IS Mising Operator********************/

proc sql;
select name,highpoint
from day8.continents
where highpoint is not missing;
quit;

proc sql;
select name,highpoint
from day8.continents
where name like "A%";
quit;

proc sql;
select city,country,latitude
from day8.worldcitycoords
where latitude between -12 and 50;
quit;

proc sql;
select name,depth
from day8.continents
where depth<-500 and depth is not missing;
quit;
