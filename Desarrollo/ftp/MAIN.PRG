*------------------------------------------------------------------------------------------------------------------------
* Aplicación : Utilización de FTP
* Programador: Walter R. Ojeda Valiente
* Fecha      : 11/AGO/2019
*------------------------------------------------------------------------------------------------------------------------
  
  CLOSE ALL
  CLEAR ALL
  
  DO SETS_INICIALES
  
  SET PROCEDURE TO FTP_CLASS ADDITIVE
  
  DO FORM MAIN
  READ EVENTS
  
  CLOSE ALL
  CLEAR ALL
  
RETURN
*
*
PROCEDURE MENSAJE_ERROR
LPARAMETERS toFTP, tcMensaje
LOCAL KEY_ENTER
  
  #DEFINE MSG_BOTON_OK    0
  #DEFINE MSG_ICONO_STOP 16
  
  KEY_ENTER = 13
  
  tcMensaje = Alltrim(tcMensaje)
  tcMensaje = Strtran(tcMensaje, Chr(0), "")
  
  tcMensaje = '"' + Strtran(tcMensaje, "*", '" + Chr(KEY_ENTER) + "') + '"'
  
  TRY
    tcMensaje = Evaluate(tcMensaje)
  CATCH
  ENDTRY
  
  =MessageBox(tcMensaje, MSG_ICONO_STOP + MSG_BOTON_OK, "Hay un problema...")
  
  WITH toFTP
    .cMensajeError    = ""
    .nCodigoResultado = 0
  ENDWITH
  
ENDPROC
*
*
PROCEDURE SETS_INICIALES
  
  SET CENTURY   ON
  SET CONFIRM   ON
  SET DATE      DMY
  SET HOURS     TO 24
  SET POINT     TO ","
  SET SAFETY    OFF 
  SET SEPARATOR TO "."
  SET TALK      OFF
  
ENDPROC
*
*
SET SEPARATOR 