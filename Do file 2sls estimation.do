use "D:\PIDE Semester Doc\energy subsidy\data\2slsfinal.dta"
 tsset Years
 describe
 summarize IR CPI ES PD ER FD
 #check stationarity ADF and PP test
 # ADF at level
 dfuller FD, lags(1)
 dfuller PD, lags(1)
 dfuller ER, lags(1)
 dfuller IR, lags(1)
 dfuller ES, lags(1)
 dfuller inf, lags(1)
 # first difference
 gen D_ES = D.ES
gen D_FD = D.FD
gen D_ER = D.ER
gen D_IR = D.IR
gen D_inf = D.inf
gen D_PD = D.PD
# ADF at first difference
dfuller D_ES, lags(1)
dfuller D_FD, lags(1)
dfuller D_ER, lags(1)
dfuller D_IR, lags(1)
dfuller D_inf, lags(1)
dfuller D_PD, lags(1)
#PP test at level
pperron ES
pperron FD
pperron ER
pperron IR
pperron inf
pperron PD
# PP test at first difference
pperron D_ES
pperron D_FD
pperron D_ER
pperron D_IR
pperron D_inf
pperron D_PD

 postfile results str15 test str10 variable double t_stat double p_value using stationarity_results.dta, replace
 asdoc list, title(ADF and PP Test Results) save(stationarity_results.doc) replace
# To check endogeneity Durbin & Wu Hausman test
 ivregress 2sls ES (FD = FDt_1) ESt_1
estat endogenous
ivregress 2sls PD (FD = FDt_1) PDt_1
estat endogenous
ivregress 2sls ER (FD IR = FDt_1 IRt_1) ERt_1
estat endogenous
ivregress 2sls IR (FD = FDt_1) IRt_1
estat endogenous
ivregress 2sls inf (FD = FDt_1 IRt_1) inft_1
estat endogenous

 
 # for 2sls estimations
 ivregress 2sls ES (FD = FDt_1) ESt_1
est store eq1

ivregress 2sls PD (FD = FDt_1) PDt_1
est store eq2

ivregress 2sls ER (FD IR = FDt_1 IRt_1) ERt_1
est store eq3

ivregress 2sls IR (FD = FDt_1) IRt_1
est store eq4
ivregress 2sls inf (FD = FDt_1 IRt_1) inft_1
est store eq5
esttab eq1 eq2 eq3 eq4 eq5, b(3) se star(* 0.10 ** 0.05 *** 0.01) stats(r2 N, labels("R²" "Obs"))bs"))
 esttab eq1 eq2 eq3 eq4 eq5 using results2sls.rtf, replace b(3) se star(* 0.10 ** 0.05 *** 0.01) stats(r2 N, labels("R²" "Obs"))
