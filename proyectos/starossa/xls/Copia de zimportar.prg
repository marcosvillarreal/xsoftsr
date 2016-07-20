
CLOSE DATABASES
CLOSE TABLES
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

USE datos!subproducto IN 0 ALIAS Csrsubproducto EXCLUSIVE
ZAP IN Csrsubproducto

USE datos!canalvta IN 0 ALIAS Csrcanalvta EXCLUSIVE 
ZAP IN Csrcanalvta

USE datos!zona IN 0 ALIAS Csrzona EXCLUSIVE
ZAP IN Csrzona

USE datos!zonaruta IN 0 ALIAS Csrzonaruta EXCLUSIVE
ZAP IN Csrzonaruta

USE datos!vendedor IN 0 ALIAS CsrVendedor EXCLUSIVE
ZAP IN Csrvendedor

USE datos!fletero IN 0 ALIAS Csrfletero EXCLUSIVE
ZAP IN Csrfletero

USE datos!motanula IN 0 ALIAS Csrmotanula EXCLUSIVE
ZAP IN Csrmotanula

USE datos!deposito IN 0 ALIAS Csrdeposito EXCLUSIVE
ZAP IN Csrdeposito

USE datos!ruta IN 0 ALIAS Csrruta EXCLUSIVE
ZAP IN Csrruta

USE datos!rutavdor IN 0 ALIAS Csrrutavdor EXCLUSIVE 
ZAP IN Csrrutavdor

USE datos!caberuta IN 0 ALIAS Csrcaberuta EXCLUSIVE
ZAP IN Csrcaberuta

USE datos!cuerruta IN 0 ALIAS Csrcuerruta EXCLUSIVE
ZAP IN Csrcuerruta

USE "datos!FuerzaVta" IN 0 ALIAS CsrFuerzaVta EXCLUSIVE
ZAP IN  CsrFuerzaVta

SET SAFETY ON

USE "\starossa\seccion" IN 0 ALIAS CsrSeccion EXCLUSIVE 

USE  "\starossa\clientes" in 0 alias CsrDeudor EXCLUSIVE

USE  "\starossa\proveed" in 0 alias CsrAcreedor EXCLUSIVE

USE  "\starossa\articulo" in 0 alias CsrArticulo EXCLUSIVE	

USE "\starossa\marcas" in 0 alias CsrmarcaVie EXCLUSIVE

USE "\starossa\canalvta" IN 0 ALIAS CsrCanalVie EXCLUSIVE

USE "\starossa\zona" IN 0 ALIAS CsrzonasVie EXCLUSIVE

USE "\starossa\vendedor" IN 0 ALIAS CsrVendeVie EXCLUSIVE

USE "\starossa\fletero" IN 0 ALIAS CsrFleteroVie EXCLUSIVE

USE "\starossa\conceanu" IN 0 ALIAS CsrconceanuVie EXCLUSIVE

USE "\starossa\deposito" IN 0 ALIAS CsrdepositoVie EXCLUSIVE

lnid = 1
SELECT CsrVendeVie
GO top
SCAN FOR !EOF()
           IF numero=0
               loop
           ENDIF
           lnprevta = IIF(preventa="S",1,0)
           lnestado = IIF(activo="S",0,1)
                                  
           INSERT INTO Csrvendedor (id,numero,nombre,comision,planilla,prevta,estado);
           			 VALUES (lnid,CsrvendeVie.numero,CsrvendeVie.nombre,Csrvendevie.comision,Csrvendevie.planilla,lnprevta,lnestado)
           lnid = lnid + 1
ENDSCAN


lnid = 1
SELECT CsrZonasVie
GO top
SCAN FOR !EOF()            
           INSERT INTO CsrZona (id,numero,nombre,porflete);
           			 VALUES (lnid,lnid,CsrzonasVie.nombre,0)
	   
           lnid = lnid + 1
ENDSCAN

lnid = 1
SELECT CsrCanalVie
GO top
SCAN FOR !EOF()
           INSERT INTO CsrCanalvta (numero,nombre,limitecred,minimofac,plazo,descuento,lista);
           			 VALUES (CsrCanalVie.numero,CsrCanalVie.nombre,CsrCanalvie.limite,CsrCanalvie.minimo_fac,CsrCanalvie.plazo,CsrCanalvie.descuento,2)
           lnid = lnid + 1
ENDSCAN


lnid = 1
SELECT CsrconceanuVie
GO top
SCAN FOR !EOF()
           INSERT INTO Csrmotanula (numero,nombre);
           			 VALUES (CsrconceanuVie.numero,CsrconceanuVie.nombre)
           lnid = lnid + 1
ENDSCAN


lnid = 1

SELECT CsrDeudor
GO top
SCAN FOR !EOF()
		lntipoiva = tipocuit
		IF lntipoiva=7
		   lntipoiva = 5
		ENDIF 
		lnidlocalidad = 1
		lnidprovincia = 1
		lnidcategoria = 1
             lnctadeudor = 1
             lnctaacreedor=0
             lnctabanco = 0
             lnctaotro = 0
             lnidcanalvta = 0
             lnidestado = IIF(Csrdeudor.activo="I",1,0)

            SELECT CsrCanalVta
            LOCATE FOR numero=CsrDeudor.canalvta
            IF !EOF() AND numero=Csrdeudor.canalvta  
                lnidcanalvta = CsrCanalVta.id
            ENDIF 
                                                 
          INSERT INTO CsrCtacte (id,CNUMERO,CNOMBRE,CDIRECCION,CPOSTAL,IDLOCALIDAD,IDPROVINCIA,CTELEFONO,TIPOIVA,CUIT,IDCATEGORIA,SALDO,SALDOANT,BONIF1,BONIF2;
          			,idplanpago,idcanalvta,estadocta,ctadeudor,ctaacreedor,ctabanco,ctaotro,inscri01,fecins01,inscri02,inscri03);
		          VALUES (lnid,LTRIM(STR(Csrdeudor.numero)),Csrdeudor.nombre,Csrdeudor.direccion,LTRIM(STR(Csrdeudor.cp)),lnidlocalidad,lnidprovincia,Csrdeudor.telefono,lntipoiva;
		          ,Csrdeudor.cuit,lnidcategoria,Csrdeudor.saldo,Csrdeudor.Saldo_ant,Csrdeudor.bonif1,Csrdeudor.bonif2,Csrdeudor.tipo_pago,lnidcanalvta,lnidestado;
		          ,lnctadeudor,lnctaacreedor,lnctabanco,lnctaotro,CsrDeudor.inscri,Csrdeudor.fefin,Csrdeudor.ibrutos,"")
		lnid = lnid + 1
		
          SELECT CsrDeudor
          	          
ENDSCAN

SELECT CsrAcreedor
GO top
SCAN FOR !EOF()

		lntipoiva = tipocuit
		lnidlocalidad = 1
		lnidprovincia = 1
		lnidcategoria = 1
             lnidestado = 0
             lnctadeudor = 0
             lnctaacreedor=1
             lnctabanco = 0
             lnctaotro = 0
             
          INSERT INTO CsrCtacte (id,CNUMERO,CNOMBRE,CDIRECCION,CPOSTAL,IDLOCALIDAD,IDPROVINCIA,CTELEFONO,TIPOIVA,CUIT,IDCATEGORIA,SALDO,SALDOANT;
          			,idplanpago,idcanalvta,estadocta,ctadeudor,ctaacreedor,ctabanco,ctaotro,inscri01,fecins01,inscri02,inscri03);
		          VALUES (lnid,LTRIM(STR(10000+CsrAcreedor.numero)),CsrAcreedor.nombre,CsrAcreedor.direccion,LTRIM(STR(CsrAcreedor.cp)),lnidlocalidad,lnidprovincia,CsrAcreedor.telefono,lntipoiva;
		          ,CsrAcreedor.cuit,lnidcategoria,CsrAcreedor.saldo,CsrAcreedor.Saldo_ant,2,0,lnidestado,lnctadeudor,lnctaacreedor,lnctabanco,lnctaotro,"",CTOD("  -  -  "),CsrAcreedor.ibrutos,"")
		lnid = lnid + 1
		          
ENDSCAN


lnid = 1
SELECT CsrSeccion
GO top
SCAN FOR !EOF()
            IF delogico
               LOOP 
            ENDIF 

            lntipoprod = IIF(Csrseccion.pideauto="S",2,1)
            lntipovta   = IIF(Csrseccion.clase="L",2,1)
            lnretibruto = IIF(CsrSeccion.perceib="S",1,0)
            lncanal     = CsrSeccion.canal
                                          
           INSERT INTO CsrRubro (id,numero,nombre,idtipoprod,idtipovta,perceibruto,idfuerzavta,nolista) VALUES (lnid,CsrSeccion.numero,Csrseccion.nombre,lntipoprod,lntipovta,lnretibruto,lncanal,0)
           lnid = lnid + 1
ENDSCAN


lnid = 1
SELECT CsrMarcaVie
GO top
SCAN FOR !EOF()
            IF delogico
               LOOP 
            ENDIF 

           INSERT INTO Csrmarca (id,numero,nombre,flete,flete2,idfuerzavta) VALUES (lnid,CsrMarcaVie.numero,CsrMarcaVie.nombre,Csrmarcavie.porcefle,Csrmarcavie.porcefle2,Csrmarcavie.canal)
           lnid = lnid + 1
ENDSCAN

lnid = 1
lnidsub = 1

SELECT CsrArticulo
GO top
SCAN FOR !EOF()
	SELECT CsrProducto
	LOCATE FOR numero=CsrArticulo.numero 
	IF numero=CsrArticulo.numero
		SELECT CsrArticulo
		LOOP 
	ENDIF
	
      SELECT Csrctacte
      LOCATE FOR cnumero=LTRIM(STR(10000+Csrarticulo.proveedor))
      lnidctacte = 0
      IF !EOF() AND cnumero=LTRIM(STR(10000+Csrarticulo.proveedor))
          lnidctacte = Csrctacte.id
      ENDIF

      SELECT CsrRubro
      LOCATE FOR numero=Csrarticulo.seccion
      lnidseccion = 0
      IF !EOF() AND numero=Csrarticulo.seccion
         lnidseccion = CsrRubro.id
      ENDIF

      SELECT CsrMarca
      LOCATE FOR numero=Csrarticulo.marca
      lnidmarca = 0
      IF !EOF() AND numero=Csrarticulo.marca
         lnidmarca = CsrMarca.id
      ENDIF

       lnfracciona = IIF(Csrarticulo.fraccion='S',1,0)
       lnidestado = IIF(Csrarticulo.borrado,2,1)
       lnidiva        = IIF(Csrarticulo.tablaiva=1,2,1)
      lnnolista    = IIF(Csrarticulo.figlista="N",1,0)
      lnnofactu   = IIF(Csrarticulo.nofactu,1,0)
       lnespromo = IIF(csrarticulo.escodboni="S",1,0)
       lnidtipovta = IIF(Csrarticulo.quefactura="B",2,1)
       
      lnidforma = 1      
      DO case
            CASE LEFT(Csrarticulo.univenta,4)="AERO"
            		lnidforma = 31
            CASE LEFT(Csrarticulo.univenta,4)="BALD"
            		lnidforma = 22
            CASE LEFT(Csrarticulo.univenta,4)="BARR"
            		lnidforma = 32
            CASE LEFT(Csrarticulo.univenta,4)="BIDO"
            		lnidforma = 5
            CASE LEFT(Csrarticulo.univenta,3)="BOT"
            		lnidforma = 4
            CASE LEFT(Csrarticulo.univenta,3)="CAJ"
            		lnidforma = 6
            CASE LEFT(Csrarticulo.univenta,4)="CART"
            		lnidforma = 29
            CASE LEFT(Csrarticulo.univenta,4)="CEPI"
            		lnidforma = 28
            CASE LEFT(Csrarticulo.univenta,4)="COMB"
            		lnidforma = 21
            CASE LEFT(Csrarticulo.univenta,4)="CUBO"
            		lnidforma = 20
            CASE LEFT(Csrarticulo.univenta,4)="DAMA"
            		lnidforma = 2
            CASE LEFT(Csrarticulo.univenta,4)="DISP"
            		lnidforma = 33
            CASE LEFT(Csrarticulo.univenta,4)="DOYPAC"
            		lnidforma = 34
            CASE LEFT(Csrarticulo.univenta,4)="ESTU"
            		lnidforma = 15
            CASE LEFT(Csrarticulo.univenta,4)="FRAS"
            		lnidforma = 11
            CASE LEFT(Csrarticulo.univenta,4)="POUC"
            		lnidforma = 24
            CASE LEFT(Csrarticulo.univenta,4)="PROM"
            		lnidforma = 35
            CASE LEFT(Csrarticulo.univenta,3)="SAC"
            		lnidforma = 18
            CASE LEFT(Csrarticulo.univenta,4)="SIFO"
            		lnidforma = 16
            CASE LEFT(Csrarticulo.univenta,4)="SOBR"
            		lnidforma = 17
            CASE LEFT(Csrarticulo.univenta,4)="TETR"
            		lnidforma = 3
            CASE LEFT(Csrarticulo.univenta,4)="TARR"
            		lnidforma = 10
            CASE LEFT(Csrarticulo.univenta,4)="LATA"
            		lnidforma = 12
            CASE LEFT(Csrarticulo.univenta,4)="PACK"
            		lnidforma = 23
            CASE LEFT(Csrarticulo.univenta,3)="PAQ"
            		lnidforma = 8
            CASE LEFT(Csrarticulo.univenta,3)="TUB"
            		lnidforma = 19
            CASE LEFT(Csrarticulo.univenta,4)="TUPP"
            		lnidforma = 30
            CASE LEFT(Csrarticulo.univenta,4)="VASO"
            		lnidforma = 14
            CASE LEFT(Csrarticulo.univenta,3)="PET"
            		lnidforma = 7
            CASE LEFT(Csrarticulo.univenta,4)="PORR"
            		lnidforma = 13
            CASE LEFT(Csrarticulo.univenta,4)="POMO"
            		lnidforma = 27
            CASE LEFT(Csrarticulo.univenta,4)="POTE"
            		lnidforma = 9
            CASE LEFT(Csrarticulo.univenta,3)="SAQ"
            		lnidforma = 36            		
      ENDCASE      
                                                      
	INSERT INTO Csrproducto (id,NUMERO,NOMBRE,CODALFA,IDIVA,COSTO,MARGEN1,PREVTA1,MARGEN2,PREVTA2,SWITCH,idunidad,idtprod,idtamano,idcatego;
					,idubicacio,idorigen,incluirped,idctacte,idrubro,MARGEN3,PREVTA3,margen4,prevta4,interno,unibulto,peso,idtipovta,idforma,fracciona,nomodifica;
					,nombulto,puntope,idmoneda,interno,incluirped,flete,feculcpra,fecalta,fecmodi,feculvta,bonif1,bonif2,bonif3,bonif4,idmarca,segflete,idestado,nolista,nofactura;
					,minimofac,espromocion); 	
	  VALUES (lnid,Csrarticulo.NUMERO,Csrarticulo.NOMBRE,LTRIM(STR(Csrarticulo.numero)),lnidiva,Csrarticulo.costo,Csrarticulo.utilidad,Csrarticulo.PREVenTA1;
	,Csrarticulo.utilidad2,Csrarticulo.PREVenTA2,"00000",1,1,1,1,1,1,1,lnidctacte,lnidseccion,Csrarticulo.utilidad3,Csrarticulo.PREVenTA3,Csrarticulo.utilidad4,Csrarticulo.PREVenTA4;
	,Csrarticulo.interno,Csrarticulo.unibulto,Csrarticulo.kilos,lnidtipovta,lnidforma,lnfracciona,0,Csrarticulo.nombulto,Csrarticulo.puntope,1,Csrarticulo.interno,1,Csrarticulo.flete;
	,DTOT(Csrarticulo.fechaulcpr),DTOT(DATE()),DTOT(DATE()),DTOT(DATE()),Csrarticulo.bonif1,Csrarticulo.bonif2,Csrarticulo.bonif3,Csrarticulo.bonif4,lnidmarca,0,lnidestado,lnnolista,lnnofactu;
	,Csrarticulo.minimofac,lnespromo)		
	
	lnid = lnid + 1
	lnidsub = lnidsub + 1
	     				
ENDSCAN


lnid = 1
SELECT CsrFleteroVie
GO top
SCAN FOR !EOF()
           INSERT INTO CsrFletero (numero,nombre,direccion,telefono,tipoflete,switch);
           			 VALUES (CsrFleteroVie.numero,CsrFleteroVie.nombre,"","",CsrFleteroVie.tipoporce,"00000")
           lnid = lnid + 1
ENDSCAN

lnid = 1
SELECT CsrDepositoVie
GO top
SCAN FOR !EOF()
	INSERT INTO Csrdeposito (numero,nombre,llevastock);
			VALUES (Csrdepositovie.numero,Csrdepositovie.nombre,1)
			lnid = lnid + 1
ENDSCAN

INSERT INTO Csrfuerzavta (id,numero,nombre) VALUES (1,1,"FUERZA VTA 1")
INSERT INTO Csrfuerzavta (id,numero,nombre) VALUES (2,2,"FUERZA VTA 2")

lnid = 1
lnidcabeza = 1
lnidrutavdor = 1
lnidzonaruta = 1
lnidcuerruta = 1

SELECT CsrDeudor
GO top
SCAN FOR !EOF()

	IF Csrdeudor.activo="I"
		LOOP 
	ENDIF

	SELECT Csrctacte
	LOCATE FOR VAL(cnumero)=CsrDeudor.numero
       IF VAL(cnumero) # Csrdeudor.numero
           SELECT CsrDeudor
           LOOP 
       ENDIF 
        
	 IF Csrdeudor.dias#0
		 SELECT CsrVendedor
		 LOCATE FOR numero=CsrDeudor.vendedor
		 
		SELECT CsrVendeVie
		LOCATE FOR numero=CsrVendedor.numero		 
		
		SELECT CsrZonasVie
		LOCATE FOR numero=Csrvendevie.zona
		 
		 SELECT Csrzona
		 LOCATE FOR ALLTRIM(nombre) = ALLTRIM(CsrzonasVie.nombre)
		 
		 IF VAL(CsrDeudor.mt)#0 AND Csrvendedor.id#0 AND Csrzona.id#0 AND VAL(CsrDeudor.mt)<3
			 SELECT CsrFuerzaVta
			 LOCATE FOR numero=VAL(CsrDeudor.mt)		     
			 
			 SELECT CsrRuta
			 LOCATE FOR nombre=TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
			 IF nombre#TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
				INSERT INTO CsrRuta (id,numero,nombre) VALUES (lnid,lnid,TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3))		     		
				lnid = lnid + 1
			 ENDIF 
		
			SELECT Csrzonaruta
			LOCATE FOR idzona=Csrzona.id AND idruta = Csrruta.id
			IF idzona#Csrzona.id OR idruta # Csrruta.id
				INSERT INTO Csrzonaruta (id,idzona,idruta,switch) VALUES (lnidzonaruta,Csrzona.id,Csrruta.id,'00000')
				lnidzonaruta = lnidzonaruta + 1
		      ENDIF 
		      
			 SELECT CsrRutaVdor
			 LOCATE FOR idvendedor=Csrvendedor.id  AND idruta=Csrruta.id AND idfuerzavta=CsrFuerzaVta.id
			 IF idvendedor#Csrvendedor.id  OR idruta#Csrruta.id OR idfuerzavta#CsrFuerzaVta.id
				INSERT INTO CsrRutaVdor (id,idruta,idvendedor,switch,idfuerzavta);
				VALUES (lnidrutavdor,Csrruta.id,Csrvendedor.id,'00000',Csrfuerzavta.id)
				lnidrutavdor = lnidrutavdor + 1
			 ENDIF 
			 
			 lcdias = ALLTRIM(STR(Csrdeudor.dias))
			 FOR i=1 TO LEN(lcdias)
			SELECT CsrCaberuta
			LOCATE FOR idrutavdor=Csrrutavdor.id AND dia=VAL(SUBSTR(lcdias,i,1))
				IF idrutavdor#Csrrutavdor.id OR dia#VAL(SUBSTR(lcdias,i,1))
					INSERT INTO Csrcaberuta (id,idrutavdor,dia) VALUES (lnidcabeza,Csrrutavdor.id,VAL(SUBSTR(lcdias,i,1)))
					lnidcabeza = lnidcabeza + 1
				ENDIF 
				IF Csrdeudor.orden#0
				      SELECT CsrCuerruta
				      LOCATE FOR idcaberuta=Csrcaberuta.id AND idctacte=Csrctacte.id AND orden=Csrdeudor.orden
				      IF idcaberuta#Csrcaberuta.id OR idctacte#Csrctacte.id OR orden#Csrdeudor.orden
		   				INSERT INTO Csrcuerruta (id,idcaberuta,idctacte,orden) VALUES (lnidcuerruta,Csrcaberuta.id,Csrctacte.id,Csrdeudor.orden)
		   				lnidcuerruta = lnidcuerruta + 1
					ENDIF 		   				
				ENDIF 	   				
			NEXT 
		ENDIF 			
		
		 IF VAL(CsrDeudor.mt3)#0 AND Csrvendedor.id # 0 AND VAL(CsrDeudor.mt3)<3
			 SELECT CsrFuerzaVta
			 LOCATE FOR numero=VAL(CsrDeudor.mt3)		     
			 
			 SELECT CsrRuta
			 LOCATE FOR nombre=TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
			 IF nombre#TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
				INSERT INTO CsrRuta (id,numero,nombre) VALUES (lnid,lnid,TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3))		     		
				lnid = lnid + 1
			 ENDIF 
			 
			 SELECT CsrRutaVdor
			 LOCATE FOR idvendedor=Csrvendedor.id  AND idruta=Csrruta.id AND idfuerzavta=CsrFuerzaVta.id
			 IF idvendedor#Csrvendedor.id  OR idruta#Csrruta.id OR idfuerzavta#CsrFuerzaVta.id
				INSERT INTO CsrRutaVdor (id,idruta,idvendedor,switch,idfuerzavta);
				VALUES (lnidrutavdor,Csrruta.id,Csrvendedor.id,'00000',Csrfuerzavta.id)
				lnidrutavdor = lnidrutavdor + 1
			 ENDIF 
			 
			 lcdias = ALLTRIM(STR(Csrdeudor.dias))
			 FOR i=1 TO LEN(lcdias)
			SELECT CsrCaberuta
			LOCATE FOR idrutavdor=Csrrutavdor.id AND dia=VAL(SUBSTR(lcdias,i,1))
				IF idrutavdor#Csrrutavdor.id OR dia#VAL(SUBSTR(lcdias,i,1))
					INSERT INTO Csrcaberuta (id,idrutavdor,dia) VALUES (lnidcabeza,Csrrutavdor.id,VAL(SUBSTR(lcdias,i,1)))
					lnidcabeza = lnidcabeza + 1
				ENDIF 
				IF Csrdeudor.orden2#0
				      SELECT CsrCuerruta
				      LOCATE FOR idcaberuta=Csrcaberuta.id AND idctacte=Csrctacte.id AND orden=Csrdeudor.orden2
				      IF idcaberuta#Csrcaberuta.id OR idctacte#Csrctacte.id OR orden#Csrdeudor.orden2				
		   				INSERT INTO Csrcuerruta (id,idcaberuta,idctacte,orden) VALUES (lnidcuerruta,Csrcaberuta.id,Csrctacte.id,Csrdeudor.orden2)
	     				      lnidcuerruta = lnidcuerruta + 1
					ENDIF 	     				      
				ENDIF 	   				
			NEXT 
		ENDIF 					
	ENDIF 
	
**
	 IF Csrdeudor.dias2#0
		 SELECT CsrVendedor
		 LOCATE FOR numero=CsrDeudor.vende2
		SELECT CsrVendeVie
		LOCATE FOR numero=CsrVendedor.numero		 
		SELECT CsrZonasVie
		LOCATE FOR numero=Csrvendevie.zona
		 
		 SELECT Csrzona
		 LOCATE FOR ALLTRIM(nombre) = ALLTRIM(CsrzonasVie.nombre)
	 		 
		 IF VAL(CsrDeudor.mt2)#0 AND Csrvendedor.id # 0 AND CsrZona.id # 0 AND VAL(CsrDeudor.mt2)<3
			 SELECT CsrFuerzaVta
			 LOCATE FOR numero=VAL(CsrDeudor.mt2)		     
			 
			 SELECT CsrRuta
			 LOCATE FOR nombre=TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
			 IF nombre#TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
				INSERT INTO CsrRuta (id,numero,nombre) VALUES (lnid,lnid,TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3))		     		
				lnid = lnid + 1
			 ENDIF 
			 
			 SELECT CsrRutaVdor
			 LOCATE FOR idvendedor=Csrvendedor.id  AND idruta=Csrruta.id AND idfuerzavta=CsrFuerzaVta.id
			 IF idvendedor#Csrvendedor.id  OR idruta#Csrruta.id OR idfuerzavta#CsrFuerzaVta.id
				INSERT INTO CsrRutaVdor (id,idruta,idvendedor,switch,idfuerzavta);
				VALUES (lnidrutavdor,Csrruta.id,Csrvendedor.id,'00000',Csrfuerzavta.id)
                           lnidrutavdor = lnidrutavdor + 1
			 ENDIF 
			 
			 lcdias = ALLTRIM(STR(Csrdeudor.dias2))
			 FOR i=1 TO LEN(lcdias)
			SELECT CsrCaberuta
			LOCATE FOR idrutavdor=Csrrutavdor.id AND dia=VAL(SUBSTR(lcdias,i,1))
				IF idrutavdor#Csrrutavdor.id OR dia#VAL(SUBSTR(lcdias,i,1))
					INSERT INTO Csrcaberuta (id,idrutavdor,dia) VALUES (lnidcabeza,Csrrutavdor.id,VAL(SUBSTR(lcdias,i,1)))
					lnidcabeza = lnidcabeza + 1
				ENDIF 
				IF Csrdeudor.ordven2#0
				      SELECT CsrCuerruta
				      LOCATE FOR idcaberuta=Csrcaberuta.id AND idctacte=Csrctacte.id AND orden=Csrdeudor.ordven2
				      IF idcaberuta#Csrcaberuta.id OR idctacte#Csrctacte.id OR orden#Csrdeudor.ordven2				
		   				INSERT INTO Csrcuerruta (id,idcaberuta,idctacte,orden) VALUES (lnidcuerruta,Csrcaberuta.id,Csrctacte.id,Csrdeudor.ordven2)
		   				lnidcuerruta = lnidcuerruta + 1
					ENDIF 		   				
				ENDIF 	   				
			NEXT 
		ENDIF 			
		
		 IF VAL(CsrDeudor.mt4)#0 AND Csrvendedor.id # 0 AND VAL(CsrDeudor.mt4)<3
			 SELECT CsrFuerzaVta
			 LOCATE FOR numero=VAL(CsrDeudor.mt4)
			 
			 SELECT CsrRuta
			 LOCATE FOR nombre=TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
			 IF nombre#TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3)
				INSERT INTO CsrRuta (id,numero,nombre) VALUES (lnid,lnid,TRIM(Csrzona.nombre)+" "+STR(Csrvendedor.numero,3))		     		
				lnid = lnid + 1
			 ENDIF 
			 
			 SELECT CsrRutaVdor
			 LOCATE FOR idvendedor=Csrvendedor.id  AND idruta=Csrruta.id AND idfuerzavta=CsrFuerzaVta.id
			 IF idvendedor#Csrvendedor.id  OR idruta#Csrruta.id OR idfuerzavta#CsrFuerzaVta.id
				INSERT INTO CsrRutaVdor (id,idruta,idvendedor,switch,idfuerzavta)  VALUES (lnidrutavdor,Csrruta.id,Csrvendedor.id,'00000',Csrfuerzavta.id)
				lnidrutavdor = lnidrutavdor + 1
			 ENDIF 
			 
			 lcdias = ALLTRIM(STR(Csrdeudor.dias2))
			 FOR i=1 TO LEN(lcdias)
			SELECT CsrCaberuta
			LOCATE FOR idrutavdor=Csrrutavdor.id AND dia=VAL(SUBSTR(lcdias,i,1))
				IF idrutavdor#Csrrutavdor.id OR dia#VAL(SUBSTR(lcdias,i,1))
					INSERT INTO Csrcaberuta (id,idrutavdor,dia) VALUES (lnidcabeza,Csrrutavdor.id,VAL(SUBSTR(lcdias,i,1)))
					lnidcabeza = lnidcabeza + 1
				ENDIF 
				IF Csrdeudor.orden3#0
				      SELECT CsrCuerruta
				      LOCATE FOR idcaberuta=Csrcaberuta.id AND idctacte=Csrctacte.id AND orden=Csrdeudor.orden3
				      IF idcaberuta#Csrcaberuta.id OR idctacte#Csrctacte.id OR orden#Csrdeudor.orden3				
		   				INSERT INTO Csrcuerruta (id,idcaberuta,idctacte,orden) VALUES (lnidcuerruta,Csrcaberuta.id,Csrctacte.id,Csrdeudor.orden3)
		   				lnidcuerruta = lnidcuerruta + 1
					ENDIF 		   				
				ENDIF 	   				
			NEXT 
		ENDIF 					
	ENDIF 
	 	                                                 
	SELECT CsrDeudor         
ENDSCAN

CLOSE ALL 
	