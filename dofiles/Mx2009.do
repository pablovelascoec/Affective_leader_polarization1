use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses3.dta"
keep if C1004=="MEX_2009"

***leaders ACBE
recode C3010_A (96/99=.), gen(leaderA)
recode C3010_B (96/99=.), gen(leaderB)
recode C3010_C (96/99=.), gen(leaderC)
recode C3010_E (96/99=.), gen(leaderE)
*fame
gen fameA = 1 if C3010_A == 96 | C3010_A == 98
gen fameB = 1 if C3010_B == 96 | C3010_B == 98
gen fameC = 1 if C3010_C == 96 | C3010_C == 98
gen fameE = 1 if C3010_E == 96 | C3010_E == 98
*455 / 92 / 537 / 219
* W .18 / 1 / 0 / .92
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = .18 if maxleader == leaderA
replace weight = 1 if maxleader == leaderB
replace weight = 0 if maxleader == leaderC
replace weight = .92 if maxleader == leaderE
gen ALP = abs(maxleader-meanleader)*weight
**ALP 
gen distanceA = maxleader-leaderA
gen distanceB = maxleader-leaderB
gen distanceC = maxleader-leaderC
gen distanceE = maxleader-leaderE
replace distanceA= 0 if distanceA==.
replace distanceB= 0 if distanceB==.
replace distanceC= 0 if distanceC==.
replace distanceE= 0 if distanceE==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weight2 = .0877 if maxleader==leaderA
replace weight2 = .4759 if maxleader==leaderB
replace weight2 = 0 if maxleader==leaderC
replace weight2 = .4364 if maxleader==leaderE
gen ALP2 = sqrt((.0877*(distanceA^2)) + (.4759*(distanceB^2)) + (0*(distanceC^2)) + (.4364*(distanceE^2)) + (weight2*maxleader) )
replace ALP2=. if nleader==0
**ALP2 3.8922 / sd 2.1255


**only missing party I
recode C3009_A (96/99=.), gen(partyA)
recode C3009_B (96/99=.), gen(partyB)
recode C3009_C (96/99=.), gen(partyC)
recode C3009_D (96/99=.), gen(partyD)
recode C3009_E (96/99=.), gen(partyE)
recode C3009_F (96/99=.), gen(partyF)
recode C3009_G (96/99=.), gen(partyG)
recode C3009_H (96/99=.), gen(partyH)
* 38.9 / 29.6 / 12.9 / 6.9 / 3.8 / 3.6 / 2.5 / 1.1
*W 1 / .75 / .31 / .15 / .07 / .07 / .04 / 0
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty
***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.75 if maxparty == partyB
replace weightp = 0.31 if maxparty == partyC
replace weightp = 0.15 if maxparty == partyD
replace weightp = 0.07 if maxparty == partyE
replace weightp = 0.07 if maxparty == partyF
replace weightp = 0.04 if maxparty == partyG
replace weightp = 0 if maxparty == partyH
gen AP = abs(maxparty-meanparty)*weightp

gen distancepA = maxparty-partyA
gen distancepB = maxparty-partyB
gen distancepC = maxparty-partyC
gen distancepD = maxparty-partyD
gen distancepE = maxparty-partyE
gen distancepF = maxparty-partyF
gen distancepG = maxparty-partyG
gen distancepH = maxparty-partyH
replace distancepA= 0 if distancepA==.
replace distancepB= 0 if distancepB==.
replace distancepC= 0 if distancepC==.
replace distancepD= 0 if distancepD==.
replace distancepE= 0 if distancepE==.
replace distancepF= 0 if distancepF==.
replace distancepG= 0 if distancepG==.
replace distancepH= 0 if distancepH==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weightp2 = .4177 if maxparty == partyA
replace weightp2 = .3149 if maxparty == partyB
replace weightp2 = .1304 if maxparty == partyC
replace weightp2 = .0641 if maxparty == partyD
replace weightp2 = .0298 if maxparty == partyE
replace weightp2 = .0276 if maxparty == partyF
replace weightp2 = .0155 if maxparty == partyG
replace weightp2 = 0 if maxparty == partyH
gen AP2 = sqrt((.4177*(distancepA^2)) +(.3149*(distancepB^2)) + (.1304*(distancepC^2)) + (.0641*(distancepD^2)) + (.0298*(distancepE^2)) + (.0276*(distancepF^2)) + (.0155*(distancepG^2)) + (0*(distancepH^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
**AP2 3.6917 / sd 2.0126






