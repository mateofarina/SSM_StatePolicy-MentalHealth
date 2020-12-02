

/* Below is the code to create Tables Used in 
“How Do State Policies Shape Experiences of Household Income Shocks and Mental Health During the COVID-19 Pandemic?” 
Data: PULSE Study Weeks 1 - 12
Author: Mateo Farina

*/
*** Prediction for Graphs in R
** SURVEY Information 
svyset [pweight=pweight]
prop di_distress [pw=pweight], over(wrkloss est_st) vce(cluster scram) // by jobloss status
prop di_anxiety  [pw=pweight], over(wrkloss est_st) vce(cluster scram) // by jobloss status


**** Tables for Paper

eststo clear	   
foreach x in di_distress di_anxiety {
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##i.med_exp if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##i.eitc if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##c.unemp_amt2 if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##c.unemp_dur if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##i.noutilityoff if under_65==1|| est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##i.stopevict if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##c.repub_per  if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##i.trump_won if under_65==1 || est_st: ,vce(robust)
eststo: melogit `x' c.age i.race i.female i.educ i.marital i.week i.wrkloss##c.repub_per i.wrkloss##i.trump_won if under_65==1 || est_st: ,vce(robust)
esttab using /Users/mfarina/Projects/State_Distress/Analysis/Table2_melogit_`x'_under65firstobs.csv, b(%9.3f) not ///
       starlevels(* .05 ** .01 *** .001) nodepvars nomtitles wide nopa se replace
esttab using /Users/mfarina/Projects/State_Distress/Analysis/Table2_melogit_`x'_under65firstobs_eform.csv, b(%9.3f) not eform ci ///
       starlevels(* .05 ** .01 *** .001) nodepvars nomtitles wide nopa replace
eststo clear
}	



