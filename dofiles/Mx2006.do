use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses3.dta"
keep if C1004=="MEX_2006"

**leaders ABCGH
recode C3010_A (96/99=.), gen(leaderA)
recode C3010_B (96/99=.), gen(leaderB)
recode C3010_C (96/99=.), gen(leaderC)
recode C3010_G (96/99=.), gen(leaderG)
recode C3010_H (96/99=.), gen(leaderH)
*fame
gen fameA = 1 if C3010_A == 96 | C3010_A == 98
gen fameB = 1 if C3010_B == 96 | C3010_B == 98
gen fameC = 1 if C3010_C == 96 | C3010_C == 98
gen fameG = 1 if C3010_G == 96 | C3010_G == 98
gen fameH = 1 if C3010_H == 96 | C3010_H == 98
* 68 / 66 / 56 / 368 / 349
*W .96 / .97 / 1 / 0 / .06
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = .96 if maxleader == leaderA
replace weight = .97 if maxleader == leaderB
replace weight = 1 if maxleader == leaderC
replace weight = 0 if maxleader == leaderG
replace weight = .06 if maxleader == leaderH
***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
**ALP 
gen distanceA = maxleader-leaderA
gen distanceB = maxleader-leaderB
gen distanceC = maxleader-leaderC
gen distanceG = maxleader-leaderG
gen distanceH = maxleader-leaderH
replace distanceA= 0 if distanceA==.
replace distanceB= 0 if distanceB==.
replace distanceC= 0 if distanceC==.
replace distanceG= 0 if distanceG==.
replace distanceH= 0 if distanceH==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weight2 = .3215 if maxleader==leaderA
replace weight2 = .3237 if maxleader==leaderB
replace weight2 = .3344 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderG
replace weight2 = .0204 if maxleader==leaderH
gen ALP2 = sqrt((.3215*(distanceA^2)) + (.3237*(distanceB^2)) + (.3344*(distanceC^2)) + (0*(distanceG^2)) + (.0204*(distanceH^2)) + (weight2*maxleader) )
replace ALP2=. if nleader==0
**ALP2 4.6256 / 2.3049





****Parties ABCGH (DEF: same value in lower chamber voting as C)
recode C3009_A (96/99=.), gen(partyA)
recode C3009_B (96/99=.), gen(partyB)
recode C3009_C (96/99=.), gen(partyC)
recode C3009_G (96/99=.), gen(partyG)
recode C3009_H (96/99=.), gen(partyH)
* 33.39 / 28.99 / 28.21 / 4.54 / 2.05 
* W 1 / .86 / .83 / .08 / 0
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty
***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.86 if maxparty == partyB
replace weightp = 0.83 if maxparty == partyC
replace weightp = 0.08 if maxparty == partyG
replace weightp = 0 if maxparty == partyH
gen AP = abs(maxparty-meanparty)*weightp

gen distancepA = maxparty-partyA
gen distancepB = maxparty-partyB
gen distancepC = maxparty-partyC
gen distancepG = maxparty-partyG
gen distancepH = maxparty-partyH
replace distancepA= 0 if distancepA==.
replace distancepB= 0 if distancepB==.
replace distancepC= 0 if distancepC==.
replace distancepG= 0 if distancepG==.
replace distancepH= 0 if distancepH==.
*W2
gen weightp2 = .3606 if maxparty == partyA
replace weightp2 = .3099 if maxparty == partyB
replace weightp2 = .3009 if maxparty == partyC
replace weightp2 = .0286 if maxparty == partyG
replace weightp2 = 0 if maxparty == partyH
gen AP2 = sqrt((.3606*(distancepA^2)) +(.3099*(distancepB^2)) + (.3009*(distancepC^2)) + (.0286*(distancepG^2)) + (0*(distancepH^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 4.4916 / 2.2403




















