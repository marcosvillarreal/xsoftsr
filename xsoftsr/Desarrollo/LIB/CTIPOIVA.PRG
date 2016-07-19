*-- DEVUELVE EL TIPO DE IVA A PARTIR DEL CÓDIGO DE IVA --
parameters tcTipoIva
local lnIVA
lnIVA=val(tcTipoIva)
local laIVA(6)
laIVA(1)='RI'
laIVA(2)='RNI'
laIVA(3)='CF'
laIVA(4)='E'
laIVA(5)='NR'
laIVA(6)='RIL'
return iif(lnIVA>0 and lnIVA<=6,laIVA(lnIVA),'N/D')