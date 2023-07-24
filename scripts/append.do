//processing dependent variables by state level

global raw "/Users/anna/Desktop/Cambridge/raw"
global temp "/Users/anna/Desktop/Cambridge/temp"
global output_data "/Users/anna/Desktop/Cambridge/data"
global final "/Users/anna/Desktop/Cambridge/output"

****************************************************************
/* unnecessary as not calcluating damages anymore
use "$output_data/compiled_rgdp_pop.dta", clear
merge 1:1 state year using "$output_data/final_state_gdp.dta"
//drop as it's state= US *
drop if _merge == 2
drop _merge
save "$output_data/merge1.dta",replace
*/
****************************************************************
use "$output_data/compiled_rgdp_pop.dta", clear
merge 1:1 state year using "$output_data/final_personal_exp.dta"
drop if _merge ==2 //regional data
drop _merge
save "$output_data/merge2.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/final_employment.dta"
drop if _merge ==2 //regional data
drop _merge
save "$output_data/merge3.dta",replace
**************************************************************** 
merge 1:1 state year using "$output_data/final_art.dta"
//drop as these were regions like Far WEst or so
drop if _merge == 1 
drop _merge
save "$output_data/merge4.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/final_outdoor.dta"
//missing vals as outdoor doesn't have 2010 and 2011 data
drop _merge
save "$output_data/merge5.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/final_bus_app.dta"
drop _merge
save "$output_data/merge6.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/final_unemployment.dta"
drop if _merge ==2 //2020 data
drop _merge
save "$output_data/merge7.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/priceparity.dta"
drop _merge
save "$output_data/merge8.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/disability.dta"
drop _merge
save "$output_data/merge9.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/govstrength.dta"
drop _merge
save "$output_data/merge10.dta",replace
****************************************************************
merge 1:1 state year using "$output_data/education.dta"
drop if year==2010
drop if _merge ==1
drop _merge
save "$output_data/merge11.dta",replace


save "$final/dependent.dta",replace
export excel "$final/dependent.xlsx", firstrow(variables) replace
****************************************************************
import excel "$final/index.xlsx",firstrow clear
rename State state
rename Year year
merge 1:1 state year using "$final/dependent.dta"
drop if year==2010
drop _merge
save "$final/completedataset.dta",replace
export excel "$final/completedataset.xlsx",firstrow(variables)replace
