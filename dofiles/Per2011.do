****No information for Peru 2006
use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses2.dta"
keep if B1004 =="PER_2006"

*2011 
use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses3.dta"
keep if C1004== "PER_2011"

**** leaders missing F G H I
recode C3010_A (96/99=.), gen(leaderA)
recode C3010_B (96/99=.), gen(leaderB)
recode C3010_C (96/99=.), gen(leaderC)
recode C3010_D (96/99=.), gen(leaderD)
recode C3010_E (96/99=.), gen(leaderE)
***Calculating weight
gen fameA = 1 if C3010_A == 96 | C3010_A == 98
gen fameB = 1 if C3010_B == 96 | C3010_B == 98
gen fameC = 1 if C3010_C == 96 | C3010_C == 98
gen fameD = 1 if C3010_D == 96 | C3010_D == 98
gen fameE = 1 if C3010_E == 96 | C3010_E == 98

* A 87 / B 95 / C 119 / D 153 / E 127
* W A 1 / .88 / .52 / 0 / .39

****We generate the variables for the index max and mean
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader

gen weight = 1 if maxleader == leaderA
replace weight = .88 if maxleader == leaderB
replace weight = .52 if maxleader == leaderC
replace weight = 0 if maxleader == leaderD
replace weight = .39 if maxleader == leaderE

***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
****ALP 4.0006 / sd 3.1586

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
gen weight2 = .3587 if maxleader==leaderA
replace weight2 = .3152 if maxleader==leaderB
replace weight2 = .1848 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderD
replace weight2 = .1413 if maxleader==leaderE

gen ALP2 = sqrt((.3587*(distanceA^2)) + (.3152*(distanceB^2)) + (.1848*(distanceC^2)) + (.0*(distanceD^2)) + (.1413*(distanceE^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
***ALP2 5.1695 / sd 2.1348





***Party missing G H I 
recode C3009_A (96/99=.), gen(partyA)
recode C3009_B (96/99=.), gen(partyB)
recode C3009_C (96/99=.), gen(partyC)
recode C3009_D (96/99=.), gen(partyD)
recode C3009_E (96/99=.), gen(partyE)
recode C3009_F (96/99=.), gen(partyF)

**Weight (The DB includes votes by party on the Lower House)
* A 25.3 / B 23 / C 14.8 / D 14.4 / E 10.2 / F 6.4
* W A 1 / B.88 / C.44 / D.42 / E.20 / F0
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = .88 if maxparty == partyB
replace weightp = .44 if maxparty == partyC
replace weightp = .42 if maxparty == partyD
replace weightp = .28 if maxparty == partyE
replace weightp = 0 if maxparty == partyF

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
***AP 4.3402 / sd 2.8578


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
gen weightp2 = .3393 if maxparty == partyA
replace weightp2 = .2980 if maxparty == partyB
replace weightp2 = .1508 if maxparty == partyC
replace weightp2 = .1436 if maxparty == partyD
replace weightp2 = .0682 if maxparty == partyE
replace weightp2 = .0 if maxparty == partyF

gen AP2 = sqrt((.3393*(distancepA^2)) +(.2980*(distancepB^2)) + (.1508*(distancepC^2)) + (.1436*(distancepD^2)) + (.0682*(distancepE^2)) + (0*(distancepF^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 5.0261 / sd 2.1314

