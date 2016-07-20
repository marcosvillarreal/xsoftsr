PROCEDURE directivasfiscal

PUBLIC   EpsonTm300 , EpsonTm2000, HASAR614, HASAR615, HASARPR4, HASAR320F, HASAR715F  

EpsonTm300   = 2
EpsonTm2000 = 3
HASAR614        = 4
HASAR615        = 5
HASARPR4       = 6
HASAR320F      = 7
HASAR715F      = 8 

PUBLIC AmodeloFiscal[8],ACierresZ[8]

AmodeloFiscal[1]='no fiscal'
AmodeloFiscal[2]='EPSON TM300'
AmodeloFiscal[3]='EPSON TM2000'
AmodeloFiscal[4]='HASAR 614'
AmodeloFiscal[5]='HASAR 615'
AmodeloFiscal[6]='HASAR PR4'
AmodeloFiscal[7]='HASAR 320F'
AmodeloFiscal[8]='HASAR 715F'

ACierresZ[1] = 0
ACierresZ[2] = 3800
ACierresZ[3] = 3800
ACierresZ[4] = 1850
ACierresZ[5] = 1850
ACierresZ[6] = 1850
ACierresZ[7] = 1850
ACierresZ[8] = 3800

ENDPROC


PROCEDURE directivasHasar

* Eventos Fiscales
PUBLIC F_FISCAL_MEMORY_FAIL,F_WORKING_MEMORY_FAIL,F_ALWAYS_ZERO,F_UNRECOGNIZED_COMMAND,F_INVALID_FIELD_DATA
PUBLIC F_INVALID_COMMAND,F_TOTAL_OVERFLOW,F_FISCAL_MEMORY_FULL,F_FISCAL_MEMORY_NEAR_FULL,F_FISCAL_TERMINAL_CERTIFIED
PUBLIC F_FISCAL_TERMINAL_FISCALIZED,F_DATE_SET_FAIL,F_RECEIPT_SKIP_OPEN,F_RECEIP_OPEN	,F_INVOICE_OPEN

F_FISCAL_MEMORY_FAIL					= 1
F_WORKING_MEMORY_FAIL				= 2
F_ALWAYS_ZERO							= 4
F_UNRECOGNIZED_COMMAND			= 8
F_INVALID_FIELD_DATA						= 16
F_INVALID_COMMAND						= 32
F_TOTAL_OVERFLOW						= 64
F_FISCAL_MEMORY_FULL					= 128
F_FISCAL_MEMORY_NEAR_FULL			= 256
F_FISCAL_TERMINAL_CERTIFIED			= 512
F_FISCAL_TERMINAL_FISCALIZED			= 1024
F_DATE_SET_FAIL							= 2048
F_RECEIPT_SKIP_OPEN					= 4096
F_RECEIP_OPEN							= 8192
F_INVOICE_OPEN							= 16384

* Eventos de Impresora
PUBLIC P_PRINTER_ERROR,P_OFFLINE,P_JOURNAL_PAPER_LOW,P_RECEIPT_PAPER_LOW,P_BUFFER_FULL,P_BUFFER_EMPTY,P_SLIP_PLATEN_OPEN,P_DRAWER_CLOSED

P_PRINTER_ERROR							= 4
P_OFFLINE									= 8
P_JOURNAL_PAPER_LOW					= 16
P_RECEIPT_PAPER_LOW					= 32
P_BUFFER_FULL							= 64
P_BUFFER_EMPTY							= 128
P_SLIP_PLATEN_OPEN						= 256
P_DRAWER_CLOSED						= 16384

* Modelos de Impresora
PUBLIC MODELO_614,MODELO_615,MODELO_PR4,MODELO_950,MODELO_951,MODELO_262,MODELO_PJ20,MODELO_P320,MODELO_715,MODELO_715_201

MODELO_614									= 1
MODELO_615									= 2
MODELO_PR4								= 3
MODELO_950									= 4
MODELO_951									= 5
MODELO_262									= 6
MODELO_PJ20								= 7
MODELO_P320								= 8
MODELO_715                                 				= 9
MODELO_715_201 							= 25

* Tipos de Documentos Fiscales
PUBLIC TICKET_C,TICKET_FACTURA_A,TICKET_FACTURA_B,FACTURA_A,FACTURA_B,RECIBO_A,RECIBO_B,NOTA_DEBITO_A,NOTA_DEBITO_B
PUBLIC TICKET_NOTA_DEBITO_A,TICKET_NOTA_DEBITO_B

TICKET_C										= 84
TICKET_FACTURA_A							= 65
TICKET_FACTURA_B							= 66
FACTURA_A									= 48
FACTURA_B									= 49
RECIBO_A									= 97
RECIBO_B									= 98
NOTA_DEBITO_A								= 68
NOTA_DEBITO_B								= 69
TICKET_NOTA_DEBITO_A					= 50
TICKET_NOTA_DEBITO_B					= 51


* Tipos de Documentos No Fiscales
PUBLIC NOTA_CREDITO_A,NOTA_CREDITO_B,REMITO,ORDEN_SALIDA,RESUMEN_CUENTA,CARGO_HABITACION,COTIZACION,RECIBO_X
PUBLIC TICKET_NOTA_CREDITO_A,TICKET_NOTA_CREDITO_B,TICKET_RECIBO_X

NOTA_CREDITO_A							= 82
NOTA_CREDITO_B							= 83
REMITO										= 114
ORDEN_SALIDA								= 115
RESUMEN_CUENTA							= 116
CARGO_HABITACION						= 85
COTIZACION									= 117
RECIBO_X									= 120
TICKET_NOTA_CREDITO_A					= 52
TICKET_NOTA_CREDITO_B					= 53
TICKET_RECIBO_X							= 54

*  Relacion modelo impresora / version ocx / tipo de comprobante ( filas modelo impresora , 1 columna modelo, 2 columna  string strzero(comprobante,3) )
* si se agregan modelos agregarlos abajo, si agrego comprobante debo agregar en fiscal.vcx funcion hasartipocomp

PUBLIC AOcx01CompModelo[10,2],AOcx05CompModelo[10,2]

LOCAL i,j
FOR i=1 TO ALEN(AOcx01CompModelo) / 2
	FOR j=1 TO 2
		AOcx01CompModelo[i,j] =0  				&& ocx viejo 010724
		AOcx05CompModelo[i,j] =0        			&& ocx nuevo 051122
	NEXT 
NEXT 

* function FarmaArray esta en proc.prg

* OCX VIEJO 070124
FarmoArray(01,01,@AOcx01CompModelo,MODELO_614,TICKET_C)
FarmoArray(02,03,@AOcx01CompModelo,MODELO_615,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C)
FarmoArray(03,03,@AOcx01CompModelo,MODELO_PR4,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C)
FarmoArray(04,00,@AOcx01CompModelo,MODELO_950)
FarmoArray(05,00,@AOcx01CompModelo,MODELO_951)
FarmoArray(06,00,@AOcx01CompModelo,MODELO_262)
FarmoArray(07,00,@AOcx01CompModelo,MODELO_PJ20)
FarmoArray(08,14,@AOcx01CompModelo,MODELO_P320,FACTURA_A,FACTURA_B,RECIBO_A,RECIBO_B,NOTA_DEBITO_A,NOTA_DEBITO_B;
										   	                                 ,NOTA_CREDITO_A,NOTA_CREDITO_B,REMITO,ORDEN_SALIDA,RESUMEN_CUENTA;
											                                 ,CARGO_HABITACION,COTIZACION,RECIBO_X)
											                                 
* en 715 con ocx viejo  usa nombre comprobantes modelo 320, en caso de credito_A/B y debito_A/B debo mandar esto y no ticket_nota_credito / ticket_nota_debito
* al abrir el fiscal o no fiscal le quito la palabra ticket_ al comienzo ya que entra como ticket_nota_credito
FarmoArray(09,08,@AOcx01CompModelo,MODELO_715,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C,RECIBO_X;
															   ,NOTA_DEBITO_A,NOTA_DEBITO_B,NOTA_CREDITO_A,NOTA_CREDITO_B)	
FarmoArray(10,08,@AOcx01CompModelo,MODELO_715_201,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C,RECIBO_X;
															  ,NOTA_DEBITO_A,NOTA_DEBITO_B,NOTA_CREDITO_A,NOTA_CREDITO_B)	


* OCX NUEVO 051122
FarmoArray(01,01,@AOcx05CompModelo,MODELO_614,TICKET_C)
FarmoArray(02,03,@AOcx05CompModelo,MODELO_615,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C)
FarmoArray(03,03,@AOcx05CompModelo,MODELO_PR4,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C)
FarmoArray(04,00,@AOcx05CompModelo,MODELO_950)
FarmoArray(05,00,@AOcx05CompModelo,MODELO_951)
FarmoArray(06,00,@AOcx05CompModelo,MODELO_262)
FarmoArray(07,00,@AOcx05CompModelo,MODELO_PJ20)
FarmoArray(08,14,@AOcx05CompModelo,MODELO_P320,FACTURA_A,FACTURA_B,RECIBO_A,RECIBO_B,NOTA_DEBITO_A,NOTA_DEBITO_B;
										   	                                 ,NOTA_CREDITO_A,NOTA_CREDITO_B,REMITO,ORDEN_SALIDA,RESUMEN_CUENTA;
											                                 ,CARGO_HABITACION,COTIZACION,RECIBO_X)
											                                 
* en ocx nuevo aparecen ticket_nota_debito y ticket_nota_credito para reemplazar nota_credito y nota_debito											                                 
FarmoArray(09,08,@AOcx05CompModelo,MODELO_715,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C,TICKET_NOTA_DEBITO_A,TICKET_NOTA_DEBITO_B;
														        ,TICKET_NOTA_CREDITO_A,TICKET_NOTA_CREDITO_B,TICKET_RECIBO_X)	
FarmoArray(10,08,@AOcx05CompModelo,MODELO_715_201,TICKET_FACTURA_A,TICKET_FACTURA_B,TICKET_C,TICKET_NOTA_DEBITO_A,TICKET_NOTA_DEBITO_B;
														        ,TICKET_NOTA_CREDITO_A,TICKET_NOTA_CREDITO_B,TICKET_RECIBO_X)	


* Estado de Controlador
PUBLIC S_NONFORMATTED_MEMORY,S_NONINITIALIZED_MEMORY,S_RECEIPT_NOT_OPENED,S_FISCAL_RECEIPT_OPENED,S_FISCAL_TEXT_ISSUED
PUBLIC S_NONFISCAL_RECEIPT_OPENED,S_TENDER,S_TENDER_CLEARED,S_PERCEPTION,S_KILLED,S_RETURN_RECHARGE,S_DISCOUNT_CHARGE
PUBLIC S_RECEIPT_CONCEPT,S_CREDIT_NOTE,S_CREDIT_NOTE_DISCOUNT,S_CREDIT_NOTE_RETURN,S_CREDIT_NOTE_PERCEPTION
PUBLIC S_CREDIT_NOTE_TEXT,S_INTERNAL_USE_RECEIPT,S_QUOTATION,S_EMBARK,S_ACCOUNT,S_BLOCKED,S_NONE

S_NONFORMATTED_MEMORY				= 0
S_NONINITIALIZED_MEMORY				= 1
S_RECEIPT_NOT_OPENED					= 2
S_FISCAL_RECEIPT_OPENED				= 3
S_FISCAL_TEXT_ISSUED					= 4
S_NONFISCAL_RECEIPT_OPENED		= 5
S_TENDER									= 6
S_TENDER_CLEARED						= 7
S_PERCEPTION								= 8
S_KILLED										= 9
S_RETURN_RECHARGE					= 10
S_DISCOUNT_CHARGE						= 11
S_RECEIPT_CONCEPT						= 12
S_CREDIT_NOTE							= 13
S_CREDIT_NOTE_DISCOUNT				= 14
S_CREDIT_NOTE_RETURN					= 15
S_CREDIT_NOTE_PERCEPTION			= 16
S_CREDIT_NOTE_TEXT						= 17
S_INTERNAL_USE_RECEIPT				= 18
S_QUOTATION								= 19
S_EMBARK									= 20
S_ACCOUNT									= 21
S_BLOCKED									= 22
S_NONE										= 255

* Tipos de Documentos de Clientes
PUBLIC TIPO_CUIT,TIPO_LE,TIPO_LC,TIPO_DNI,TIPO_PASAPORTE,TIPO_CI,TIPO_NINGUNO,TIPO_CUIL

TIPO_CUIT									= 67
TIPO_LE										= 48
TIPO_LC										= 49
TIPO_DNI										= 50
TIPO_PASAPORTE							= 51
TIPO_CI										= 52
TIPO_NINGUNO								= 32
TIPO_CUIL									= 76

* Responsabilidad de Clientes
PUBLIC RESPONSABLE_INSCRIPTO,RESPONSABLE_NO_INSCRIPTO,RESPONSABLE_EXENTO,NO_RESPONSABLE
PUBLIC  CONSUMIDOR_FINAL,BIENES_DE_USO,MONOTRIBUTO,NO_CATEGORIZADO,MONOTRIBUTO_SOCIAL,EVENTUAL,EVENTUAL_SOCIAL

RESPONSABLE_INSCRIPTO				= 73
RESPONSABLE_NO_INSCRIPTO			= 78
RESPONSABLE_EXENTO					= 69
NO_RESPONSABLE							= 65
CONSUMIDOR_FINAL						= 67
BIENES_DE_USO							= 66
MONOTRIBUTO								= 77
NO_CATEGORIZADO							= 84
MONOTRIBUTO_SOCIAL						= 83
EVENTUAL									= 86
EVENTUAL_SOCIAL							= 87

* Lineas de Display
PUBLIC LINEA_SUPERIOR,LINEA_INFERIOR,SECCION_DE_REPETICION

LINEA_SUPERIOR							= 76
LINEA_INFERIOR								= 75
SECCION_DE_REPETICION					= 78

* Tipos de Papel
PUBLIC PAPEL_TICKET,PAPEL_DIARIO,PAPEL_TICKET_Y_DIARIO

PAPEL_TICKET								= 0
PAPEL_DIARIO								= 1
PAPEL_TICKET_Y_DIARIO					= 2

* Tipos de Vouchers
PUBLIC VOUCHER_DE_COMPRA,VOUCHER_DE_CANCELACION_COMPRA,VOUCHER_DE_DEVOLUCION,VOUCHER_DE_CANCELACION_DEVOLUCION

VOUCHER_DE_COMPRA					= 67
VOUCHER_DE_CANCELACION_COMPRA	= 86
VOUCHER_DE_DEVOLUCION				= 68
VOUCHER_DE_CANCELACION_DEVOLUCION = 65

* Tipos de Tarjetas
PUBLIC TARJETA_CREDITO	,TARJETA_DEBITO

TARJETA_CREDITO							= 67
TARJETA_DEBITO							= 68

* Tipos de Ingresos de Tarjeta
PUBLIC INGRESO_DE_TARJETA_MANUAL	,INGRESO_DE_TARJETA_AUTOMATIZADO

INGRESO_DE_TARJETA_MANUAL			= 42
INGRESO_DE_TARJETA_AUTOMATIZADO = 32

* Tipos de Operaciones de Tarjetas
PUBLIC OPERACION_TARJETA_ONLINE,OPERACION_TARJETA_OFFLINE

OPERACION_TARJETA_ONLINE			= 78
OPERACION_TARJETA_OFFLINE			= 70

* Tipos de Descuento
PUBLIC DESCUENTO_RECARGO,DEVOLUCION_DE_ENVASES

DESCUENTO_RECARGO					= 66
DEVOLUCION_DE_ENVASES				= 69

* Tipos de parametros de configuracion
PUBLIC IMPRESION_CAMBIO,IMPRESION_LEYENDAS,CORTE_PAPEL,IMPRESION_MARCO,REIMPRESION_CANCELADOS,COPIAS_DOCUMENTOS,PAGO_SALDO,SONIDO

IMPRESION_CAMBIO							= 52
IMPRESION_LEYENDAS						= 53
CORTE_PAPEL								= 54
IMPRESION_MARCO							= 55
REIMPRESION_CANCELADOS				= 56
COPIAS_DOCUMENTOS						= 57
PAGO_SALDO								= 58
SONIDO										= 59

* Errores (expresados en hexadecimal)
PUBLIC H_ERR_GENERIC,H_ERR_HANDLER,H_ERR_ATOMIC,H_ERR_TIMEOUT,H_ERR_ALREADYOPEN,H_ERR_NOMEM,H_ERR_NOTOPENYET
PUBLIC H_ERR_INVALIDPTR,H_ERR_ABORT,H_ERR_FIELD_NOT_FOUND,H_ERR_INVALID_BUFFER,H_ERR_INVALID_BIT,H_ERR_PRINTER_NOT_FOUND
PUBLIC H_ERR_NOT_SUPPORTED,H_ERR_NOT_OPENED,H_ERR_INVALID_PORT,H_ERR_FILENAME,H_ERR_FIELD_OPTIONAL,H_ERR_FIELD_INVALID

H_ERR_GENERIC							= 80040201
H_ERR_HANDLER							= 80040202
H_ERR_ATOMIC								= 80040203
H_ERR_TIMEOUT							= 80040204
H_ERR_ALREADYOPEN						= 80040205
H_ERR_NOMEM								= 80040206
H_ERR_NOTOPENYET						= 80040207
H_ERR_INVALIDPTR							= 80040208
H_ERR_ABORT								= 80040209
H_ERR_FIELD_NOT_FOUND				= 80040232
H_ERR_INVALID_BUFFER					= 80040233
H_ERR_INVALID_BIT							= 80040234
H_ERR_PRINTER_NOT_FOUND			= 80040235
H_ERR_NOT_SUPPORTED					= 80040236
H_ERR_NOT_OPENED						= 80040237
H_ERR_INVALID_PORT						= 80040238
H_ERR_FILENAME							= 80040239
H_ERR_FIELD_OPTIONAL					= 80040240
H_ERR_FIELD_INVALID						= 80040241

* Tipos de Codigos de Barras
PUBLIC CODIGO_TIPO_EAN_13,CODIGO_TIPO_EAN_8,CODIGO_TIPO_UPCA,CODIGO_TIPO_ITS

CODIGO_TIPO_EAN_13						= 49
CODIGO_TIPO_EAN_8						= 50
CODIGO_TIPO_UPCA						= 51
CODIGO_TIPO_ITS							= 52

ENDPROC


FUNCTION GetErrorFiscal
PARAMETERS FiscalStatus,PrinterStatus

PRIVATE  i, c

DECLARE FiscalErrors [16]
DECLARE PrinterErrors[16]

FiscalErrors[01] =      "Error Chequeo memoria fiscal"
FiscalErrors[02] =      "Error Chequeo memoria trabajo"
FiscalErrors[03] =      "Carga de bateria baja"
FiscalErrors[04] =      "Comando desconocido"
FiscalErrors[05] =      "Datos no validos en campo"
FiscalErrors[06] =      "Comando no valido p/estado actual"
FiscalErrors[07] =      "Desborde del total"
FiscalErrors[08] =      "Memoria fiscal llena"
FiscalErrors[09] =      "Memoria fiscal a punto de llenarse"
FiscalErrors[10] =      ""
FiscalErrors[11] =      ""
FiscalErrors[12] =      "Error en ingreso de fecha"
FiscalErrors[13] =      "" &&Recibo fiscal abierto"
FiscalErrors[14] =      "" &&Recibo abierto"
FiscalErrors[15] =      "" &&Factura abierta"
FiscalErrors[16] =      ""

PrinterErrors[01] = ""
PrinterErrors[02] = ""
PrinterErrors[03] = "Error de Impresora"
PrinterErrors[04] = "Impresora Offline"
PrinterErrors[05] = "Falta papel del diario"
PrinterErrors[06] = "Falta papel de tickets"
PrinterErrors[07] = "Buffer de Impresora lleno"
PrinterErrors[08] = ""
PrinterErrors[09] = ""
PrinterErrors[10] = ""
PrinterErrors[11] = ""
PrinterErrors[12] = ""
PrinterErrors[13] = ""
PrinterErrors[14] = ""
PrinterErrors[15] = ""
PrinterErrors[16] = ""

IF PrinterStatus < 0
        RETURN "-1"
ENDIF

* Analiza los bits comenzando del menos significativo
FOR i = 1 TO 16
        IF ( INT (PrinterStatus % 2) == 1 )
                IF ( LEN (PrinterErrors[i]) > 0 )
                    return "P"+strzero(i,2)+"~"+PrinterErrors[i]
                ENDIF
        ENDIF
        PrinterStatus = PrinterStatus / 2
NEXT

IF FiscalStatus < 0
        RETURN "-2"
ENDIF

* Analiza los bits comenzando del menos significativo
FOR i = 1 TO 16
        IF ( INT (FiscalStatus % 2) == 1 )
                IF ( LEN (FiscalErrors[i]) > 0 )
                    return "F"+strzero(i,2)+"~"+FiscalErrors[i]
                ENDIF
        ENDIF
        FiscalStatus = FiscalStatus / 2
NEXT

RETURN ""
                