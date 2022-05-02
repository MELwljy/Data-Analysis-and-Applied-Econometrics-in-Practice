/* 	=============================================================
	This is the template do-file for Patrick Blanchenay's 
	ECO372 Assignment 4. Before anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment4_BLANCHENAY_Patrick.do

	Comment your code, explain what steps you are doing. 
	You can insert comments before the instruction, or at the 
	end of lines.
	
	You should also use indentation to make your code easy to read.
	
	Remember that running this do-file does not save it.
	============================================================= */
log close _all 														// closes any previously opened log file	

/* =============================================================
	THINGS TO CHANGE
	============================================================= */

// Working directory:  This is the folder where your do-file and dataset are located
cd "C:\Users\WLJY8\Desktop\Courses\YEAR 4\WINTER\ECO372\ECO372_Assignment4_2021Apr"

// SURNAME (Last name) as on ACORN (replace BLANCHENAY)
local surname WANG // One word only

// First name as on ACORN (replace Patrick)
local firstname Liangjiayi // Only the fist of your given names, as it appears on ACORN

// Student number, replace 12345678 by your student number, without quotes
local studentnumber 1004405789

																		
/* 	=============================================================
	Do not change these commands
	============================================================= */
cap log close
log using "ECO372_Assignment4_`surname'_`firstname'.log", replace text 	// This log file will regenerated everytime you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making user click
clear			// Removes any data from memory every time this script is run.
display "ECO372_Assignment4 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)

/* 	=============================================================
	============ EXERCISE 1 ============
	============================================================= */

use "datasets/AganStarr2018.dta", clear			// If your files are placed correctly, you should not need to change that 
datasignature									// checks data integrity													

// YOUR COMMANDS FOR EXERCISE 1 GO HERE

//a
describe
tab posresponse interview

//b
label variable post "Period" 
label define timelabel 0 "Pre-BTB" 1 "Post-BTB"
label values post timelabel
table post, contents(mean white mean crime mean ged mean empgap mean box)
table post, contents(mean posresponse mean interview)

/*
For a more standarized table
eststo summstats1: estpost summarize white crime ged empgap box posresponse interview if pre==1
eststo summstats2: estpost summarize white crime ged empgap box posresponse interview if pre==0
esttab summstats1 summstats2 using "Qb.rtf", replace cell("mean(fmt(%6.3f))") ///
	mtitle("Pre-BTB" "Post-BTB")
*/

//c
ttest white, by(pre) unequal
ttest crime, by(pre) unequal
ttest ged, by(pre) unequal
ttest empgap, by(pre) unequal
ttest box, by(pre) unequal

//d
reg posresponse white crime ged empgap pre i.center i.chain_id, vce(cluster chain_id)
estimates store OLS1

reg posresponse white crime ged empgap i.center i.chain_id if box==1, vce(cluster chain_id)
estimates store OLS2

esttab OLS1 OLS2 using "Qd.rtf", ///
	rtf replace se ///
	mtitles("Full Sample" "Employers with Box") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons *center *chain_id)

//e 
reg interview  white crime ged empgap pre i.center i.chain_id, vce(cluster chain_id)
estimates store OLS3
reg interview  white crime ged empgap i.center i.chain_id if box==1, vce(cluster chain_id)
estimates store OLS4

esttab OLS3 OLS4 using "Qe.rtf", ///
	rtf replace se ///
	mtitles("Full Sample" "Employers with Box") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons *center *chain_id)

//f

//g
table balanced

//h
reg posresponse c.box#c.white white box ged empgap i.center if pre==1, vce(cluster chain_id)
estimates store OLS5
reg posresponse c.box#c.white white box ged empgap if remover==1 & balanced==1, vce(cluster chain_id)
estimates store OLS6
reg posresponse c.box#c.white white box ged empgap i.center if remover==1, vce(cluster chain_id)
estimates store OLS7
reg posresponse c.white#c.pre white pre ged empgap if remover==0 & balanced==1, vce(cluster chain_id)
estimates store OLS8

esttab OLS5 OLS6 OLS7 OLS8 using "Qh.rtf", ///
	rtf replace se ///
	mtitles("Pre-BTB" "Box Remover Balanced" "Box Remover Full" "Other empl. balanced") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons ged empgap *center)
	
//i
reg interview c.box#c.white white box ged empgap i.center if pre==1, vce(cluster chain_id)
estimates store OLS9
reg interview c.box#c.white white box ged empgap if remover==1 & balanced==1, vce(cluster chain_id)
estimates store OLS10
reg interview c.box#c.white white box ged empgap i.center if remover==1, vce(cluster chain_id)
estimates store OLS11
reg interview c.white#c.pre white pre ged empgap if remover==0 & balanced==1, vce(cluster chain_id)
estimates store OLS12

esttab OLS9 OLS10 OLS11 OLS12 using "Qi.rtf", ///
	rtf replace se ///
	mtitles("Pre-BTB" "Box Remover Balanced" "Box Remover Full" "Other empl. balanced") ///
	stats(N r2 F, labels("Obs." "R-squared" "F-statistic")) ///
	drop(_cons ged empgap *center)



/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
	
log close
graph close _all

/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
