CLOSE DATABASES
CLOSE TABLES
*!*	OPEN DATABASE ? EXCLUSIVE

*!*	SET SAFETY OFF

*!*	SET CPCOMPILE TO 1252
*!*	codepage = 1252
*!*	SET CPDIALOG ON

*!*	SET DATABASE TO DATOS

*!*	USE datos!producto IN 0 ALIAS CsrProducto EXCLUSIVE

*!*	USE datos!subproducto IN 0 ALIAS CsrSubProducto EXCLUSIVE

*!*	USE datos!existenc IN 0 ALIAS CsrStock EXCLUSIVE
*!*	ZAP IN CsrStock

*!*	USE datos!movstock IN 0 ALIAS CsrMovStock EXCLUSIVE
*!*	ZAP IN CsrMovStock

*!*	USE datos!maopera IN 0 ALIAS CsrMaopera EXCLUSIVE

*!*	USE datos!deposito IN 0 ALIAS CsrDeposito EXCLUSIVE

*!*	SET SAFETY ON

*!*	USE  "\starossa\existenc" in 0 alias CsrExistencia EXCLUSIVE

*!*	ldfecha = DATE()
*!*	ldfechasis=DATETIME(YEAR(ldfecha),MONTH(ldfecha),DAY(ldfecha),0,0,0)
*!*	lnid=1
*!*	lnidmov=1
*!*	SELECT CsrMaopera
*!*	IF RECCOUNT('CsrMaopera')>0
*!*		GO bottom
*!*		lnidmaopera=Csrmaopera.id+1
*!*	ENDIF
*!*	SELECT deposito as iddeposito,numero as idproducto,exiuni as existe;
*!*	FROM CsrExistencia WHERE exiuni<>0 ORDER BY iddeposito,idproducto INTO CURSOR 'CsrLista' READWRITE 

*!*	SELECT CsrLista
*!*	Oavisar.proceso('S','Procesando '+alias()) 
*!*	GO TOP 
*!*	SCAN FOR !EOF('CsrLista')
*!*		SELECT CsrDeposito
*!*		LOCATE FOR numero=CsrLista.iddeposito
*!*		IF FOUND()
*!*			SELECT CsrProducto
*!*			LOCATE FOR numero=CsrLista.idproducto
*!*			IF FOUND()
*!*				lccodigo=ALLTRIM(STR(CsrProducto.numero) )
*!*			  	SELECT CsrSubProducto
*!*			  	LOCATE FOR numero=CsrProducto.numero
*!*			  	IF FOUND()
*!*					lnidsub=CsrSubproducto.id
*!*			  	ELSE
*!*					lnidsub=0
*!*			  	ENDIF
*!*			
*!*				ldfecha=DATETIME(1996,1,1,0,0,0)
*!*				INSERT INTO CsrStock (id,idarticulo,iddeposito,idsubarti,existe,existeant,existedisp,fecvto,kilos,kilosant,kilosdisp,volumen,volumenant,volumendisp);
*!*				 VALUES (lnid,CsrProducto.id,CsrDeposito.id,lnidsub,INT(Round(CsrLista.existe,0)),0,INT(Round(CsrLista.existe,0)),ldfecha,CsrProducto.peso,0,CsrProducto.peso*INT(Round(CsrLista.existe,0)),0,0,0)
*!*				lnid=lnid+1
*!*				
*!*				IF CsrLista.existe<>0
*!*					IF CsrLista.existe>0
*!*						lnidcomproba = 9
*!*						lcclasecomp = "L"
*!*					ELSE
*!*						lnidcomproba = 10
*!*						lcclasecomp = "M"
*!*					ENDIF
*!*					lcletra="X"
*!*					lcnum="00000000"
*!*					lcnumero=lcletra+"0000"+lcnum
*!*					
*!*					INSERT INTO CsrMaopera (id,origen,programa,sucursal,terminal,sector;
*!*					,fechasis,idoperador,idvendedor,iddetanrocaja,idcomproba,numcomp;
*!*					,clasecomp,turno,puestocaja,idcotizadolar,switch,estado,detalle,fechaserver);
*!*					VALUES (lnidmaopera,"IMP","IMPORTACION",1,9,1,ldfechasis,1,1,100021,lnidcomproba,lcnumero;
*!*					,lcclasecomp,1,1,1,"0000","0","Importación",ldfechasis)
*!*					
*!*					INSERT INTO CsrMovStock (idmaopera,idorigen,idarticulo,idsubarti,codigo;
*!*					,fecha,iddeposito,cantidad,kilos,volumen,importe,switch,signo);
*!*					VALUES (lnidmaopera,lnidmaopera,CsrProducto.id,lnidsub,lccodigo;
*!*					,ldfechasis,CsrDeposito.id,INT(round(ABS(CsrLista.existe),0)),0,0,0,"0000",IIF(CsrLista.existe>0,1,-1))
*!*					
*!*					*lnidmov=lnidmov+1
*!*					lnidmaopera=lnidmaopera+1
*!*				ENDIF
*!*				
*!*			ENDIF 
*!*		ENDIF
*!*		SELECT CsrLista
*!*		
*!*	ENDSCAN
Oavisar.proceso('N') 
=MESSAGEBOX('Proceso terminado! ')
CLOSE tables
CLOSE INDEXES
CLOSE DATABASES


