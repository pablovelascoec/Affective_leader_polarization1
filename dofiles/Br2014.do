
use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses4.dta"
keep if D1004 == "BRA_2014"

recode D3012_A (96/99=.), gen(leaderA)
recode D3012_B (96/99=.), gen(leaderB)
recode D3012_C (96/99=.), gen(leaderC)
recode D3012_D (96/99=.), gen(leaderD)
**Missing leaderD
recode D3012_E (96/99=.), gen(leaderE)
recode D3012_F (96/99=.), gen(leaderF)
recode D3012_G (96/99=.), gen(leaderG)
recode D3012_H (96/99=.), gen(leaderH)
**missing leaderH
recode D3012_I (96/99=.), gen(leaderI)

***Calculating weight
gen fameA = 1 if D3012_A == 96 | D3012_A == 98
gen fameB = 1 if D3012_B == 96 | D3012_B == 98
gen fameC = 1 if D3012_C == 96 | D3012_C == 98
gen fameE = 1 if D3012_E == 96 | D3012_E == 98
gen fameF = 1 if D3012_F == 96 | D3012_F == 98
gen fameG = 1 if D3012_G == 96 | D3012_G == 98
gen fameI = 1 if D3012_I == 96 | D3012_I == 98

**fameA 86 / fameB 157 / fameC 1078 / fameE 211 / fameF 1129 / fameG 940 / fameI 1602
**Normalization min-max (86-1602) -- (don't forget rotate afterwards) 
*weight1fame == x-86/1602-86 
* A 0 / B 0.05 / C .65 / E .08 / F .69 / G .56 / I 1

*WEIGHT A 1 / B .95 / C .35 / E .92 / F .31 / G .44 / I .00 


****We generate the variables for the index max and mean
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
***stablishing weight 
gen weight = 1 if maxleader == leaderA
replace weight = 0.95 if maxleader == leaderB
replace weight = 0.35 if maxleader == leaderC
replace weight = 0.92 if maxleader == leaderE
replace weight = 0.31 if maxleader == leaderF
replace weight = 0.44 if maxleader == leaderG
replace weight = 0 if maxleader == leaderI

***Weighted ALP (index could go from 1 to 10)
gen ALP = abs(maxleader-meanleader)*weight	
***ALP 4.7186 / sd 2.5555


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
gen weight2 = .2522 if maxleader==leaderA
replace weight2 = .2404 if maxleader==leaderB
replace weight2 = .0872 if maxleader==leaderC
replace weight2 = .2314 if maxleader==leaderE
replace weight2 = .0787 if maxleader==leaderF
replace weight2 = .1101 if maxleader==leaderG
replace weight2 = 0 if maxleader==leaderI

gen ALP2 = sqrt((.2522*(distanceA^2)) + (.2404*(distanceB^2)) + (.0872*(distanceC^2)) + (.2314*(distanceE^2)) + (.0787*(distanceF^2)) + (.1101*(distanceG^2)) + (0*(distanceI^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
*ALP2 3.9550 / sd 1.9895




**********Same for parties 
*missing DH 

recode D3011_A (96/99=.), gen(partyA)
recode D3011_B (96/99=.), gen(partyB)
recode D3011_C (96/99=.), gen(partyC)
recode D3011_E (96/99=.), gen(partyE)
recode D3011_F (96/99=.), gen(partyF)
recode D3011_G (96/99=.), gen(partyG)
recode D3011_I (96/99=.), gen(partyI)

***Lower house vote
*Weight A 1 / B .74 / C .71 / E .23 / F .20 / G .16 / I 0

**
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.74 if maxparty == partyB
replace weightp = 0.71 if maxparty == partyC
replace weightp = 0.23 if maxparty == partyE
replace weightp = 0.20 if maxparty == partyF
replace weightp = 0.16 if maxparty == partyG
replace weightp = 0 if maxparty == partyI

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
***AP 3.4554 / sd 2.8276

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
gen weightp2 = .3291 if maxparty == partyA
replace weightp2 = .2429 if maxparty == partyB
replace weightp2 = .2331 if maxparty == partyC
replace weightp2 = .0757 if maxparty == partyE
replace weightp2 = .0655 if maxparty == partyF
replace weightp2 = .0537 if maxparty == partyG
replace weightp2 = 0 if maxparty == partyI

gen AP2 = sqrt((.3291*(distancepA^2)) +(.2429*(distancepB^2)) + (.2331*(distancepC^2)) + (.0757*(distancepE^2)) + (.0655*(distancepF^2)) + (.0537*(distancepG^2))+(0*(distancepI^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 3.1184 / sp 2.1826