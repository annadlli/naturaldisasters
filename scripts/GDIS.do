
//converted from csv to excel as was having problems with file
import excel using "/Users/anna/Desktop/Cambridge/raw/pend-gdis-1960-2018-disasterlocations.xlsx",firstrow clear

keep if country=="United States"
keep if year >=2011
gen DisNo = disasterno + "-USA"
save "/Users/anna/Desktop/Cambridge/gdisfiltered.dta", replace


import excel using "/Users/anna/Desktop/Cambridge/raw/emdat_public_2023_07_21_query_uid-matlTp.xlsx", firstrow clear


merge 1:n DisNo using gdisfiltered.dta
//results: 61 not matched with 1017 matched, 7 unmatched from gdis, 54 from original
//gdis unmatched comes from 2014-0553-USA, which I can't find in embdat
save combinedgdis,replace
