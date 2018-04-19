libname Practise "F:\OrangeTree SAS\SAS\Datasets";
data Auction1;
set practise.Auction;
Length New_Volume $10;
google = Volume/10;
if volume gt 10 then New_Volume = 'Null';
if volume lt 10 then New_Volume = 'Empty';
run;

data Auction2;
set practise.Auction;
volume = round(volume);
run;

data data3;
set practise.candy_sales_summary;
data = Name || Region; /** Concatenate Characted Variable*/
run;
data Mahesh;
set practise.Exercise;
if Prestretch = 'Stretch' and Ankleweights = 'No weights' then status = 'Healthy'; /** AND Operator */ /* Observations are case sensitive*/
else status = 'ok';
run;

data Mahesh1;
set practise.cotton;
if variety = 37 or spacing = 40 then condition = 'Good';/** OR Operator**/ /* When one condition must be true*/
else condition = 'ok';
run;


										/*CHAPTER 10 - Creating Subsets of Observations*// 

/*Conditionally writing Observations to One or More SAS Data Sets */

Data Mahesh3;
set practise.cotton;
if variety = 37 then output Mahesh3;
run;

Data Mahesh4 Mahesh5;
set practise.cotton;
if variety = 37 then output Mahesh4;
else output Mahesh5;
run;


										/* CHAPTER 11 - Working with Grouped or Sorted Observations */


proc sort data = practise.listingsales;
by propertyid;
run;

data mahesh6;
set practise.methods;
by block;
firstblock = first.block; /* Finding the First or Last Observations in a Group*/
lastblock = last.block;
run;

proc sort data = mahesh6;
by firstblock;
run;

                                       /* CHAPTER 13 - Finding Shortcuts in Programming */

data Mahesh7;
set practise.cholesterol;
if diff = '.' then delete;
if cholesterol1 = '.' then delete;
if cholesterol2 = '.' then delete;
run;

/* Performing more than one action in an IF THEN Statement */

data Mahesh8;
set practise.cholesterol;
if diff = '.' then
do;
Diff1 = 'Null';
end;
if cholesterol1 = '.' then
do;
choles1 = 'Null';
end;
if cholesterol2 = '.' then
do;
choles2 = 'Null';
end;
run;



											/* Working with Dates in the SAS System*/



data dates1;
set practise.beer_sales_minimal; /* Changing year into Quarter*/ 
Quarter = Qtr(SaleDate);
run;
data dates2;
set work.dates1;
if Quarter = '1' then Qtr = 'Q1';
else if Quarter = '2' then Qtr = 'Q2'; /* Changing the Numeric of Quarter into Q1, Q2, Q3, Q4*/
else if Quarter = '3' then Qtr = 'Q3';
else Qtr = 'Q4';
run;
proc sort data = practise.listingsales out = sales_sorted;
by saledate;
run;
data dates3;
set practise.listingsales; /* display day, week, month & quarter*/ 
Quarter = Qtr(SaleDate);
Month = month(saledate);
Week = week(saledate);
Day = day(saledate);
year = year(saledate);
run;
data dates4;
set practise.beer_sales_minimal;
year= year(saledate);
Quarter = Qtr(saledate);
Month = month(saledate);
Week = week(saledate);
Day = day(saledate);
run;









