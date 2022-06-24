use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses5.dta"
keep if E1004 == "BRA_2018"

**leaders missing D E G H I // appear A B C F // A Bolsonaro / B Haddad / C Alckmin / F Meirelles 

recode E3018_A (96/99=.), gen(leaderA)
recode E3018_B (96/99=.), gen(leaderB)
recode E3018_C (96/99=.), gen(leaderC)
recode E3018_F (96/99=.), gen(leaderF)

***Calculating weight
**1) min max missing values
gen fameA = 1 if E3018_A == 96 | E3018_A == 98
gen fameB = 1 if E3018_B == 96 | E3018_B == 98
gen fameC = 1 if E3018_C == 96 | E3018_C == 98
gen fameF = 1 if E3018_F == 96 | E3018_F == 98

**fameA 169/ fameB 226 / fameC 350 / fameF 834
**Weight (rotated) A 1 / B 0.91 / C 0.73 / F 0

egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader

***stablishing weight 
gen weight = 1 if maxleader == leaderA
replace weight = 0.91 if maxleader == leaderB
replace weight = 0.73 if maxleader == leaderC
replace weight = 0 if maxleader == leaderF

***Weighted ALP (index could go from 1 to 10)
gen ALP = abs(maxleader-meanleader)*weight
***ALP 5.2234 / sd 3.0841


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
gen weight2 = .3785 if maxleader==leaderA
replace weight2 = .3460 if maxleader==leaderB
replace weight2 = .2755 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderF

gen ALP2 = sqrt((.3785*(distanceA^2)) + (.3460*(distanceB^2)) + (.2755*(distanceC^2)) + (0*(distanceF^2)) + (weight2*maxleader))
replace ALP2=. if nleader==0
**ALP2 4.3835 /  sd 2.4179







**********Same for parties 
*no missing 
*PSL / PT / PSDB / PSD / PP / MDB / PSB / PR / PRB (see identifiers E5000_*) 

recode E3017_A (96/99=.), gen(partyA)
recode E3017_B (96/99=.), gen(partyB)
recode E3017_C (96/99=.), gen(partyC)
recode E3017_D (96/99=.), gen(partyD)
recode E3017_E (96/99=.), gen(partyE)
recode E3017_F (96/99=.), gen(partyF)
recode E3017_G (96/99=.), gen(partyG)
recode E3017_H (96/99=.), gen(partyH)
recode E3017_I (96/99=.), gen(partyI)

***Weight with vote shars for legislative normalized (chamber of deputes) (see results 2018)
*PSL 11.92% / PT 10.37% / PSDB 6.05% / PSD 5.89% / PP 5.61% / MDB 5.57% / PSB 5.52% / PR 5.35% / PRB 5.11%
*Weight A 1 / B .77 / C .14 / D .11 / E .07 / F .07 / G .06 / h .04 / I .00

**
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty

***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.77 if maxparty == partyB
replace weightp = 0.14 if maxparty == partyC
replace weightp = 0.11 if maxparty == partyD
replace weightp = 0.07 if maxparty == partyE
replace weightp = 0.07 if maxparty == partyF
replace weightp = 0.05 if maxparty == partyG
replace weightp = 0.04 if maxparty == partyH
replace weightp = 0 if maxparty == partyI

***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
*AP 2.6908 / sd 3.0011



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
gen weightp2 = .4422 if maxparty == partyA
replace weightp2 = .3416 if maxparty == partyB
replace weightp2 = .0610 if maxparty == partyC
replace weightp2 = .0506 if maxparty == partyD
replace weightp2 = .0325 if maxparty == partyE
replace weightp2 = .0299 if maxparty == partyF
replace weightp2 = .0266 if maxparty == partyG
replace weightp2 = .0156 if maxparty == partyH
replace weightp2 = 0 if maxparty == partyI

gen AP2 = sqrt((.4422*(distancepA^2)) +(.3416*(distancepB^2)) + (.0610*(distancepC^2)) + (.0506*(distancepD^2)) + (.0325*(distancepE^2)) + (.0299*(distancepF^2)) + (.0266*(distancepG^2)) + (.0156*(distancepH^2)) + (0*(distancepI^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
**AP2 3.1098 / sd 2.3205

