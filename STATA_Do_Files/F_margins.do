* Margins Plot
set more off, permanently

xtnbreg patent_count diversity_ln_L1 absorptive_capacity_L1 geo_diversity_L1 c.absorptive_capacity_L1#c.diversity_ln_L1  c.geo_diversity_L1#c.diversity_ln_L1 sales_ln_L1 current_ratio_L1 age_L1  cvc_experience_ln_L1 acquisitions_L1 jointventures_L1 portfolio_size_L1  i.fyear,fe  

margins, at(diversity_ln_L1=(-8(2)2)) predict(iru0) atmeans
marginsplot, scheme(s1mono)

* Absor
margins, at(diversity_ln_L1=(-8 -6 -4 -2 0 2) absorptive_capacity_L1=(0.01 0.2 0.59 )) predict(nu0) atmeans
marginsplot, xdimension(at(diversity_ln_L1)) scheme(s1mono) legend(cols(1)) ytitle(Predicted Number of Events) scale(1.2)

* Geo
margins, at(diversity_ln_L1=(-8 -6 -4 -2 0 2) geo_diversity_L1=(0 1.38 2.78 )) predict(nu0) atmeans
marginsplot, xdimension(at(diversity_ln_L1)) scheme(s1mono) legend(cols(1)) ytitle(Predicted Number of Events) scale(1.2)
