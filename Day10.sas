libname Day10 "F:\Student\Mahesh\Data1";

/*****************************MACROS*******************************/

/***************Macros are by default saved in WORK library
Macros are saved in catalog form which cannot be opened*****************/

/****Macro Begins with %macro ends with %mend******/

/****Sasmacr will be created in the WORK library. You can call MACRO by using %nameofmacro************/

%macro print;
proc print data= day10.candy;
run;
%mend;
%print

/***************************************GENERALIZING THE MACRO**********************************/

/***Two paremeter used to generalise the MACRO
1. Positional Parameter
2. Keyword Parameter*************/

/***********************POSITIONAL PARAMETER*****************/

%macro print1(var1);
proc print data = &var1;
run;
%mend;
%print1(day10.class)
%macro sort(v1,v2,v3);
proc sort data = &v1 out = &v2;
by &v3;
run;
%mend;
%sort(Day10.cars,class1,weight)
%macro mean(s1,s2,s3,s4);
proc means data = &s1;
var &s2;
class &s3;
Output out = &s4;
run;
%mend;
%mean(Day10.Cars,weight,Type,mahesh1)

/********************KEYWORD PARAMETER**********************/

%macro mean1(v1=,v2=,v3=,v4=);
proc means data=&v1;
var &v2;
class &v3;
Output out =&v4;
run;
%mend;
%mean1(v1=Day10.cars,v2=weight,v3=Type,v4=eClerx)
%macro sql1(a1=,a2=,a3=,a4=,a5=,a6=);
proc sql;
select &a1, &a2-32*5/9 as &a3 format 4.1, &a4-32*5/9 as &a5 format 4.1 from &a6;
quit;
%mend;
%sql1(a1=city,a2=avglow,a3=low,a4=avghigh,a5=high,a6=day10.worldtemps)

libname mymacro "F:\Student\Mahesh\MyMacro";
options mstored sasmstore = mymacro;
%macro print1/store des = "Printing Data" Source;
libname data "F:\Student\Mahesh\Data1";
proc print data = &v1;
run;
%mend;
%print(data.class)
