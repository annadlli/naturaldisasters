//processing dependent variables by state level

global raw "/Users/anna/Desktop/Cambridge/raw"
global temp "/Users/anna/Desktop/Cambridge/temp"
global output_data "/Users/anna/Desktop/Cambridge/data"
******************************************************************************


//business applications
import excel "/Users/anna/Desktop/Cambridge/raw/business apps.xlsx", firstrow clear

// Convert string variables to integer variables
encode BA2010, generate(intBA2010)
encode BA2011, generate(intBA2011)
encode BA2012, generate(intBA2012)
encode BA2013, generate(intBA2013)
encode BA2014, generate(intBA2014)
encode BA2015, generate(intBA2015)
encode BA2016, generate(intBA2016)
encode BA2017, generate(intBA2017)
encode BA2018, generate(intBA2018)
encode BA2019, generate(intBA2019)

drop BA* X Y

collapse (sum) sum2010 = intBA2010 sum2011 = intBA2011 sum2012 = intBA2012 sum2013 = intBA2013 sum2014 = intBA2014 sum2015 = intBA2015 sum2016 = intBA2016 sum2017 = intBA2017 sum2018 = intBA2018 sum2019 = intBA2019, by(State)

reshape long sum, i(State) j(year)
rename State state
rename sum bus_app_count


// Display the updated dataset
list


export excel using "$output_data/bus_app.xlsx", firstrow(variables) replace
//do state abbr to state name match in excel
import excel using "$output_data/bus_app.xlsx", firstrow clear
drop state E F G H 
rename D state
order state year bus_app_count
save "$output_data/final_bus_app", replace

******************************************************************************

//outdoor
import excel using "$raw/SAOACTVA__ALL_AREAS_2012_2021.xlsx",firstrow clear

rename I value2012
rename J value2013
rename K value2014
rename L value2015
rename M value2016
rename N value2017 
rename O value2018
rename P value2019
rename Q value2020
drop R
keep if Description == " Total Core Outdoor Recreation "


gen change2012 = .
gen change2013 = (value2013/value2012)-1
gen change2014 = (value2014/value2013)-1
gen change2015 = (value2015/value2014)-1
gen change2016 = (value2016/value2015)-1
gen change2017 = (value2017/value2016)-1
gen change2018 = (value2018/value2017)-1
gen change2019 = (value2019/value2018)-1


keep GeoName value* change*

reshape long value change, i(GeoName) j(year)
drop if year==2020
rename GeoName state
rename value outdoorvalue
rename change outdoorchange
label variable outdoorchange "Change between year t and year t-1"
label variable outdoorvalue "Total Outdoor Recreational Activities value, in thousands of dollars"

save "$output_data/final_outdoor.dta",replace

******************************************************************************
//arts

import excel using "$raw/SAACArtsVA__ALL_AREAS_2001_2021",firstrow clear
keep if Description == "Total ACPSA value added "
drop I J K L M N O P Q AC 


rename R value2010
rename S value2011
rename T value2012
rename U value2013
rename V value2014
rename W value2015
rename X value2016
rename Y value2017 
rename Z value2018
rename AA value2019
rename AB value2020

gen change2011 = (value2011/value2010)-1
gen change2012 = (value2012/value2011)-1
gen change2013 = (value2013/value2012)-1
gen change2014 = (value2014/value2013)-1
gen change2015 = (value2015/value2014)-1
gen change2016 = (value2016/value2015)-1
gen change2017 = (value2017/value2016)-1
gen change2018 = (value2018/value2017)-1
gen change2019 = (value2019/value2018)-1

keep GeoName value* change*


reshape long value change, i(GeoName) j(year)
drop if year ==2020
rename GeoName state
rename value artvalue
rename change artchange
label variable artchange "Change between year t and year t-1"
label variable artvalue "Arts and culture industry gross output less its intermediate inputs, in thousands of dollars"

save "$output_data/final_art.dta",replace


******************************************************************************
//personal expenditure

import excel using "$raw/SAPCE1__ALL_AREAS_1997_2021.xlsx",firstrow clear

keep if Description == "Personal consumption expenditures "
drop I J K L M N O P Q R S T U AG


rename V value2010
rename W value2011
rename X value2012
rename Y value2013
rename Z value2014
rename AA value2015
rename AB value2016
rename AC value2017 
rename AD value2018
rename AE value2019
rename AF value2020

gen change2011 = (value2011/value2010)-1
gen change2012 = (value2012/value2011)-1
gen change2013 = (value2013/value2012)-1
gen change2014 = (value2014/value2013)-1
gen change2015 = (value2015/value2014)-1
gen change2016 = (value2016/value2015)-1
gen change2017 = (value2017/value2016)-1
gen change2018 = (value2018/value2017)-1
gen change2019 = (value2019/value2018)-1

keep GeoName value* change*


reshape long value change, i(GeoName) j(year)
drop if year ==2020
rename GeoName state
drop if state == "United States"
rename value pers_expend
rename change pers_expend_change
label variable pers_expend_change "Change between year t and year t-1"
label variable pers_expend "A measure of spending on goods and services purchased by, and on behalf of, households based on households' state of residence, in thousands of dollars"

save "$output_data/final_personal_exp.dta",replace

******************************************************************************

//gdp
import excel using "$raw/SAGDP2N__ALL_AREAS_1997_2022",firstrow clear


keep if Description == "All industry total "
drop I J K L M N O P Q R S T U AG AH


rename V value2010
rename W value2011
rename X value2012
rename Y value2013
rename Z value2014
rename AA value2015
rename AB value2016
rename AC value2017 
rename AD value2018
rename AE value2019
rename AF value2020

encode value2010, generate(intvalue2010)
encode value2011, generate(intvalue2011)
encode value2012, generate(intvalue2012)
encode value2013, generate(intvalue2013)
encode value2014, generate(intvalue2014)
encode value2015, generate(intvalue2015)
encode value2016, generate(intvalue2016)
encode value2017, generate(intvalue2017)
gen intvalue2018 = value2018
//encode value2018, generate(intvalue2018)
encode value2019, generate(intvalue2019)
encode value2020, generate(intvalue2020)
drop value*
gen change2011 = (intvalue2011/intvalue2010)-1
gen change2012 = (intvalue2012/intvalue2011)-1
gen change2013 = (intvalue2013/intvalue2012)-1
gen change2014 = (intvalue2014/intvalue2013)-1
gen change2015 = (intvalue2015/intvalue2014)-1
gen change2016 = (intvalue2016/intvalue2015)-1
gen change2017 = (intvalue2017/intvalue2016)-1
gen change2018 = (intvalue2018/intvalue2017)-1
gen change2019 = (intvalue2019/intvalue2018)-1
keep GeoName intvalue* change*


reshape long intvalue change, i(GeoName) j(year)
drop if year ==2020
rename GeoName state
drop if state == "United States"
rename intvalue gdp
rename change gdp_change
label variable gdp_change "Change between year t and year t-1"
label variable gdp "All industry total includes all Private industries and Government in millions of current dollars"

save "$output_data/final_state_gdp.dta",replace

******************************************************************************

//employment
import excel using "$raw/SAEMP25N__ALL_AREAS_1998_2021",firstrow clear
keep if Description == "Total employment (number of jobs) "
drop I J K L M N O P Q R S T AF

rename U value2010
rename V value2011
rename W value2012
rename X value2013
rename Y value2014
rename Z value2015
rename AA value2016
rename AB value2017 
rename AC value2018
rename AD value2019
rename AE value2020


encode value2010, generate(intvalue2010)
encode value2011, generate(intvalue2011)
encode value2012, generate(intvalue2012)
encode value2013, generate(intvalue2013)
encode value2014, generate(intvalue2014)
encode value2015, generate(intvalue2015)
encode value2016, generate(intvalue2016)
encode value2017, generate(intvalue2017)
encode value2018, generate(intvalue2018)
encode value2019, generate(intvalue2019)
encode value2020, generate(intvalue2020)
drop value*

keep GeoName intvalue* 

reshape long intvalue, i(GeoName) j(year)
drop if year ==2020
rename GeoName state
drop if state == "United States"
rename intvalue employment
label variable employment "Total employment by number of jobs"

save "$temp/employment.dta",replace

//employment change
import excel using "$raw/employmentchange",firstrow clear
rename C change2009
rename D change2010
rename E change2011
rename F change2012
rename G change2013
rename H change2014
rename I change2015
rename J change2016
rename K change2017
rename L change2018
rename M change2019
drop GeoFips
reshape long change, i(GeoName) j(year)
rename GeoName state
drop if state == "United States"
drop if year == 2009
rename change employmentchange
label variable employmentchange "Change between year t and year t-1"
save "$temp/employmentchange.dta",replace

//merge together
use "$temp/employment.dta",clear
merge 1:1 state year using "$temp/employmentchange.dta" 
drop _merge
save "$output_data/final_employment.dta",replace

****************************************************************************
//unemployment
import excel using "$raw/emp-unemployment.xls", firstrow clear
rename C value2009
rename D value2010
rename E value2011
rename F value2012
rename G value2013
rename H value2014
rename I value2015
rename J value2016
rename K value2017
rename L value2018
rename M value2019
rename N value2020

gen change2011 = (value2011/value2010)-1
gen change2012 = (value2012/value2011)-1
gen change2013 = (value2013/value2012)-1
gen change2014 = (value2014/value2013)-1
gen change2015 = (value2015/value2014)-1
gen change2016 = (value2016/value2015)-1
gen change2017 = (value2017/value2016)-1
gen change2018 = (value2018/value2017)-1
gen change2019 = (value2019/value2018)-1

drop Fips
rename Area state
reshape long value change, i(state) j(year)
drop if state == "United States"
drop if year == 2009
rename value unemploymentrate
rename change unemploymentchange
label variable unemploymentchange "Change between year t and year t-1"
label variable unemploymentrate "Annual average unemployment rate for state"
save "$output_data/final_unemployment.dta",replace

****************************************************************************
 
//rgdp
import excel using "$raw/GDP real",firstrow clear

keep if Description == "Real GDP (millions of chained 2012 dollars)  "

drop I J K L M N O P Q R S T U AG AH


rename V value2010
rename W value2011
rename X value2012
rename Y value2013
rename Z value2014
rename AA value2015
rename AB value2016
rename AC value2017 
rename AD value2018
rename AE value2019
rename AF value2020

gen change2011 = (value2011/value2010)-1
gen change2012 = (value2012/value2011)-1
gen change2013 = (value2013/value2012)-1
gen change2014 = (value2014/value2013)-1
gen change2015 = (value2015/value2014)-1
gen change2016 = (value2016/value2015)-1
gen change2017 = (value2017/value2016)-1
gen change2018 = (value2018/value2017)-1
gen change2019 = (value2019/value2018)-1

keep GeoName value* change*


reshape long value change, i(GeoName) j(year)
rename GeoName state
drop if state == "United States"
rename value rgdp
rename change rgdpgrowth
label variable rgdpgrowth "growth between year t+1 and year t"
label variable rgdp "in millions of chained-2012 year dollars"

save "$output_data/final_state_rgdp.dta",replace


****************************************************************

//population (to calc rgdp per capita)

import excel using "$raw/nst-est2019-01.xlsx",firstrow clear
drop if State == "United States" | State == "Northeast" | State == "Midwest" | State == "South" | State == "West"
drop if _n > 51
drop Census EstimatesBase
rename D value2010
rename E value2011
rename F value2012
rename G value2013
rename H value2014
rename I value2015
rename J value2016
rename K value2017 
rename L value2018
rename M value2019

gen change2011 = (value2011/value2010)-1
gen change2012 = (value2012/value2011)-1
gen change2013 = (value2013/value2012)-1
gen change2014 = (value2014/value2013)-1
gen change2015 = (value2015/value2014)-1
gen change2016 = (value2016/value2015)-1
gen change2017 = (value2017/value2016)-1
gen change2018 = (value2018/value2017)-1
gen change2019 = (value2019/value2018)-1

reshape long value change, i(State) j(year)
rename State state
rename value population
rename change popchange
label variable popchange "Change between year t and year t-1"
save "$temp/pop.dta",replace

import excel "$raw/NST-EST2022-POP.xlsx",firstrow clear
reshape long value, i(state) j(year)
rename value population
save "$temp/pop2020.dta",replace

use "$temp/pop.dta",clear
merge 1:1 state year using "$temp/pop2020.dta"
sort state year
drop _merge
save "$output_data/pop.dta",replace
****************************************************************************
//rgdp per capita
use "$output_data/final_state_rgdp",clear
merge 1:1 state year using "$output_data/pop"
drop if _merge ==1
drop _merge
gen rgdppercapita = rgdp/population
bysort state: gen rgdpcapita_change = (rgdppercapita-rgdppercapita[_n-1])/rgdppercapita[_n-1]
bysort state: gen rgdpcapita_growth = (rgdppercapita[_n+1]-rgdppercapita)/rgdppercapita
drop if year==2020

save "$output_data/compiled_rgdp_pop.dta",replace

****************************************************************
//price parity
import excel using "$raw/price parity.xlsx",firstrow clear
drop C P Q GeoFips
drop if _n>52
rename GeoName state
drop if state == "United States"
rename D value2009
rename E value2010
rename F value2011
rename G value2012
rename H value2013
rename I value2014
rename J value2015
rename K value2016
rename L value2017 
rename M value2018
rename N value2019
rename O value2020

reshape long value, i(state) j(year)
gen priceparitychange = (value/value[_n-1])-1
rename value priceparity
drop if year ==2009 | year == 2020
save "$output_data/priceparity.dta",replace
****************************************************************

//disability (pre-processed to append all years together)
import excel "$raw/disability.xlsx",firstrow clear
drop if state == "Puerto Rico"
reshape long value, i(state) j(year)
gen disability = real(subinstr(value, "%", "", .))
drop value
gen disabilitychange = (disability/disability[_n-1])-1
save "$output_data/disability.dta",replace
****************************************************************
// gov expenditure
import excel "$raw/govexp.xls",firstrow clear
rename A state
drop if state == "United States"
drop if state == ""
drop B C D E F G H I J K L Y
rename M value2009
rename N value2010
rename O value2011
rename P value2012
rename Q value2013
rename R value2014
rename S value2015
rename T value2016
rename U value2017 
rename V value2018
rename W value2019
rename X value2020
drop if _n ==1
reshape long value, i(state) j(year)
rename value govexp
label variable govexp "in millions of dollars"
save "$temp/govexp.dta",replace
use "$output_data/final_state_gdp.dta",clear
merge 1:1 state year using "$temp/govexp.dta"
drop if _merge ==1
drop if year==2020 |year==2009
drop if _merge ==2
//calculate government srenght: govexp/gdp

gen govstrength= govexp/gdp
gen govstrengthchange = (govstrength/govstrength[_n-1])-1
drop _merge
save "$output_data/govstrength.dta",replace
****************************************************************
//education
import excel "$raw/education.xlsx",firstrow sheet("high school") clear
drop if A == ""
rename A state
reshape long value, i(state) j(year)
rename value highschoolgrad
save "$temp/highschoolgrad.dta",replace
import excel "$raw/education.xlsx",firstrow sheet("bachelor") clear
drop if A == ""
rename A state
reshape long value, i(state) j(year)
rename value bachelorgrad
