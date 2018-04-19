libname Practise "F:\OrangeTree SAS\SAS\Datasets";

                 /*CHAPTER - 25  Producing Detail Reports with the PRINT Procedure */

proc print data = practise.candy_sales_summary;
var Name Region OrderId;        /* Var to list the variable to be displayed*/
run;

proc print data = practise.candy_sales_summary;
by Region;        /* ID statement identifies the observations with the value of the variable*/
run;

proc print data = practise.candy_sales_summary;
var Name Region OrderId category subcategory;
where category = 'Nuts' and subcategory = 'Sweet'; /* Using WHERE Statement*/
run;


                 /* Creating Enhanced Reports*/

proc print data = practise.candy_sales_summary;
var units retail_price category subcategory;
where category = 'Nuts' and subcategory = 'Sweet';
sum Units retail_price;    /* Summing Numeric Variables*/
run;


			/* CHAPTER 26 - Understanding the Basics of the TABULATE Procedure */

