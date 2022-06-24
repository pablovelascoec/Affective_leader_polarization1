use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses2.dta"
keep if B1004 =="BRA_2002"

**Leader missing F G (repeated with C) H and I (the variable is the addtional optiona scale)
recode B3041_A (96/99=.), gen(leaderA)
recode B3041_B (96/99=.), gen(leaderB)
recode B3041_C (96/99=.), gen(leaderC)
recode B3041_D (96/99=.), gen(leaderD)
recode B3041_E (96/99=.), gen(leaderE)

***Calculating weight
gen fameA = 1 if B3041_A == 96 | B3041_A == 98
gen fameB = 1 if B3041_B == 96 | B3041_B == 98
gen fameC = 1 if B3041_C == 96 | B3041_C == 98
gen fameD = 1 if B3041_D == 96 | B3041_D == 98
gen fameE = 1 if B3041_E == 96 | B3041_E == 98

* A 44 / B 62 / C 485 / 692 / 247 
*W 1 / .97 / .32 / 0 / .69 

egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader

gen weight = 1 if maxleader == leaderA
replace weight = .97 if maxleader == leaderB
replace weight = .32 if maxleader == leaderC
replace weight = 0 if maxleader == leaderD
replace weight = .69 if maxleader == leaderE

***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
**ALP 5.6257 / 2.6515

gen distanceA = maxleader-leaderA
gen distanceB = maxleader-leaderB
gen distanceC = maxleader-leaderC
gen distanceD = maxleader-leaderD
gen distanceE = maxleader-leaderE
gen distanceF = maxleader-leaderF
gen distanceG = maxleader-leaderG
gen distanceH = maxleader-leaderH
gen distanceI = maxleader-leaderI

replace distanceA= 0 if distanceA==.
replace distanceB= 0 if distanceB==.
replace distanceC= 0 if distanceC==.
replace distanceD= 0 if distanceD==.
replace distanceE= 0 if distanceE==.
replace distanceF= 0 if distanceF==.
replace distanceG= 0 if distanceG==.
replace distanceH= 0 if distanceH==.
replace distanceI= 0 if distanceI==.

*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weight2 = .3358 if maxleader==leaderA
replace weight2 = .3264 if maxleader==leaderB
replace weight2 = .1073 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderD
replace weight2 = .2306 if maxleader==leaderE

gen ALP2 = sqrt((.3358*(distanceA^2)) + (.3264*(distanceB^2)) + (.1073*(distanceC^2)) + (0*(distanceD^2)) + (.2306*(distanceE^2)) + (weight2*maxleader) )
replace ALP2=. if nleader==0
*ALP2 4.6069 / sd 2.0167





***Party missing E F I 

recode B3037_A (96/99=.), gen(partyA)
recode B3037_B (96/99=.), gen(partyB)
recode B3037_C (96/99=.), gen(partyC)
recode B3037_D (96/99=.), gen(partyD)
recode B3037_G (96/99=.), gen(partyG)
recode B3037_H (96/99=.), gen(partyH)

**Weight (it includes the percentage of vote)
* A 18.4 / B 14.3 / C 13.4 / D 13.4 / G 5.1 / F 4.6
*W 1 / .70 / .64 / .64 / .04 / 0	

egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty
***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.70 if maxparty == partyB
replace weightp = 0.64 if maxparty == partyC
replace weightp = 0.64 if maxparty == partyD
replace weightp = 0.04 if maxparty == partyG
replace weightp = 0 if maxparty == partyH

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
**AP 3.5527 / sd 2.9688

gen distancepA = maxparty-partyA
gen distancepB = maxparty-partyB
gen distancepC = maxparty-partyC
gen distancepD = maxparty-partyD
gen distancepE = maxparty-partyE
gen distancepF = maxparty-partyF
gen distancepG = maxparty-partyG
gen distancepH = maxparty-partyH
gen distancepI = maxparty-partyI

replace distancepA= 0 if distancepA==.
replace distancepB= 0 if distancepB==.
replace distancepC= 0 if distancepC==.
replace distancepD= 0 if distancepD==.
replace distancepE= 0 if distancepE==.
replace distancepF= 0 if distancepF==.
replace distancepG= 0 if distancepG==.
replace distancepH= 0 if distancepH==.
replace distancepI= 0 if distancepI==.
*missing E F I 

*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weightp2 = .3317 if maxparty == partyA
replace weightp2 = .2332 if maxparty == partyB
replace weightp2 = .2115 if maxparty == partyC
replace weightp2 = .2115 if maxparty == partyD
replace weightp2 = .0120 if maxparty == partyG
replace weightp2 = 0 if maxparty == partyH


gen AP2 = sqrt((.2719*(distancepA^2)) +(.1911*(distancepB^2)) + (.1734*(distancepC^2)) + (.1734*(distancepD^2)) + (.0099*(distancepG^2)) + (0*(distancepH^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 3.5175 / sd 1.9561







