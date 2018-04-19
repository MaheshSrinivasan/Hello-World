libname Day7 "F:\Student\Mahesh\Data1";


/********************************INFILE STATEMENTS**********************************/

data test2;
infile "F:\Student\Mahesh\Data1\test2.txt";
input @1 Fname$7.
@9 Lname$6.
@16 ID$5.
@22 Month 2.
@25 Age 2.;
run;

data test2_1;
infile "F:\Student\Mahesh\Data1\test2.txt" Missover; /** It prevents SAS to go into the new input line if it does not find values in the current line**/
input @1 Fname$7.
@9 Lname$6.
@16 ID$5.
@22 Month 2.
@25 Age 2.;
run;

data test3;
infile "F:\Student\Mahesh\Data1\test3.txt";
input @1 Fname$7.
@9 Lname$5.
@16 ID$4.
@20 Salary comma9.;
format salary comma9.2;
run;
data test3_1;
infile "F:\Student\Mahesh\Data1\test3_1.txt" pad;/** Pad is the keyword which takes the data in a specified format**/
input @1 Fname$7.
@9 Lname$5.
@16 ID$4.
@20 Salary comma9.;
format salary comma9.2;
run;

data test5;
infile "F:\Student\Mahesh\Data1\test5.txt" dlm=",";
input Gender$ Age Var1 Var2 Var3 Var4;
run;
proc import datafile = "F:\Student\Mahesh\Data1\test5.txt" out = test_5 dbms = dlm replace;
delimiter =","; /** Homework Change the variable name**/
getnames=no; 
datarow=1;
run;

data test7;
infile "F:\Student\Mahesh\Data1\test7.txt" Missover dsd dlm= " ";  /* DSD = Delimited Sensitive Data... " " specifies there is a missing value */
input var1 var2 var3 var4 var5 var6;
run;


/*******************************************ARRAYS************************/


data temp;
input mon tue wed thu fri sat sun;
cards;
79 80 85 82 79 85 90
70 85 84 94 89 90 95
;
run;
data temp1 (drop =i);
set temp;
array wkday(7) mon tue wed thu fri sat sun; /* Wkday(7) 7 is the Dimensions of the arry***/
array wkdayc(7) monc tuec wedc thuc fric satc sunc;
do i=1 to 7;
wkdayc(i) = round((wkday(i) -32)*5/9,0.01); /* Homework - Two decimals in the results Celcius******/
end;
run;

data sales;
input Q1 Q2 Q3 Q4;
cards;
1200 1000 3000 1500
3000 3500 3500 4000
;
run;

data sales_array (drop=i);
set sales;
array Quarter(4) Q1 Q2 Q3 Q4;
array SubQuarter(3) S1 S2 S3;
do i=1 to 3;
SubQuarter(i)= Quarter(i+1)-Quarter(i);
end;
run;

data sales2;
set sales;
array sales(4) Q1 Q2 Q3 Q4;
array commission(4) Q11 Q22 Q33 Q44;
array rate(4) _Temporary_ (10,20,30,40);   /*** rate(4) is an temporary array*/
do i=1 to 4;
commission(i) = sales(i)*rate(i)/100;
end;
run;
