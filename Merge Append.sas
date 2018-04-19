libname Practise "F:\OrangeTree SAS\SAS\Datasets";
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
merge data3(in=a) data4(in=b);
by id;
if a=1 and b=0; /* Left Outer Merge*/
run;
data data10;
merge data3(in=a) data4(in=b);
by id;
if a=0 and b=1; /* Right Outer Merge*/
run;
Data candy_cust;
set practise.candy_customers;
substr(Region,3,2) = "abc";
run;


/****************************PROC APPEND ****************************/

data append2;
set data1 data2;
run;

proc append base = data1 data = data2; /* Using the APPEND PROCEDURE : The Simplest Case*/
run;

proc append base = practise.A data = practise.Aml_survival force; /* Using the APPEND Procedure When Data Sets Contain difference variables*/
run;




