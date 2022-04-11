clear all
set more off

import delimited "qdata.csv"

xtset country time



*sets gdpcap to millions for ease of understanding
gen gdpcaplm = gdpcaplog/1000000

* * * * * * generate all _i lags needed * * * * * *

*** pi ***
gen piL4=pi[_n-4]
gen pinegL4=pineg[_n-4]
gen pizlbL4=pizlb[_n-4]

*** di ***
gen diL4=di[_n-4]
gen dinegL4=dineg[_n-4]
gen dizlbL4=dizlb[_n-4]

* * * * * * control lags needed * * * * * *
gen uL2=u[_n-2]
gen ptaxL2=ptax[_n-2]
gen intbL2=intb[_n-2]



* * * * * * models * * * * * *



*** GDP-(pi) ***
xtreg gdpcaplm piL4 pizlbL4 pinegL4 uL2 L.cspend cconf trade ptaxL2 i.time,fe vce(cluster country)

*** GDP-(di)***
xtreg gdpcaplm diL4 dizlbL4 dinegL4 uL2 L.cspend cconf trade ptaxL2 i.time,fe vce(cluster country)



*** bbs-(pi) ***
xtreg bbs piL4 pizlbL4 pinegL4 loan hpi uL2 cspend cconf i.time,fe vce(cluster country)

*** bbs-(di) ***
xtreg bbs diL4 dizlbL4 dinegL4 loan hpi uL2 cspend cconf i.time,fe vce(cluster country)



*** loan-(pi) ***
xtreg loan piL4 pizlbL4 pinegL4 L.u cconf hpi intbL2 i.time,fe vce(cluster country)

*** loan-(di) ***
xtreg loan diL4 dizlbL4 dinegL4 L.u cconf hpi intbL2 i.time,fe vce(cluster country)
