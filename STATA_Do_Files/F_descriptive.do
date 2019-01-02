clear
use "\\unimaas.nl\users\students\i6172598\data\My Documents\STATA\sample_stata.dta", clear

*descriptives
summarize patent_count ///
	diversity_L1 diversity_ln_L1 diversity_ln_sqrt_L1 absorptive_capacity_L1 geo_diversity_L1 sales_L1 sales_ln_L1  /// 
	current_ratio_L1 age_L1 acquisitions_L1 jointventures_L1 /// 
	portfolio_size_L1  cvc_experience_L1 cvc_experience_ln_L1, detail

outreg2 using DESCRIPTIVES.doc, replace sum(detail) /// 
	dec(2) keep(patent_count  ///
	diversity_L1 diversity_ln_L1 diversity_ln_sqrt_L1 absorptive_capacity_L1 geo_diversity_L1 sales_L1 sales_ln_L1  /// 
	current_ratio_L1 age_L1 acquisitions_L1 jointventures_L1 /// 
	portfolio_size_L1  cvc_experience_L1 cvc_experience_ln_L1) 
	
*correlations
estpost correlate patent_count  ///
	diversity_L1 diversity_ln_L1 diversity_ln_sqrt_L1 absorptive_capacity_L1 geo_diversity_L1 sales_L1 sales_ln_L1  /// 
	current_ratio_L1 age_L1 acquisitions_L1 jointventures_L1 /// 
	portfolio_size_L1  cvc_experience_L1 cvc_experience_ln_L1, matrix listwise
	
est store c1  
esttab * using CORRELATION.rtf, unstack not noobs compress 
