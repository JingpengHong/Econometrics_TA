***========================================================================================================***
***Econometrics Class 3 Homework 5
***IV regression
***Jingpeng Hong
***jphong2017@nsd.pku.edu.cn
***June, 2021
***========================================================================================================***

/* Housekeeping */

clear all
set more off
global hw5 = "/Users/hongjingpeng/Desktop/Econometrics_TA/HW/HW5"

**================================***
** IV regression                  ***
** Dataset: fertility.dta         ***
**================================***

/****************** Review *******************

IV conditions:
a) Relevant  : cov(X, Z) != 0   (Check: weak instruments - First stage F-statistics, F > 10    )
b) Exogenous : cov(u, Z) == 0   (Check: overidentifed    - J-test, regress u against Xs and Ws )

Estimation: 2SLS

*********************************************/

/* Angrist, J.D. and Evans, W.N., 1998. Children and Their Parents' Labor Supply: 
Evidence from Exogenous Variation in Family Size. American Economic Review, 88(3), pp.450-477.*/

use $hw5/fertility.dta, clear

*a) naive OLS
reg weeksm1 morekids, r

*b) why the naive OLS is inappropriate
* omitted variable bias, simultaneous causality, etc.

*c) estimate the effect of samesex on morekids
reg morekids samesex, r

*d) why samesex is valid
* relevance:  preference for a mixed sibling-sex composition
* exogeneity: kids' sex is random

*e&f) regress weeksm1 on morekids using samesex as IV
ivregress 2sls weeksm1 (morekids = samesex), r
estat firststage       /* check weak IVs */

*g) regress weeksm1 on morekids using samesex as IV
ivregress 2sls weeksm1 agem1 black hispan othrace (morekids = samesex), r









