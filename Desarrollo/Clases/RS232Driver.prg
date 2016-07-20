#define STX CHR(2)
#define ETX CHR(3)
#define DC2 CHR(18)
#define DC4 CHR(20)
#define NAK CHR(21)

#DEFINE comEventBreak    1001 && A Break signal was received. 
#DEFINE comEventFrame    1004 && Framing Error. The hardware detected a framing error. 
#DEFINE comEventOverrun  1006 && Port Overrun. A character was not read from the hardware before the next character arrived and was lost. 
#DEFINE comEventRxOver   1008 && Receive Buffer Overflow. There is no room in the receive buffer. 
#DEFINE comEventRxParity 1009 && Parity Error. The hardware detected a parity error. 
#DEFINE comEventTxFull   1010 && Transmit Buffer Full. The transmit buffer was full while trying to queue a character. 
#DEFINE comEventDCB      1011 && Unexpected error retrieving Device Control Block (DCB) for the port. 


#DEFINE comEvSend    1 && There are fewer than Sthreshold number of characters in the transmit buffer. 
#DEFINE comEvReceive 2 && Received Rthreshold number of characters. This event is generated continuously until you use the Input property to remove the data from the receive buffer. 
#DEFINE comEvCTS     3 && Change in Clear To Send line. 
#DEFINE comEvDSR     4 && Change in Data Set Ready line. This event is only fired when DSR changes from 1 to 0. 
#DEFINE comEvCD      5 && Change in Carrier Detect line. 
#DEFINE comEvRing    6 && Ring detected. Some UARTs (universal asynchronous receiver-transmitters) may not support this event. 
#DEFINE comEvEOF     7 && End Of File (ASCII character 26) character received. 

LPARAMETERS nPort
LOCAL oMSComm32

oMSComm32 = NEWOBJECT("MSComm32Container", "RS232Driver.prg", "", nPort)

IF TYPE("oMSComm32") == "O"
	RETURN oMSComm32.MSComm32Object
ELSE
	RETURN .NULL.
ENDIF

DEFINE CLASS MSComm32Container AS Custom
	ADD OBJECT MSComm32Object AS MSComm32Object NOINIT
	
	FUNCTION Init(nPort)
		RETURN This.MSComm32Object.Init(nPort)
	ENDFUNC
ENDDEFINE

DEFINE CLASS MSComm32Object AS olecontrol
	OleClass = "MSCOMMLib.MSComm.1"
	OleLCID  = 1033
	Height = 36
	Width = 38
	Name = "MSComm32Object"
	Pak2Sent = 32 - 1
	RespuestaFiscal = ""
	LastBufferCount = -1
	
	FUNCTION Init(nPort)
		LOCAL lError
		TRY
			With This
				.CommPort = nPort
				.Settings = "9600,N,8,1"
				.PortOpen = .T.
				.rthreshold = 0
				.SThreshold = 0
				.InputLen = 0
				.InputMode = 0
			EndWith
		CATCH TO oError
			lError = .T.
			
			MESSAGEBOX(oError.Message, 16, "Epson Fiscal Object")
		ENDTRY
		RETURN lError = .F.
	ENDFUNC
	
*!*		FUNCTION OnComm()
*!*			nEvento = This.CommEvent
*!*			
*!*			DO CASE
*!*			CASE nEvento = comEvSend
*!*			CASE nEvento = comEvReceive	&& Recibo datos
*!*			CASE comEventBreak    = nEvento && A Break signal was received. 
*!*				MESSAGEBOX("A Break signal was received.")
*!*			CASE comEventFrame    = nEvento && Framing Error. The hardware detected a framing error. 
*!*				MESSAGEBOX("Framing Error. The hardware detected a framing error.")
*!*			CASE comEventOverrun  = nEvento && Port Overrun. A character was not read from the hardware before the next character arrived and was lost. 
*!*				MESSAGEBOX("Port Overrun. A character was not read from the hardware before the next character arrived and was lost.")
*!*			CASE comEventRxOver   = nEvento && Receive Buffer Overflow. There is no room in the receive buffer.
*!*				MESSAGEBOX("Receive Buffer Overflow. There is no room in the receive buffer.")
*!*			CASE comEventRxParity = nEvento && Parity Error. The hardware detected a parity error. 
*!*				MESSAGEBOX("Parity Error. The hardware detected a parity error.")
*!*			CASE comEventTxFull   = nEvento && Transmit Buffer Full. The transmit buffer was full while trying to queue a character. 
*!*				MESSAGEBOX("Transmit Buffer Full. The transmit buffer was full while trying to queue a character.")
*!*			CASE comEventDCB      = nEvento && Unexpected error retrieving Device Control Block (DCB) for the port. 
*!*				MESSAGEBOX("Unexpected error retrieving Device Control Block (DCB) for the port.")
*!*			ENDCASE
*!*		ENDFUNC
	
	FUNCTION Enviar(cCommand)
		LOCAL cBCC, nLastBuffer, nIntentos, lError, lContinue, lSuccess
		
		cCommand    = CHR(2)+This.Pak2Sent+cCommand+CHR(3)
		cBCC        = RIGHT("000000" + DEC2BASE(This.SumaASCII(cCommand), 16), 4)
		nIntentos   = 0
		nTimeMax    = 0
		nLastBuffer = -1
		
		With This
			DO WHILE lError = .F. AND lSuccess = .F.
				.Output = cCommand+cBCC
				
				STORE .T. TO lContinue
				
				DO WHILE lContinue
					DO Delay WITH 1
					
					IF .InBufferCount <> nLastBuffer
						nLastBuffer = .InBufferCount
						
						IF nTimeMax <= 30
							nTimeMax = nTimeMax + .3
						ELSE
							cRespuesta = ""
							lContinue  = .F.
							
							EXIT
						ENDIF
					ELSE
						DO WHILE .T.
							STORE .Input TO cRespuesta
							
							IF nLastBuffer <> LEN(cRespuesta)
								DOEVENTS
							ELSE
								EXIT
							ENDIF
						ENDDO
						
						STORE STRTRAN(STRTRAN(ALLTRIM(cRespuesta), DC2, ""), DC4, "") TO cRespuesta
						
						DO CASE
						CASE OCCURS(NAK, cRespuesta) > 0
							IF nIntentos < 6
								DO delay WITH .8
								
								nIntentos = nIntentos + 1
							ELSE
								MESSAGEBOX("¡¡Error en el protocolo de comunicación!!", 16, "Comunición RS232")
								
								lError    = .T.
								lContinue = .F.
							ENDIF
						CASE OCCURS(STX, cRespuesta) > 1 AND OCCURS(ETX, cRespuesta) = 0
							IF nIntentos < 6
								DO delay WITH .8
								
								nIntentos = nIntentos + 1
							ELSE
								MESSAGEBOX("¡¡Error en el protocolo de comunicación!!", 16, "Comunición RS232")
								
								lError    = .T.
								lContinue = .F.
							ENDIF
						CASE OCCURS("Error", cRespuesta) > 0
							lError    = .T.
							lContinue = .F.
						CASE OCCURS(STX, cRespuesta) > 0 AND OCCURS(ETX, cRespuesta) > 0 AND .EsperaCRC(cRespuesta)
							IF .CheckCRC(ALLTRIM(SUBST(cRespuesta, AT(STX, cRespuesta, 1))))
								lContinue = .F.
								lSuccess  = .T.
							ELSE
								.Output = NAK
								
								DO Delay WITH .8
								
								lContinue = .F.
							ENDIF
						ENDCASE
					ENDIF
				ENDDO
			ENDDO
			
			IF lError = .F.
				IF EMPTY(cRespuesta)
					MESSAGEBOX("¡¡Error en el protocolo de comunicación!! Se produjo un TIMEOUT.", 16, "Comunición RS232")
					
					RETURN ""
				ELSE
					cRespuesta = SUBST(cRespuesta, AT(CHR(28), cRespuesta, 1) + 1)
					
					IF OCCURS("Error", cRespuesta) > 0
						cRespuesta = SUBST(cRespuesta, 1, AT(CHR(28), cRespuesta, 2) - 1)
					ELSE
						cRespuesta = SUBST(cRespuesta, 1, AT(CHR(3), cRespuesta, 1) - 1)
					ENDIF
					
					RETURN cRespuesta
				ENDIF
			ELSE
				cRespuesta = SUBST(cRespuesta, AT(CHR(28), cRespuesta, 1) + 1)
				
				IF OCCURS("Error", cRespuesta) > 0
					cRespuesta = SUBST(cRespuesta, 1, AT(CHR(28), cRespuesta, 2) - 1)
				ELSE
					cRespuesta = SUBST(cRespuesta, 1, AT(CHR(3), cRespuesta, 1) - 1)
				ENDIF
				
				RETURN cRespuesta
			ENDIF
		EndWith
	ENDFUNC
	
	FUNCTION EsperaCRC
	PARAMETERS cInput
	
	cInput = SUBST(ALLTRIM(cInput), AT(ETX, ALLTRIM(cInput), 1)+1)
	
	IF LEN(cInput) = 4
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
	
	FUNCTION CheckCRC
	PARAMETERS cBuffer
	
	cCRCBuf = RIGHT(cBuffer, 4)
	cBuffer = STRTRAN(cBuffer, cCRCBuf, "")
	cCRC    = RIGHT("000000" + DEC2BASE(This.SumaASCII(cBuffer), 16), 4)
	
	IF cCRCBuf == cCRC
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
	
	FUNCTION SumaASCII
		PARAMETERS cAsciiCad
		PRIVATE nCont, nVal

		nVal = 0

		FOR nCont = 1 TO LEN(cAsciiCad)
			nVal = nVal + ASC(SUBST(cAsciiCad, nCont, 1))
		ENDFOR

		RETURN nVal
	ENDFUNC

	FUNCTION pak2sent_Access()
		IF This.Pak2Sent > BASE2DEC("7F", 16)
			This.Pak2Sent = BASE2DEC("20", 16) - 1
		ELSE
			This.Pak2Sent = This.Pak2Sent + 1
		ENDIF
		
		RETURN CHR(This.Pak2Sent)
	ENDFUNC
ENDDEFINE