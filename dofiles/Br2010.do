use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses3.dta"
keep if C1004== "BRA_2010"

**Leader missing B D E G H I // A C F

recode C3010_A (96/99=.), gen(leaderA)
recode C3010_C (96/99=.), gen(leaderC)
recode C3010_F (96/99=.), gen(leaderF)

***Calculating weight
gen fameA = 1 if C3010_A == 96 | C3010_A == 98
gen fameC = 1 if C3010_C == 96 | C3010_C == 98
gen fameF = 1 if C3010_F == 96 | C3010_F == 98
* A 32 / C 25 / F 452
* Wieght .98 / 1 / 0

****We generate the variables for the index max and mean
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = .98 if maxleader == leaderA
replace weight = 1 if maxleader == leaderC
replace weight = 0 if maxleader == leaderF

***Weighted ALP (index could go from 1 to 10)
gen ALP = abs(maxleader-meanleader)*weight
***ALP 4.8948 / sd 2.8613

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
gen weight2 = .4959 if maxleader==leaderA
replace weight2 = .5041 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderF

gen ALP2 = sqrt((.4959*(distanceA^2)) + (.5041*(distanceC^2)) + (0*(distanceF^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
*ALP2 3.7469 / sd 2.0704







****Party missing D F G 

recode C3009_A (96/99=.), gen(partyA)
recode C3009_B (96/99=.), gen(partyB)
recode C3009_C (96/99=.), gen(partyC)
recode C3009_E (96/99=.), gen(partyE)
recode C3009_H (96/99=.), gen(partyH)
recode C3009_I (96/99=.), gen(partyI)

**Weight (The DB includes votes by party on the Lower House)
* A PT 16.9 / PMDB 13 / PSDB 11.9 / E 7.53 / H 4.98 / I 4.17
*Weight A 1 / B .69 / C .61 / E .26 / H .06 / I 0

**
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.69 if maxparty == partyB
replace weightp = 0.61 if maxparty == partyC
replace weightp = 0.26 if maxparty == partyE
replace weightp = 0.06 if maxparty == partyH
replace weightp = 0 if maxparty == partyI


***Weighted AP (index could go from 0 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
***3.6268 / sd 2.7308


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
gen weightp2 = .3805 if maxparty == partyA
replace weightp2 = .2639 if maxparty == partyB
replace weightp2 = .2310 if maxparty == partyC
replace weightp2 = .1004 if maxparty == partyE
replace weightp2 = .0242 if maxparty == partyH
replace weightp2 = 0 if maxparty == partyI

*missing D F G
gen AP2 = sqrt((.3805*(distancepA^2)) +(.2639*(distancepB^2)) + (.2310*(distancepC^2)) + (.1004*(distancepE^2)) + (0.0242*(distancepH^2)) + (0*(distancepI^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP 3.4918 / sd 2.1502

