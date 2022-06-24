use "C:\Users\Acer\Desktop\dashboardelectoral\shiny_workshops\Affective_Leader_Polarization\Data\cses1.dta"
keep if A1004 == "MEX_2000"

***Leader only ABC (IMPORTANT TO INTERPRET WITH CAUTION THE MEASURE)
recode A3021_A (96/99=.), gen(leaderA)
recode A3021_B (96/99=.), gen(leaderB)
recode A3021_C (96/99=.), gen(leaderC)
***Calculating weight
gen fameA = 1 if A3021_A == 99 | A3021_A == 98
gen fameB = 1 if A3021_B == 99 | A3021_B == 98
gen fameC = 1 if A3021_C == 99 | A3021_C == 98
*Wow to many missing values 
*959 / 781 / 731
*W 0 / .78 / 1
egen nleader =  anycount(leader*), value(0/10)
egen maxleader=rowmax(leader*)
egen sumleader= rowtotal(leader*)
gen meanleader= (sumleader-maxleader)/nleader
gen weight = 0 if maxleader == leaderA
replace weight = .78 if maxleader == leaderB
replace weight = 1 if maxleader == leaderC
***Weighted ALP (index could go from 0 to 10)
gen ALP = abs(maxleader-meanleader)*weight
**ALP 
gen distanceA = maxleader-leaderA
gen distanceB = maxleader-leaderB
gen distanceC = maxleader-leaderC
replace distanceA= 0 if distanceA==.
replace distanceB= 0 if distanceB==.
replace distanceC= 0 if distanceC==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weight2 = 0 if maxleader==leaderA
replace weight2 = .4384 if maxleader==leaderB
replace weight2 = .5616 if maxleader==leaderC

gen ALP2 = sqrt((0*(distanceA^2)) + (.4384*(distanceB^2)) + (.5616*(distanceC^2)) + (weight2*maxleader) )
replace ALP2=. if nleader==0
*ALP2 2.3509


***Party A B C F (only those have voting share in Lower Chamber)
recode A3020_A (96/99=.), gen(partyA)
recode A3020_B (96/99=.), gen(partyB)
recode A3020_C (96/99=.), gen(partyC)
recode A3020_E (96/99=.), gen(partyF)
* Lower chamber vote
* 38.2 / 36.9 / 18.6 / 0.7
* W 1 / .66 / .63 / .03 / 0
egen nparty =  anycount(party*), value(0/10)
egen maxparty=rowmax(party*)
egen sumparty= rowtotal(party*)
gen meanparty= (sumparty-maxparty)/nparty
***stablishing weight 
gen weightp = 1 if maxparty == partyA
replace weightp = 0.97 if maxparty == partyB
replace weightp = 0.48 if maxparty == partyC
replace weightp = 0 if maxparty == partyF
***Weighted AP (index could go from 1 to 10)
gen AP = abs(maxparty-meanparty)*weightp	
**AP 
gen distancepA = maxparty-partyA
gen distancepB = maxparty-partyB
gen distancepC = maxparty-partyC
gen distancepF = maxparty-partyF
replace distancepA= 0 if distancepA==.
replace distancepB= 0 if distancepB==.
replace distancepC= 0 if distancepC==.
replace distancepF= 0 if distancepF==.
*wheight2 is the weight transformed to numbers that together sum up to 1 
gen weightp2 = .4094 if maxparty == partyA
replace weightp2 = .3942 if maxparty == partyB
replace weightp2 = .1954 if maxparty == partyC
replace weightp2 = 0 if maxparty == partyF
gen AP2 = sqrt((.4094*(distancepA^2)) +(.3942*(distancepB^2)) + (.1954*(distancepC^2)) + (0*(distancepF^2)) + (weightp2*maxparty))
replace AP2=. if nparty==0
*AP2 3.8094 / sd 2.3275