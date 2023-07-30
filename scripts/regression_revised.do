
global raw "/Users/anna/Desktop/Cambridge/raw"
global temp "/Users/anna/Desktop/Cambridge/temp"
global output_data "/Users/anna/Desktop/Cambridge/data"
global final "/Users/anna/Desktop/Cambridge/output"

log using "$final/modelresults.log",replace
**************************************************************
use "$final/completedataset.dta",clear

drop if year == 2020
encode state, gen(state1)
xtset state1 year
drop state 
rename state1 state
//xtline rgdpcapita_growth,overlay

*************************************************************
//baseline model
//rgdp per capita
//growth
xtreg rgdpcapita_growth ln_frequency L1.rgdpcapita_growth
outreg2 using "$final/regressionbaseline.doc", replace r2 obs  
xtreg rgdpcapita_growth ln_standard_duration L1.rgdpcapita_growth
outreg2 using "$final/regressionbaseline.doc", append r2 obs  
xtreg rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth
outreg2 using "$final/regressionbaseline.doc", append r2 obs  

//rgdp
//growth
xtreg rgdp_growth ln_frequency L1.rgdp_growth
outreg2 using "$final/regressionbaseline.doc", append r2 obs 
xtreg rgdp_growth ln_standard_duration L1.rgdp_growth
outreg2 using "$final/regressionbaseline.doc", append r2 obs 
xtreg rgdp_growth ln_frequency ln_standard_duration L1.rgdp_growth
outreg2 using "$final/regressionbaseline.doc", append r2 obs 
*************************************************************
//adding FE

//rgdpcapita
//growth
xtreg rgdpcapita_growth ln_frequency L1.rgdpcapita_growth i.year, fe robust
outreg2 using "$final/regressionfe.doc", replace  keep(ln_frequency L1.rgdpcapita_growth)  adjr2 obs   ctitle(Fixed Effects) addtext(Country FE, YES, Year FE, YES)

xtreg rgdpcapita_growth ln_standard_duration  L1. rgdpcapita_growth i.year, fe robust
outreg2 using "$final/regressionfe.doc", append keep(ln_standard_duration L1.rgdpcapita_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth i.year, fe robust
outreg2 using "$final/regressionfe.doc", append keep(ln_frequency ln_standard_duration L1.rgdpcapita_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

//rgdp
//growth
xtreg rgdp_growth ln_frequency L1.rgdp_growth i.year, fe robust
outreg2 using "$final/regressionfe.doc", append keep(ln_frequency L1.rgdp_growth)  adjr2 obs   addtext(Country FE, YES, Year FE, YES)

xtreg rgdp_growth ln_standard_duration  L1. rgdp_growth i.year, fe robust
outreg2 using "$final/regressionfe.doc", append keep(ln_standard_duration L1.rgdp_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdp_growth ln_frequency ln_standard_duration L1.rgdp_growth i.year, fe robust
outreg2 using "$final/regressionfe.doc", append keep(ln_frequency ln_standard_duration L1.rgdp_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

*************************************************************
//controls
rename goveexp_growth govexp_growth

//rgdpcapita
//growth
xtreg rgdpcapita_growth ln_frequency L1.rgdpcapita_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressioncontrol.doc", replace keep(ln_frequency L1.rgdpcapita_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdpcapita_growth ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressioncontrol.doc", append keep(ln_standard_duration L1.rgdpcapita_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  


xtreg rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressioncontrol.doc", append keep(ln_frequency ln_standard_duration L1.rgdpcapita_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

//rgdp 
//growth
xtreg rgdp_growth ln_frequency L1.rgdp_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressioncontrol.doc", append keep(ln_frequency L1.rgdp_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdp_growth ln_standard_duration L1.rgdp_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressioncontrol.doc", append keep(ln_standard_duration L1.rgdp_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  


xtreg rgdp_growth ln_frequency ln_standard_duration L1.rgdp_growth i.year govexp_growth  exchangerate_growth laborgrowth bachelorgrad, fe robust
outreg2 using "$final/regressioncontrol.doc", append keep(ln_frequency ln_standard_duration L1.rgdp_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  



xtreg rgdp_growth ln_frequency L1.rgdp_growth i.year ln_real_govexp exchangerate_growth laborgrowth bachelorgrad, fe robust

*************************************************************
//controls for diff disaster type

//rgdpcapita
//growth
xtreg rgdpcapita_growth ln_frequency_climate L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressionspecific.doc", replace keep(ln_frequency_climate L1.rgdpcapita_growth govexp_growth laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdpcapita_growth ln_frequency_hydro L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressionspecific.doc", append keep(ln_frequency_hydro L1.rgdpcapita_growth govexp_growth laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdpcapita_growth ln_frequency_meteor L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressionspecific.doc", append keep(ln_frequency_meteor L1.rgdpcapita_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

//rgdp 
//growth
xtreg rgdp_growth ln_frequency_climate L1.rgdp_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressionspecific.doc", append keep(ln_frequency_climate L1.rgdp_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  


xtreg rgdp_growth ln_frequency_hydro L1.rgdp_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressionspecific.doc", append keep(ln_frequency_hydro L1.rgdp_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

xtreg rgdp_growth ln_frequency_meteor L1.rgdp_growth i.year govexp_growth  laborgrowth bachelorgrad exchangerate_growth, fe robust
outreg2 using "$final/regressionspecific.doc", append keep(ln_frequency_meteor L1.rgdp_growth govexp_growth  laborgrowth bachelorgrad exchangerate_growth) addtext(Country FE, YES, Year FE, YES) adjr2 obs  

log close
