
CLOSE DATABASES
CLOSE TABLES
OPEN DATABASE ? EXCLUSIVE

SET SAFETY OFF

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON

SET DATABASE TO DATOS
USE datos!producto IN 0 ALIAS Csrproducto EXCLUSIVE

USE datos!ctacte IN 0 ALIAS Csrctacte EXCLUSIVE

USE datos!fletero IN 0 ALIAS Csrfletero EXCLUSIVE

USE datos!fuerzavta IN 0 ALIAS Csrfuerzavta EXCLUSIVE

USE datos!comprobante IN 0 ALIAS Csrcomprobante EXCLUSIVE 

USE datos!paraconta IN 0 ALIAS Csrparaconta EXCLUSIVE 

USE datos!valor IN 0 ALIAS Csrvalor EXCLUSIVE 

USE datos!vendedor IN 0 ALIAS Csrvendedor EXCLUSIVE 

USE datos!deposito IN 0 ALIAS Csrdeposito EXCLUSIVE 

USE datos!cabefac IN 0 ALIAS Csrcabefac EXCLUSIVE 
ZAP IN Csrcabefac

USE datos!cuerfac IN 0 ALIAS Csrcuerfac EXCLUSIVE
ZAP IN Csrcuerfac

USE datos!cuerdeta IN 0 ALIAS CsrCuerdeta EXCLUSIVE
ZAP IN Csrcuerdeta

USE datos!ncabefac IN 0 ALIAS Csrncabefac EXCLUSIVE 
ZAP IN Csrncabefac

USE datos!ncuerfac IN 0 ALIAS Csrncuerfac EXCLUSIVE
ZAP IN Csrncuerfac

USE datos!movctacte IN 0 ALIAS Csrmovctacte EXCLUSIVE 
ZAP IN Csrmovctacte

USE datos!afectacte IN 0 ALIAS Csrafectacte EXCLUSIVE
ZAP IN Csrafectacte

USE datos!maopera IN 0 ALIAS Csrmaopera EXCLUSIVE
ZAP IN Csrmaopera

USE datos!nmaopera IN 0 ALIAS Csrnmaopera EXCLUSIVE
ZAP IN Csrnmaopera

USE datos!tablaimp IN 0 ALIAS Csrtablaimp EXCLUSIVE
ZAP IN Csrtablaimp

USE datos!tablaasi IN 0 ALIAS Csrtablaasi EXCLUSIVE
ZAP IN Csrtablaasi

USE datos!movstock IN 0 ALIAS Csrmovstock EXCLUSIVE
ZAP IN Csrmovstock

SET SAFETY ON

USE "\starossa\cabefac" IN 0 ALIAS Csrcabeza EXCLUSIVE 

USE  "\starossa\cuerfac" in 0 alias Csrcuerpo EXCLUSIVE
SELECT CsrCuerpo
INDEX on STR(TIPOCOMP,2)+LETRA+str(talonario,4)+STR(NUMCOMP,8) TO Csrcuerpo

USE  "\starossa\movimien" in 0 alias Csrmovimien EXCLUSIVE

USE  "\starossa\movisto" in 0 alias Csrmovisto EXCLUSIVE	

lnid = 1
lnidcabeza = 1
lnidmovcte = 1
lnidcuerpo = 1
lnidmstk = 1
lnidn = 1
lnidncabefac = 1
lnidncuerfac = 1
lnidTablaasi = 1
lnidTablaimp = 1

SELECT Csrcabeza
GO top
SCAN FOR !EOF()
	IF EMPTY(fecha) OR importe=0
		LOOP 
	ENDIF
	
	lntipoiva = tipocuit
	IF lntipoiva=7
	   lntipoiva = 5
	ENDIF 
	
	lnidlocalidad=0		
       lcbuscocuerpo = STR(TIPOCOMP,2)+LETRA+str(talonario,4)+STR(NUMCOMP,8)
     
	DO case
		CASE "BLANCA"$LOCALIDAD OR "BCA."$localidad OR "BANCA"$LOCALIDAD OR "B.BA"$LOCALIDAD
			lnidlocalidad = 1
		CASE "CABILDO"$localidad
			lnidlocalidad =2			
		CASE "WHITE"$localidad
			lnidlocalidad =3
		CASE "CERR"$localidad
			lnidlocalidad =7
		CASE "CHOELE"$localidad
			lnidlocalidad =34
		CASE "REGINA"$localidad
			lnidlocalidad =43
		CASE "ASCASUBI"$localidad
			lnidlocalidad =49
		CASE "PATAGON"$localidad
			lnidlocalidad =33
		CASE "CARHUE"$localidad
			lnidlocalidad =89
		CASE "	VILLALONGA"$localidad
			lnidlocalidad =91
		CASE "VILLA ROSAS"$localidad
			lnidlocalidad = 0
		CASE "VILLA BORDEU"$localidad
			lnidlocalidad =0
		CASE "	TRES ARROYO"$localidad
			lnidlocalidad=0		
	ENDCASE
	
	lcswitch = "00000"
	lcDebeHaber	= "D"
	lnsigno = 1
	DO case
		CASE tipocomp=1      && remito
			lntipocomp = 36
		CASE tipocomp=2	&& factura
			lntipocomp = 1
		CASE tipocomp=3	&& n.deb
			lntipocomp = 2
		CASE tipocomp=4	&& n.cre
			lntipocomp = 3
			lnsigno = -1
			lcDebeHaber	="H"
		CASE tipocomp=5	&& f.remito
			lntipocomp = 0
	ENDCASE 

	lnidcomproba = 0
	lcnumcomp = CsrCabeza.letra+RIGHT(STR(10000+CsrCabeza.talonario),4)+RIGHT(STR(1000000000+Csrcabeza.numcomp),8)
	lcclasecomp = ""
	SELECT CsrComprobante	
	LOCATE FOR numero=lntipocomp	
	IF numero=lntipocomp
		lnidcomproba = id
		lcclasecomp = clase
	ENDIF
		
      SELECT Csrctacte
      LOCATE FOR cnumero=LTRIM(STR(Csrcabeza.cliente))
      lnidctacte = 0      
      IF cnumero=LTRIM(STR(Csrcabeza.cliente))
          lnidctacte = Csrctacte.id
          lntipoiva   = CsrCtacte.tipoiva
      ENDIF

      SELECT Csrfletero
      LOCATE FOR numero=Csrcabeza.fletero
      lnidfletero = 0      
      IF numero=Csrcabeza.fletero
          lnidfletero = Csrfletero.id
      ENDIF

      SELECT Csrfuerzavta
      LOCATE FOR numero=Csrcabeza.canal
      lnidfuerzavta = 0      
      IF numero=Csrcabeza.canal
          lnidfuerzavta = Csrfuerzavta.id
      ENDIF

      SELECT Csrvendedor
      LOCATE FOR numero=Csrcabeza.vendedor
      lnidvendedor = 0      
      IF numero=Csrcabeza.vendedor
          lnidvendedor = Csrvendedor.id
      ENDIF

	ldfechasis = DATETIME(YEAR(DATE()),MONTH(DATE()),DAY(DATE()),0,0,0)
	ldfecha       = DATETIME(YEAR(Csrcabeza.fecha),MONTH(Csrcabeza.fecha),DAY(Csrcabeza.fecha),0,0,0)
	
	    INSERT INTO Csrmaopera (id,origen,programa,terminal,fechasis,idoperador,idvendedor,idcomproba,numcomp,clasecomp;
	                ,iddetanrocaja,turno,switch,sucursal,sector,puestocaja,idcotizadolar,estado,fechaserver);
	           VALUES (lnid,'FAC',"IMPORTACION",1,ldfechasis,1,lnidvendedor,lnidcomproba,lcnumcomp,lcclasecomp,1,1,"00000",1,1,1,1,'0',ldfecha)

		Insert into Csrcabefac (ID, IDMAOPERA, IDCTACTE, CTACTE, CNOMBRE, CDIRECCION, CTELEFONO, CPOSTAL, IDLOCALIDAD, IDPROVINCIA;
						, IDTIPOIVA, CUIT, IDSUBCTA, FECHA, IDPLANPAGO, TOTAL, BONIF1, BONIF2, SWITCH, LISTAPRECIO, IDFLETERO, IDFUERZAVTA, IDRUTAVDOR,SIGNO);
		                              value (lnidcabeza,lnid,lnidctacte,LTRIM(STR(Csrcabeza.cliente)),CsrCabeza.nombre,Csrcabeza.direccion,"","",lnidlocalidad,1;
		       		,lntipoiva,CsrCabeza.cuit,0,ldfecha,CsrCabeza.tipovta,Csrcabeza.importe,Csrcabeza.bonif1,Csrcabeza.bonif2,"F0000",1,lnidfletero,lnidfuerzavta,0,lnsigno)

		IF CsrCabeza.tipovta=2
			INSERT INTO CsrMovctacte (id,idmaopera,fecha,ctacte,idctacte,subnumero,idsubcta,cuota,importe,saldo,entrega,vencimien,total,detalle,switch,pefiscal,signo);
				VALUES (lnidmovcte,lnid,ldfecha,LTRIM(STR(Csrcabeza.cliente)),lnidctacte,0,0,1,Csrcabeza.importe,Csrcabeza.importe - CsrCabeza.entrega,Csrcabeza.entrega;
						,CsrCabeza.fecha_vto,Csrcabeza.importe,"",lcswitch,STR(YEAR(Csrcabeza.fecha),4)+RIGHT(STR(1000+MONTH(Csrcabeza.fecha)),2),lnsigno)
			lnidmovcte = lnidmovcte + 1
		ENDIF 

		lctablaori  = 'CAFA'
		lctipoconce = ""
		lnidorigen  = lnidCabeza	
		lnimporte = CsrCabeza.importe
		lnidprovincia = 0
		lntasa = 0
		lnbase = 0
		
		lnidcuenta  = 14 
								
		INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
				VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

		lnidTablaasi = lnidTablaasi + 1
		
		lcDebeHaber = IIF(lcDebeHaber='D','H','D')  && cambio el signo para los impuestos

		IF CsrCabeza.neto_iva#0
			* debito fiscal
			lnidcuenta  = 24
			lctipoconce = "IG"		
			lntasa = 21
			lnbase = Csrcabeza.gravado
			lnimporte = CsrCabeza.neto_iva

			INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
					VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

			lnidasiento = CsrTablaasi.id
			lnidTablaasi = lnidTablaasi + 1

			INSERT INTO CsrTablaimp(id,idmaopera,idcuenta,tipoconce,importe,idorigen,tablaori,idasiento,tasa,baseimp,nombre,idprovincia,detalle);
					VALUES (lnidTablaimp,lnid,lnidcuenta,lctipoconce,lnimporte,lnidorigen,lctablaori,lnidasiento,lntasa,lnbase,"",lnidprovincia,"")
			lnidTablaimp = lnidTablaimp + 1
		ENDIF
		
		lntasa = 0
		lnbase = 0
		IF CsrCabeza.gravado#0
			* neto gravado
			lnidcuenta =25
			lctipoconce = "NG"
			lnimporte = CsrCabeza.gravado
			
			INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
					VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

			lnidasiento = CsrTablaasi.id
			lnidTablaasi = lnidTablaasi + 1

			INSERT INTO CsrTablaimp(id,idmaopera,idcuenta,tipoconce,importe,idorigen,tablaori,idasiento,tasa,baseimp,nombre,idprovincia,detalle);
					VALUES (lnidTablaimp,lnid,lnidcuenta,lctipoconce,lnimporte,lnidorigen,lctablaori,lnidasiento,lntasa,lnbase,"",lnidprovincia,"")
			lnidTablaimp = lnidTablaimp + 1
		ENDIF

		IF CsrCabeza.neto_exe#0
			* venta exenta
			lnidcuenta  = 25
			lnimporte   = Csrcabeza.neto_exe
			lctipoconce = "EX"

			INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
					VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

			lnidasiento = CsrTablaasi.id
			lnidTablaasi = lnidTablaasi + 1

			INSERT INTO CsrTablaimp(id,idmaopera,idcuenta,tipoconce,importe,idorigen,tablaori,idasiento,tasa,baseimp,nombre,idprovincia,detalle);
					VALUES (lnidTablaimp,lnid,lnidcuenta,lctipoconce,lnimporte,lnidorigen,lctablaori,lnidasiento,lntasa,lnbase,"",lnidprovincia,"")
			lnidTablaimp = lnidTablaimp + 1
		ENDIF
		
		IF CsrCabeza.perceib + CsrCabeza.pib #0
			* IBTO1 / IBTO2
			lnidcuenta  = 18

			lnimporte   =Csrcabeza.perceib + CsrCabeza.pib	
	    		lctipoconce = "PB"
	    	
			INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
					VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

			lnidasiento = CsrTablaasi.id
			lnidTablaasi = lnidTablaasi + 1

			INSERT INTO CsrTablaimp(id,idmaopera,idcuenta,tipoconce,importe,idorigen,tablaori,idasiento,tasa,baseimp,nombre,idprovincia,detalle);
					VALUES (lnidTablaimp,lnid,lnidcuenta,lctipoconce,lnimporte,lnidorigen,lctablaori,lnidasiento,lntasa,lnbase,"",lnidprovincia,"")
			lnidTablaimp = lnidTablaimp + 1
		ENDIF
		
		IF CsrCabeza.percenoca#0
			* NO categorizado
			lnidcuenta  = 24

			lnimporte   = Csrcabeza.percenoca
			
		    	lctipoconce = "PN"
		
			INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
					VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

			lnidasiento = CsrTablaasi.id
			lnidTablaasi = lnidTablaasi + 1

			INSERT INTO CsrTablaimp(id,idmaopera,idcuenta,tipoconce,importe,idorigen,tablaori,idasiento,tasa,baseimp,nombre,idprovincia,detalle);
					VALUES (lnidTablaimp,lnid,lnidcuenta,lctipoconce,lnimporte,lnidorigen,lctablaori,lnidasiento,lntasa,lnbase,"",lnidprovincia,"")
			lnidTablaimp = lnidTablaimp + 1
		ENDIF
		
		IF CsrCabeza.interno#0
			* interno
			lnidcuenta  = 29
	    
			lnimporte = CsrCabeza.interno
			lctipoconce = "II"
		
			INSERT INTO CsrTablaasi (id,idmaopera,idcuenta,debehaber,importe,idorigen,tablaori,tipoconce,detalle);
					VALUES (lnidTablaasi,lnid,lnidcuenta,lcdebehaber,lnimporte,lnidorigen,lctablaori,lctipoconce,"")

			lnidasiento = CsrTablaasi.id
			lnidTablaasi = lnidTablaasi + 1

			INSERT INTO CsrTablaimp(id,idmaopera,idcuenta,tipoconce,importe,idorigen,tablaori,idasiento,tasa,baseimp,nombre,idprovincia,detalle);
					VALUES (lnidTablaimp,lnid,lnidcuenta,lctipoconce,lnimporte,lnidorigen,lctablaori,lnidasiento,lntasa,lnbase,"",lnidprovincia,"")
			lnidTablaimp = lnidTablaimp + 1
		ENDIF
					
	SELECT CsrCuerpo
       SEEK lcbuscocuerpo 
       DO WHILE !EOF() AND  lcbuscocuerpo = STR(TIPOCOMP,2)+LETRA+str(talonario,4)+STR(NUMCOMP,8)	
             lnunivta = IIF(unidad="U",1,2)
		lnkilos = 0
		lnvolumen = 0
		lnespromo = IIF(espromoes="S",1,0)

	      SELECT Csrdeposito
	      LOCATE FOR numero=Csrcuerpo.deposito
	      lniddeposito = 0      
	      IF numero=Csrcuerpo.deposito
	          lniddeposito = Csrdeposito.id
	      ENDIF
				             
		SELECT CsrProducto
		LOCATE FOR numero=Csrcuerpo.articulo
		lnidarticulo = 0
		lcnumero  =" "
		lcnombre = " "
		IF numero=Csrcuerpo.Articulo
			lnidarticulo = Csrproducto.id
			lcnumero = Csrproducto.codalfa
			lcnombre = Csrproducto.nombre
			lnkilos = Csrproducto.peso
			lnvolumen = Csrproducto.volumen
		ENDIF
		
		lnunibulto  = IIF(Csrcuerpo.unibulto<=0,1,Csrcuerpo.unibulto)
		
		lnprecosto = Csrcuerpo.costo / lnunibulto 
		lnpreunita = Csrcuerpo.importe / lnunibulto 
		lnprearti    = Csrcuerpo.precioarti / lnunibulto 
		lninterno   = Csrcuerpo.internos / lnunibulto 

		lnprecostosiva = (lnprecosto - lninterno) / (1+Csrcuerpo.ivari/100) + lninterno
		lnpreunitasiva  = (lnpreunita - lninterno) / (1+Csrcuerpo.ivari/100) + lninterno
		lnpreartisiva     = (lnprearti - lninterno) / (1+Csrcuerpo.ivari/100) + lninterno
		
		lnCantidad   = Csrcuerpo.cantidad * IIF(lnunivta=1,1,lnunibulto)
		lnKilos          = lnKilos *  lnCantidad
		lnvolumen   = lnKilos * lnCantidad
		
			INSERT INTO CsrCuerfac (ID, IDMAOPERA, IDARTICULO, CODIGO, NOMBRE, CANTIDAD, UNIVENTA, UNIBULTO, ORICOD, SDOCANT, KILOS;
										, LISTAPRECIO, PRECOSTO, PREUNITA, PREARTI, INTERNO, DESPOR, TASAIVA, SWITCH, IDDEPOSITO, ESPROMOCION;
										, PERCEIBRUTO, IDCABEZA, VOLUMEN, PRECOSTOSIVA, PREUNITASIVA, PREARTISIVA);
				                         VALUES (lnidcuerpo,lnid,lnidarticulo,lcnumero,lcnombre,lncantidad,lnunivta,lnunibulto ,"D",0,lnkilos,1,lnprecosto;
				  					,lnpreunita,lnprearti,lninterno,Csrcuerpo.bonifica,Csrcuerpo.ivari,"00000",lniddeposito,lnespromo,0,lnidcabeza,lnvolumen,lnprecostosiva;
				  					,lnpreunitasiva,lnpreartisiva)
			lnidcuerpo = lnidcuerpo + 1		
				
		SELECT CsrCuerpo
		SKIP 
	ENDDO
			
		lnid = lnid + 1
		lnidcabeza = lnidcabeza + 1
	
	SELECT CsrCabeza		     				
ENDSCAN

CLOSE ALL 
	