libname Day5 "F:\Student\Mahesh\Data1";

/*********** DATE FUNCTIONS********/

Data candy_dates;
set day5.candy_sales_summary;
day = day (date);
month = month (date);
year = year (date);
quarter = qtr (date);
weekday = weekday (date);
week = week (date);
run;
Data candy_dates1;
set candy_dates;
format new_date mmddyy10.;
new_date = mdy(month,day,year);
run;
Data candy_dates2;
set day5.candy_sales_summary;
format sysdate date9.;
sysdate = today();
date_diff = datdif(date, sysdate, "ACT/ACT");
year_diff = yrdif(date, sysdate,"ACT/ACT");
run;
Data candy_dates2;
set day5.candy_sales_summary;
format sysdate date9.;
sysdate = today();
date_diff = datdif(date, sysdate, "ACT/ACT");          /***Function**/
year_diff = yrdif(date, sysdate,"ACT/ACT");            /***Function**/
year = intck ("Year", date, today());
month = intck ("Month",date, today());
day = intck ("Day", date, sysdate);
run;
Data candy_dates4;
set day5.candy_sales_summary;
format sysdatetime datetime16. datevalue ddmmyy10. timevalue time8.;
sysdatetime = datetime();
datevalue = datepart (sysdatetime);  /***Function**/
timevalue = timepart (sysdatetime);  /***Function**/
run;
Data candy_dates4;
set day5.candy_sales_summary;
format sysdatetime datetime16. datevalue date9. timevalue time8.;
sysdatetime = datetime();
datevalue = datepart (sysdatetime);
timevalue = timepart (sysdatetime);
run;

/* TEXT FUNCTIONS *************/

Data crime;
set day5.crime;
Stateup = upcase (staten);
Statelow = lowcase (staten);
Stateprop = propcase (staten);
run;
Data candy_prod;
set day5.candy_products;
start_index = index(product, "Chocolate");
run;
Data candy_prod;
set day5.candy_products;
start_index = index(product, "Chocolate");
start_f = find(product, "chocolate", "i");
run;
Data candy_customer;
set day5.candy_cust;
Newregion = substr(Region,3,2);
run;
Data candy_customer;
set day5.candy_cust;
substr(Region,3,2) = "abc";
run;
Data candy_cust1;
set day5.candy_customers;
fname = scan (name,1,"");
mname = scan (name,2,"");
lname = scan (name,3,"");
if lname = "" then lname=mname;
if mname=lname then mname ="";
run;
Data candy_cust1;
set candy_cust1;
newname = Catx (" ", fname,mname,lname);
run;
Data candy_prod;
set day5.candy_products;
New_Product = tranwrd(tranwrd(tranwrd (Product, "Chocolate", "Choco"),"Delight", "Dell"),"Taffy","Mahesh");
run;

/*******************Numeric Functions ******************************/

data crime1;
set day5.crime;
Total_Crime = sum(murder,rape,robbery,assault,burglary,larceny,auto);
run;
Data candy_int;
set day5.candy_sales_summary;
sale_amount = int(sale_amount);
sale_amount1 = round(sale_amount);
sale_amount2 = round(sale_amount,0.1);
sale_amount3 = round(sale_amount,0.01);
run;
data sales12;
set day5.sales_12;
sale_amount = input (sale_amount, comma12.); /**** Input function is used to change Character to Numeric Variabla*/
Cust_id = put (customer_id, 3.); /* Put function is used to change Numeric to Characted to Numeric Variable*/
format sale_amount comma12.;
run;
