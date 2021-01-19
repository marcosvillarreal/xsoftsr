*------------------------------------------------------------------------------------------------------------------
* Nombre del programa   : PROBAR_FTP.PRG
* Nombre del programador: Walter R. Ojeda Valiente
* Fecha de creación     : 11/AGO/2019
* Tarea realizada       : Ejemplo del uso de CLASE_FTP, que es una clase para enviar comandos a un Servidor FTP
*------------------------------------------------------------------------------------------------------------------
  
  CLOSE ALL
  CLEAR ALL
  
  CLEAR
  
  #DEFINE KEY_ENTER Chr(13)
  
  SET CENTURY ON
  SET DATE    DMY
  SET HOURS   TO 24
  SET TALK    OFF
  
  SET PROCEDURE TO FTP_CLASS
  
  loFTP = CreateObject("CLASE_FTP")
  
  IF Vartype(loFTP) <> "O" THEN
    =MessageBox("NO SE PUDO CREAR EL OBJETO CLASE_FTP")
    RETURN
  ENDIF
  
  WITH loFTP
    .cServidorFTP   = "ftp.miempresa.com"
    .cNombreUsuario = "miusuario"
    .cContrasena    = "micontrasena"
    .cPuertoNro     = "21"
    .CONECTAR_SERVIDOR_FTP()
    *--- Conexión OK
    IF Empty(.cMensajeError) THEN
      =MessageBox("Conexión exitosa al Servidor FTP" + KEY_ENTER + KEY_ENTER + "Carpeta remota: " + .cCarpetaRemota)
      DO MOSTRAR_ARCHIVOS WITH loFTP
    ENDIF
    *--- Crear una carpeta en el Servidor FTP
    IF Empty(.cMensajeError) THEN
      .CREAR_CARPETA_REMOTA("prueba_temporal_walter")
    ENDIF
    *--- Mostrar el contenido de la carpeta creada en el Servidor FTP, debería estar vacía
    IF Empty(.cMensajeError) THEN
      .CAMBIAR_A_LA_CARPETA_REMOTA("prueba_temporal_walter")
      DO MOSTRAR_ARCHIVOS WITH loFTP
    ENDIF
    *--- Enviar un archivo a la carpeta creada en el Servidor FTP
    IF Empty(.cMensajeError) THEN
      .ENVIAR_ARCHIVO_AL_SERVIDOR_FTP("MAIN.PRG")
      IF Empty(.cMensajeError) THEN
        =MessageBox("El archivo MAIN.PRG fue enviado exitosamente al Servidor FTP")
      ENDIF
    ENDIF
    *--- Mostrar el contenido de la carpeta creada en el Servidor FTP, para comprobar que realmente se envió el archivo MAIN.PRG
    IF Empty(.cMensajeError) THEN
      DO MOSTRAR_ARCHIVOS WITH loFTP
    ENDIF
    *--- Verificar si el archivo MAIN.PRG existe en el SErvidor FTP
    IF Empty(.cMensajeError) THEN
      .EXISTE_EL_ARCHIVO_EN_EL_SERVIDOR_FTP("MAIN.PRG")
      IF Empty(.cMensajeError) THEN
        lcNombreArchivo = GetWordNum(.cDatosArchivo, 1, "|")
        lcTamanoArchivo = GetWordNum(.cDatosArchivo, 2, "|")
        lcDateTime      = GetWordNum(.cDatosArchivo, 5, "|")
        lcAtributos     = GetWordNum(.cDatosArchivo, 6, "|")
        =MessageBox("El archivo MAIN.PRG existe en el Servidor FTP" + KEY_ENTER + KEY_ENTER ;
                  + "Nombre del archivo: " + lcNombreArchivo + KEY_ENTER ;
                  + "Tamaño del archivo: " + lcTamanoArchivo + " bytes" + KEY_ENTER ;
                  + "Fecha y hora: " + lcDateTime + KEY_ENTER ;
                  + "Atributos: " + lcAtributos)
      ENDIF
    ENDIF    
    *--- Recibir el archivo MAIN.PRG desde el Servidor FTP y guardarlo en una carpeta local
    IF Empty(.cMensajeError) THEN
      .RECIBIR_ARCHIVO_REMOTO("MAIN.PRG", "MAIN2.PRG", .T.)
      IF Empty(.cMensajeError) THEN
        =MessageBox("El archivo MAIN.PRG fue recibido exitosamente desde el Servidor FTP")
      ENDIF
    ENDIF
    *--- Borrar el archivo MAIN.PRG en el Servidor FTP
    IF Empty(.cMensajeError) THEN
      .BORRAR_ARCHIVO_REMOTO("MAIN.PRG")
      IF Empty(.cMensajeError) THEN
        =MessageBox("El archivo MAIN.PRG fue borrado exitosamente del Servidor FTP")
      ENDIF
    ENDIF
    *--- Se ubica en otra carpeta remota, para poder eliminar a la carpeta remota actual
    IF Empty(.cMensajeError) THEN
      .CAMBIAR_A_LA_CARPETA_REMOTA("..")     && No se puede borrar la carpeta actual, hay que ubicarse en otra carpeta para que una carpeta pueda ser borrada
      IF Empty(.cMensajeError) THEN
        =MessageBox("El cambio a la carpeta superior fue realizado exitosamente")
      ENDIF
    ENDIF
    *--- Borrar la carpeta creada en el Servidor FTP
    IF Empty(.cMensajeError) THEN
      .BORRAR_CARPETA_REMOTA("prueba_temporal_walter")
      IF Empty(.cMensajeError) THEN
        =MessageBox("La carpeta prueba_temporal_walter fue borrada exitosamente")
      ENDIF
    ENDIF
    *--- Si ocurrió algún error, mostrar el mensaje de error correspondiente
    IF !Empty(.cMensajeError) THEN
      =MessageBox(.cMensajeError + KEY_ENTER + "Código resultado: " + Transform(.nCodigoResultado))
    ENDIF
    .DESCONECTAR_SERVIDOR_FTP()
  ENDWITH
  
  loFTP = .NULL.
  
  RELEASE loFTP
  
RETURN
*
*
PROCEDURE MOSTRAR_ARCHIVOS
LPARAMETERS toFTP
LOCAL lnI, lcDatos
  
  laArrayCarpeta = ""
  
  toFTP.OBTENER_CONTENIDO_DE_LA_CARPETA_REMOTA(@laArrayCarpeta, "*.*")
  
  IF !Empty(laArrayCarpeta) THEN
    ?
    ?
    ? "CARPETA " + toFTP.cCarpetaRemota FONT "COURIER NEW", 9
    ? "------------------------------------------------------" FONT "COURIER NEW", 9
    FOR lnI = 1 TO Alen(laArrayCarpeta, 1)
      lcDatos = PADR(Left(laArrayCarpeta[lnI, 1], 25), 25, " ") + "  " ;
              + PADL(STR(laArrayCarpeta[lnI, 2]), 12) + "  " ;
              + PADR(TTOC(laArrayCarpeta[lnI, 5]), 24) + "  " ;
              + laArrayCarpeta[lnI, 6]
      ? lcDatos FONT "COURIER NEW", 9
    ENDFOR
  ELSE
    ? Iif(Empty(laArrayCarpeta), "Array vacío", "") + "  Código resultado error: " + Transform(toFTP.nCodigoResultado) FONT "COURIER NEW", 9
  ENDIF  
  
  =MessageBox("Presiona 'Aceptar' para continuar...")
  
RETURN
*
*

  
  
  
  