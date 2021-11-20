/***************************************************************************************************/
/* Homework 3, Econometrics, National School of Development, Peking University 				       */
/* Jingpeng Hong								         			   		                       */      					
/* jphong2017@nsd.pku.edu.cn     						         		   			   			   */
/* April, 2021                           								         		           */
/***************************************************************************************************/

clear all
set more off
cd "/Users/hongjingpeng/Desktop/Econometrics_TA/HW/HW3"

use CollegeDistance.dta, clear

/*************************************************/
/* Tables                                        */
/* E7.3(b) Construct a table like Table 7.1      */
/*************************************************/

/* Many packages for output, e.g. esttab, outreg2, logout, ttable2, etc.
   We introduce esttab here */

//findit esttab
/* "esttab" is a command from package "estout" */
///ssc install estout

* Simple Specification 
reg ed dist, r
est store reg1  // Save the estimation results above

* Control some demographic characteristics
reg ed dist female black hispanic urban, r
est store reg2  

* Involve an interaction
gen female_black = female * black
reg ed dist female black hispanic urban female_black, r
est store reg3

* Involve distance square 
gen dist2 = dist * dist
reg ed dist female black hispanic urban female_black dist2, r
est store reg4

esttab reg1 reg2 reg3 reg4             ///
using output_table.csv, 			   /// 
scalars(N r2_a F) main(b %12.3f) aux(se %12.3f) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

/*********************************************************/
/* Figures                                               */
/* E8.3 Plot the regression relation between dist and ed */
/*********************************************************/

* Plot the regression relation between dist and ed

matrix A = [1, 58, 0.95, 0, 1, 0, 0, 1, 1, 7.1, 10.06, 1]'

* Baseline regression from (a)
reg ed dist female bytest tuition black hispanic incomehi ownhome dadcoll momcoll cue80 stwmfg80, r

matrix coef1 = e(b)
matrix B1 = coef1[1,2 .. 13]
matrix C = B1 * A
scalar beta_0 =  C[1,1]
scalar beta_1 =  coef1[1,1]

* Quadratic regression from (c)
reg ed dist dist2 female bytest tuition black hispanic incomehi ownhome dadcoll momcoll cue80 stwmfg80, r

matrix coef2 = e(b)
matrix B2 = coef2[1,3 .. 14]
matrix C = B2 * A
scalar alpha_0 =  C[1,1]
scalar alpha_1 =  coef2[1,1]
scalar alpha_2 =  coef2[1,2]

* Plot the predicted function
twoway (function y = beta_0 + beta_1 * x, range(0 10)) ///
	   (function y = alpha_0 + alpha_1 * x + alpha_2 * x^2, range(0 10))
	  
* Embellish our figure
twoway (function y = beta_0 + beta_1 * x, range(0 10)) ///
	   (function y = alpha_0 + alpha_1 * x + alpha_2 * x^2, range(0 10)), ///
	   legend(order(1 "Linear fit" 2 "Quadratic fit") rows(1)) ///
	   ytitle("Predicted years of education")  ///
	   xtitle("Distance")   ///
	   scheme(s1color)
	   
graph export Figure1.png, replace




