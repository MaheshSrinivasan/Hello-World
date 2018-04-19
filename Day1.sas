libname Day1 "F:\Student\Mahesh\Data1";
Data Day1.Mahesh;
input City $ ID $ Age;
datalines;
Bangalore T101 24
Pune T102 29
;
run;
Data Day1.Mahesh;
length City $10.;
input City $ ID $ Age;
datalines;
Bangalore T101 24
Pune T102 29
;
run;
Data Day1.Mahesh;
length City $10.;
input City $ ID $ Age Salary DOJ Profit;
informat Salary dollar6. DOJ ddmmyy10. Profit dollar7.2;
format Salary dollar6. DOJ ddmmyy10. Profit dollar7.2;
label DOJ = "Date of Joining";
rename Salary = Salary_of_Employee;
datalines;
Bangalore T101 24 $2,000 12/12/2010 $300.50
Pune T102 29 $3,000 11/10/2006 $400.50
;
run;
Proc contents data = Day1.Mahesh position short;
run;
proc contents data = Day1._all_ nods;
run;
proc print data = Day1.Mahesh;
Var City Salary_of_Employee;
run;
Proc print data = Day1.Mahesh noobs n;
run;

Proc print data = day1.candy_sales_summary noobs n label;
label prodid = "Product ID" sale_amount = "Revenue";
sum sale_amount;
id prodid;
var category subcategory;
run;
