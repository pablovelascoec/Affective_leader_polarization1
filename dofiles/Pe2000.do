use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses1.dta"
keep if A1004== "PER_2000"

***missing G H I 
recode A3021_A (96/99=.), gen(leaderA)
recode A3021_B (96/99=.), gen(leaderB)
recode A3021_C (96/99=.), gen(leaderC)
recode A3021_D (96/99=.), gen(leaderD)
recode A3021_E (96/99=.), gen(leaderE)
recode A3021_F (96/99=.), gen(leaderF)

***Calculating weight
gen fameA = 1 if A3021_A == 99 | A3021_A == 98
gen fameB = 1 if A3021_B == 99 | A3021_B == 98
gen fameC = 1 if A3021_C == 99 | A3021_C == 98
gen fameD = 1 if A3021_D == 99 | A3021_D == 98
gen fameE = 1 if A3021_E == 99 | A3021_E == 98
gen fameF = 1 if A3021_F == 99 | A3021_F == 98
* 18 / 219 / 114 / 74 / 437 / 93

*W 1 / .52 / .77 / .87 / 0 / .82

egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader

gen weight = 1 if maxleader == leaderA
replace weight = .52 if maxleader == leaderB
replace weight = .77 if maxleader == leaderC
replace weight = .87 if maxleader == leaderD
replace weight = 0 if maxleader == leaderE
replace weight = .82 if maxleader == leaderF

***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
**ALP 4.4748 / sd 2.3617

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
gen weight2 = .2513 if maxleader==leaderA
replace weight2 = .1308 if maxleader==leaderB
replace weight2 = .1938 if maxleader==leaderC
replace weight2 = .2178 if maxleader==leaderD
replace weight2 = 0 if maxleader==leaderE
replace weight2 = .2064 if maxleader==leaderF

gen ALP2 = sqrt((.2513*(distanceA^2)) + (.1308*(distanceB^2)) + (.1938*(distanceC^2)) + (.2178*(distanceD^2)) + (0*(distanceE^2)) + (.2064*(distanceF^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
****ALP2 4.8396 / 1.9019







***Party missing G H I 

recode A3020_A (96/99=.), gen(partyA)
recode A3020_B (96/99=.), gen(partyB)
recode A3020_C (96/99=.), gen(partyC)
recode A3020_D (96/99=.), gen(partyD)
recode A3020_E (96/99=.), gen(partyE)
recode A3020_F (96/99=.), gen(partyF)


**Weight (it includes the percentage of vote)
* A Peru2000 42.2 / B PP 23.3 / FIM C 7.5 / SP D 7.2 / E 5.5 / F 4
*W 1 / .51 / .09 / .08 / .04 / 0	

egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.51 if maxparty == partyB
replace weightp = 0.09 if maxparty == partyC
replace weightp = 0.08 if maxparty == partyD
replace weightp = 0.04 if maxparty == partyE
replace weightp = 0 if maxparty == partyF

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
**AP 3.7597 / sd 3.0564


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

*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weightp2 = .5814 if maxparty == partyA
replace weightp2 = .2938 if maxparty == partyB
replace weightp2 = .0533 if maxparty == partyC
replace weightp2 = .0487 if maxparty == partyD
replace weightp2 = .0228 if maxparty == partyE
replace weightp2 = .0 if maxparty == partyF

gen AP2 = sqrt((.5814*(distancepA^2)) +(.2938*(distancepB^2)) + (.0533*(distancepC^2)) + (.0487*(distancepD^2)) + (.0228*(distancepE^2)) + (0*(distancepF^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
****AP2 5.000 / sd 2.0359
