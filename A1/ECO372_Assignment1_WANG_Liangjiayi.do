clear
/* 	=============================================================
	This is the template do-file for Patrick Blanchenay's 
	ECO372 Assignment 1. Before anything else, rename this file, 
	changing "SURNAME" to your ACORN surname, and "Firstname" to 
	your ACORN first name. Use _ for spaces.
	
	For me, it would be: ECO372_Assignment1_BLANCHENAY_Patrick.do

	Comment your code, explain what steps you are doing. 
	You can insert comments before the instruction, or at the 
	end of lines.
	
	You should also use indentation to make your code easy to read.
	
	Remember that running this do-file does not save it.
	============================================================= */
	
											
/* 	=============================================================
	THINGS TO CHANGE
	============================================================= */

// Working directory:  This is the folder where your do-file and dataset are located
cd "C:/Users/WLJY8/Desktop/Courses/YEAR 4/WINTER/ECO372/ECO372_Assignment1_2021Jan"

// SURNAME (Last name) as on ACORN (replace BLANCHENAY)
local surname WANG // One word only

// First name as on ACORN (replace Patrick)
local firstname Liangjiayi // Only the first of your given names, as it appears on ACORN

// Student number, replace 12345678 by your student number, without quotes
local studentnumber 1004405789

/* 	=============================================================
	Do not change the commands below
	============================================================= */
cap log close _all // closes any previously opened log files
log using "ECO372_Assignment1_`surname'_`firstname'.log", replace text 	// This log file will be regenerated every time you run the do-file
set more off 	// This tells Stata to automatically continue if displays exceed screen capacity, instead of making the user click
clear			// Removes any data from memory every time this script is run.
set seed `studentnumber' // Fixes randomization issues
display "ECO372_Assignment1 " _n "`surname' `firstname' `studentnumber'" _n c(current_date) c(current_time)
																		

/* 	====================================
	============ EXERCISE  =============
	==================================== */

use "datasets/BurdeLinden_2013.dta", clear			
datasignature										// checks data integrity			

// your code for the Exercise questions goes below this

// a) no code for this question

// b)
count 
// count the number of observations
tab treatment 
// creates tables of frequencies of treatment 
describe 
// describe each variable’s information

// c) no code for this question

// d)
graph bar (mean) f07_both_norma_total, over (treatment) title("2017 total normalized test score comparison between treatment and control group",tstyle(size(Medium small)))
// create bar graph about the 2017 total normalized test score comparison between treatment and control group
// graph export "2017score_distribution1.png", replace
// export the graph

// e)
ttest f07_both_norma_total,by(treatment) unequal 
// create t-test and test whether there is a statistically significant difference in Fall 2007 test scores between treatment and control

// f) no code for this question

// g) no code for this question

// h)
hist f07_both_norma_total if f07_girl_cnt==1,title("Distribution (density) of the Fall 2007 test scores for girls",tstyle(size(Medium small)))
// create histogram to show the density of the Fall 2007 test scores for girls
// graph export "2017score_distribution2.png", replace
// export the graph

// i)
ttest f07_both_norma_total if f07_girl_cnt==1 ,by(treatment) unequal
// create t-test and test whether there is a statistically significant difference in Fall 2007 test scores between treatment and control

// j) no code for this question

// k)
ttest f07_yrs_ed_head_cnt,by(treatment) unequal
// create t-test and test whether there is a whether there is a statistically significant difference in parent's education level between the treatment and control group.

// l)
generate randvar=runiform()
//Generate a new variable randvar equal to a random number drawn between 0 and 1.
generate var1= (randvar>=0.5) 
// create dummy variable equal to 1 whenever randvar is greater or equal to 0.5, and 0 when randvar is smaller than 0.5.
tab var1
// find the number of individuals in each of these two groups

// m)
ttest f07_both_norma_total,by(var1) unequal
// create t-test and test whether there is a whether there is a statistically significant difference in Fall 2007 test scores between the treatment and control group.

// n) no code for this question


/* 	=============================================================
	============ 	FINAL COMMANDS 	(do not change)	============
	============================================================= */
log close				// closes your log file
/* 	=============================================================
	============ 			END OF SCRIPT			 ============
	============================================================= */
