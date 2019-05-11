clear all
set more off
use "/Users/sadikshyanepal/Desktop/Data Management /CMS Research /36755-0001-Data.dta"


collapse (sum) REM63 REM64 REM65 REM66 REM67 REM68 REM69 REM70 REM71 REM72
gen x= _n

reshape long REM, i(x) j(year)
gen REM_lag=REM[_n-1]
gen percent = (REM-REM_lag)/REM_lag
replace year = 2007 if year== 63
replace year = 2008 if year== 64
replace year = 2009 if year== 65
replace year = 2010 if year== 66
replace year = 2011 if year== 67
replace year = 2012 if year== 68
replace year = 2013 if year== 69
replace year = 2014 if year== 70
replace year = 2015 if year== 71
replace year = 2016 if year== 72

ren year Year

preserve 
clear
import excel "/Users/sadikshyanepal/Desktop/Data Management /Remittancedatainflows(Dec.2018).xls", sheet("Percentage Remmitance") firstrow
tempfile ABC
save `ABC'
restore

merge 1:1 x Year using `ABC'
keep if _merge==3 
export excel using "/Users/sadikshyanepal/Desktop/Data Management /Percentage Change.xlsx", firstrow(variables), replace
