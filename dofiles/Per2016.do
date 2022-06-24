
use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses4.dta"
keep if D1004 == "PER_2016"

**missing leaders H I
recode D3012_A (96/99=.), gen(leaderA)
recode D3012_B (96/99=.), gen(leaderB)
recode D3012_C (96/99=.), gen(leaderC)
recode D3012_D (96/99=.), gen(leaderD)
recode D3012_E (96/99=.), gen(leaderE)
recode D3012_F (96/99=.), gen(leaderF)
recode D3012_G (96/99=.), gen(leaderG)

***Calculating weight
gen fameA = 1 if D3012_A == 96 | D3012_A == 98
gen fameB = 1 if D3012_B == 96 | D3012_B == 98
gen fameC = 1 if D3012_C == 96 | D3012_C == 98
gen fameD = 1 if D3012_D == 96 | D3012_D == 98
gen fameE = 1 if D3012_E == 96 | D3012_E == 98
gen fameF = 1 if D3012_F == 96 | D3012_F == 98
gen fameG = 1 if D3012_G == 96 | D3012_G == 98

**fameA 39 / B 53 / C 78 / D 125 / E 63 / F 146 / G 283 
*W A 1 / B 0.94 / C .84 / D .65 / E .90 / F .56 / G 0 

****We generate the variables for the index max and mean
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader

***stablishing weight 
gen weight = 1 if maxleader == leaderA
replace weight = 0.94 if maxleader == leaderB
replace weight = 0.84 if maxleader == leaderC
replace weight = 0.65 if maxleader == leaderE
replace weight = 0.90 if maxleader == leaderE
replace weight = 0.56 if maxleader == leaderF
replace weight = 0 if maxleader == leaderG

***Weighted ALP (index could go from 1 to 10)
gen ALP = abs(maxleader-meanleader)*weight	

*ALP 5.1319 / sd 2.4652







