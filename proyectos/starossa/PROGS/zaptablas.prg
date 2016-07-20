
CLOSE DATABASES
OPEN DATABASE ? EXCLUSIVE

SET SAFETY OFF

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON

SET DATABASE TO DATOS
USE datos!producto IN 0 ALIAS Csrproducto EXCLUSIVE
ZAP IN Csrproducto

USE datos!ctacte IN 0 ALIAS Csrctacte EXCLUSIVE
ZAP IN Csrctacte

USE datos!rubro IN 0 ALIAS Csrrubro EXCLUSIVE 
ZAP IN Csrrubro

USE datos!marca IN 0 ALIAS Csrmarca EXCLUSIVE
ZAP IN Csrmarca

USE datos!deposito IN 0 ALIAS Csrdeposito EXCLUSIVE
ZAP IN Csrdeposito

USE datos!fletero IN 0 ALIAS Csrfletero EXCLUSIVE
ZAP IN Csrfletero

USE datos!subproducto IN 0 ALIAS Csrsubproducto EXCLUSIVE
ZAP IN Csrsubproducto

USE datos!canalvta IN 0 ALIAS Csrcanalvta EXCLUSIVE 
ZAP IN Csrcanalvta

USE datos!zona IN 0 ALIAS Csrzona EXCLUSIVE
ZAP IN Csrzona

USE datos!vendedor IN 0 ALIAS CsrVendedor EXCLUSIVE
ZAP IN Csrvendedor

USE datos!cabepromo IN 0 ALIAS CsrCabepromo EXCLUSIVE 
ZAP IN CsrCabepromo

USE datos!cuerpromo IN 0 ALIAS Csrcuerpromo EXCLUSIVE 
ZAP IN CsrCuerpromo

USE datos!bonictacte IN 0 ALIAS CsrBonictacte EXCLUSIVE 
ZAP IN CsrBonictacte 

USE datos!bonivdor IN 0 ALIAS CsrBonivdor EXCLUSIVE 
ZAP IN CsrBonivdor

USE datos!keysid IN 0 ALIAS Csrkeysid EXCLUSIVE
ZAP IN Csrkeysid

USE datos!afectacte IN 0 ALIAS Csrafectacte EXCLUSIVE
ZAP IN Csrafectacte

USE datos!aferemito IN 0 ALIAS Csraferemito EXCLUSIVE
ZAP IN Csraferemito

USE datos!afetarjeta IN 0 ALIAS Csrafetarjeta EXCLUSIVE
ZAP IN Csrafetarjeta

USE datos!cabedeta IN 0 ALIAS Csrcabedeta EXCLUSIVE
ZAP IN Csrcabedeta

USE datos!cabefac IN 0 ALIAS Csrcabefac EXCLUSIVE
ZAP IN Csrcabefac

USE datos!cabeunifica IN 0 ALIAS Csrcabeunifica EXCLUSIVE
ZAP IN Csrcabeunifica

USE datos!cbantevdor IN 0 ALIAS Csrcbantevdor EXCLUSIVE
ZAP IN Csrcbantevdor

USE datos!cuerfac IN 0 ALIAS Csrcuerfac EXCLUSIVE
ZAP IN Csrcuerfac

USE datos!cuerunifica IN 0 ALIAS Csrcuerunifica EXCLUSIVE
ZAP IN Csrcuerunifica

USE datos!dcabefac IN 0 ALIAS Csrdcabefac EXCLUSIVE
ZAP IN Csrdcabefac

USE datos!dcuerfac IN 0 ALIAS CsrdCuerfac EXCLUSIVE
ZAP IN Csrdcuerfac

USE datos!dmaopera IN 0 ALIAS Csrdmaopera EXCLUSIVE
ZAP IN Csrdmaopera

USE datos!dpagos IN 0 ALIAS Csrdpagos EXCLUSIVE
ZAP IN Csrdpagos

USE datos!existenc IN 0 ALIAS Csrexistenc EXCLUSIVE
ZAP IN Csrexistenc

USE datos!fuerzavta IN 0 ALIAS Csrfuerzavta EXCLUSIVE
ZAP IN Csrfuerzavta

USE datos!maopera IN 0 ALIAS Csrmaopera EXCLUSIVE
ZAP IN Csrmaopera

USE datos!movcaja IN 0 ALIAS Csrmovcaja EXCLUSIVE
ZAP IN Csrmovcaja

USE datos!movctacte IN 0 ALIAS Csrmovctacte EXCLUSIVE
ZAP IN Csrmovctacte

USE datos!movstock IN 0 ALIAS Csrmovstock EXCLUSIVE
ZAP IN Csrmovstock

USE datos!movtarjeta IN 0 ALIAS Csrmovtarjeta EXCLUSIVE
ZAP IN Csrmovtarjeta

USE datos!rutavdor IN 0 ALIAS Csrrutavdor EXCLUSIVE
ZAP IN Csrrutavdor

USE datos!subctacte IN 0 ALIAS Csrsubctacte EXCLUSIVE
ZAP IN Csrsubctacte

USE datos!tablaasi IN 0 ALIAS Csrtablaasi EXCLUSIVE
ZAP IN Csrtablaasi

USE datos!tablaimp IN 0 ALIAS Csrtablaimp EXCLUSIVE
ZAP IN Csrtablaimp

USE datos!variedad IN 0 ALIAS Csrvariedad EXCLUSIVE
ZAP IN Csrvariedad

USE datos!caberuta IN 0 ALIAS Csrcaberuta EXCLUSIVE
ZAP IN Csrcaberuta

USE datos!cuerruta IN 0 ALIAS CsrCuerruta EXCLUSIVE
ZAP IN Csrcuerruta

USE datos!motanula IN 0 ALIAS Csrmotanula EXCLUSIVE
ZAP IN Csrmotanula

USE datos!zonaruta IN 0 ALIAS Csrzonaruta EXCLUSIVE
ZAP IN Csrzonaruta

SET SAFETY ON

CLOSE TABLES
CLOSE DATABASES