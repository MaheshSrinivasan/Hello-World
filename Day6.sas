libname day6 "F:\Student\Mahesh\Data1";
proc report data = day6.candy_sales_summary ps = 1500 ls = 256;
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount units product; /* Product as display variable*/
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount units retail_price; /* Column is used for selection of variables*/
define sale_amount/display; /* Define is a statement & Display is keyword*/
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount units retail_price; /* Column is used for selection of variables*/
define retail_price/analysis mean; /* Analysis keyword change the statistics of the variable*/
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount units retail_price; /* Column is used for selection of variables*/
define sale_amount/order; /* Sort Data*/
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount units retail_price; /* Column is used for selection of variables*/
define sale_amount/order descending; /* Sort Data by descendng*/
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount retail_price subcategory; /* Column is used for selection of variables*/
define subcategory/order; /* Sort Data by descendng*/
run;
proc report data = day6.candy_sales_summary ps = 1500;
column sale_amount retail_price subcategory; /* Column is used for selection of variables*/
define subcategory/group; /* Group the variable*/
run;

/**************Creating a New Variable**************/

proc report data = day6.candy_sales_summary ps = 2500 ls = 256;
column subcategory sale_amount retail_price units avg_sales;
define avg_sales / computed;
compute avg_sales; /****Use Compute to create a new variable****/
avg_sales = sale_amount.sum/units.sum;
endcomp;
run;

proc report data = day6.candy_sales_summary ps=1500 ls=256;
column subcategory;
define subcategory/across;
run;

proc report data = day6.candy_sales_summary nowd; /*** suppreses the report window*/
column category subcategory;
define category/group;
define subcategory/across;
run;
proc report data = day6.candy_sales_summary; 
column category subcategory retail_price;
define retail_price/format=euro12.2;
run;
proc sql;
select * from day6.table1
Intersect
select * from day6.table2;
Quit;

/**************************** Merge Datasets****************************/

data data1;
input Id$ Name$ Age;
cards;
1 A 14
2 B 11
4 B 16
5 D 19
run;
data data2;
input Id$ Name$ Age;
datalines;
2 C 15
3 D 18
5 I 20
run;
data append;
set data1 data2;
run;
proc append base = data1 data = data2; 
run;
data data3;
input ID Age Income;
cards;
9 25 1200
1 29 1500
5 30 9000
run;
data data4;
input id names$ bonus;
datalines;
9 A 100
2 B 500
6 C 4000
5 F 1000
run;
proc sort data = data3;
by id;
run;
proc sort data = data4;
by id;
run;
data data5; /* There should be a Unique Variable in both the datasets*/
merge data3 data4; /* Full Merge */
by id;
run;
data data6; 
merge data3(in=a) data4(in=b); /* Storing datasets in a variable*/
by id;
if a and b; /*Inner Merge*/
run;
data data7; 
merge data3(in=a) data4(in=b); /* Storing datasets in a variable*/
by id;
if a; /*Left Merge*/
run;
data data8; 
merge data3(in=a) data4(in=b); /* Storing datasets in a variable*/
by id;
if b; /*Right Merge*/
run;
data data9; 
merge data3(in=a) data4(in=b); /* Storing datasets in a variable*/
by id;
if a=1 and b=0; /*Left Outer Merge*/
run;
data data10; 
merge data3(in=a) data4(in=b); /* Storing datasets in a variable*/
by id;
if a=0 and b=1; /*Right Outer Merge*/
run;

/**** Procedures related Transpose*************************/

proc means data = day6.candy_sales_summary noprint;
var sale_amount;
class fiscal_quarter subcategory;
Output out = sales_report sum=Revenue;
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
