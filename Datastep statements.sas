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
Data candy_cust;
set practise.candy_customers;
substr(Region,3,2) = "abc";
run;

title1 ’Nitrogen Content of Red Clover Plants’;
data Clover;
input Strain $ Nitrogen @@;
datalines;
3DOK1 19.4 3DOK1 32.6 3DOK1 27.0 3DOK1 32.1 3DOK1 33.0
3DOK5 17.7 3DOK5 24.8 3DOK5 27.9 3DOK5 25.2 3DOK5 24.3
3DOK4 17.0 3DOK4 19.4 3DOK4 9.1 3DOK4 11.9 3DOK4 15.8
3DOK7 20.7 3DOK7 21.0 3DOK7 20.5 3DOK7 18.8 3DOK7 18.6
3DOK13 14.3 3DOK13 14.4 3DOK13 11.8 3DOK13 11.6 3DOK13 14.2
COMPOS 17.3 COMPOS 19.4 COMPOS 19.1 COMPOS 16.9 COMPOS 20.8
;

proc anova data = Clover;
class strain;
model Nitrogen = Strain;
run;

ods graphics on;
proc anova data = Clover;
class strain;
model Nitrogen = Strain;
run;
title ’Simple Linear Regression’;
data Class;
input Name $ Height Weight Age @@;
datalines;
Alfred 69.0 112.5 14 Alice 56.5 84.0 13 Barbara 65.3 98.0 13
Carol 62.8 102.5 14 Henry 63.5 102.5 14 James 57.3 83.0 12
Jane 59.8 84.5 12 Janet 62.5 112.5 15 Jeffrey 62.5 84.0 13
John 59.0 99.5 12 Joyce 51.3 50.5 11 Judy 64.3 90.0 14
Louise 56.3 77.0 12 Mary 66.5 112.0 15 Philip 72.0 150.0 16
Robert 64.8 128.0 12 Ronald 67.0 133.0 15 Thomas 57.5 85.0 11
William 66.5 112.0 15
;

ods graphics on;
proc reg;
model Weight = Height;
run;

data USPopulation;
input Population @@;
retain Year 1780;
Year = Year+10;
YearSq = Year*Year;
Population = Population/1000;
datalines;
3929 5308 7239 9638 12866 17069 23191 31443 39818 50155
62947 75994 91972 105710 122775 131669 151325 179323 203211
226542 248710 281422
;

ods graphics on;
proc reg data=USPopulation plots=ResidualByPredicted;
var YearSq;
model Population=Year / r clm cli;
run;
data time;
input time @@;
datalines;
43 90 84 87 116 95 86 99 93 92
121 71 66 98 79 102 60 112 105 98
;
run;

ods graphics on;
proc ttest h0=80 plots(showh0) sides=u alpha=0.1;
var time;
run;
