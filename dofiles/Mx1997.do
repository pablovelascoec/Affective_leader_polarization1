use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses1.dta"
keep if A1004 == "MEX_1997"

***Leader only ABC (IMPORTANT TO INTERPRET WITH CAUTION THE MEASURE)
recode A3021_A (96/99=.), gen(leaderA)
recode A3021_B (96/99=.), gen(leaderB)
recode A3021_C (96/99=.), gen(leaderC)
***Calculating weight
gen fameA = 1 if A3021_A == 99 | A3021_A == 98
gen fameB = 1 if A3021_B == 99 | A3021_B == 98
gen fameC = 1 if A3021_C == 99 | A3021_C == 98
*140 / 558 / 303
*W 1 / 0 / .61
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = 1 if maxleader == leaderA
replace weight = 0 if maxleader == leaderB
replace weight = .61 if maxleader == leaderC
***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
**ALP 3.4543
gen distanceA = maxleader-leaderA
gen distanceB = maxleader-leaderB
gen distanceC = maxleader-leaderC
replace distanceA= 0 if distanceA==.
replace distanceB= 0 if distanceB==.
replace distanceC= 0 if distanceC==.

*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weight2 = .6211 if maxleader==leaderA
replace weight2 = 0 if maxleader==leaderB
replace weight2 = .3789 if maxleader==leaderC

gen ALP2 = sqrt((.6211*(distanceA^2)) + (0*(distanceB^2)) + (.3789*(distanceC^2)) + (weight2*maxleader) )
replace ALP2=. if nleader==0
*ALP2 2.8401



***Party missing G H I / but F did not participate in Lower House
recode A3020_A (96/99=.), gen(partyA)
recode A3020_B (96/99=.), gen(partyB)
recode A3020_C (96/99=.), gen(partyC)
recode A3020_D (96/99=.), gen(partyD)
recode A3020_E (96/99=.), gen(partyE)
* Lower chamber vote
* 38 / 	25.8 / 24.9 / 3.7 / 2.5 / 
* W 1 / .66 / .63 / .03 / 0
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty
***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.66 if maxparty == partyB
replace weightp = 0.63 if maxparty == partyC
replace weightp = 0.03 if maxparty == partyD
replace weightp = 0 if maxparty == partyE
***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
**AP 
gen distancepA = maxparty-partyA
gen distancepB = maxparty-partyB
gen distancepC = maxparty-partyC
gen distancepD = maxparty-partyD
gen distancepE = maxparty-partyE
replace distancepA= 0 if distancepA==.
replace distancepB= 0 if distancepB==.
replace distancepC= 0 if distancepC==.
replace distancepD= 0 if distancepD==.
replace distancepE= 0 if distancepE==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weightp2 = .4308 if maxparty == partyA
replace weightp2 = .2828 if maxparty == partyB
replace weightp2 = .2718 if maxparty == partyC
replace weightp2 = .0146 if maxparty == partyD
replace weightp2 = 0 if maxparty == partyE
gen AP2 = sqrt((.4308*(distancepA^2)) +(.2828*(distancepB^2)) + (.2718*(distancepC^2)) + (.0146*(distancepD^2)) + (0*(distancepE^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 3.9322 / sd 2.3102





