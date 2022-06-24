use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses4.dta"
keep if D1004=="MEX_2012"

***leaders ABCF
recode D3012_A (96/99=.), gen(leaderA)
recode D3012_B (96/99=.), gen(leaderB)
recode D3012_C (96/99=.), gen(leaderC)
recode D3012_F (96/99=.), gen(leaderF)
*fame
gen fameA = 1 if D3012_A == 96 | D3012_A == 98
gen fameB = 1 if D3012_B == 96 | D3012_B == 98
gen fameC = 1 if D3012_C == 96 | D3012_C == 98
gen fameF = 1 if D3012_F == 96 | D3012_F == 98
* 76 / 85 / 72 / 191
*W .97 / .89 / 1 / 0
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = .97 if maxleader == leaderA
replace weight = .89 if maxleader == leaderB
replace weight = 1 if maxleader == leaderC
replace weight = 0 if maxleader == leaderF
gen ALP = abs(maxleader-meanleader)*weight
**ALP 
gen distanceA = maxleader-leaderA
gen distanceB = maxleader-leaderB
gen distanceC = maxleader-leaderC
gen distanceF = maxleader-leaderF
replace distanceA= 0 if distanceA==.
replace distanceB= 0 if distanceB==.
replace distanceC= 0 if distanceC==.
replace distanceF= 0 if distanceF==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weight2 = .3382 if maxleader==leaderA
replace weight2 = .3118 if maxleader==leaderB
replace weight2 = .35 if maxleader==leaderC
replace weight2 = 0 if maxleader==leaderF
gen ALP2 = sqrt((.3382*(distanceA^2)) + (.3118*(distanceB^2)) + (.35*(distanceC^2)) + (0*(distanceF^2)) + (weight2*maxleader) )
replace ALP2=. if nleader==0


***parties missing HI
recode D3011_A (96/99=.), gen(partyA)
recode D3011_B (96/99=.), gen(partyB)
recode D3011_C (96/99=.), gen(partyC)
recode D3011_D (96/99=.), gen(partyD)
recode D3011_E (96/99=.), gen(partyE)
recode D3011_F (96/99=.), gen(partyF)
recode D3011_G (96/99=.), gen(partyG)
* 31.93 / 25.89 / 18.35 / 6.12 / 4.59 / 4.08 / 4 
* W 1 / .78 / .51 / .08 / .02 / 0 / 0
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty
***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.78 if maxparty == partyB
replace weightp = 0.51 if maxparty == partyC
replace weightp = 0.08 if maxparty == partyD
replace weightp = 0.02 if maxparty == partyE
replace weightp = 0 if maxparty == partyF
replace weightp = 0 if maxparty == partyG
gen AP = abs(maxparty-meanparty)*weightp
gen distancepA = maxparty-partyA
gen distancepB = maxparty-partyB
gen distancepC = maxparty-partyC
gen distancepD = maxparty-partyD
gen distancepE = maxparty-partyE
gen distancepF = maxparty-partyF
gen distancepG = maxparty-partyG
replace distancepA= 0 if distancepA==.
replace distancepB= 0 if distancepB==.
replace distancepC= 0 if distancepC==.
replace distancepD= 0 if distancepD==.
replace distancepE= 0 if distancepE==.
replace distancepF= 0 if distancepF==.
replace distancepG= 0 if distancepG==.

*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weightp2 = .4171 if maxparty == partyA
replace weightp2 = .3269 if maxparty == partyB
replace weightp2 = .2143 if maxparty == partyC
replace weightp2 = .0317 if maxparty == partyD
replace weightp2 = .0088 if maxparty == partyE
replace weightp2 = .0012 if maxparty == partyF
replace weightp2 = 0 if maxparty == partyG
gen AP2 = sqrt((.4171*(distancepA^2)) +(.3269*(distancepB^2)) + (.2143*(distancepC^2)) + (.0317*(distancepD^2)) + (.0088*(distancepE^2)) + (.0012*(distancepF^2)) + (0*(distancepG^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
***AO2 4.0514 / 2.2477