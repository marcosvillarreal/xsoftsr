CLOSE DATABASES
CLOSE TABLES
OPEN DATABASE ? EXCLUSIVE

SET SAFETY OFF

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON

SET DATABASE TO DATOS

USE datos!ctacte IN 0 ALIAS Csrctacte EXCLUSIVE
REPLACE ALL saldo WITH 0

USE datos!maopera IN 0 ALIAS CsrMaopera EXCLUSIVE
ZAP IN CsrMaopera

USE datos!movctacte IN 0 ALIAS CsrMovctacte EXCLUSIVE
ZAP IN CsrMovctacte



*USE datos!tablaasi IN 0 ALIAS CsrTablaasi EXCLUSIVE
*ZAP IN CsrTablaasi

SET SAFETY ON

USE  "\starossa\clientes" in 0 alias CsrDeudor EXCLUSIVE

USE  "\starossa\proveed" in 0 alias CsrAcreedor EXCLUSIVE

USE "\starossa\movipub" IN 0 ALIAS CsrMovipub EXCLUSIVE

USE  "\starossa\moviprov" in 0 alias CsrMoviprov EXCLUSIVE





*fecha de importacion
ldfecha=CTOD("30-06-2009")
lcfiscal=ALLTRIM(STR(YEAR(ldfecha)))+ALLTRIM(STR(MONTH(ldfecha)))+ALLTRIM(STR(DAY(ldfecha)))
lnidmaopera=1
SELECT CsrMaopera
IF RECCOUNT('CsrMaopera')>0
	GO bottom
	lnidmaopera=Csrmaopera.id+1
ENDIF

lnidmovctacte=1
SELECT CsrMovCtacte
IF RECCOUNT('CsrMovctacte')>0
	GO bottom
	lnidmovctacte=CsrMovctacte.id+1
ENDIF

ldfechasis=DATETIME(YEAR(ldfecha),MONTH(ldfecha),DAY(ldfecha),0,0,0)
ldfechas=DATETIME(YEAR(DATE()),MONTH(DATE()),DAY(DATE()),0,0,0)
		
		
SELECT Csrmovipub
SELECT distinct cliente,SUM(pago)as pago, SUM(importe) as importe;
, 00000000000.000 as saldo FROM Csrmovipub where fecha<=ldfecha ;
GROUP BY cliente INTO CURSOR CsrAnterior READWRITE 
SELECT CsrAnterior
replace ALL saldo WITH importe-pago IN CsrAnterior
DELETE FROM CsrAnterior WHERE saldo=0

SELECT distinct cliente,SUM(pago)as pago, SUM(importe) as importe;
, 00000000000.000 as saldo ,MAX(fecha)as fecha FROM Csrmovipub where fecha>ldfecha ;
GROUP BY cliente INTO CURSOR CsrSaldosPost READWRITE 
SELECT CsrSaldosPost
replace ALL saldo WITH importe-pago IN CsrSaldosPost
DELETE FROM CsrSaldosPost WHERE saldo=0



SELECT CsrAnterior
Oavisar.proceso('S','Procesando '+alias()) 
GO top

SCAN FOR !EOF('CsrAnterior')
	SELECT CsrCtacte
	LOCATE FOR cnumero=ALLTRIM(STR(CsrAnterior.cliente))
	IF FOUND()
		lnsigno=1
		replace Csrctacte.saldoant WITH 0, Csrctacte.saldo WITH CsrAnterior.Saldo IN CsrCtacte
		
		ldfechas=ldfechasis
		lnidcomproba=1000002
		lnimporte=CsrCtacte.saldo
		lcclasecomp="B"
		IF lnimporte<0
			lnimporte=lnimporte*-1
			lnsigno=-1
			lnidcomproba=1000003
			lcclasecomp="C"
		eNDIF
		lcletra=IIF(CsrCtacte.tipoiva=1,"A","B")
		lcnum=strtran(str(VAL(CsrCtacte.cnumero),8,0),' ','0')
		lcnumero=lcletra+"0000"+lcnum

		INSERT INTO CsrMaopera (id,origen,programa,sucursal,terminal,sector;
		,fechasis,idoperador,idvendedor,iddetanrocaja,idcomproba,numcomp;
		,clasecomp,turno,puestocaja,idcotizadolar,switch,estado,detalle,fechaserver);
		VALUES (lnidmaopera,"IMP","IMPCTACTE",1,9,1,ldfechasis,1,1,100021,lnidcomproba,lcnumero;
		,lcclasecomp,1,1,1,"0000","0","Importación",ldfechasis)
		
		
		INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero;
		,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,pefiscal;
		,switch,signo) VALUES (lnidmovctacte,lnidmaopera,ldfechas,Csrctacte.cnumero;
		,CsrCtacte.id," ",0,1,lnimporte,lnimporte,0,ldfechasis,lnimporte;
		,"Saldo de Importación",SUBSTR(lcfiscal,1,6),"0000",lnsigno)
		
		lnidmovctacte=lnidmovctacte+1
		lnidmaopera=lnidmaopera+1
	ENDIF
ENDSCAN 
		
SELECT cliente,detalle,Importe,Pago,Saldo,fecha FROM CsrMovipub WHERE fecha>ldfecha;
order by cliente into cursor CsrPosterior
SELECT CsrSaldosPost


SCAN 
	SELECT CsrCtacte
	LOCATE FOR  VAL(cnumero)=CsrSaldosPost.cliente
	IF FOUND()
		replace Csrctacte.saldo WITH CsrCtacte.saldo+CsrSaldosPost.saldo IN CsrCtacte
	ENDIF 
ENDSCAN 
SELECT CsrPosterior
Oavisar.proceso('S','Procesando '+alias()) 
SCAN  
	SELECT CsrCtacte
	LOCATE FOR VAL(cnumero)=CsrPosterior.cliente
	IF FOUND()
		ldfechas=DATETIME(YEAR(CsrPosterior.fecha),month(CsrPosterior.fecha),day(CsrPosterior.fecha),0,0,0)
		lnsigno=1
		lnidcomproba=1000002
		lnimporte=CsrPosterior.importe
		lcclasecomp="B"
		IF !lnimporte=0
		
			lcletra=IIF(CsrCtacte.tipoiva=1,"A","B")
			lcnum=strtran(str(VAL(CsrCtacte.cnumero),8,0),' ','0')
			lcnumero=lcletra+"0000"+lcnum

			INSERT INTO CsrMaopera (id,origen,programa,sucursal,terminal,sector;
			,fechasis,idoperador,idvendedor,iddetanrocaja,idcomproba,numcomp;
			,clasecomp,turno,puestocaja,idcotizadolar,switch,estado,detalle,fechaserver);
			VALUES (lnidmaopera,"IMP","IMPCTACTE",1,9,1,ldfechasis,1,1,100021,lnidcomproba,lcnumero;
			,lcclasecomp,1,1,1,"0000","0","Importación",ldfechasis)
			
			
			INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero;
			,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,pefiscal;
			,switch,signo) VALUES (lnidmovctacte,lnidmaopera,ldfechas,Csrctacte.cnumero;
			,CsrCtacte.id," ",0,1,lnimporte,lnimporte,0,ldfechasis,lnimporte;
			,CsrPosterior.detalle,SUBSTR(lcfiscal,1,6),"0000",lnsigno)
			
			lnidmovctacte=lnidmovctacte+1
			lnidmaopera=lnidmaopera+1
			
		endif	
			***
			
		
		lnimporte=CsrPosterior.pago
		lnsigno=-1
		lnidcomproba=1000003
		lcclasecomp="C"
		
		IF !lnimporte=0
			lcletra=IIF(CsrCtacte.tipoiva=1,"A","B")
			lcnum=strtran(str(VAL(CsrCtacte.cnumero),8,0),' ','0')
			lcnumero=lcletra+"0000"+lcnum

			INSERT INTO CsrMaopera (id,origen,programa,sucursal,terminal,sector;
			,fechasis,idoperador,idvendedor,iddetanrocaja,idcomproba,numcomp;
			,clasecomp,turno,puestocaja,idcotizadolar,switch,estado,detalle,fechaserver);
			VALUES (lnidmaopera,"IMP","IMPCTACTE",1,9,1,ldfechasis,1,1,100021,lnidcomproba,lcnumero;
			,lcclasecomp,1,1,1,"0000","0","Importación",ldfechasis)
			
			
			INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero;
			,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,pefiscal;
			,switch,signo) VALUES (lnidmovctacte,lnidmaopera,ldfechas,Csrctacte.cnumero;
			,CsrCtacte.id," ",0,1,lnimporte,lnimporte,0,ldfechasis,lnimporte;
			,CsrPosterior.detalle,SUBSTR(lcfiscal,1,6),"0000",lnsigno)
			
			lnidmovctacte=lnidmovctacte+1
			lnidmaopera=lnidmaopera+1

		endif	
			
	ENDIF
	SELECT CsrPosterior
ENDSCAN 

*Oavisar.proceso('S','Procesando saldos') 
&& Movimiento de proveedores
&& Procesamos losMovimientos anteriores a la fecha

SELECT cliente,SUM(importeco) as totalcomp,SUM(decontado) as decontado;
,00000000.000 as saldo FROM Csrmoviprov  ;
into CURSOR 'CsrDebito' readwrite;
GROUP BY cliente WHERE (tipocomp=1 OR tipocomp=2) AND  fecha<=ldfecha

SELECT cliente,SUM(importeco) as importeco;
,00000000.000 as saldo FROM Csrmoviprov;
into CURSOR 'CsrCredito' readwrite;
GROUP BY cliente WHERE (tipocomp=3 OR tipocomp=4)  AND  fecha<=ldfecha

replace ALL cliente WITH 10000+cliente,saldo WITH totalcomp-decontado IN csrDebito
replace ALL cliente WITH 10000+cliente,saldo WITH importeco*-1 IN CsrCredito
 && Con esta consulta, agrupamos los de debitos, creditos y el saldo_ant, con esto tendremos el saldo real hasta la fecha.
SELECT CsrAcreedor.numero+10000 as cliente;
,(IIF(ISNULL(CsrDebito.saldo),0,CsrDebito.saldo)+IIF(ISNULL(CsrCredito.saldo),0,CsrCredito.saldo)-IIF(ISNULL(CsrAcreedor.saldo_ant),0,CsrAcreedor.saldo_ant)) as saldo ;
FROM CsrAcreedor;
left JOIN CsrDebito ON CsrAcreedor.numero+10000=CsrDebito.cliente;
left JOIN CsrCredito ON CsrDebito.cliente=csrcredito.cliente;
INTO CURSOR CsrSaldo READWRITE 

SELECT csrsaldo
Oavisar.proceso('S','Procesando '+alias()) 
GO top


SCAN FOR !EOF('CsrSaldo')
	SELECT CsrCtacte
	LOCATE FOR cnumero=ALLTRIM(STR(Csrsaldo.cliente))
	IF FOUND()
		replace saldo WITH CsrSaldo.saldo IN CsrCtacte
	ENDIF
	SELECT CsrSaldo
ENDSCAN

&& agregamos un unico registro por el saldo agrupado anterior a la fecha
SELECT CsrSaldo
SCAN 
		IF CsrSaldo.saldo = 0
			LOOP
		ENDIF 
		SELECT CsrCtacte
		LOCATE FOR cnumero=ALLTRIM(STR(CsrSaldo.cliente))
		
		IF FOUND()
			ldfechas=ldfechasis
			lnidcomproba=22
			lnimporte=CsrCtacte.saldo
			lcclasecomp="A"
			IF lnimporte<0
				lnimporte=lnimporte*-1
				lnsigno=-1
				lnidcomproba=7
				lcclasecomp="C"
			ENDIF 
			lcletra=IIF(CsrCtacte.tipoiva=1,"A","B")
			lcnum=strtran(str(VAL(CsrCtacte.cnumero),8,0),' ','0')
			lcnumero=lcletra+"0000"+lcnum
			
				INSERT INTO CsrMaopera (id,origen,programa,sucursal,terminal,sector;
				,fechasis,idoperador,idvendedor,iddetanrocaja,idcomproba,numcomp;
				,clasecomp,turno,puestocaja,idcotizadolar,switch,estado,detalle,fechaserver);
				VALUES (lnidmaopera,"IMP","IMPPROVE",1,9,1,ldfechasis,1,1,100021,lnidcomproba;
				,lcnumero,lcclasecomp,1,1,1,"0000","0","Importación",ldfechasis)
				
				ldfechafac=ldfechas
				lcperiodo=SUBSTR(lcfiscal,1,6)
				ldfechavto=ldfechasis
				lnimporte = CsrSaldo.saldo
				lnsigno=1
				IF lnidcomproba=22
					IF lnimporte<0
						lnimporte=lnimporte*-1
					ENDIF 
					lnsigno=-1
				ELSE
					lnsigno=1
				ENDIF
							
				INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero;
				,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,pefiscal;
				,switch,signo) VALUES (lnidmovctacte,lnidmaopera,ldfechafac,Csrctacte.cnumero;
				,CsrCtacte.id," ",0,1,lnimporte,lnimporte,0,ldfechavto,lnimporte;
				,"Saldo Agrupado de Importación",lcperiodo,"0000",lnsigno)
				
				lnidmovctacte=lnidmovctacte+1
				lnidmaopera=lnidmaopera+1
		ENDIF
		SELECT CsrSaldo
ENDSCAN

&& importaremos la totalidad de movimientos posterior a la fecha
SELECT cliente+10000 as cliente,tipocomp,fecha_fac,vencimien,importeco,IIF(EMPTY(decontado),0,decontado)as decontado;
,letra,talonario,numcomp FROM CsrMoviprov WHERE fecha>ldfecha ORDER BY cliente;
into cursor 'CsrAux' readwrite

SELECT CsrAux
Oavisar.proceso('S','Procesando '+alias()) 
GO TOP 

SCAN FOR !EOF('CsrAux')
		SELECT CsrCtacte
		LOCATE FOR cnumero=ALLTRIM(STR(CsrAux.cliente))
		IF FOUND()
			DO CASE 
				CASE CsrAux.tipocomp=1
					lnidcompro=22
					lcclase="A"
				CASE CsrAux.tipocomp=2
					lnidcompro=22
					lcclase="A"
				CASE CsrAux.tipocomp=3
					lnidcompro=7
					lcclase="C"
				CASE CsrAux.tipocomp=4
					lnidcompro=8
					lcclase="D"
			ENDCASE
				lctalo=''
				tam=LEN(ALLTRIM(STR(CsrAux.talonario)))
				lctalo=strtran(str(CsrAux.talonario,4,0),' ','0')
				lcnum=''
				tam=LEN(ALLTRIM(STR(CsrAux.numcomp)))
				lcnum=strtran(str(CsrAux.numcomp,8,0),' ','0')
				lcnumero=ALLTRIM(CsrAux.letra)+ALLTRIM(lctalo)+ALLTRIM(lcnum)
			
				INSERT INTO CsrMaopera (id,origen,programa,sucursal,terminal,sector;
				,fechasis,idoperador,idvendedor,iddetanrocaja,idcomproba,numcomp;
				,clasecomp,turno,puestocaja,idcotizadolar,switch,estado,detalle,fechaserver);
				VALUES (lnidmaopera,"IMP","IMPPROVE",1,9,1,ldfechasis,1,1,100021,lnidcompro;
				,lcnumero,lcclase,1,1,1,"0000","0","Importación",ldfechasis)
				
				ldfechafac=DATETIME(YEAR(CsrAux.fecha_fac),MONTH(CsrAux.fecha_fac),DAY(CsrAux.fecha_fac),0,0,0)
				lcperiodo=alltrim(STR(YEAR(CsrAux.fecha_fac)))+ALLTRIM(STR(MONTH(CsrAux.fecha_fac)))
				ldfechavto=DATETIME(YEAR(CsrAux.vencimien),MONTH(CsrAux.vencimien),DAY(CsrAux.vencimien),0,0,0)
				lnentrega=CsrAux.decontado
				lnimporte=CsrAux.Importeco
				lnsaldo=lnimporte-lnentrega
				lnsigno=1
				IF lnidcompro=22
					IF lnimporte<0
						lnimporte=lnimporte*-1
					ENDIF 
					lnsigno=-1
				ELSE
					IF lnidcompro=7 .or. lnidcompro=8
						lnsigno=1
					ENDIF 
				ENDIF
							
				INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero;
				,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,pefiscal;
				,switch,signo) VALUES (lnidmovctacte,lnidmaopera,ldfechafac,Csrctacte.cnumero;
				,CsrCtacte.id," ",0,1,lnimporte,lnimporte,0,ldfechavto,lnimporte;
				,"Saldo de Importación",lcperiodo,"0000",lnsigno)
				
				IF  lnentrega<>0
					lnidmovctacte=lnidmovctacte+1
					INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero;
					,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,pefiscal;
					,switch,signo) VALUES (lnidmovctacte,lnidmaopera,ldfechafac,Csrctacte.cnumero;
					,CsrCtacte.id," ",0,1,lnentrega,lnentrega,0,ldfechavto,lnimporte;
					,"Saldo de Importación",lcperiodo,"0000",lnsigno)
				ENDIF 
					
				
				lnidmovctacte=lnidmovctacte+1
				lnidmaopera=lnidmaopera+1
		ENDIF
		
		SELECT CsrAux
		
ENDSCAN

Oavisar.proceso('N') 
=MESSAGEBOX('Proceso terminado! ')
CLOSE tables
CLOSE INDEXES
CLOSE DATABASES
