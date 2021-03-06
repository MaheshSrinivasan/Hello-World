libname Day1 "F:\Student\Mahesh\Data1";
ods html body = "F:\Student\Mahesh\MyOutput\Outpt.html";
proc print data = Day1.candy;
run;
ods pdf body = "F:\Student\Mahesh\MyOutput\Output.pdf";
proc print data = Day1.candy;
run;
ods rtf body = "F:\Student\Mahesh\MyOutput\Output.rtf";
proc print data = Day1.candy;
run;
data class2 (obs = 7, firstobs = 7);
set day1.class;
run;
data class3;
set day1.class (drop = height Sex Age);
run;
data class3 (drop =_numeric_);
set day1.class;
run;
data class3 (Keep = _character_);
set day1.class;
run;
data class3;
set day1.class;
drop height sex;
run;
data mahesh;
set day1.candy (obs = 10);
run;
data mahesh;
set day1.candy (firstobs = 7 obs =10);
run;
data mahesh (keep = _numeric_);
set day1.candy;
run;
ods pdf body = "F:\Student\Mahesh\MyOutput\sample.pdf";
proc print data = day1.candy;
run;
data candy_sales;
set day1.candy_sales_summary;
where category = "Candy";
run;
data candy01;
set day1.candy;
where brand = "Nestle" OR brand = "Hershey";
run;
data candy02;
set day1.candy;
where brand in ("Nestle", "Hershey");
run;
data cars01;
set day1.cars;
length status $10;
If country = "USA" then status = "New";
else if country = "Japan" then status = "Old";
else status = "Other";
run;
data cars02;
set day1.cars;
length status $10;
select (country);
when ("USA") status = "New";
when ("Japan") status = "Old";
otherwise status = "Other";
end;
run;
data candy_nuts candy_summary;
set day1.candy_sales_summary;
if category ="Nuts" then output candy_nuts;
else output candy_summary;
run;

Proc print data = day1.candy_products;
where product contains "Che";
run;
proc print data = day1.candy_products;
where product like "%s";
run;
data candy001;
set day1.candy;
where (brand = "Nestle" and Calories >200) or (brand = "Hershey" and Calories>300);
run;
