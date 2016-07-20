CLOSE DATABASES
CLOSE TABLES
OPEN DATABASE ? EXCLUSIVE

SET SAFETY OFF

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON

SET DATABASE TO DATOS

USE datos!producto IN 0 ALIAS CsrProducto EXCLUSIVE

USE datos!variedad IN 0 ALIAS CsrVariedad EXCLUSIVE
ZAP IN CsrVariedad

USE datos!subproducto IN 0 ALIAS CsrSubProducto EXCLUSIVE
ZAP IN CsrSubProducto



SET SAFETY ON

USE  "\starossa\detaboni" in 0 alias CsrDetaBoni EXCLUSIVE
*** inicalizamos variables
lnidvari=1
lnidsub=1

SELECT distinct detalle FROM CsrDetaboni;
group BY detalle  ORDER BY detalle INTO CURSOR CsrAuxVari

SELECT CsrVariedad
Oavisar.proceso('S','Procesando '+alias()) 
SELECT CsrAuxVari

SCAN 
	IF VAL(CsrAuxVari.detalle)=0
	 lcdetalle=CsrAuxVari.detalle
	 DO CASE 
		CASE CsrAuxVari.detalle = "POM.ROSADO" 
			lcdetalle="POMELO ROSADO"
		CASE CsrAuxVari.detalle = "POM/ROSADO"
			lcdetalle="POMELO ROSADO"
		CASE CsrAuxVari.detalle = "POMELO/ROS"
			lcdetalle="POMELO ROSADO"
		CASE CsrAuxVari.detalle ="ARCTIC ICE"
			lcdetalle="ARTIC ICE"
		CASE CsrAuxVari.detalle = "CAB. SAUV"
			lcdetalle = "CABERNET SAUVIGNON"
		CASE CsrAuxVari.detalle = "CABERN/SOU"
			lcdetalle = "CABERNET SAUVIGNON"
		CASE CsrAuxVari.detalle = "CABER.SAUB"
			lcdetalle = "CABERNET SAUVIGNON"
		CASE CsrAuxVari.detalle = "CAB.SAUVIG"
			lcdetalle = "CABERNET SAUVIGNON"
		CASE CsrAuxVari.detalle = "MANZ/ROJA"
			lcdetalle = "MANZANA ROJA"
		CASE CsrAuxVari.detalle = "MANZ.ROJA"
			lcdetalle = "MANZANA ROJA"
		CASE CsrAuxVari.detalle = "DULC.LECHE"
			lcdetalle = "DULCE DE LECHE"
		CASE CsrAuxVari.detalle = "TOMATE MED"
			lcdetalle = "TOMATE MEDITERRANEO"
		CASE CsrAuxVari.detalle = "TOM/MEDIT"
			lcdetalle = "TOMATE MEDITERRANEO"
		CASE CsrAuxVari.detalle = "NAR/DURAZ"
			lcdetalle = "NARANJA Y DURAZNO"
		CASE CsrAuxVari.detalle = "DUR/NARANJ"
			lcdetalle = "NARANJA Y DURAZNO"
		CASE CsrAuxVari.detalle ="PAN Y CEB"
			lcdetalle = "PANCETA Y CEBOLLA"
		CASE CsrAuxVari.detalle = "TUCO CLAS"
			lcdetalle = "TUCO CLASICO"
		CASE CsrAuxVari.detalle ="BANANA-ANA"
			lcdetalle = "BANANA Y ANA"
		CASE CsrAuxVari.detalle ="QUESO/JAM"
			lcdetalle = "QUESO Y JAMON"
		CASE CsrAuxVari.detalle = "CAB.MERLOT"
			lcdetalle = "CABERNET MERLOT"
		CASE CsrAuxVari.detalle = "PECH/POLLO"
			lcdetalle = "PECHUGA DE POLLO"
		CASE CsrAuxVari.detalle = "NAR/LIGHT"
			lcdetalle =	"NARANJA LIGHT"
		CASE CsrAuxVari.detalle = "FRUT.TROPI"
			lcdetalle = "FRUTAS TROPICALES"
		CASE CsrAuxVari.detalle = "POLLO/ES/Z"
			lcdetalle = "POLLO ESPINACA ZAPALLO"
		CASE CsrAuxVari.detalle = "POLLO/ESPI"
			lcdetalle = "POLLO Y ESPINACA"
		CASE CsrAuxVari.detalle = "NAR/LIMON"
			lcdetalle = "NARANJA Y LIMON"
		CASE CsrAuxVari.detalle = "LIMON/LIGH"
			lcdetalle = "LIMON LIGHT"
		CASE CsrAuxVari.detalle = "POMELO/LIG"
			lcdetalle = "POMELO LIGHT"
		CASE CsrAuxVari.detalle = "ESP/CREMA"
			lcdetalle ="ESPINACA CON CREMA"
		CASE CsrAuxVari.detalle = "CHARDONAY"
			lcdetalle ="CHARDONNAY"
		CASE CsrAuxVari.detalle = "SAUV/MERLO"
			lcdetalle ="SAUVIGNON MERLOT"
		CASE CsrAuxVari.detalle = "VERDURAS"
			lcdetalle ="VERDURA"
	 ENDCASE
		SELECT CsrVariedad
		LOCATE FOR nombre=lcdetalle
		IF !FOUND()
			INSERT INTO CsrVariedad (id,numero,nombre,tag);
			VALUES (lnidvari,lnidvari,lcdetalle,"0000000000")
			lnidvari=lnidvari+1
		endif
	ENDIF
	
ENDSCAN
SELECT CsrSubproducto
Oavisar.proceso('S','Procesando '+alias())
SELECT numero,detalle FROM CsrDetaboni;
ORDER BY numero,detalle INTO CURSOR CsrAux2 
SELECT CsrAux2
SCAN
	SELECT CsrProducto
	LOCATE FOR numero = CsrAux2.numero
	IF FOUND()
		lnidart=CsrProducto.id
		lnnum=CsrProducto.numero
		SELECT CsrVariedad
		LOCATE FOR nombre = CsrAux2.detalle
		IF FOUND()
			lnidvari=CsrVariedad.id
			lnsubnum=CsrVariedad.numero
			lcnom=CsrVariedad.nombre
			
			INSERT INTO SubProducto (id,idarticulo,numero,subnumero,idvariedad,nombre,codigo,troquel,nofactura);
			VALUES (lnidsub,lnidart,lnnum,lnsubnum,lnidvari,lcnom,"0","00000000",0)
			
			lnidsub=lnidsub+1
		ENDIF
		
	ENDIF
	SELECT Csraux2
	
ENDSCAN


Oavisar.proceso('N') 
=MESSAGEBOX('Proceso terminado! ')
CLOSE tables
CLOSE INDEXES
CLOSE DATABASES
