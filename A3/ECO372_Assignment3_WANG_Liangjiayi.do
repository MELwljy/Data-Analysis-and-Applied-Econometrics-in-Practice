/* 	=============================================================
	This is the template do-file for Patrick Blanchenay's 
	ECO372 Assignment 3. Before anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment2_BLANCHENAY_Patrick.do

	Comment your code, explain what steps you are doing. 
	You can insert comments before the instruction, or at the 
	end of lines.
	
	You should also use indentation to make your code easy to read.
	
	Remember that running this do-file does not save it.
	============================================================= */
	
											
/* =============================================================
	THINGS TO CHANGE
	============================================================= */

// Working directory:  This is the folder where your do-file and dataset are located
cd "C:\Users\WLJY8\Desktop\Courses\YEAR 4\WINTER\ECO372\ECO372_Assignment3_2021Mar"

// SURNAME (Last name) as on ACORN (replace BLANCHENAY)
local surname WANG // One word only

// First name as on ACORN (replace Patrick)
local firstname Liangjiayi // Only the fist of your given names, as it appears on ACORN

// Student number, replace 12345678 by your student number, without quotes
local studentnumber 1004405789

/* 	=============================================================
	Do not change the following commands
	============================================================= */
cap log close _all // closes any previously opened log files
set seed `studentnumber'
log using "ECO372_Assignment3_`surname'_`firstname'.log", replace text 	// This log file will be regenerated everytime you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making user click
clear			// Removes any data from memory every time this script is run.
display "ECO372_Assignment3 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)
																		


/* 	====================================
	============ EXERCISE  1  ============
	==================================== */

use "datasets/Angrist_etal_Columbia2002_1.dta", clear		// Loads the file
datasignature												// checks data integrity			

// your code for the Exercise questions a-e goes here
//a
describe

//b
summarize math reading writing totalpts

//c
reg totalpts vouch0 i.t_site, robust
estimates store OLS1

reg math vouch0 i.t_site, robust
estimates store OLS2

reg reading vouch0 i.t_site, robust
estimates store OLS3

reg writing vouch0 i.t_site, robust
estimates store OLS4
	
esttab OLS1 OLS2 OLS3 OLS4 using "Qc.rtf", ///
	rtf replace se ///
	mtitles("Total Points OLS" "Math Score OLS" "Reading Score OLS" "Writing Score OLS") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons *.t_site)
	
//d
reg totalpts vouch0 age sex mom_sch dad_sch i.strata svy hsvisit, robust
estimates store OLS5

esttab OLS5 using "Qd.rtf", ///
	rtf replace se ///
	mtitles("Total Points OLS results with covariates") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons age sex mom_sch dad_sch *.strata svy hsvisit)
	
//e	


use "datasets/Angrist_etal_Columbia2002_2.dta", clear		// Loads the file
datasignature												// checks data integrity		


// your code for the Exercise questions f-l goes here

//f
describe

//g
reg scyfnsh vouch0 svy age sex hsvisit i.strata i.month, robust
estimates store OLS6

reg inschl vouch0 svy age sex hsvisit i.strata i.month, robust
estimates store OLS7

esttab OLS6 OLS7 using "Qg.rtf", ///
	rtf replace se ///
	mtitles("Highest_Grade_OLS" "Still_in_Scl_OLS") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons *.strata svy age sex hsvisit *.month)	

// h

// i
reg usesch vouch0,robust

// j
reg scyfnsh usesch svy hsvisit age sex i.strata i.month, robust
estimates store OLS8

ivregress 2sls scyfnsh (usesch=vouch0) svy hsvisit age sex i.strata i.month, robust 
estimates store IV9

esttab OLS8 IV9 using "Qj.rtf", ///
	rtf replace se ///
	mtitles("High_Score_OLS_estimate" "High_Score_IV_estimate") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons *.strata svy age sex hsvisit *.month)	
	
// k

// l
reg inschl usesch svy hsvisit age sex i.strata i.month, robust
estimates store OLS10

ivregress 2sls inschl (usesch=vouch0) svy hsvisit age sex i.strata i.month, robust 
estimates store IV11

esttab OLS10 IV11 using "Ql.rtf", ///
	rtf replace se ///
	mtitles("In_Scl_OLS_estimate" "In_Scl_IV_estimate") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons *.strata svy age sex hsvisit *.month)	
	
	

/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
log close				// closes your log file
/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
