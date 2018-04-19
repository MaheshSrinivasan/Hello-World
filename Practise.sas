libname practise "F:\Student\Mahesh\Practise";
libname local "F:\Student\Mahesh\Data1";
proc import datafile = "F:\Student Study Materials\SAS Programming\SAS Practice Questions\data sets_45Qs\owen.csv" out = practise.owen dbms = csv replace;
run;
proc contents data=practise.owen;
run;
proc contents data=practise.owen position short;
run;
proc print data = practise.owen (obs = 20);
run;

proc import datafile = "F:\Student Study Materials\SAS Programming\SAS Practice Questions\data sets_45Qs\group123.csv" out=practise.group123 dbms = csv replace;
run;

data practise.group4;
set practise.group123;
where birthstate="India";
run;

proc import datafile = "F:\Student Study Materials\SAS Programming\SAS Practice Questions\data sets_45Qs\bank.csv" out=practise.bank dbms = csv replace;
run;

data practise.bank1;
set practise.Bank;
where (Jobcat=4 and Age gt 30 and EDLEVEL in (16,17));
run;

proc contents data =practise._all_;
run;

data practise.bank2; 
set practise.bank(keep = ID JOBCAT SALNOW);
run; 

data practise.group1;
set practise.group123(keep = ID Group Sex);
run;

proc import datafile = "F:\Student Study Materials\SAS Programming\SAS Practice Questions\data sets_45Qs\clinic.csv" out=practise.clinic dbms = csv replace;
run;

data practise.clinic1 (obs = 15 firstobs = 5);
set practise.clinic (keep = id group sideffct);
run;

data practise.Egypt;
set practise.group123;
where birthstate="Egypt";
run;

data practise.MI;
set practise.group123;
where birthstate="MI";
run;

data practise.group2;
set practise.group123;
if yearbirth lt 1970 then delete;
run;

data practise.cars1;
set local.cars;
where country="USA" or country ="Japan";
run;

data _null_;
set local.cars End =Final;
if final then call symput ("lastobs",_n_);
run;

%put &lastobs;
%let f=%eval(&lastobs - 99);
%put &f;
data practise.cars2;
set local.cars(firstobs=&f);
run;

data practise.cars4;
set local.cars(firstobs=50 obs=50);
run;

data practise.group6;
set practise.group123;
length size $10.;
if weightlb < 150 then size ="slim";
else if 150<= weightlb<200 then size ="Medium";
else if size ="obese";
run;

proc freq data = practise.group123;
tables _numeric_;
run;
proc freq data = practise.group123;
tables _character_;
run;
proc freq data = practise.group123;
tables sex birthstate;
run;
proc freq data = practise.group123;
tables sex * birthstate;
run;
proc freq data = practise.group123;
tables heightin * weightlb;
run;
proc freq data = practise.group123;
tables sex* heightin * weightlb;
run;

proc freq data = practise.owen;
tables sex *B_order* Age;
run;
