***========================================================================================================***
***Econometrics Class 3 Homework 4
***Fixed effects regression / Probit & Logit 
***Jingpeng Hong
***jphong2017@nsd.pku.edu.cn
***May, 2021
***========================================================================================================***

/* Housekeeping */

clear all
set more off
cd "/Users/hongjingpeng/Desktop/Econometrics_TA/HW/HW4"

**================================***
** Fixed effects regression       ***
** Dataset: SeatBelts.dta         ***
**================================***

use SeatBelts.dta, clear

gen lg_income = log(income)

/* Baseline regression */
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lg_income age, r
est store reg1

/* Fixed effects regression */

* Method 1 : xtreg 

// declare data to be panel data
xtset fips year

// state fixed effects
xtreg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lg_income age, fe vce(cluster fips)
est store reg2

// state and time fixed effects
xtreg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lg_income age i.year, fe vce(cluster fips)

// test time-fixed effects
testparm i.year
estadd scalar F_yearfe = r(F)

est store reg3

* Method 2 : areg

// state fixed effects 
areg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lg_income age, absorb(fips) vce(cluster fips)
est store reg4

// state and time fixed effects
areg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lg_income age i.year, absorb(fips) vce(cluster fips)
est store reg5

/* Output */
esttab reg1  reg2 reg3 reg4 reg5  ///
using ouput1.csv ,           	  ///
keep(sb_useage)         	      ///
scalars(F_yearfe)  main(b %12.3f) aux(se %12.3f) nogaps star(* 0.1 ** 0.05 *** 0.01) replace

//ssc install reghdfe

**================================***
** Probit & Logit                 ***
** Dataset: Smoking.dta           ***
**================================***

use Smoking.dta, clear

gen age2 = age * age

/* Linear Probability Model */
reg smoker smkban female age age2 hsdrop hsgrad colsome colgrad black hispanic, r

/* Mr. A: white, non-hispanic, 20 years old, high school dropout */
adjust female=0 age=20 age2=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0, by(smkban) xb

/* Probit Model */
probit smoker smkban female age age2 hsdrop hsgrad colsome colgrad black hispanic, r

// Mr. A
adjust female=0 age=20 age2=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0, by(smkban) pr


/* Logit Model */
logit smoker smkban female age age2 hsdrop hsgrad colsome colgrad black hispanic, r

// Mr. A 
adjust female=0 age=20 age2=400 hsdrop=1 hsgrad=0 colsome=0 colgrad=0 black=0 hispanic=0, by(smkban) pr







