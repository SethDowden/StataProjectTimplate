*------------------------------------------------------------------------------* 
* Author: Seth Dowden
* Date: October 8, 2023
* Project: main
*------------------------------------------------------------------------------*
* Initalize Stata environment.
clear all
set more off
set seed 42
cd /Users/sethdowden/GitHub/StataProjectTimplate/stata

*------------------------------------------------------------------------------*
* Readin data
*------------------------------------------------------------------------------*
use data/data.dta, clear
summarize
describe
*✌️j
