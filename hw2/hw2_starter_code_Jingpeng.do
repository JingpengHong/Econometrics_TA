/***************************************************************************************************/
/* Homework 2    																				   */
/* NSD Econometrics, 2021 Spring																   */
/* TA: Jingpeng Hong								         			   		                   */
/* jphong2017@nsd.pku.edu.cn    						         		   			   			   */
/* April, 2021                           								         	               */
/***************************************************************************************************/

clear all
cd "/Users/hongjingpeng/Desktop/Econometrics_TA/HW/HW2" 

/***************************************************
	Empirical Exercise 4.1, Stock & Watson
****************************************************/

use cps08.dta, clear

*a)
reg ahe age

*b)
// Bob, 26-year-old
adjust age= 26

// Alexis, 30-year-old
adjust age= 30


/***************************************************
	Empirical Exercise 5.1, Stock & Watson
****************************************************/

*a)
reg ahe age
reg ahe age, level(90)
reg ahe age, level(99)


*c) For high-school graduates
reg ahe age if bachelor== 0  

*d) For college graduates
reg ahe age if bachelor== 1

*e) Is the effect of age on earnings different for high school graduates than for college graduates?

// See the Hint by S&W
reg ahe age if bachelor== 1, r
reg ahe age if bachelor== 0, r

/***************************************************
	Empirical Exercise 6.2, Stock & Watson
****************************************************/

use CollegeDistance.dta, clear

*a)
reg ed dist, r

*b)
reg ed dist bytest female black hispanic incomehi ownhome dadcoll momcoll cue80 stwmfg80, r

*d)
help reg
reg ed dist bytest female black hispanic incomehi ownhome dadcoll momcoll cue80 stwmfg80, r
scalar r2  = e(r2)
scalar r2_a= e(r2_a)
scalar list r2 r2_a

*g)
adjust dist= 2 bytest= 58 female= 0 black= 1 hispanic= 0 incomehi= 1 ownhome= 1 /// 
	   dadcoll= 0 momcoll= 1  cue80= 7.5  stwmfg80= 9.75

*h)
adjust dist= 4 bytest= 58 female= 0 black= 1 hispanic= 0 incomehi= 1 ownhome= 1 /// 
	   dadcoll= 0 momcoll= 1  cue80= 7.5  stwmfg80= 9.75









