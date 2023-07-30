global raw "/Users/anna/Desktop/Cambridge/raw"
global temp "/Users/anna/Desktop/Cambridge/temp"
global output_data "/Users/anna/Desktop/Cambridge/data"
global final "/Users/anna/Desktop/Cambridge/output"

log using "$final/gmm.log",replace
***************************************************************
use "$final/completedataset.dta",clear
encode state, gen(state1)
xtset state1 year
drop _merge
/*
//xtline rgdpcapita_growth,overlay
gen ln_highschool = ln(highschoolgrad)
gen ln_duration = ln(standard_duration)
gen ln_frequency = ln(frequency)
gen ln_rgdpcapita_growth = ln(rgdpcapita_growth)
gen ln_govstrengthchange = ln(govstrengthchange)
gen ln_gov = ln(govstrength)
gen ln_priceparity = ln(priceparity)
//gen ln_out = ln(outdoorchange)
//gen ln_busapp = ln(bus_app_count)
gen ln_disability = ln(disabilitychange)
gen ln_popchange = ln(popchange)
***************************************************************
//pooled OLS
reg rgdpcapita_growth ln_frequency L1.rgdpcapita_growth i.year goveexp_growth  laborgrowth bachelorgrad exchangerate_growth
//coeff:  .077
xtreg rgdpcapita_growth ln_frequency L1.rgdpcapita_growth i.year goveexp_growth  laborgrowth bachelorgrad exchangerate_growth,fe robust

//coeff:    -.047, value is lower

//since we have a lot of indiv and less time periods, use twostep system gmm
/*
xtabond2 rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth goveexp_growth  laborgrowth bachelorgrad i.year, gmm(L1.rgdpcapita_growth) iv(goveexp_growth  bachelorgrad) twostep
// P value > 0.05, accept null hypothesis that instruments are valid
//lag 1 is correct, as AR(2) test P val >0.05*/
xtabond2 rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth goveexp_growth  laborgrowth bachelorgrad exchangerate_growth i.year, gmmstyle(L.rgdpcapita_growth goveexp_growth  laborgrowth bachelorgrad) ivstyle(i.year exchangerate_growth) twostep robust small
//problem of overfitting
xtabond2 rgdpcapita_growth ln_frequency L1.rgdpcapita_growth bachelorgrad exchangerate_growth i.year, gmmstyle(L1.rgdpcapita_growth bachelorgrad ln_frequency) ivstyle(i.year exchangerate_growth) twostep robust small
*/
/*basic model 
estimates clear
eststo:xtabond2 rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth i.year, gmmstyle(L1.rgdpcapita_growth) ivstyle(i.year ln_frequency ln_standard_duration) twostep robust small
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

eststo:xtabond2 rgdp_growth ln_frequency ln_standard_duration L1.rgdp_growth i.year, gmmstyle(L1.rgdpcapita_growth) ivstyle(i.year ln_frequency ln_standard_duration) twostep robust small
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

**************************************************************/
//controls
estimates clear
eststo:xtabond2 rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth  laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.govexp_growth) ivstyle(i.year ln_frequency exchangerate_growth ln_standard_duration) twostep robust small
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

eststo:xtabond2 rgdp_growth ln_frequency ln_standard_duration L1.rgdp_growth i.year govexp_growth  laborgrowth bachelorgrad , gmmstyle(L1.rgdpcapita_growth L.goeexp_growth, collapse) ivstyle(i.year ln_frequency ln_standard_duration) twostep robust small
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace
//

estimates clear
eststo:xtabond2 rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

eststo:xtabond2 rgdp_growth ln_frequency ln_standard_duration L1.rgdp_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdp_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace
//////




estimates clear
eststo:xtabond2 rgdpcapita_growth ln_frequency_climate ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency_climate ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

eststo:xtabond2 rgdp_growth ln_frequency_climate ln_standard_duration L1.rgdp_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdp_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency_climate ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace



eststo:xtabond2 rgdpcapita_growth ln_frequency_hydro ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency_hydro ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

eststo:xtabond2 rgdp_growth ln_frequency_hydro ln_standard_duration L1.rgdp_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdp_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency_hydro ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace


eststo:xtabond2 rgdpcapita_growth ln_frequency_meteor ln_standard_duration L1.rgdpcapita_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency_meteor ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace

eststo:xtabond2 rgdp_growth ln_frequency_meteor ln_standard_duration L1.rgdp_growth i.year govexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdp_growth L.govexp_growth, collapse) ivstyle(i.year ln_frequency_meteor ln_standard_duration) twostep robust small 
esttab using results.rtf ,label se starlevels( * 0.10 ** 0.05 *** 0.010)  stats(N j ar1p ar2p hansenp, labels("Observations" "No. of instruments" "AR1 (p-value)" "AR2 (p-value)" "Hansen-J (p-value)" "F Statistic")) replace



/*
xtabond2 rgdpcapita_growth ln_frequency ln_standard_duration L1.rgdpcapita_growth i.year goveexp_growth  laborgrowth bachelorgrad exchangerate_growth, gmmstyle(L1.rgdpcapita_growth L.goveexp_growth L., collapse) ivstyle(i.year ln_frequency exchangerate_growth ln_standard_duration) twostep robust small
 */


xtabond2 rgdp_growth ln_frequency_hydro ln_standard_duration L1.rgdpcapita_growth i.year goveexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.goveexp_growth, collapse) ivstyle(i.year ln_frequency_hydro ln_standard_duration) twostep robust small

xtabond2 rgdp_growth ln_frequency_meteor ln_standard_duration L1.rgdpcapita_growth i.year goveexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.goveexp_growth, collapse) ivstyle(i.year ln_frequency_meteor ln_standard_duration) twostep robust small 

xtabond2 rgdp_growth ln_frequency_climate ln_standard_duration L1.rgdpcapita_growth i.year goveexp_growth laborgrowth bachelorgrad, gmmstyle(L1.rgdpcapita_growth L.goveexp_growth, collapse) ivstyle(i.year ln_frequency_climate ln_standard_duration) twostep robust small 


gen ln_labor = ln(laborforce)

xtabond2 rgdpcapita ln_frequency_hydro ln_standard_duration L1.rgdpcapita i.year ln_real_govexp ln_labor bachelorgrad, gmmstyle(L1.rgdpcapita ln_real_govexp bachleorgrad, ) ivstyle(i.year ln_frequency_hydro ln_standard_duration) twostep robust small 


***************************************************************


xtabond2 rgdpcapita_growth ln_frequency_climate ln_standard_duration L1.rgdpcapita_growth i.year, gmmstyle(L1.rgdpcapita_growth) ivstyle(i.year ln_frequency_climate ln_standard_duration) twostep robust small

/*
xtabond2 ln_rgdpcapita_growth ln_frequency ln_standard_duration L1.ln_rgdpcapita_growth ln_govexp ln_priceparity ln_laborforcechange ln_highschool i.year, gmm(L1.ln_rgdpcapita_growth) iv(ln_govexp ln_priceparity ln_laborforcechange ln_highschool) nolevel twostep



xtabond2 ln_rgdp ln_frequency ln_standard_duration L1.ln_rgdp ln_govexp ln_priceparity ln_laborforcechange ln_highschool i.year, gmm(L1.ln_rgdp) iv(ln_govexp ln_priceparity ln_laborforcechange ln_highschool) nolevel

//exogeneity needs to have p val> 0.05
//ln_popchange is needed
log close
