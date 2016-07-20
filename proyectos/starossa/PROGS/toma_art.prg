DEBUG
SUSPEND

SET DATABASE TO DATOS
USE datos!producto IN 0 ALIAS Csrproducto

USE GETFILE() IN 0 ALIAS Csrarticulo


SELECT CsrArticulo
GO top
SCAN FOR !EOF()
	INSERT INTO Csrproducto (NUMERO,NOMBRE,CODALFA,IDIVA,PRECPRA,MARGEN1,PREVTA1,MARGEN2,PREVTA2,SWITCH); 
	  VALUES (Csrarticulo.NUMERO,Csrarticulo.NOMBRE,LTRIM(STR(Csrarticulo.numero)),Csrarticulo.tablaiva,Csrarticulo.costo,Csrarticulo.utilidad,Csrarticulo.PREVenTA1;
	,Csrarticulo.utilidad,Csrarticulo.PREVenTA2,"NNNNN")
ENDSCAN
CLOSE ALL 
	