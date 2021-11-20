/***************************************************************************************************/
/* NSD Econometrics, 2021 Spring																   */
/* TA: Jingpeng Hong								         			   		                   */
/* jphong2017@nsd.pku.edu.cn    						         		   			   			   */
/* April Fool's Day, 2021                           								         	   */
/***************************************************************************************************/

/*
	HOUSEKEEPING 
*/

* Clear memory
clear all

* Change Directory
cd "/Users/hongjingpeng/Desktop/Econometrics_TA/Lab/Apr1" 

/***************************************************
	HW 1: Empirical Exercise 3.1, Stock & Watson
****************************************************/

* Load data
use cps92_08.dta, clear

* Descriptive Statistics
describe ahe
sum ahe
sum ahe, d
tab bachelor
tab bachelor year

/*
	a. Compute sample mean & Construct 95% CI of 1992, 2008 and change.
*/

* t-test
help ttest
ttest ahe, by(year)

/*
	b. Inflation Adjustment
*/

gen ahe_ad = ahe
replace ahe_ad = ahe /140.3 *215.2 if year == 1992

/*
	d&e. College graduates v.s. High School graduates in 1992/2008
*/

ttest ahe_ad if year == 2008, by(bachelor)
ttest ahe_ad if year == 1992, by(bachelor)

/*
	f. 1992 v.s. 2008 among College/High School graduates
*/

ttest ahe_ad if bachelor == 0, by(year)
ttest ahe_ad if bachelor == 1, by(year)

* (CLG2008- HS2008)- (CLS1992- HS1992): Actually a Diff-in-Diff Design

//ssc install diff
recode year (1992= 0)(2008= 1), gen(time)
diff ahe_ad, t(bachelor) p(time)

/***************************************************
	SUPPLEMENT: Might help your HW 2
****************************************************/

/*
	Single Regressor
*/

* OLS
reg ahe_ad age

* OLS with heteroskedasticity robust standard errors
reg ahe_ad age, r 

* Predict
predict ahe_p
adjust age= 30

* Hypothesis test
reg ahe_ad age, r
test age= 0

/*
	Multiple Regressors
*/

* OLS with heteroskedasticity robust standard errors
reg ahe_ad age bachelor female, r

* Predict
adjust age= 22 bachelor= 1 female= 1

* Hypothesis test
test bachelor= female

* Is the effect of age on earnings different for HS graduates than for CLG graduates?

// Method 1
reg ahe_ad age if bachelor== 1, r
reg ahe_ad age if bachelor== 0, r

// Method 2
recode bachelor(0 =1)(1 =0), gen(hs)
gen age_clg = age* bachelor
gen age_hs  = age* hs

reg ahe_ad age_clg age_hs, r
test age_clg= age_hs







