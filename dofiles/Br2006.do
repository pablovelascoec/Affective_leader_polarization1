use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses3.dta"
keep if C1004== "BRA_2006"

**Leader missing A D F G H // B C E I 

recode C3010_B (96/99=.), gen(leaderB)
recode C3010_C (96/99=.), gen(leaderC)
recode C3010_E (96/99=.), gen(leaderE)
recode C3010_I (96/99=.), gen(leaderI)

***Calculating weight
gen fameB = 1 if C3010_B == 96 | C3010_B == 98
gen fameC = 1 if C3010_C == 96 | C3010_C == 98
gen fameE = 1 if C3010_E == 96 | C3010_E == 98
gen fameI = 1 if C3010_I == 96 | C3010_I == 98
* B 14 / C 51 / E 183 / I 74
*Weight 1 / .78 / 0 / .64

****We generate the variables for the index max and mean
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = 1 if maxleader == leaderB
replace weight = .78 if maxleader == leaderC
replace weight = 0 if maxleader == leaderE
replace weight = .64 if maxleader == leaderI

***Weighted ALP (index could go from 0 to 10)
**ALP 4.7053 / sd 2.703

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
gen weight2 = .4122 if maxleader==leaderB
replace weight2 = .3220 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderE
replace weight2 = .2659 if maxleader==leaderI

gen ALP2 = sqrt((.4122*(distanceB^2)) + (.3220*(distanceC^2)) + (0*(distanceE^2)) + (.2659*(distanceI^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
*ALP2 3.9216 / sd 2.0588





***Party missing G H I 
recode C3009_A (96/99=.), gen(partyA)
recode C3009_B (96/99=.), gen(partyB)
recode C3009_C (96/99=.), gen(partyC)
recode C3009_D (96/99=.), gen(partyD)
recode C3009_E (96/99=.), gen(partyE)
recode C3009_F (96/99=.), gen(partyF)

**Weight (The DB includes votes by party on the Lower House)
* A PMDB 14.6 / B PT 15 / PSDB C 13.6 / PFL D 10.9 / E 5.2 / F 4.7

egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = .96 if maxparty == partyA
replace weightp = 1 if maxparty == partyB
replace weightp = 0.86 if maxparty == partyC
replace weightp = 0.60 if maxparty == partyD
replace weightp = 0.05 if maxparty == partyE
replace weightp = 0 if maxparty == partyF

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	

**AP 3.183 / sd 3.0164

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
gen weightp2 = .2765 if maxparty == partyA
replace weightp2 = .2877 if maxparty == partyB
replace weightp2 = .2486 if maxparty == partyC
replace weightp2 = .1732 if maxparty == partyD
replace weightp2 = .0142 if maxparty == partyE
replace weightp2 = 0 if maxparty == partyF

gen AP2 = sqrt((.2765*(distancepA^2)) +(.2877*(distancepB^2)) + (.2486*(distancepC^2)) + (.1732*(distancepD^2)) + (.0140*(distancepE^2)) + (0*(distancepF^2))+ (weightp2*maxparty))
replace AP2=. if nparty==0
**AP2 2.8191 / sd 2.3970
