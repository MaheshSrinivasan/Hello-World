libname Practise "F:\OrangeTree SAS\SAS\Datasets";
data data1;
length City $15;
input ID Name$ City$ School$;
datalines;
1 Mahesh Chennai SS
2 Ramesh MaduraiCIty MM
;
run;
data data2;
input ID Name$ City$;
cards;
1 Kumar Goa 
2 Ram Kerala
3 Yuvi Goa
;
run;
data data3;
merge data1 data2;
run;
proc print data = data3;
title 'Mahesh';
run;;
proc contents data = practise.A;
run;
data combined;
set data1 data2;
by id;
run;
proc append base=data1 data=data2;
run;
proc summary data = data1 print;
run;
data data1;
modify data1;
ID=ID+1;
run;
data southamerican;
length Country$10;
input year Country$ Result$;
datalines;
1998 Brazil lost
1994 Brazil won
1990 Argentina lost
1986 Argentina won
1978 Argentina won
1970 Brazil won
1962 Brazil won
1958 Brazil won
;
run;

data european;
input year Country$ Result$;
cards;
1998 France won
1994 Italy lost
1990 Germany won
1986 Germany won
1982 Italy won
1982 Germany lost
1978 holland lost
;
run;
proc print data = european;
by year descending;
run;
data finalist;
set southamerican european;
run;
data finalist;
set southamerican (in=s) european;
if s then Continent = 'SouthAmerica';
else continent = 'Europe';
run;
data champions (drop=result);
set southamerican (in = s) european;
if result ='won';
if s then Continent ='SouthAmerica';
else continent ='Europe';
run;
proc freq data = Practise.Beer_sales;
run;
proc freq data = Practise.Bullets;
tables powder;
run;
Proc freq data = Practise.Chi_sq;
tables Frequency_of_Readership;
run;
Proc freq data = Practise.Chi_sq;
tables Level_of_Educational_Achievement;
run;
proc means data = Practise.Cars;
var weight;
run;
proc means data = Practise.Cars;
run;
proc means data = Practise.Cars;
var weight gastank;
run;
Proc summary data = Practise.cars print;
var weight gastank;
run;
proc tabulate data = practise.cars;
class weight;
run;
proc univariate data = practise.cars;
var weight;
run;
proc contents data = practise.cars varnum;
run;
proc freq data = practise.cars;
tables gastank;
run;
proc report data = practise.cars;
run;
proc standard data = practise.cars out = mahesh;
run;
data datefunction;
set practise.candy_sales_history;
day = day (date);
week = week (date);
month = month (date);
qtr = qtr (date);
year = year (date);
run;
data datefunction1;
set datefunction;
format New_Date ddmmyy10. sysdate ddmmyy10. datetime datetime16. datevalue ddmmyy10. timevalue time8.;
sysdate = date();
New_Date = mdy(month, day, year);
datetime = datetime();
datevalue = datepart (datetime);
timevalue = timepart (datetime);
run;
data retail;
cost = '20000';
total = .40*cost;/******.represents to leave once decimal point**/
run;

data staff;
JobCategory = 'FA';
JobLevel = '1';
JobCategory = JobCategory || JobLevel;
run;

proc print data = practise.continents;
where name like '_o%';
run;
proc gchart data = practise.candy_sales_summary;
vbar subcategory/ sum sumvar =sale_amount
group= fiscal_year subgroup=fiscal_quarter;
run;
proc gplot data = practise.candy_sales_summary;
plot sale_amount*units;
run;
data binom;
binom_prob= pdf('binomial',50,0.6,100);
run;
data binom_plot;
do x=0 to 20;
binom_prob=pdf ('binomial', x, 0.5, 20);
output; end;
run;
proc gplot data=binom_plot;
plot binom_prob*x;
run;
proc univariate data=practise.class normal plot;
var height;
histogram height/normal (mu=est sigma=est color=green);
run;
proc univariate data=practise.candy_sales_summary normal plot;
var sale_amount;
histogram sale_amount/normal (mu=est sigma=est color=green);
run;
proc means data = practise.candy_sales_summary;
var sale_amount units;
class category subcategory;
output out = mahesh;
run;
proc summary data = practise.candy_sales_summary print;
var sale_amount units;
ods rtf body = "F:\OrangeTree SAS\SAS\Output\sales.rtf";
run;
proc tabulate data = practise.class;
var age height weight;
Class sex;
tables sex (age height weight) * (mean sum);
run;
proc univariate data = practise.class;
var age;
qqplot age;
run;
proc contents data = practise.class position short;
run;
proc contents data = practise._all_ nods;
run;
ods html;
ods grahics on;
proc corr data = practise.class;
run;
ods graphics off;
ods html close;
proc print data = practise.class noobs ;
run;
proc export data = practise.class outfile= "F:\OrangeTree SAS\SAS\Datasets\class.xls" dbms = tab replace;
run;
proc means data = practise.candy_sales_summary noprint;
var sale_amount;
class fiscal_quarter subcategory;
output out = sales_report sum = revenue;
run;
proc sort data = sales_report out = sales_sorted;
by fiscal_quarter;
where _type_ = 3;
run;
proc transpose data = sales_sorted out = sales_transpose;
id subcategory; /* id keyword- we are specifying the variable to transpose*/
var revenue; /*** Use Var for the observations**/
by fiscal_quarter;
run;
proc report data = practise.candy_sales_summary ps=1500;
column sale_amount units retail_price;
define sale_amount/display;
run;


proc sort data = practise.cars out= mahesh;
by type country;
run;
data mahesh1;
set mahesh;
by type;
Firsttype = First.type;
Lasttype = Last.type;
run;

proc sort data = mahesh1;
by firsttype lasttype;
run;
proc sql;
select * from mahesh1 where Firsttype = 1 and Lasttype = 1;
quit;
data practise.cars;
if Country = 'Japan' and Type ='Compact' then status = 'Null';
run;




