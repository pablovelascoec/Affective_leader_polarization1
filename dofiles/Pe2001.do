use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses1.dta"
keep if A1004== "PER_2001"

***missing G H I 
recode A3021_A (96/99=.), gen(leaderA)
recode A3021_B (96/99=.), gen(leaderB)
recode A3021_C (96/99=.), gen(leaderC)
recode A3021_D (96/99=.), gen(leaderD)
recode A3021_E (96/99=.), gen(leaderE)
recode A3021_F (96/99=.), gen(leaderF)

***Calculating weight
gen fameA = 1 if A3021_A == 96 | A3021_A == 98
gen fameB = 1 if A3021_B == 96 | A3021_B == 98
gen fameC = 1 if A3021_C == 96 | A3021_C == 98
gen fameD = 1 if A3021_D == 96 | A3021_D == 98
gen fameE = 1 if A3021_E == 96 | A3021_E == 98
gen fameF = 1 if A3021_F == 96 | A3021_F == 98
* 10 / 13 / 28 / 36 / 65 / 297

*W 1 / .99 / .94 / .91 / 0.81 / 0

egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader

gen weight = 1 if maxleader == leaderA
replace weight = .99 if maxleader == leaderB
replace weight = .94 if maxleader == leaderC
replace weight = .91 if maxleader == leaderD
replace weight = .81 if maxleader == leaderE
replace weight = 0 if maxleader == leaderF

***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
**ALP 5.5658 / sd 2.3198


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
gen weight2 = .2153 if maxleader==leaderA
replace weight2 = .2131 if maxleader==leaderB
replace weight2 = .2018 if maxleader==leaderC
replace weight2 = .1958 if maxleader==leaderD
replace weight2 = .1740 if maxleader==leaderE
replace weight2 = 0 if maxleader==leaderF

gen ALP2 = sqrt((.2153*(distanceA^2)) + (.2131*(distanceB^2)) + (.2018*(distanceC^2)) + (.1958*(distanceD^2)) + (.1740*(distanceE^2)) + (0*(distanceF^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
***ALP2 5.18 / sd 1.9694








***Party missing G H I 

recode A3020_A (96/99=.), gen(partyA)
recode A3020_B (96/99=.), gen(partyB)
recode A3020_C (96/99=.), gen(partyC)
recode A3020_D (96/99=.), gen(partyD)
recode A3020_E (96/99=.), gen(partyE)
recode A3020_F (96/99=.), gen(partyF)

**Weight (it includes the percentage of vote)
* A 26.2 / B 19.7 / C 13.8 / D 10.9 / E 3.5 / F 1.3
*W 1 / .74 / .50 / .39 / .09 / 0	

egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.74 if maxparty == partyB
replace weightp = 0.50 if maxparty == partyC
replace weightp = 0.39 if maxparty == partyD
replace weightp = 0.09 if maxparty == partyE
replace weightp = 0 if maxparty == partyF

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
**AP 4.0922 / sd 2.4924


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
gen weightp2 = .3683 if maxparty == partyA
replace weightp2 = .2722 if maxparty == partyB
replace weightp2 = .1849 if maxparty == partyC
replace weightp2 = .1420 if maxparty == partyD
replace weightp2 = .0325 if maxparty == partyE
replace weightp2 = .0 if maxparty == partyF

gen AP2 = sqrt((.3683*(distancepA^2)) +(.2722*(distancepB^2)) + (.1849*(distancepC^2)) + (.1420*(distancepD^2)) + (.0325*(distancepE^2)) + (0*(distancepF^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 4.8472 / sd 1.9367



