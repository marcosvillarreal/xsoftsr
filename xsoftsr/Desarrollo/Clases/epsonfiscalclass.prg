EXTERNAL ARRAY aFiscalStatus
EXTERNAL ARRAY aPrinterStatus

#DEFINE errprnlnf " Ha ocurrido un error al imprimir el último ;"+;
				  "item del corriente documento fiscal. Inten_ ;"+;
				  "te tratar de imprimir nuevamente el corres_ ;"+;
				  "pondiente Item, reintentando el proceso o   ;"+;
				  "bien. Si el probleme persiste cancele la im_;"+;
				  "presión y el documento se cancelar  autom _ ;"+;
				  "ticamente.                                  "
#DEFINE cantopenport  " El Controlador Fiscal no responde. ;" +;
					  "Verifique que otra aplicación no es_;" +;
					  "té utilizandolo en éste instante.   "
#DEFINE cantcloseport " El Controlador Fiscal no responde al;" +;
					  "momento de cerrar la última petición ;" +;
					  "solicitada.                          "
#DEFINE NoHexNumber   " El Controlador Fiscal generó un;"+;
					  "Numero hexadecimal incorrecto.  "
#DEFINE ErrSendData   "Error de envío de datos al Controlador"
#DEFINE OkSetTiHour "La Hora y la Fecha del Controlador fuero cambiadas con éxito."
#DEFINE OkFisStatus " El Controlador Fiscal no respondió;con error alguno durante la verifi_;cación del mismo.                  ;"
#DEFINE CantRecFisc " El Controlador Fiscal no guardó correctamente ;"+;
					"el último documento. Deberá verificar que los  ;"+;
					"totales del día coincidan con el cierre de Jor_;"+;
					"nada Fiscal que el Controlador emitirá al final;"+;
					"del día.                                       "

DEFINE CLASS EpsonFiscalClass AS Custom
	FisDrv = .NULL.
	RespuestaFiscal = ""
	
	FUNCTION Init(nPort)
		This.FisDrv = RS232Driver(nPort)
		
		RETURN !ISNULL(This.FisDrv)
	ENDFUNC
	
	FUNCTION StateRS232
		PARAMETERS cRespuesta, aAnswers
		PRIVATE nCont, cRetVal, nOffsetSep, nOrigen, aPortResult

		DECLARE aPortResult[16,2]

		aPortResult = 0

		aPortResult[1,1]  = "Buffer de Transmisión Vacío"
		aPortResult[2,1]  = "Buffer de Recepción Vacío"
		aPortResult[3,1]  = "Estado de Linea DTR (Data Terminal Ready)"
		aPortResult[4,1]  = "Estado de Linea RTS (Request to Send)"
		aPortResult[5,1]  = "Estado de Linea DSR (Data Set Ready)"
		aPortResult[6,1]  = "Estado de Linea CTS (Clear to Send)"
		aPortResult[7,1]  = ""
		aPortResult[8,1]  = ""
		aPortResult[9,1]  = ""
		aPortResult[10,1] = ""
		aPortResult[11,1] = ""
		aPortResult[12,1] = ""
		aPortResult[13,1] = ""
		aPortResult[14,1] = ""
		aPortResult[15,1] = ""
		aPortResult[16,1] = ""

		DECLARE aAnswers[16,2]

		cRetVal = ""
		cRespuesta = SUBST(cRespuesta, 1, AT(CHR(28), cRespuesta, 1)-1)

		* Convierte en entero el status del impresor

		nPrinterStatus = base2dec(cRespuesta, 16)

		* Analiza los bits comenzando del menos significativo
		FOR nCont = 1 TO 16
			aAnswers[nCont,1] = aPortResult[nCont,1]

			IF ( INT (nPrinterStatus % 2) == 1 )
				aAnswers[nCont,2] = 0
			ELSE
				aAnswers[nCont,2] = 1
			ENDIF

			nPrinterStatus = nPrinterStatus / 2	
		NEXT

		RETURN cRetVal
	ENDFUNC

	FUNCTION EpsonPrnSt
		PARAMETERS cRespuesta, aAnswers
		PRIVATE nCont, cRetVal, nOffsetSep, nOrigen, aPrinterErrors

		DECLARE aPrinterErrors[16]

		aPrinterErrors[1]  = ""
		aPrinterErrors[2]  = ""
		aPrinterErrors[3]  = "Error de Impresora"
		aPrinterErrors[4]  = "Impresora Offline"
		aPrinterErrors[5]  = "Falta papel del diario"
		aPrinterErrors[6]  = "Falta papel de tickets"
		aPrinterErrors[7]  = "Buffer de Impresora lleno"
		aPrinterErrors[8]  = "Buffer de Impresora vacío"
		aPrinterErrors[9]  = "Tapa de impresora slip abierta"
		aPrinterErrors[10] = ""
		aPrinterErrors[11] = ""
		aPrinterErrors[12] = ""
		aPrinterErrors[13] = "Cajón de dinero cerrado o ausente"
		aPrinterErrors[14] = ""
		aPrinterErrors[15] = "Impresora sin papel a ser impreso"
		aPrinterErrors[16] = ""

		DECLARE aAnswers[16]

		cRetVal = ""
		cRespuesta = SUBST(cRespuesta, 1, AT(CHR(28), cRespuesta, 1)-1)

		* Convierte en entero el status del impresor

		nPrinterStatus = base2dec(cRespuesta, 16)

		* Analiza los bits comenzando del menos significativo
		FOR nCont = 1 TO 16
			IF ( INT (nPrinterStatus % 2) == 1 )
				aAnswers[nCont] = aPrinterErrors[nCont]
			ELSE
				aAnswers[nCont] = ""
			ENDIF

			nPrinterStatus = nPrinterStatus / 2	
		NEXT

		RETURN cRetVal
	ENDFUNC

	FUNCTION EpsonFisSt
		PARAMETERS cRespuesta, aAnswers
		PRIVATE nCont, nOrigen, nOffsetSep, aPrinterErrors

		DECLARE aFiscalErrors[16]

		aFiscalErrors[1] = 	"Error en chequeo de memoria fiscal"
		aFiscalErrors[2] = 	"Error en chequeo de la memoria de trabajo"
		aFiscalErrors[3] = 	"Carga de bateria baja"
		aFiscalErrors[4] = 	"Comando desconocido"
		aFiscalErrors[5] = 	"Datos no validos en un campo"
		aFiscalErrors[6] = 	"Comando no valido para el estado fiscal actual"
		aFiscalErrors[7] = 	"Desborde del total"
		aFiscalErrors[8] = 	"Memoria fiscal llena"
		aFiscalErrors[9] = 	"Memoria fiscal a punto de llenarse"
		aFiscalErrors[10] = "Terminal fiscal certificada"
		aFiscalErrors[11] = "Terminal fiscal fiscalizada"
		aFiscalErrors[12] = "Es Necesario hacer un cierre de Jornada Fiscal"
		aFiscalErrors[13] = "Recibo fiscal abierto"
		aFiscalErrors[14] = "Recibo abierto"
		aFiscalErrors[15] = "Factura abierta"
		aFiscalErrors[16] = ""

		DECLARE aAnswers[16]

		cRetVal    = ""
		cRespuesta = SUBST(cRespuesta, AT(CHR(28), cRespuesta, 1)+1)

		IF OCCURS(CHR(28), cRespuesta) > 0
			cRespuesta = SUBST(cRespuesta, 1, AT(CHR(28), cRespuesta, 1)-1)
		ENDIF

		* Convierte en entero el status fiscal
		nFiscalStatus = base2dec(cRespuesta, 16)

		* Analiza los bits comenzando del menos significativo
		FOR nCont = 1 TO 16
			IF ( INT (nFiscalStatus % 2) == 1 )
				aAnswers[nCont] = aFiscalErrors[nCont]
			ELSE
				aAnswers[nCont] = ""
			ENDIF

			nFiscalStatus = nFiscalStatus / 2	
		NEXT

		RETURN cRetVal
	ENDFUNC

	FUNCTION ShowErrMes
		PARAMETERS cMessage

		=Oavisar.usuario("Epson Fiscal Object"+CHR(13)+cMessage, 16 )
	ENDFUNC

	FUNCTION ChkPrnState
		PARAMETERS aAnswers, lNeedPrn, lNotShErr
		PRIVATE cRetVal

		cRetVal = ""

		DO CASE
			CASE aAnswers[3] = "Error de Impresora"
				cRetVal = aAnswers[3]
			CASE aAnswers[4] = "Impresora Offline"
				cRetVal = aAnswers[4]
			CASE aAnswers[5] = "Falta papel del diario" AND lNeedPrn
				cRetVal = aAnswers[5]
			CASE aAnswers[6] = "Falta papel de tickets" AND lNeedPrn
				cRetVal = aAnswers[6]
			CASE aAnswers[7] = "Buffer de Impresora lleno"
				cRetVal = aAnswers[7]
			CASE aAnswers[9] = "Tapa de impresora slip abierta"
				cRetVal = aAnswers[9]
		ENDCASE

		IF !EMPTY(cRetVal)
			IF lNotShErr = .F.
				This.ShowErrMes(cRetVal)
			ENDIF
		ENDIF

		RETURN cRetVal
	ENDFUNC

	FUNCTION ChkFisState
		PARAMETERS aAnswers, lNotShErr, lChkState
		PRIVATE cRetVal

		cRetVal = ""

		DO CASE
			CASE aAnswers[1] = "Error en chequeo de memoria fiscal"
				cRetVal = IIF(lChkState, "", aAnswers[1])
			CASE aAnswers[2] = "Error en chequeo de la memoria de trabajo"
				cRetVal = IIF(lChkState, "", aAnswers[2])
			CASE aAnswers[4] = "Comando desconocido"
				cRetVal = IIF(lChkState, "", aAnswers[4])
			CASE aAnswers[5] = "Datos no validos en un campo"
				cRetVal = IIF(lChkState, "", aAnswers[5])
			CASE aAnswers[6] = "Comando no valido para el estado fiscal actual"
				cRetVal = IIF(lChkState, "", aAnswers[6])
			CASE aAnswers[7] = "Desborde del total"
				cRetVal = IIF(lChkState, "", aAnswers[7])
			CASE aAnswers[8] = "Memoria fiscal llena"
				cRetVal = IIF(lChkState, "", aAnswers[8])
			CASE aAnswers[12] = "Es Necesario hacer un cierre de Jornada Fiscal"
				cRetVal = IIF(lChkState, "", aAnswers[12])
		ENDCASE

		IF !EMPTY(cRetVal)
			IF lNotShErr = .F.
				This.ShowErrMes(cRetVal)
			ENDIF
		ENDIF

		RETURN cRetVal
	ENDFUNC

	*!*
	*!*   FUNCTION SetSpeed
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibido por el controlador.
	*!*  En la variable cRetValue (Pasarla por Referencia)
	*!*  se devolver  los valores del estado consultado
	*!*
	*!*  Valores esperados para <nSpeed>
	*!*
	*!*     75 
	*!*    110 
	*!*    150 
	*!*    300 
	*!*   1200 
	*!*   2400 
	*!*   3600 
	*!*   4800 
	*!*   9600 Recomendada
	*!*  19200 
	*!*  38400 
	*!*  57600
	*!*
	*!*
	FUNCTION SetSpeed
		PARAMETERS nSpeed
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(108)+CHR(28)+CHR(83)+CHR(28)+ALLTRIM(STR(nSpeed, 5))+CHR(28)+CHR(56)+CHR(28)+CHR(78)+CHR(28)+CHR(49))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION chkestado
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibido por el controlador.
	*!*  En la variable cRetValue (Pasarla por Referencia)
	*!*  se devolver  los valores del estado consultado
	*!*
	*!*  Valores esperados para <cQueEsta>
	*!*
	*!*  "N" Informaci¢n Normal
	*!*  "A" Informaci¢n de los contadores de los Documentos
	*!*      fiscales y no fiscales
	*!*  "P" Informaci¢n sobre las caracter¡sticas del controlador
	*!*  "C" Informaci¢n del Contribuyente
	*!*  "D" Informaci¢n sobre el Documento que se est  emitiendo
	*!*
	FUNCTION chkestado
		PARAMETERS cQueEsta, cRetValue, lNotShErr
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(42)+CHR(28)+cQueEsta)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F., lNotShErr)) AND EMPTY(This.ChkFisState(@aFiscalStatus, lNotShErr, .T.))
				cRetValue = cCadena
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			IF lNotShErr = .F.
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*  FUNCTION GetEstFisc
	*!*
	*!*  Verifica el Estado Fiscal de una Impresora
	*!*
	*!*  Valores esperados para <nNroMess>
	*!*
	*!*  1 Devolvera si la terminal est  certificada
	*!*  2 Devolvera si la terminal ya fue fiscalizada
	*!*
	FUNCTION GetEstFisc
		PARAMETERS nNroMess
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(42)+CHR(28)+CHR(78))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = !EMPTY(IsIniPrn(@aFiscalStatus, nNroMess))
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*  FUNCTION IsIniPrn
	*!*
	*!*  Verifica si el contralodor ya fue certificado o fiscalizado.
	*!*  generalmente se utiliza para saber si el controlador
	*!*  est  o no en modo de prueba.
	*!*
	*!*	 <aAnswers> es un vector en donde se encontraran
	*!*	            los estados fiscales devueltos por el controlador
	*!*	            al momento que se verific¢ del Status Fiscal mediante
	*!*	            el m‚todo "EpsonFisSt".
	*!*  <nNroMess> Parametro en donde se pedir  por uno o por otro de los
	*!*			    dos mensajes posibles
	*!*
	FUNCTION IsIniPrn
		PARAMETERS aAnswers, nNroMess

		RETURN aAnswers[IIF(nNroMess = 1, 10, 11)]
	ENDFUNC

	*
	*  FUNCTION gettimefis
	*
	*  Obtiene la Hora del Impresor Fiscal.
	*
	FUNCTION gettimefis
		PRIVATE cCadena, cRetValue, aPrinterStatus, aFiscalStatus,;
				cPrnStatus, cFisStatus

		cRetValue      = "00:00:00"
		cCadena        = This.FisDrv.Enviar(CHR(89))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
			
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				cRetValue = TRANSFORM(VAL(SUBST(cCadena, AT(CHR(28), cCadena, 3) + 1)), "@ 99:99:99")
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN cRetValue
	ENDFUNC

	*
	*  FUNCTION getdatefis
	*
	*  Obtiene la Fecha del Impresor Fiscal.
	*
	FUNCTION getdatefis
		PRIVATE cCadena, dRetValue, aPrinterStatus, aFiscalStatus,;
				cPrnStatus, cFisStatus, cYear

		dRetValue      = CTOD("01/01/1990")
		cCadena        = This.FisDrv.Enviar(CHR(89))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
			
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				dRetValue = TRANSFORM(VAL(SUBST(SUBST(cCadena, AT(CHR(28), cCadena, 2) + 1), 1, AT(CHR(28), SUBST(cCadena, AT(CHR(28), cCadena, 2) + 1), 1) - 1)), "@L 999999")
				
				IF BETWEEN(VAL(SUBST(dRetValue, 1, 2)), 90, 99)
					cYear = STR(1900 + VAL(SUBST(dRetValue, 1, 2)), 4)
				ELSE
					cYear = STR(2000 + VAL(SUBST(dRetValue, 1, 2)), 4)
				ENDIF
				
				dRetValue = CTOD(SUBST(dRetValue, 5, 2) + "/" + SUBST(dRetValue, 3, 2) + "/" + cYear)
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN dRetValue
	ENDFUNC

	*
	*  FUNCTION sethourdate
	*
	*  Establece la Hora y la Fecha del Impresor Fiscal.
	*
	FUNCTION sethourdate
		PARAMETERS cTime, dDate
		PRIVATE aPrinterStatus, aFiscalStatus,;
				cPrnStatus, cFisStatus, lRetValue

		cCadena        = This.FisDrv.Enviar(CHR(88) + CHR(28) + SUBST(STRTRAN(DTOC(dDate), "/", ""), 7, 2) + SUBST(STRTRAN(DTOC(dDate), "/", ""), 3, 2) + SUBST(STRTRAN(DTOC(dDate), "/", ""), 1, 2) + CHR(28) + STRTRAN(cTime, ":", ""))
		lRetValue      = .F.
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
			
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			ELSE
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*
	*  PROCEDURE QuerStaCont
	*
	*  Responde, a trav‚s de la linea serie, con los datos almacenados en
	*  memoria RAM durante la jornada fiscal.
	*
	PROCEDURE QuerStaCont
		PRIVATE cRetValue, cString, nContArray, cData, nCont, aDataRam

		cRetValue = ""

		IF chkestado(CHR(65), @cRetValue)
			cString    = ""
			nContArray = 0
			cData      = SUBST(cRetValue, AT(CHR(28), cRetValue, 2) + 1)
				
			FOR nCont = 1 TO LEN(cData)
				IF SUBST(cData, nCont, 1) = CHR(28)
					nContArray = nContArray + 1
					
					DECLARE aDataRam[nContArray]
						
					aDataRam[nContArray] = cString
					cString = ""
				ELSE
					cString = cString + SUBST(cData, nCont, 1)

					IF nCont = LEN(cData)
						nContArray = nContArray + 1

						DECLARE aDataRam[nContArray]
						
						aDataRam[nContArray] = cString
					ENDIF
				ENDIF
			ENDFOR

			*DO contepsn.spr WITH aDataRam
		ENDIF
	ENDFUNC

	*!*
	*!*  PROCEDURE QInfSeller
	*!*
	*!*  Muestra los datos del Contribuyente
	*!*
	PROCEDURE QInfSeller
		PRIVATE cRetValue, cString, nContArray, cData, nCont, aDataRam

		cRetValue = ""

		IF chkestado(CHR(67), @cRetValue)
			cString    = ""
			nContArray = 0
			cData      = SUBST(cRetValue, AT(CHR(28), cRetValue, 2) + 1)
				
			FOR nCont = 1 TO LEN(cData)
				IF SUBST(cData, nCont, 1) = CHR(28)
					nContArray = nContArray + 1
					
					DECLARE aDataRam[nContArray]
						
					aDataRam[nContArray] = cString
					cString = ""
				ELSE
					cString = cString + SUBST(cData, nCont, 1)

					IF nCont = LEN(cData)
						nContArray = nContArray + 1

						DECLARE aDataRam[nContArray]
						
						aDataRam[nContArray] = cString
					ENDIF
				ENDIF
			ENDFOR

			*DO epsnownr.spr WITH aDataRam
		ENDIF
	ENDFUNC
	
	*!*
	*!*  PROCEDURE QInfPrnFis
	*!*
	*!*  Muestra los datos del Controlador Fiscal Instalado
	*!*
	PROCEDURE QInfPrnFis
		PRIVATE cRetValue, cString, nContArray, cData, nCont, aDataRam

		cRetValue = ""

		IF chkestado(CHR(80), @cRetValue)
			cString    = ""
			nContArray = 0
			cData      = SUBST(cRetValue, AT(CHR(28), cRetValue, 2) + 1)
				
			FOR nCont = 1 TO LEN(cData)
				IF SUBST(cData, nCont, 1) = CHR(28)
					nContArray = nContArray + 1
					
					DECLARE aDataRam[nContArray]
						
					aDataRam[nContArray] = cString
					cString = ""
				ELSE
					cString = cString + SUBST(cData, nCont, 1)

					IF nCont = LEN(cData)
						nContArray = nContArray + 1

						DECLARE aDataRam[nContArray]
						
						aDataRam[nContArray] = cString
					ENDIF
				ENDIF
			ENDFOR

			DO infoepsn.spr WITH aDataRam
		ENDIF
	ENDFUNC


	*!*
	*!*   FUNCTION closdayfis
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibido por el controlador.
	*!*  En el vector <aDataRep> (Pasarlo por Referencia)
	*!*  se devolver  los valores del cierre realizada
	*!*
	*!*  Valores esperados para <cTipo>
	*!*
	*!*  "Z" Realiza un cierre "Z"
	*!*  "X" Realiza un cierre "X" £til para el cambio de cajero
	*!*
	*!*  Valores esperados para <lPrint>
	*!*
	*!*  .T. Imprime el Cierre solicitado
	*!*  .F. No Imprime el Cierre solicitado
	*!*
	FUNCTION closdayfis
		PARAMETERS cTipo, lPrint, aDataRep
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(57)+CHR(28)+cTipo+CHR(28)+IIF(lPrint, CHR(80), CHR(88)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
			
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				IF !EMPTY(aFiscalStatus[9])
					MESSAGEBOX(aFiscalStatus[9] + ". Comunique al Servicio Técnico de su Controlador acerca de éste Mensaje.", 64, "Epson Fiscal Object")
				ENDIF
				
				cString    = ""
				nContArray = 0
				cData      = SUBST(cCadena, AT(CHR(28), cCadena, 2) + 1)
				
				FOR nCont = 1 TO LEN(cData)
					IF SUBST(cData, nCont, 1) = CHR(28)
						nContArray = nContArray + 1
						
						DECLARE aDataRep[nContArray]
						
						aDataRep[nContArray] = cString
						cString = ""
					ELSE
						cString = cString + SUBST(cData, nCont, 1)
						
						IF nCont = LEN(cData)
							nContArray = nContArray + 1
							
							DECLARE aDataRep[nContArray]
							
							aDataRep[nContArray] = cString
						ENDIF
					ENDIF
				ENDFOR
				
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION OpenTicket
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a si el documento
	*!*  pudo o no abrirse
	*!*
	FUNCTION OpenTicket
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(64)+CHR(28)+CHR(67))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
			
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = !EMPTY(aFiscalStatus[13])
			Else
				lRetValue = .F.
			EndIf
		ELSE
			lRetValue = This.ChkIfDocOp()
			
			IF !lRetValue
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION SendExDesc
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  El valor de <cDescrip> debe ser la descripci¢n
	*!*  extra que se desea enviar. No se pueden enviar
	*!*  m s de 3 lineas extras por item a facturar
	*!*
	FUNCTION SendExDesc
		PARAMETERS cDescrip
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(65)+CHR(28)+cDescrip)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION SndTicItem
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  El valor de <cDescLine> es el inicio de la descripci¢n
	*!*  el item a facturar. Se entiende entonces que las lineas
	*!*  extras deben continuar a ‚sta descripci¢n.
	*!*
	*!*  Valores esperados para <cCantidad>
	*!*
	*!*  Debe ser una expresi¢n caracter no superior a 9 caracteres
	*!*  debe respetar el siguiente formato "99999.999" en donde
	*!*  el punto se muestra £nicamente para hacer conocer que
	*!*  los £ltimos tres valores siempre ser n los decimales, pero
	*!*  no debe aparecer dentro del par metro a enviar. Tampoco deben
	*!*  aparecer espacios en blanco.
	*!*
	*!*  Ejemplo: ALLTRIM(STRTRAN(STR(ABS(nCantidad), 9, 3), ".", ""))
	*!*
	*!*  Valores esperados para <cPreUniOri>
	*!*
	*!*  El valor de ‚ste par metro es el del valor absoluto (ABS()) del
	*!*  precio unitario del art¡culo a facturar. El total del item lo
	*!*  calcula el controlador.
	*!*  Debe ser una expresi¢n caracter no superior a 10 caracteres
	*!*  debe respetar el siguiente formato "9999999.99" en donde
	*!*  el punto se muestra £nicamente para hacer conocer que
	*!*  los £ltimos dos valores siempre ser n los decimales, pero
	*!*  no debe aparecer dentro del par metro a enviar. Tampoco deben
	*!*  aparecer espacios en blanco. 
	*!*
	*!*  Ejemplo: ALLTRIM(STRTRAN(STR(nPreUniOri, 10, 2), ".", ""))
	*!*
	*!*  Valores esperados para <cPorcIva>
	*!*
	*!*  El valor de ‚ste par metro es el del porcentaje de I.V.A. por
	*!*  el cual est  gravado el art¡culo a facturar.
	*!*  Debe ser una expresi¢n caracter no superior a 5 caracteres
	*!*  debe respetar el siguiente formato ".99999" en donde
	*!*  el punto se muestra £nicamente para hacer conocer  que
	*!*  la expresi¢n debe ser una expresi¢n decimal de 5 n£meros menor
	*!*  a uno, pero no debe aparecer dentro del par metro a enviar.
	*!*  Tampoco deben aparecer espacios en blanco. 
	*!*
	*!*  Ejemplo: 
	*!*     
	*!*     nPorcIva = 21
	*!*
	*!*		ALLTRIM(STRTRAN(STR(nPorcIva/100, 5, 5), ".", ""))
	*!*
	*!*  Valores esperados para <cCalifItm>
	*!*
	*!*  "M" El valor del item se sumar  al total de la factura
	*!*  "m" El valor del item se restar  del total de la factura
	*!*
	*!*  Valores esperados para <cBultos>
	*!*
	*!*  El valor de ‚ste par metro no influye en los totales del item.
	*!*  Debe ser una expresi¢n caracter no superior a 5 caracteres
	*!*  debe respetar el siguiente formato "99999." en donde
	*!*  el punto se muestra £nicamente para hacer conocer que
	*!*  la expresi¢n es un entero de 5 caracteres, pero no debe apa_
	*!*  recer dentro del par metro a enviar. Tampoco deben aparecer
	*!*  espacios en blanco. 
	*!*
	*!*  Ejemplo: ALLTRIM(STRTRAN(STR(nBultos, 5, 0), ".", ""))
	*!*
	*!*  Valores esperados para <cTasImVar>
	*!*
	*!*  Se la denomina "Tasa de ajuste Variable". Tendr  un valor mayor
	*!*  a 0 £nicamente cuando el item a vender tenga impuestos internos.
	*!*  Debe ser una expresi¢n caracter no superior a 8 caracteres que
	*!*  debe respetar el siguiente formato ".99999999" en donde
	*!*  el punto se muestra £nicamente para hacer conocer que
	*!*  la expresi¢n debe ser una expresi¢n decimal menor a uno, pero
	*!*  no debe aparecer dentro del par metro a enviar. Tampoco deben
	*!*  aparecer espacios en blanco.
	*!*  La tasa de ajuste variable se forma de la siguiente forma:
	*!*
	*!*      Tasa de ajuste variable = (Monto I.V.A. / PVP)
	*!*
	*!*  En donde PVP = Precio de Venta Publico y el Monto I.V.A. es = al
	*!*  monto del porcentaje de I.V.A. (unitario) que grava el art¡culo.
	*!*
	*!*  Ejemplo: ALLTRIM(STRTRAN(STR(0, 9, 8), ".", ""))
	*!*
	*!*  NOTA:
	*!*  =====
	*!*   Recuerde que cuando un art¡culo tiene impuesto internos
	*!*   el PVP estar  formado por la Base Imponible + I.V.A. + Imp. Int.
	*!*   La base imponible se obtiene de la siguiente forma:
	*!*
	*!*           BI = PVP / (1 + ((%I.V.A. + %Imp. Int.) / 100)
	*!*
	*!*  Valores esperados para <cImpInt>
	*!*
	*!*  Monto de Impuestos internos fijos.
	*!*  Debe ser una expresi¢n caracter no superior a 17 caracteres que
	*!*  debe respetar el siguiente formato "999999999.99999999" en donde
	*!*  el punto se muestra £nicamente para hacer conocer que los £ltimos
	*!*  ocho caracteres siempre ser n decimales, pero  no debe aparecer
	*!*  dentro del par metro a enviar. Tampoco deben aparecer espacios
	*!*  en blanco.
	*!*  Se recomienda utilizar siempre la tasa de impuesto variable y dejar
	*!*  este par metro con valor cero. Ej. "000000000000000000"
	*!* 
	*!*
	FUNCTION SndTicItem
		PARAMETERS cDescLine, cCantidad, cPreUniOri, cPorcIva,;
				   cCalifItm, cBultos, cTasImVar, cImpInt
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(66)+CHR(28)+cDescLine+CHR(28)+;
								cCantidad+CHR(28)+cPreUniOri+CHR(28)+cPorcIva+CHR(28)+;
								cCalifItm+CHR(28)+cBultos+CHR(28)+cTasImVar+CHR(28)+cImpInt)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION DescTicket
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <cMotDesc>
	*!*
	*!*  Esta es la descripci¢n que se le dar  al descuento
	*!*
	*!*  Valores esperados para <cMonto>
	*!*
	*!*  El valor de ‚ste par metro es el del valor absoluto (ABS()) del
	*!*  total a descontar a la factura
	*!*  Debe ser una expresi¢n caracter no superior a 10 caracteres
	*!*  debe respetar el siguiente formato "9999999.99" en donde
	*!*  el punto se muestra £nicamente para hacer conocer que
	*!*  los £ltimos dos valores siempre ser n los decimales, pero
	*!*  no debe aparecer dentro del par metro a enviar. Tampoco deben
	*!*  aparecer espacios en blanco. 
	*!*
	FUNCTION DescTicket
		PARAMETERS cMotDesc, cMonto
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(68)+CHR(28)+cMotDesc+CHR(28)+cMonto+CHR(28)+CHR(68))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = !EMPTY(aFiscalStatus[13])
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION SendTikPay
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <cFormPago>
	*!*
	*!*  Esta es la descripci¢n que se le dar  al pago realizado
	*!*
	*!*  Valores esperados para <cMonto>
	*!*
	*!*  El valor de ‚ste par metro es el del valor absoluto (ABS()) del
	*!*  total abonado en ‚sta forma de pago.
	*!*  Debe ser una expresi¢n caracter no superior a 10 caracteres
	*!*  debe respetar el siguiente formato "9999999.99" en donde
	*!*  el punto se muestra £nicamente para hacer conocer que
	*!*  los £ltimos dos valores siempre ser n los decimales, pero
	*!*  no debe aparecer dentro del par metro a enviar. Tampoco deben
	*!*  aparecer espacios en blanco. 
	*!*
	*!*  Valores esperados para <lCancel>
	*!*
	*!*  .T. Cancela el documento el curso
	*!*  .F. No cancela el Documento en curso
	*!*
	FUNCTION SendTikPay
		PARAMETERS cFormPago, cMonto, lCancel
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(68)+CHR(28)+cFormPago+CHR(28)+cMonto+CHR(28)+IIF(lCancel = .F., CHR(84), CHR(67)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = IIF(lCancel, EMPTY(aFiscalStatus[13]), !EMPTY(aFiscalStatus[13]))
			Else
				lRetValue = .F.
			EndIf
		ELSE
			IF lCancel
				lRetValue = !This.ChkIfDocOp()
			
				IF !lRetValue
					This.ShowErrMes(ErrSendData)
				ENDIF
			ELSE
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION CloseTick
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <cCorte>
	*!*
	*!*  Indica el tipo de corte a realizar
	*!*
	*!*  "T" Total   (Recomendado)
	*!*  "P" Parcial
	*!*
	FUNCTION CloseTick
		PARAMETERS cCorte
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(69)+CHR(28)+cCorte)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = EMPTY(aPrinterStatus[13])
			Else
				lRetValue = .F.
			EndIf
		ELSE
			lRetValue = !This.ChkIfDocOp()
			
			IF !lRetValue
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION OpnInvoice
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <invtype>
	*!*
	*!*  "E" Remito
	*!*  "L" Recibo Fiscal
	*!*  "C" Cotizacion
	*!*  "F" Factura
	*!*  "T" Ticket - Factura
	*!*  "R" Recibo - Factura
	*!*  "D" Nota de Debito - (LX300F+ FX880F)
	*!*  "M" Nota de Credito - Imp. tickets Solamente
	*!*  "N" Nota de Credito - (LX300F+ FX880F)
	*!*
	*!*  Valores esperados para <papertype>
	*!*
	*!*  "C" Formulario Continuo
	*!*  "S" Hoja suelta o Impresora Slip
	*!*
	*!*  Valores esperados para <invletter>
	*!*
	*!*  Letra del Documento Fiscal que se desea abrir
	*!*  Los valores posibles son: "A", "B", o "C", otro
	*!*  valor ser  rechazado.
	*!*
	*!*  Valores esperados para <copies>
	*!*
	*!*  Cantidad de Copias que se desea Imprimir. Este valor debe
	*!*  un n£mero no mayor a cinco ni menor a uno, y debe estar
	*!*  expresado en caracter.
	*!*  
	*!*  NOTA
	*!*  ====
	*!*    En el caso de Tiquet-Factura ‚ste valor es ignorado.
	*!*
	*!*  Valores esperados para <formtype>
	*!*
	*!*  "F" Se utiliza un formulario pre-impreso con la lineas ya dibujadas
	*!*  "P" La impresora fiscal debe dibujar las lineas de la factura
	*!*      que se est  por emitir.
	*!*  "A" Autoimpresor, no imprime todo el encabezado.
	*!*  
	*!*  NOTA
	*!*  ====
	*!*    En el caso de Tiquet-Factura ‚ste valor es ignorado.
	*!*
	*!*  Valores esperados para <fonttype>
	*!*
	*!*  Aqu¡ se debe enviar el tama¤o de los caracteres que se van a utilizar en
	*!*  toda la factura a emitir.
	*!*  Esta opci¢n solo es v lida para las Facturas en Hoja suelta (Slip) o
	*!*  formulario continuo.
	*!*  En caso de enviar un valor err¢neo, la impresora lo ignora y no
	*!*  reporta error.
	*!*  La lista de valores aceptados es la siguiente:
	*!*
	*!*  "10" CPI (caracteres por pulgada)
	*!*  "12" CPI (caracteres por pulgada)
	*!*  "17" CPI (caracteres por pulgada)
	*!*  
	*!*  NOTA
	*!*  ====
	*!*    En el caso de Tiquet-Factura ‚ste valor es ignorado.
	*!*
	*!*  Valores esperados para <iva_seller>
	*!*
	*!*  Responsabilidad frente al I.V.A. del EMISOR.
	*!*  Esta opci¢n es requerida en forma obligatoria cuando el controlador
	*!*  est  en modo entrenamiento. Si el Impresor Fiscal esta funcionando en
	*!*  Modo Fiscal, este dato es ignorado y se utiliza la responsabilidad
	*!*  almacenada en la Memoria Fiscal.
	*!*  La lista de valores aceptados es la siguiente:
	*!*
	*!*  "I" Responsable Inscripto
	*!*  "R" Responsable No Inscripto
	*!*  "N" No Responsable
	*!*  "E" Exento
	*!*  "M" Monotributo
	*!*  
	*!*  Valores esperados para <iva_buyer>
	*!*  
	*!*  Aqui se espera que se ingrese la Responsabilidad frente al
	*!*  del COMPRADOR, ‚ste dato es obligatorio y recibir  cualquier
	*!*  valor de la lista siguiente:
	*!*  
	*!*  "I" Responsable Inscripto
	*!*  "R" Responsable No Inscripto
	*!*  "N" No Responsable
	*!*  "E" Exento
	*!*  "M" Monotributo
	*!*  "F" Consumidor Final
	*!*  
	*!*  Si el sujero es "No categorizado", se deber  abrir un Documento
	*!*  a Consumidor Final o Monotributo y realizar la percepci¢n que
	*!*  corresponde por la RG212.
	*!*  
	*!*  Valores esperados para <buyername1> y <buyername2>
	*!*  
	*!*  Son las dos casillas en donde se puede almacenar el Nombre
	*!*  comercial del COMPRADOR. El valor no debe ser mayor a 40
	*!*  caracteres.
	*!*  
	*!*  Valores esperados para <doctype>
	*!*  
	*!*  Tipo de Documento del COMPRADOR. Texto ASCII no superior a 6
	*!*  caracteres, si dice CUIT o CUIL se verificar  el n£mero que se
	*!*  ingrese en el campo siguiente.
	*!*  
	*!*  Valores esperados para <nrodocid>
	*!*  
	*!*  C.U.I.T. o Documento del COMPRADOR.
	*!*  Debe ser una expresi¢n caracter no superior a 11 caracteres y
	*!*  debe respetar el siguiente formato "99999999999" y en donde
	*!*  los espacios en blanco deben eliminarse.
	*!*  
	*!*  Valores esperados para <cVenBUso>
	*!*  
	*!*  "B" Se imprime la leyenda "VTA. BIENES DE USO"
	*!*  "N" No se imprime la leyenda anterior.
	*!*
	*!*  Las opci¢n que elija ser  v lida £nicamente si el EMISOR es
	*!*  Responsable Inscripto y el COMPRADOR Responsable No Inscripto y
	*!*  si el documento que se desea abrir es un Ticket-Factura "B" o
	*!*  Factura "B". En cualquier otro caso, el dato no ser  considerado
	*!*
	*!*  Valores esperados para <address1>, <address2> y <address3>
	*!*
	*!*  Son las tres casillas en donde se puede almacenar el Domicilio
	*!*  comercial del COMPRADOR. El valor no debe ser mayor a 40
	*!*  caracteres.
	*!*
	*!*  Valores esperados para <lineaad_1> y <lineaad_2>
	*!*  
	*!*  En ‚stas casillas se pueden almacenar valores adicionales rela_
	*!*  cionados con el documento que se desea abrir, como por ejemplo
	*!*  el N§ de Remito asociado al documento.  El valor no debe ser
	*!*  mayor a 40 caracteres.
	*!*
	*!*  Valores esperados para <cOpnDNFH>
	*!*
	*!*  "C" Luego del tiquet no se va a realizar un documento no fiscal
	*!*      homologado para Farmacias.
	*!*  "G" Se prepara el controlador para la impresi¢n D.N.F.H. para
	*!*      Farmacias cuando se termina de imprimir el documento.
	*!*
	FUNCTION OpnInvoice
		PARAMETERS invtype,;
				   papertype,;
				   invletter,;
				   copies,;
				   formtype,;
				   fonttype,;
				   iva_seller,;
				   iva_buyer,;
				   buyername1,;
				   buyername2,;
				   doctype,;
				   nrodocid,;
				   cVenBUso,;
				   address1,;
				   address2,;
				   address3,;
				   lineaad_1,;
				   lineaad_2,;
				   cOpnDNFH

		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(96)+CHR(28)+;
								invtype+CHR(28)+;
								papertype+CHR(28)+;
								invletter+CHR(28)+;
								copies+CHR(28)+;
								formtype+CHR(28)+;
								fonttype+CHR(28)+;
								iva_seller+CHR(28)+;
								iva_buyer+CHR(28)+;
								buyername1+CHR(28)+;
								buyername2+CHR(28)+;
								doctype+CHR(28)+;
								nrodocid+CHR(28)+;
								cVenBUso+CHR(28)+;
								address1+CHR(28)+;
								address2+CHR(28)+;
								address3+CHR(28)+;
								lineaad_1+CHR(28)+;
								lineaad_2+CHR(28)+;
								cOpnDNFH)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = !EMPTY(aFiscalStatus[13])
			Else
				lRetValue = .F.
			EndIf
		ELSE
			lRetValue = This.ChkIfDocOp()
			
			IF !lRetValue
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*  FUNCTION SndInvItem
	*!*
	*!*  Valores esperados para <cFrstExLine>
	*!*
	*!*  El valor de <cFrstExLine> debe ser la 1§ descripci¢n
	*!*  extra que se desea enviar y que continua a <cDescLine>.
	*!*
	*!*  Valores esperados para <cScndExLine>
	*!*
	*!*  El valor de <cScndExLine> debe ser la 2§ descripci¢n
	*!*  extra que se desea enviar y que continua a <cFrstExLine>.
	*!*
	*!*  Valores esperados para <cThrdExLine>
	*!*
	*!*  El valor de <cThrdExLine> debe ser la 3§ descripci¢n
	*!*  extra que se desea enviar y que continua a <cScndExLine>.
	*!*
	*!*  Valores esperados para <cIvaNInsc>
	*!*
	*!*  El valor de ‚ste par metro es el del porcentaje de I.V.A. no
	*!*  inscripto por el cual est r  gravado el art¡culo a facturar,
	*!*  Cua
	*!*  Debe ser una expresi¢n caracter no superior a 5 caracteres
	*!*  debe respetar el siguiente formato ".99999" en donde
	*!*  el punto se muestra £nicamente para hacer conocer  que
	*!*  la expresi¢n debe ser una expresi¢n decimal de 5 n£meros menor
	*!*  a uno, pero no debe aparecer dentro del par metro a enviar.
	*!*  Tampoco deben aparecer espacios en blanco. 
	*!*
	*!*  Ejemplo: 
	*!*     
	*!*     nIvaNoInsc = 10.5
	*!*
	*!*		ALLTRIM(STRTRAN(STR(nIvaNoInsc/100, 5, 5), ".", ""))
	*!*
	FUNCTION SndInvItem
		PARAMETERS cDescLine, cCantidad, cPreUniOri, cPorcIva,;
				   cCalifItm, cBultos, cTasImVar,;
				   cFrstExLine, cScndExLine, cThrdExLine, cIvaNInsc, cImpInt
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(98)+CHR(28)+cDescLine+CHR(28)+;
								cCantidad+CHR(28)+cPreUniOri+CHR(28)+cPorcIva+CHR(28)+;
								cCalifItm+CHR(28)+cBultos+CHR(28)+cTasImVar+CHR(28)+;
								cFrstExLine+CHR(28)+cScndExLine+CHR(28)+cThrdExLine+CHR(28)+;
								cIvaNInsc+CHR(28)+cImpInt)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION DescInvoice
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Ver explicaci¢n de "DescTicket"
	*!*
	FUNCTION DescInvoice
		PARAMETERS cMotDesc, cMonto
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(100)+CHR(28)+cMotDesc+CHR(28)+cMonto+CHR(28)+CHR(68))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = !EMPTY(aFiscalStatus[13])
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION SendInvPay
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Ver explicaci¢n de "SendTikPay"
	*!*
	FUNCTION SendInvPay
		PARAMETERS cFormPago, cMonto, lCancel
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(100)+CHR(28)+cFormPago+CHR(28)+cMonto+CHR(28)+IIF(lCancel = .F., CHR(84), CHR(67)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = IIF(lCancel, EMPTY(aFiscalStatus[13]), !EMPTY(aFiscalStatus[13]))
			Else
				lRetValue = .F.
			EndIf
		ELSE
			IF lCancel
				lRetValue = !This.ChkIfDocOp()
			
				IF !lRetValue
					This.ShowErrMes(ErrSendData)
				ENDIF
			ELSE
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION CloseInv
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <cTipForm>
	*!*
	*!*  "F" Factura
	*!*  "T" Ticket - Factura
	*!*  "R" Recibo - Factura
	*!*
	*!*  Valores esperados para <cTipoDoc>
	*!*
	*!*  "A" o "B" depende del documento que se haya abierto
	*!*
	FUNCTION CloseInv
		PARAMETERS cTipForm, cTipoDoc
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(101)+CHR(28)+cTipForm+CHR(28)+cTipoDoc+CHR(28)+"")
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
			
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = EMPTY(aPrinterStatus[13])
			Else
				lRetValue = .F.
			EndIf
		ELSE
			lRetValue = !This.ChkIfDocOp()
			
			IF !lRetValue
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*
	*  PROCEDURE SetFootDoc
	*
	*  Imprime los datos Finales del Documento.
	*
	PROCEDURE SetFootDoc
		PARAMETERS cVend, cCaja, cTerm, cUnidades, cNroItems, cDocum
		PRIVATE lError

		FOR nNroLinea = 11 TO 14
			DO CASE
				CASE nNroLinea = 11
					lError = !SetHeadCola(nNroLinea, "Vend.: " + cVend + " Caja: " + cCaja + " Terminal: " + cTerm)
				CASE nNroLinea = 12
					lError = !SetHeadCola(nNroLinea, "Unid.: " + cUnidades + " It.: " + cNroItems + " Doc.: " + cDocum)
				CASE nNroLinea = 13
					lError = !SetHeadCola(nNroLinea, REPLICATE("-", 40))
				OTHER
					lError = !SetHeadCola(nNroLinea, CHR(243)+"        Gracias  por  su  compra")
			ENDCASE
			
			IF lError
				EXIT
			ENDIF
		ENDFOR

		RETURN lError
	ENDFUNC

	*
	*  PROCEDURE UnSeFootDoc
	*
	*  Elimina los datos Finales del Documento.
	*
	FUNCTION UnSeFootDoc
		PRIVATE lError

		FOR nNroLinea = 11 TO 14
			DO CASE
				CASE nNroLinea = 11
					lError = !SetHeadCola(nNroLinea, CHR(127))
				CASE nNroLinea = 12
					lError = !SetHeadCola(nNroLinea, CHR(127))
				CASE nNroLinea = 13
					lError = !SetHeadCola(nNroLinea, CHR(127))
				OTHER
					lError = !SetHeadCola(nNroLinea, CHR(127))
			ENDCASE
			
			IF lError
				EXIT
			ENDIF
		ENDFOR

		RETURN lError
	ENDFUNC

	*
	*  FUNCTION CancOpnDoc
	*
	*  Cancela cualquier doc. fiscal que se encuentre abierto.
	*
	FUNCTION CancOpnDoc
		PRIVATE cRetValue, lReturn, cTipoDoc, cFisStatus, cPrnStatus,;
				aPrinterStatus, aFiscalStatus

		cRetValue = ""

		STORE .F. TO lReturn, aPrinterStatus, aFiscalStatus

		IF chkestado("D", @cRetValue)
			cTipoDoc = SUBST(SUBST(cRetValue, AT(CHR(28), cRetValue, 2) + 1), 1, 1)
			
			DO CASE
				CASE INLIST(cTipoDoc, "M", "T", "F", "I", "O", "H")
					With This
						.SendTikPay("CANCELACION", TRANSFORM(0, "@L 9999999999"), .T.)
						
						STORE .RespuestaFiscal TO cRetValue
					EndWith
					
					IF !EMPTY(cRetValue)
						cFisStatus = This.EpsonFisSt(cRetValue, @aFiscalStatus)
						cPrnStatus = This.EpsonPrnSt(cRetValue, @aPrinterStatus)
						
						IF EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F., .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus, .T.))
							lRetValue = .T.
						ELSE
							With This
								.SendInvPay("CANCELACION", TRANSFORM(0, "@L 9999999999"), .T.)
								
								STORE .RespuestaFiscal TO cRetValue
							EndWith
							
							IF !EMPTY(cRetValue)
								cFisStatus = This.EpsonFisSt(cRetValue, @aFiscalStatus)
								cPrnStatus = This.EpsonPrnSt(cRetValue, @aPrinterStatus)
								
								IF EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F., .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus, .T.))
									lRetValue = .T.
								ELSE
									With This
										.CloseDNF("T")
										
										STORE .RespuestaFiscal TO cRetValue
									EndWith
									
									cFisStatus = This.EpsonFisSt(cRetValue, @aFiscalStatus)
									cPrnStatus = This.EpsonPrnSt(cRetValue, @aPrinterStatus)
									
									IF EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F., .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus, .T.))
										lRetValue = .T.
									ELSE
										lRetValue = .F.
									ENDIF
								ENDIF
							ELSE
								lRetValue = .F.
								
								This.ShowErrMes(ErrSendData)
							ENDIF
						ENDIF
					ELSE
						lRetValue = .F.
						
						This.ShowErrMes(ErrSendData)
					ENDIF
				OTHER
					lRetValue = .F.
			ENDCASE
		ENDIF
		
		RETURN lRetValue
	ENDFUNC

	*  PROCEDURE SetHeadCola
	*
	*  Setea la Cabecera y la Cola del Ticket o Factura a Imprimir
	*
	PROCEDURE SetHeadCola
		PARAMETERS nNroLinea, cTexto
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(93)+CHR(28)+ALLTRIM(STR(nNroLinea, 5))+CHR(28)+cTexto)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC


	*  FUNCTION GetHeadCola
	*
	*  Extra la Cabecera y la Cola del Ticket o Factura grabadas en el Impresor
	*
	FUNCTION GetHeadCola
		PARAMETERS nNroLinea, cRetValue
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(94)+CHR(28)+ALLTRIM(STR(nNroLinea, 5)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .F.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				cRetValue = SUBST(cCadena, AT(CHR(28), cCadena, 2) + 1)
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION AvanzaTkAud
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <nLineas>
	*!*
	*!*  Debe ser un valor num‚rico que indica la cantidad
	*!*  de lineas que se desea avanzar.
	*!*
	FUNCTION AvanzaTkAud
		PARAMETERS nLineas
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cFisStatus, cPrnStatus

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(82)+CHR(28)+ALLTRIM(STR(nLineas, 11)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF
		
		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION FeedAudit
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <nLineas>
	*!*
	*!*  Debe ser un valor num‚rico que indica la cantidad
	*!*  de lineas que se desea avanzar.
	*!*
	FUNCTION FeedAudit
		PARAMETERS nLineas
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cFisStatus, cPrnStatus

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(81)+CHR(28)+ALLTRIM(STR(nLineas, 11)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION FeedTicket
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <nLineas>
	*!*
	*!*  Debe ser un valor num‚rico que indica la cantidad
	*!*  de lineas que se desea avanzar.
	*!*
	FUNCTION FeedTicket
		PARAMETERS nLineas
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cFisStatus, cPrnStatus

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(80)+CHR(28)+ALLTRIM(STR(nLineas, 11)))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*  FUNCTION ChkIfDocOp
	*!*
	*!*  Comprueba el estado Fiscal luego de haber pedido la
	*!*  apertura o cierre de un Documento Fiscal.
	*!*  Este procedimiento se creo dado a que en algunas ocaciones,
	*!*  son pocas por suerte, se efect£a un Time Out cuando se ‚sta
	*!*  leyendo el Buffer del Puerto de Comunicaciones y el proceso
	*!*  devuelve .F., pero en realidad el comando pudo haberse eje_
	*!*  cutado con ‚xito.
	*!*
	FUNCTION ChkIfDocOp
		PARAMETERS cDocOpen, lNoSndError
		PRIVATE cRetValue, lReturn

		cDocOpen  = "N"
		cRetValue = ""
		lReturn   = .F.

		IF chkestado("D", @cRetValue)
			cTipoDoc = SUBST(SUBST(cRetValue, AT(CHR(28), cRetValue, 2) + 1), 1, 1)
			
			DO CASE
				CASE INLIST(cTipoDoc, "T", "F", "I", "O", "H")
					cDocOpen = cTipoDoc
					lReturn  = .T.
				OTHER
					lReturn = .F.
			ENDCASE
		ELSE
			IF !lNoSndError
				MessageBox(" No se pudo verificar el estado del im_ " + CHR(13) +;
						   "presor luego de la emitir la petición de" + CHR(13) +;
						   "apertura de un documento, sea éste fis_ " + CHR(13) +;
						   "cal o no fiscal, y que ésta fallara por " + CHR(13) +;
						   "un error no previsto o un error de pro_ " + CHR(13) +;
						   "tocolo en la recepción de la respuesta  " + CHR(13) +;
						   "del contolador, empero el comando pudo  " + CHR(13) +;
						   "haberse ejecutado exitosamente.         " + CHR(13) +;
						   " Se recomienda cancelar el proceso que  " + CHR(13) +;
						   "se estaba realizando y realizar una ve_ " + CHR(13) +;
						   "rificación de documentos que hayan que_ " + CHR(13) +;
						   "dado abiertos, cancelarlos en tal caso, " + CHR(13) +;
						   "y de los contadores, tanto del controla_" + CHR(13) +;
						   "dor como los del sistema. Siguiendo és_ " + CHR(13) +;
						   "tos consejos se evitará problemas poste_" + CHR(13) +;
						   "riores.                                 ", 64, "Epson Fiscal Object")
			ENDIF
		ENDIF

		RETURN lReturn
	ENDFUNC

	*!*
	*!*  FUNCTION startdocnf
	*!*
	*!*  Abre un Documento no Fiscal
	*!*
	FUNCTION startdocnf
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(72))
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			lRetValue = This.ChkIfDocOp()
			
			IF !lRetValue
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC
	
	*!*
	*!*   FUNCTION SendTxtNFi
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  El valor de <cDescrip> debe ser la descripci¢n
	*!*  que se desea enviar. No se pueden enviar expresiones
	*!*  superiores a 40 caracteres.
	*!*
	FUNCTION SendTxtNFi
		PARAMETERS cDescrip
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(73)+CHR(28)+cDescrip)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		cRetValue      = ""
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			This.ShowErrMes(ErrSendData)
		ENDIF

		RETURN lRetValue
	ENDFUNC

	*!*
	*!*   FUNCTION CloseDNF
	*!*
	*!*  Devuelve .T. o .F. de acuerdo a la respuesta
	*!*  recibida del controlador.
	*!*
	*!*  Valores esperados para <cCorte>
	*!*
	*!*  Indica el tipo de corte a realizar
	*!*
	*!*  "T" Total   (Recomendado)
	*!*  "P" Parcial
	*!*
	FUNCTION CloseDNF
		PARAMETERS cCorte
		PRIVATE lRetValue, aPrinterStatus, aFiscalStatus, cCadena,;
				cString, nContArray, cData

		lRetValue      = .F.
		cCadena        = This.FisDrv.Enviar(CHR(74)+CHR(28)+cCorte)
		aPrinterStatus = .F.
		aFiscalStatus  = .F.
		
		With This
			.RespuestaFiscal = cCadena
		EndWith
		
		IF !EMPTY(cCadena)
			cFisStatus = This.EpsonFisSt(cCadena, @aFiscalStatus)
			cPrnStatus = This.EpsonPrnSt(cCadena, @aPrinterStatus)
					
			If EMPTY(cFisStatus) AND EMPTY(cPrnStatus) AND EMPTY(This.ChkPrnState(@aPrinterStatus, .T.)) AND EMPTY(This.ChkFisState(@aFiscalStatus))
				lRetValue = .T.
			Else
				lRetValue = .F.
			EndIf
		ELSE
			lRetValue = !This.ChkIfDocOp()
			
			IF !lRetValue
				This.ShowErrMes(ErrSendData)
			ENDIF
		ENDIF

		RETURN lRetValue
	ENDFUNC
ENDDEFINE