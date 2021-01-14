FUNCTION TomarFacturaExcelProveedor
PARAMETERS nIdProveedor

PUBLIC oExcelFactura,oExcelReporte
LOCAL loCatchErr As Exception
LOCAL lExcel
lExcel = .t.
TRY 
	oExcelFactura= CREATEOBJECT("Excel.Application") 
CATCH TO loCatchErr
	lExcel = .f.
ENDTRY   

IF !lExcel
      =Oavisar.usuario("No se puede procesar el archivo porque no tiene la aplicación" ;
        + CHR(13) + "Microsoft Excel instalada en su computador.",0)
	RETURN .f.
ENDIF

IF USED('CsrFactura')
	USE IN CsrFactura
ENDIF 
CREATE CURSOR CsrFactura (codproveedor c(15),cantidad i)

NombrePlanilla = GETFILE('xlsx','Abrir Archivo de Proveedor')
*NombrePlanilla = "J:\Aplicaciones\santarossa\Factura Unilever 454-555438.xlsx"

DO CASE
CASE nIdProveedor = 1
	Format_Unilever()
OTHERWISE
	oavisar.usuario('No existe el formato definido para el proveedor elegido.')
	RETURN .f.
ENDCASE

RETURN .t.

FUNCTION Format_Unilever()

	with oExcelFactura
		.Visible = .F.
	  	.Application.WorkBooks.Open(NombrePlanilla)
	  
		&&Extraemos los articulos  
	  	LOCAL nCodigo
	  	
	  	Fila = 7     
	  	.Sheets(4).Select
	  	nCodigo = .Cells(Fila, 1).Value     
	  	nCodigo = INT(IIF(TYPE('nCodigo')$'N',nCodigo,VAL(nCodigo)))
	  	cCodigo = ALLTRIM(STR(nCodigo,15))
	  	do while LEN(Trim(cCodigo)) <> 0    && Condición para saber donde terminan los datos, se podrían agregar más condiciones
	    	*oavisar.usuario(cCodigo)
	    	nCantidad = .Cells(Fila,5).Value
	    	nCantidad = INT(IIF(TYPE('nCantidad')$'N',nCantidad ,VAL(nCantidad )))
	    	
	    	APPEND BLANK IN CsrFactura
	    	replace codproveedor WITH cCodigo, cantidad WITH nCantidad IN csrFactura
	    	
	    	Fila = Fila + 1     && Se procesará la siguiente fila
	    	nCodigo = .Cells(Fila, 1).Value     
	  		nCodigo = INT(IIF(TYPE('nCodigo')$'N',nCodigo,VAL(nCodigo)))
	  		cCodigo = NVL(ALLTRIM(STR(nCodigo,15)),'')
	  	enddo
	ENDWITH
	
	SELECT CsrFactura
	vista()
	
ENDFUNC  