*-- Procedimiento para manejar errores WSAA
PROCEDURE errhand1
	*--PARAMETER merror, mess, mess1, mprog, mlineno
	LOCAL cMensaje
	cMensaje	= ""
	cMensaje	= cMensaje + WSAA.Excepcion + CHR(13)
	cMensaje	= cMensaje + WSAA.Traceback + CHR(13)
	*--? WSAA.XmlRequest
	*--? WSAA.XmlResponse
	stop()
	*-- trato de extraer el código de error de afip (1000)
	afiperr = ERROR() -2147221504 
	if afiperr>1000 and afiperr<2000 then
		cMensaje	= cMensaje + 'codigo error afip:' + strtrim(afiperr,5) + CHR(13)
	else
		afiperr = 0
	endif
	cMensaje	= cMensaje + 'Error number: ' + LTRIM(STR(ERROR())) + CHR(13)
	cMensaje	= cMensaje + 'Error message: ' + MESSAGE() + CHR(13)
	cMensaje	= cMensaje + 'Line of code with error: ' + MESSAGE(1) + CHR(13)
	cMensaje	= cMensaje + 'Line number of error: ' + LTRIM(STR(LINENO())) + CHR(13)
	cMensaje	= cMensaje + 'Program with error: ' + PROGRAM() + CHR(13)
	
	=Grabar_SEC(cMensaje,"Log_ErrorFAC.txt","Aplicaciones\Temporal")
	
	*-- Preguntar: Aceptar o cancelar?
	ch = MESSAGEBOX(WSAA.Excepcion, 5 + 48, "Error: " + cMensaje)
	IF ch = 2 && Cancelar
		ON ERROR 
		CLEAR EVENTS
		CLOSE ALL
		RELEASE ALL
		CLEAR ALL
		CANCEL
	ENDIF	
ENDPROC

*-- Procedimiento para manejar errores WSFE
PROCEDURE errhand2
	*--PARAMETER merror, mess, mess1, mprog, mlineno
	LOCAL cMensaje
	cMensaje = ""
	cMensaje	= cMensaje + WSFE.Excepcion + CHR(13)
	cMensaje	= cMensaje + WSFE.Traceback + CHR(13)
	*--? WSFE.XmlRequest
	*--? WSFE.XmlResponse
		
	cMensaje	= cMensaje + 'Error number: ' + LTRIM(STR(ERROR())) + CHR(13)
	cMensaje	= cMensaje + 'Error message: ' + MESSAGE() + CHR(13)
	cMensaje	= cMensaje + 'Line of code with error: ' + MESSAGE(1) + CHR(13)
	cMensaje	= cMensaje + 'Line number of error: ' + LTRIM(STR(LINENO())) + CHR(13)
	cMensaje	= cMensaje + 'Program with error: ' + PROGRAM() + CHR(13)
	
	=Grabar_SEC(cMensaje,"Log_ErrorFAC.txt","Aplicaciones\Temporal")
	
	*-- Preguntar: Aceptar o cancelar?
	ch = MESSAGEBOX(WSFE.Excepcion, 5 + 48, "Error: " + cMensaje)
	IF ch = 2 && Cancelar
		ON ERROR 
		CLEAR EVENTS
		CLOSE ALL
		RELEASE ALL
		CLEAR ALL
		CANCEL
	ENDIF	
ENDPROC
