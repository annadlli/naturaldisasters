
global raw "/Users/anna/Desktop/Cambridge/raw"
global temp "/Users/anna/Desktop/Cambridge/temp"
global output_data "/Users/anna/Desktop/Cambridge/data"
global final "/Users/anna/Desktop/Cambridge/output"

**************************************************************//generate descriptive statistics


use "$final/completedataset.dta",clear

// Generate descriptive statistics
tabstat frequency standard_duration, stat(mean sd min max count) save
return list
matrix A = r(StatTotal)
putexcel set "$final/tabstat.xlsx", replace
putexcel A1 = matrix(A), names
putexcel A1 = matrix(r(StatTotal)), names
**************************************************************/

tabstat frequency standard_duration, by(state) stat(mean) save
tabstat frequency standard_duration, by(state) stat(median) save

**************************************************************

histogram frequency, xtitle("Number of Occurrences") title("Frequency of Natural Disasters by State in 2011-2019") 
 graph export "$final/frequencyhist.jpg", as(jpg) name("Graph") quality(90) 
 
 **************************************************************
//growth
asdoc tabstat frequency standard_duration rgdpcapita_growth rgdp_growth exchangerate_growth deflator_growth bachelorgrad laborgrowth govexp_growth, by(state) statistics(mean) nototal replace

//level
asdoc tabstat frequency standard_duration rgdp rgdpcapita exchangerate real_govexp bachelorgrad deflator laborforce frequency_*, by(state) statistics(mean) nototal replace
