use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses3.dta"
keep if C1004 == "CHL_2009"

** missing leader A D E F I
**sí BCGH
recode C3010_B (96/99=.), gen(leaderB)
recode C3010_C (96/99=.), gen(leaderC)
recode C3010_G (96/99=.), gen(leaderG)
recode C3010_H (96/99=.), gen(leaderH)

gen fameB = 1 if C3010_B == 96 | C3010_B == 98
gen fameC = 1 if C3010_C == 96 | C3010_C == 98
gen fameG = 1 if C3010_G == 96 | C3010_G == 98
gen fameH = 1 if C3010_H == 96 | C3010_H == 98
*fame B 23 / 23 / 53 / 29

xtile leadB2= leaderB, nq(2)
sum leaderB if leadB2==1
sum leaderB if leadB2==2

*weight .81 / .76 / .24 / .62

egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader


***stablishing weight 
gen weight = .81 if maxleader == leaderB
replace weight = 0.76 if maxleader == leaderC
replace weight = 0.24 if maxleader == leaderG
replace weight = 0.62 if maxleader == leaderH

***Weighted ALP (index could go from 1 to 10)
gen ALP = sqrt(((maxleader-meanleader)^2)*weight)	

***ALP 4.6884 / sd 2.01574




**********Same for parties 
*missing F H I
recode C3009_A (96/99=.), gen(partyA)
recode C3009_B (96/99=.), gen(partyB)
recode C3009_C (96/99=.), gen(partyC)
recode C3009_D (96/99=.), gen(partyD)
recode C3009_E (96/99=.), gen(partyE)
recode C3009_G (96/99=.), gen(partyG)

***Fame is not reliable for parties. Thas it why it is replaced by % votes standardized with min - max (from 0 to 1 too)

xtile partyA2= partyA, nq(2)
sum partyA if partyA2==1
sum partyA if partyA2==2

**
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = .53 if maxparty == partyA
replace weightp = 0.77 if maxparty == partyB
replace weightp = 0.71 if maxparty == partyC
replace weightp = 0.21 if maxparty == partyD
replace weightp = 0.55 if maxparty == partyE
replace weightp = 0.61 if maxparty == partyG

***Weighted AP (index could go from 1 to 10)
gen AP = sqrt(((maxparty-meanparty)^2)*weightp)	

***ALP 4.6884 / sd 2.01574

