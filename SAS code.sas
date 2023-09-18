libname assign2 "C:\Users\rvi223\Downloads";

proc contents data=assign2.arter;
run;

data arter;
set assign2.arter;
run;

**PROPORTIONAL ODDS MODEL;
proc logistic data=arter;
class hs(ref="0") female(ref="0")/param=ref;
model arter=hs female npdage/aggregate scale=none;
run;

**PARTIAL-PROPORTIONAL ODDS MODEL;
proc logistic data=arter outest=sas;
class hs(ref="0") female(ref="0")/param=ref;
model arter=hs female npdage/unequalslopes aggregate scale=none;
hs: test HS1_2=HS1_1;
hs: test HS1_3=HS1_2;
female: test female1_2=female1_1;
female: test female1_3=female1_2;
npdage: test npdage_2=npdage_1;
npdage: test npdage_3=npdage_1;
run;

**based on linear hypothesis testing, hs and female do not appear to have proportionality across all logits, but age does
so final model will have unequal slopes for hs and female, and proportional odds assumption for age;
proc logistic data=arter;
class hs(ref="0") female(ref="0")/param=ref;
model arter=hs female npdage/unequalslopes=(hs female) aggregate scale=none;
run;

**multinomial model;
proc logistic data=arter ;
class hs(ref="0") female(ref="0")/param=ref;
model arter=hs female npdage/aggregate scale=none link=glogit;
run;

