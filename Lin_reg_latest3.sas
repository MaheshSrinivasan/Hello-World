

data Linear_Reg_Sample_Data_1;
set LINEAR_REGRESSION_13FEB2013_V01;
Losses1=input(Losses,5.0);
rec_no=_n_;
if Losses1<=1200 then Capped_Losses=Losses1;
else Capped_Losses=1200;
run;


*plotting graphs for losses and capped losses;
title "Losses - Scatter Plot";
proc gplot data=Linear_Reg_Sample_Data_1;
  plot Losses1*rec_no; 
run;


title "Capped Losses - Scatter Plot";
proc gplot data=Linear_Reg_Sample_Data_1;
  plot Capped_Losses*rec_no; 
run;


*use summary table for accessing univariate statistics;
proc univariate data=Linear_Reg_Sample_Data_1 ;
   var Losses1 Capped_Losses;
   output out=sum pctlpts  = 5 10 25  50 75 90 95 97.5 99 99.5 
                    pctlpre  = Losses1 Capped_Losses
                    pctlname = pct5 pct10 pct25 pct50 pct75 pct90 pct95 pct975 pct99 pct995
					max= max
					std= SD;
run;

*Modifying input data;
data lin_reg_sample;
set Linear_Reg_Sample_Data_1
(rename=(Years_Of_Driving_Experience=yrs_drv_exp));
format Veh_Age_Band $char10.;
format Age_Band $char10.;
Age1=input(Age,5.0);
Vehicle_Age1=input(Vehicle_Age,5.0);
Number_Of_Vehicles1=input(Number_Of_Vehicles,5.0);
yrs_drv_exp1=input(yrs_drv_exp,5.0);

if Age1<=25 then Age_Band="16-25";
else if Age1<=59 then Age_Band="26-59";
else Age_Band="60+";

if Vehicle_Age1<=5 then Veh_Age_Band="(1)0-5";
else if Vehicle_Age1<=10 then Veh_Age_Band="(2)6-10";
else Veh_Age_Band="(3)11+";

if gender="M" then gender_dummy=1;
else gender_dummy=0;

if married="Married" then married_dummy=0;
else married_dummy=1;

if fuel_type="P" then fuel_type_dummy=0;
else if fuel_type="D" then fuel_type_dummy=1;

run;

*Bivariate profiling;
options mprint;
%macro eff(attr,title); 
proc sql;
create table distr_&attr as
select &attr, avg(Losses1) as avg_loss, 
avg(Capped_Losses) as avg_Capped_loss,count(rec_no) as nobs 
from lin_reg_sample 
group by &attr;
quit;
data distr_&attr;
set distr_&attr;
rec_no=_n_;
run;
proc sql;
select sum(nobs) into: tot_obs
from distr_Age1
quit;
data distr_&attr;
set distr_&attr;
pct_obs=nobs/&tot_obs;
run;
title "&title";

/*proc gplot data=distr_&attr;
plot &attr*rec_no;
plot2 avg_Capped_loss*rec_no;
y2axis min=0 label="Average Capped Loss";
xaxis label="&title";
yaxis label="Percentage of Policies";*/
run;
%mend;
%eff(Age1,Age);
%eff(Age_Band,Age Band);
%eff(Veh_Age_Band, Vehicle Age Band);
%eff(yrs_drv_exp1, Years of Driving Experience);
%eff(Gender_Dummy, Gender);
%eff(Married_Dummy, Marital Status);
%eff(Vehicle_Age1,Vehicle Age);
%eff(Number_Of_Vehicles1, Number of Vehicles);
%eff(Fuel_Type_Dummy, Fuel Type);


*Determining presence of heteroskedasticity;
%macro hetero(attr);

proc sort data= lin_reg_sample;
by &attr;
run;

proc means data=lin_reg_sample mean std ;
by &attr;
var Losses1 Capped_Losses;
output out= m_sd_&attr;
run;

%mend;
%hetero(Age_Band);
%hetero(Gender_Dummy);
%hetero(Married_Dummy);
%hetero(Veh_Age_Band);
%hetero(Fuel_Type_Dummy);

data age_16_25;
set lin_reg_sample;
where age_band="16-25";
run;

data age_26_59;
set lin_reg_sample;
where age_band="26-59";
run;
data age_60;
set lin_reg_sample;
where age_band="60+";
run;
data gender_m;
set lin_reg_sample;
where gender_dummy=1;
run;
data gender_f;
set lin_reg_sample;
where gender_dummy=0;
run;
data married_y;
set lin_reg_sample;
where married_dummy=0;
run;
data married_n;
set lin_reg_sample;
where married_dummy=1;
run;
data veh_age_5;
set lin_reg_sample;
where veh_age_band="(1)0-5";
run;
data veh_age_10;
set lin_reg_sample;
where veh_age_band="(2)6-10";
run;
data veh_age_11;
set lin_reg_sample;
where veh_age_band="(3)11+";
run;
data fuel_type_p;
set lin_reg_sample;
where fuel_type_dummy=0;
run;
data fuel_type_d;
set lin_reg_sample;
where fuel_type_dummy=1;
run;
%macro histo(type,title); 
title "Multivariate Linear Regression- 
Heteroskedasticity (&title)";
/*proc sgplot data=&type; 
histogram Capped_Losses;
run;*/
%mend;
%histo(age_16_25,"Age(16-25)");
%histo(age_26_59,"Age(26-59)");
%histo(age_60,"Age(60+)");
%histo(gender_m,"Gender=Male");
%histo(gender_f,"Gender=Female");
%histo(married_y,"Marital Status=Married");
%histo(married_n,"Marital Status=Single");
%histo(veh_age_5,Vehicle Age(0-5));
%histo(veh_age_10,Vehicle Age(6-10));
%histo(veh_age_11,Vehicle Age(11+));
%histo(fuel_type_p,Fuel Type(Petrol));
%histo(fuel_type_d,Fuel Type(Diesel));

proc corr data= lin_reg_sample cov;
run;

*choosing between driving experience in years and age;
proc reg data=lin_reg_sample outest=prediction;
model Capped_Losses = Age1;
Output Out= LINREG;
run;

proc reg data=lin_reg_sample outest=pred1;
model Capped_Losses = yrs_drv_exp1;
Output Out= LINREG1;
run;
*Finding Average Age for age bands;
proc sql;
create table avg_age_tbl as
select Age_Band,sum(Age1) as Sum_age, 
count(rec_no) as n_policies
from lin_reg_sample
group by Age_Band;
quit;

data avg_age_tbl;
set avg_age_tbl;
avg_age=sum_age/n_policies;
run;

*Finding Average Vehicle Age for vehicle age bands;
proc sql;
create table avg_veh_age_tbl as
select Veh_Age_Band,sum(Vehicle_Age1) as Sum_age, 
count(rec_no) as n_policies
from lin_reg_sample
group by Veh_Age_Band;
quit;

data avg_veh_age_tbl;
set avg_veh_age_tbl;
avg_age=sum_age/n_policies;
run;
*Use the values obtained in data sets avg_age_tbl, avg_veh_age_tbl 
to enter average values for age bands and vehicle age bands;
data lin_reg_sample1;
set lin_reg_sample;

if Age_Band="16-25" then avg_age=20.56;
else if Age_Band="26-59" then avg_age=42.41;
else if Age_Band="60+" then avg_age=65.08;

if Veh_Age_Band="(1)0-5" then avg_veh_age=2.5;
else if Veh_Age_Band="(2)6-10" then avg_veh_age=8.02;
else if Veh_Age_Band="(3)11+" then avg_veh_age=12.96;

run;

*choosing between average age and age;

proc reg data=lin_reg_sample1 outest=pred2;
model Capped_Losses =Avg_Age;
Output Out= LINREG2;
run;
proc reg data=lin_reg_sample1 outest=pred3;
model Capped_Losses =Age1;
Output Out= LINREG3;
run;
*choosing between average vehicle age and  vehicle age;
proc reg data=lin_reg_sample1 outest=pred4;
model Capped_Losses =avg_veh_age;
Output Out= LINREG4;
run;

proc reg data=lin_reg_sample1 outest=pred5;
model Capped_Losses =Vehicle_Age1;
Output Out= LINREG5;
run;

*running full regression;
proc reg data=lin_reg_sample1 outest=pred6;
model Capped_Losses =avg_veh_age
Avg_Age
Gender_Dummy
Married_Dummy 
Fuel_Type_Dummy
Number_Of_Vehicles1;
Output Out= LINREG6;
run;

*Number of vehicles is coming to be insignificant 
so we remove it and run regression again;
proc reg data=lin_reg_sample1 outest=pred7;
model Capped_Losses =avg_veh_age
Avg_Age
Gender_Dummy
Married_Dummy 
Fuel_Type_Dummy ;
Output Out= LINREG7 
p=pred 
r=residual; 
run;

*plotting residuals;
title "Capped Losses Residual";
proc gplot data=LINREG7;
plot residual*rec_no;
run;


*making the scorecard;
proc sort data= LINREG7;
by descending pred;
run;
*We can use proc rank here as well but 
it will not form equal sized bins;
data reg_sort;
set LINREG7;
if _n_<=1529 then bin=1;
else if _n_<=3058 then bin=2;
else if _n_<=4587 then bin=3;
else if _n_<=6116 then bin=4;
else if _n_<=7645 then bin=5;
else if _n_<=9174 then bin=6;
else if _n_<=10703 then bin=7;
else if _n_<=12232 then bin=8;
else if _n_<=13761 then bin=9;
else if _n_<=15290 then bin=10;
run;

proc sql;
select bin,count(bin) from reg_sort
group by bin;
quit;

proc sql;
create table reg_avg as 
select bin, count(rec_no) as Number_of_policies, 
sum(Capped_Losses) as Actual_loss,sum(pred) as Predicted_loss
from reg_sort
group by bin;
quit;

proc sql;
select sum(Actual_loss)
into :total_loss
from reg_avg;
quit;
*inserting a zero row at the top;
data reg_start;                      
 input bin Number_of_policies Actual_loss Predicted_loss ;      
 datalines;           
0 0 0 0
; 
proc sql;
insert into reg_start
select * from reg_avg;
quit;
data reg_start1;
set reg_start;
act_loss=Actual_loss/&total_loss.;
run;

*Final Scorecard;
data reg_start1;
set reg_start1;
retain act_loss_cum 0;
retain Actual_loss_cum 0;
retain Pred_loss_cum 0;
pct_obsrvtions=(_n_-1)/10;
act_loss_cum=act_loss_cum+act_loss;
Actual_loss_cum=Actual_loss_cum+Actual_loss;
Pred_loss_cum=Pred_loss_cum+Predicted_loss;
run;
data reg_start2(rename=(number_of_policies=no_of_policies 
act_loss=pct_total_actual_loss 
Actual_loss_cum=cumulative_actual_loss 
Pred_loss_cum=cumulative_prdctd_loss));
set reg_start1;
if _n_=1 then delete;
run;
title "Percentage Actual Loss vs 
Percentage of Observations considered";
symbol1 i=join c=blue h=2.5 l=1;
symbol2 i=join h=2.5 l=3;
/*proc sgplot data=reg_start1;
series y=act_loss_cum x=bin; 
series x=bin y=pct_obsrvtions/y2axis;*/
run;
title "Actual Loss vs Predicted Loss";
/*proc sgplot data=reg_start2;
series y=actual_loss x=bin;
series x=bin y=predicted_loss/y2axis;*/
run; 