libname mymacro "F:\Student\Mahesh\macr";
Options mstored sasmstore=mymacro;
%macro sort(v1,v2,v3)/store des ="Sorting by a var" source;
libname datasets "F:\Student\Mahesh\Data1";
proc sort data=&v1 out=&v2;
by &v3;
run;
%mend;
%sort(datasets.candy_sales_summary,mahesh,subcategory)
proc catalog c=mymacro.sasmacr;/** To display the Macro**/
contents;
run;
quit;
%copy sort/library =mymacro source;/**To view the Macro code****/


/***** Two Types of Macro Variable*

1.Global Macro Variable
2.Local Macro Variable *****/

%let A= datasets.candy_sales_summary;   /*** %let is used to create variable*/
%let B=Nuts;
proc print data = &A;
where category ="&B";
run;
%let x=100+30;
%put &x; /*** %put is afunction used to display the value in log window**/
%let x=100+30;
%put &x;
%let y= %eval(100+30);
%put &y;


/**Local Macro Variable****/

%macro Test(finish);
%let I=1;
%do %while (&I < &finish);
%put value of I is &I;
%let I = %eval(&I+1);
%end;
%mend;
%Test(7)

/**************Interfaces with SQL Procedures********************/

libname Day10 "F:\Student\Mahesh\Data1";
proc sql outobs=1;
reset noprint;
select max(avghigh) into:maxtemp
from day10.worldtemps
where country="India";
reset print;
Title "Highest Temperature in India is &maxtemp";
select city,avghigh format 4.1
from day10.worldtemps
where country ="India";
quit;


proc sql outobs=1;
select max(avghigh) into:maxtemp
from day10.worldtemps
where country="India";
reset print;
Title "Highest Temperature in India is &maxtemp";
select city,avghigh format 4.1
from day10.worldtemps
where country ="India";
quit;

proc sql;
select max(avghigh) into:maxtemp
from day10.worldtemps
where country="India";
reset print;
Title "Highest Temperature in India is &maxtemp";
select city,avghigh format 4.1
from day10.worldtemps
where country ="India";
quit;

data _null_;
set day10.class End=Final;
if age>13 then n+1;
if final then
call symput ("number",n);/** Create Global variable using symput in Data step**/
run;
%put &number students have age greater than 13;
