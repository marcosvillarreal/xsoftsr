
CLOSE DATABASES
OPEN DATABASE ? EXCLUSIVE

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON
SET SAFETY OFF 
SET DATABASE TO DATOS
USE datos!producto IN 0 ALIAS Csrproducto EXCLUSIVE

USE datos!ctacte IN 0 ALIAS Csrctacte EXCLUSIVE

USE datos!vendedor IN 0 ALIAS Csrvendedor EXCLUSIVE

USE datos!cabepromo IN 0 ALIAS CsrCabepromo EXCLUSIVE 
ZAP IN CsrCabepromo

USE datos!cuerpromo IN 0 ALIAS Csrcuerpromo EXCLUSIVE 
ZAP IN CsrCuerpromo

USE datos!bonictacte IN 0 ALIAS CsrBonictacte EXCLUSIVE 
ZAP IN CsrBonictacte 

USE datos!bonivdor IN 0 ALIAS CsrBonivdor EXCLUSIVE 
ZAP IN CsrBonivdor

USE  "\starossa\articulo" in 0 alias CsrArticulo EXCLUSIVE	
SELECT Csrarticulo
INDEX on numero TO art1
INDEX on codboni TO art2
SET INDEX TO art1,art2

USE  "\starossa\boniven" in 0 alias CsrBonivende EXCLUSIVE	
SELECT Csrbonivende
INDEX on vendedor TO ven1

USE  "\starossa\bonicli" in 0 alias CsrBonicli EXCLUSIVE	
SELECT Csrbonicli
INDEX on cliente TO cli1

USE  "\starossa\boniart" in 0 alias CsrBoniarticulo EXCLUSIVE	
SELECT Csrboniarticulo
INDEX on articulo TO bon1
SET SAFETY ON
lnid = 1
            
SELECT CsrArticulo
GO top
SCAN FOR !EOF()
     lnrecno = RECNO()
     
      SELECT Csrproducto
      LOCATE FOR numero=Csrarticulo.numero
      lnidprodgenera = 0
      lcnomgenera = ""
      IF !EOF() AND numero=Csrarticulo.numero
          lnidprodgenera = Csrproducto.id
          lcnomgenera = Csrproducto.nombre
      ENDIF
      SELECT Csrarticulo
      
      lnnolista    = IIF(Csrarticulo.figlista="N",1,0)
      lnnofactu   = IIF(Csrarticulo.nofactu,1,0)
       lnespromo = IIF(csrarticulo.escodboni="S",1,0)
       
       _codbodigi = Csrarticulo.numero

      if lnespromo=1  AND  lnnofactu=0   AND lnidprodgenera#0
      
         SET ORDER TO 2
         seek _codbodigi
         DO WHILE !EOF()  AND  codboni=_codbodigi  AND  _codbodigi<>0              
               IF  (regalo<>0  OR  porcada<>0)   &&  AND  nofactu               
                   lncada = porcada
                   lnentrega = regalo
                  
		      SELECT Csrproducto
		      LOCATE FOR numero=Csrarticulo.numero
		      lnidprodpromo = 0
		      IF !EOF() AND numero=Csrarticulo.numero
		          lnidprodpromo = Csrproducto.id
		      ENDIF

		      LOCATE FOR numero=Csrarticulo.codboori
		      lnidprodregalo = 0
		      IF !EOF() AND numero=Csrarticulo.codboori
		          lnidprodregalo = Csrproducto.id
		      ENDIF
			ldfechasta = DATETIME(YEAR(DATE()+365),MONTH(DATE()),DAY(DATE()),0,0,0)
			
             	      INSERT INTO CsrCabepromo (id,idprodgenera,nombre,idprodpromo,idprodregalo,cada,entrega,fechasta);	  	    	      
				  VALUES (lnid,lnidprodgenera,lcnomgenera,lnidprodpromo,lnidprodregalo,lncada,lnentrega,ldfechasta)
			lnid = lnid + 1
		  ENDIF 		  
		  
 	        SELECT Csrarticulo
 	        SKIP 
	  ENDDO
	  			  
	ENDIF
	
	SELECT CsrArticulo
	SET ORDER TO 1
	GO lnrecno
	     				
ENDSCAN

lnidcuerpo = 1

SELECT CsrBoniarticulo
GO top
DO WHILE !EOF()
     lnarticulo = articulo
     
      SELECT Csrproducto
	LOCATE FOR numero = CsrBoniarticulo.articulo
      lnidprodgenera = 0
      lcnomgenera = ""
      lccodgenera = 0
      IF !EOF() AND numero=CsrBoniarticulo.articulo
          lnidprodgenera = Csrproducto.id
          lcnomgenera = Csrproducto.nombre
          lccodgenera  = Csrproducto.numero
      ENDIF
      
	ldfechasta = DATETIME(YEAR(DATE()+365),MONTH(DATE()),DAY(DATE()),0,0,0)
      
      INSERT INTO CsrCabepromo (id,idprodgenera,numero,nombre,idprodpromo,idprodregalo,cada,entrega,fechasta);	  	    	      
				  VALUES (lnid,lnidprodgenera,lccodgenera,lcnomgenera,0,0,0,0,ldfechasta)
      
      SELECT CsrBoniarticulo
	DO WHILE !EOF()  AND articulo = lnarticulo
	      lndesde = desde
	      lnhasta = hasta
	      lnbonifica = bonif
		INSERT INTO CsrCuerpromo (id,idcabepromo,candesde,canhasta,bonifica,fechasta);
						VALUES (lnidcuerpo,lnid,lndesde,lnhasta,lnbonifica,ldfechasta)
		lnidcuerpo = lnidcuerpo + 1
									      
		SELECT CsrBoniArticulo
		SKIP
	ENDDO 
	
      lnid = lnid + 1
      
ENDDO        

lnid = 1

SELECT CsrBonivende
GO top
DO WHILE !EOF()
      lnarticulo = articulo
      lcdiasvisita = "0000000"
      lcdiasfactura = "0000000"
      lcvalor = LTRIM(STR(dias))
      FOR i=1 TO LEN(lcvalor)
               lcdia = VAL(SUBSTR(lcvalor,i,1))               
               lcdiasvisita = LEFT(lcdiasvisita,lcdia-1)+"1"+SUBSTR(lcdiasvisita,lcdia+1)
      NEXT

      lcvalor = LTRIM(STR(diasfactu))
      FOR i=1 TO LEN(lcvalor)
               lcdia = VAL(SUBSTR(lcvalor,i,1))
               
               lcdiasfactura = LEFT(lcdiasfactura,lcdia-1)+"1"+SUBSTR(lcdiasfactura,lcdia+1)
      NEXT

           
      SELECT Csrproducto
	LOCATE FOR numero = CsrBonivende.articulo
      lnidproducto = 0
      IF !EOF() AND numero=CsrBonivende.articulo
          lnidproducto = Csrproducto.id
      ENDIF
      
      SELECT Csrvendedor
      LOCATE FOR numero=CsrBonivende.vendedor
      lnidvendedor = 0
      IF !EOF() AND numero=CsrBonivende.vendedor
          lnidvendedor = Csrvendedor.id
      ENDIF
      
      INSERT INTO CsrBonivdor (id,idproducto,idvendedor,bonifica,diasvisita,diasfactura);	  	    	      
				  VALUES (lnid,lnidproducto,lnidvendedor,CsrBonivende.bonif,lcdiasvisita,lcdiasfactura)
      
      SELECT CsrBoniVende
     SKIP
      lnid = lnid + 1
      
ENDDO        


lnid = 1

SELECT CsrBonicli
GO top
DO WHILE !EOF()
     
      SELECT Csrproducto
	LOCATE FOR numero = CsrBonicli.articulo
      lnidproducto = 0
      IF !EOF() AND numero=CsrBonicli.articulo
          lnidproducto = Csrproducto.id
      ENDIF
      
      SELECT Csrctacte
      LOCATE FOR VAL(cnumero)=Csrbonicli.cliente
      lnidctacte = 0
      IF !EOF() AND VAL(cnumero)=Csrbonicli.cliente
          lnidctacte = Csrctacte.id
      ENDIF
      
      IF lnidproducto#0 AND lnidctacte#0
	      INSERT INTO CsrBonictacte (id,idproducto,idctacte,bonifica,fecha);	  	    	      
					  VALUES (lnid,lnidproducto,lnidctacte,CsrBonicli.bonif,DATEtime(1900,01,01,0,0,0))
           lnid = lnid + 1
	ENDIF 
	      
      SELECT CsrBonicli
     SKIP
      
ENDDO        


Oavisar.proceso('N') 
=MESSAGEBOX('Proceso terminado! ')
CLOSE tables
CLOSE INDEXES
CLOSE DATABASES

	