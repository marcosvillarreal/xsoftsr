
IF USED('CsrCursor')
	USE IN CsrCursor
ENDIF 
CREATE CURSOR CsrCursor (detalle c(250),detalle1 c(250))

xarchivo=GETFILE('CSV','Archivo de Excel','Abrir',1,'Abrir Archivo de Planilla de Excel') 

&& Luego puedes usar una base de datos vacia para agregar los registros. 
SELECT CsrCursor
APPEND FROM (xarchivo) SDF 
BROWSE 


&&IMPORT FROM J:\Lista\Lista_Unilever.XLS TYPE XLS 

&&Podria ser que el nombre de la Hoja1 sea diferente entonces 

&&IMPORT FROM Archivo.XLS TYPE XLS SHEET  