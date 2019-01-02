clear
ssc install outreg2
ssc install estout
set more off
 
use "\\unimaas.nl\users\students\i6172598\data\My Documents\STATA\subsample_hightech.dta", clear
 

 
*compute identifier for panel analysis
egen sample = group(parent_company)
 
 
*check
list parent_company sample in 1/6, sepby(parent_company)
 
*set cross-section & time sequence ID for panel analysis
xtset sample fyear, yearly
 
 
*Model 1 baseline
xtnbreg patent_count sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1  /// 
	acquisitions_L1 jointventures_L1 portfolio_size_L1 i.fyear,fe

estat ic
mat es_ic = r(S)
local AIC: display %4.1f es_ic[1,5]
local BIC: display %4.1f es_ic[1,6]	

outreg2 using HIGHTECH.doc,   ///
dec(3) replace ctitle(Model 1) keep(sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1) /// 
adds(Degrees of freedom, e(df_m), Log likelihood, e(ll), Wald chi2, e(chi2), AIC, `AIC', BIC, `BIC')  /// 
addtext(Firm dummies, Fixed, Time dummies, Yes) title("Negative binominal panel regression with fixed effects Dependent variable = Investor innovation performance")

 
*Model 2 diversity only
xtnbreg patent_count diversity_ln_L1 sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1 i.fyear,fe

estat ic
mat es_ic = r(S)
local AIC: display %4.1f es_ic[1,5]
local BIC: display %4.1f es_ic[1,6]	

outreg2 using HIGHTECH.doc,  ///
dec(3) addstat(Degrees of freedom, e(df_m), Log likelihood, e(ll), Wald chi2, e(chi2), AIC, `AIC', BIC, `BIC')  ///  
append ctitle(Model 2)  ///
keep(diversity_ln_L1 sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1) /// 
addtext(Firm dummies, Fixed, Time dummies, Yes)

 
 
*Model 3 diversity + diversity sqrt
xtnbreg patent_count diversity_ln_L1 diversity_ln_sqrt_L1   /// 
sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1 i.fyear,fe

estat ic
mat es_ic = r(S)
local AIC: display %4.1f es_ic[1,5]
local BIC: display %4.1f es_ic[1,6]
 
outreg2 using HIGHTECH.doc,  ///
dec(3) addstat(Degrees of freedom, e(df_m), Log likelihood, e(ll), Wald chi2, e(chi2), AIC, `AIC', BIC, `BIC')  ///
append ctitle(Model 3)   ///
keep(diversity_ln_L1 diversity_ln_sqrt_L1   /// 
sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1) /// 
addtext(Firm dummies, Fixed, Time dummies, Yes)


*Model 4 moderation variables without interaction
xtnbreg patent_count diversity_ln_L1 absorptive_capacity_L1 geo_diversity_L1 sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1 i.fyear,fe

estat ic
mat es_ic = r(S)
local AIC: display %4.1f es_ic[1,5]
local BIC: display %4.1f es_ic[1,6]

outreg2 using HIGHTECH.doc,  ///
dec(3) addstat(Degrees of freedom, e(df_m), Log likelihood, e(ll), Wald chi2, e(chi2), AIC, `AIC', BIC, `BIC')  ///
append ctitle(Model 4)   ///
keep(diversity_ln_L1 absorptive_capacity_L1 geo_diversity_L1 sales_ln_L1 current_ratio_L1 age_L1 cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1) /// 
addtext(Firm dummies, Fixed, Time dummies, Yes)

 
*Model 5 moderation variables with interaction
*FULL MODEL
xtnbreg patent_count diversity_ln_L1 absorptive_capacity_L1 geo_diversity_L1 c.absorptive_capacity_L1#c.diversity_ln_L1  c.geo_diversity_L1#c.diversity_ln_L1 sales_ln_L1 current_ratio_L1 age_L1  cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1  i.fyear,fe

estat ic
mat es_ic = r(S)
local AIC: display %4.1f es_ic[1,5]
local BIC: display %4.1f es_ic[1,6]
 
outreg2 using HIGHTECH.doc,  ///
dec(3) addstat(Degrees of freedom, e(df_m), Log likelihood, e(ll), Wald chi2, e(chi2), AIC, `AIC', BIC, `BIC')  ///
append ctitle(Model 5) ///
keep(diversity_ln_L1  absorptive_capacity_L1 geo_diversity_L1 c.absorptive_capacity_L1#c.diversity_ln_L1  c.geo_diversity_L1#c.diversity_ln_L1 sales_ln_L1 current_ratio_L1 age_L1  cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1) /// 
addtext(Firm dummies, Fixed, Time dummies, Yes)
