*------------------------------------------------------------------------------------------------------------------------
* Nombre del Programa   : FTP_CLASS.PRG
* Nombre del Programador: Walter R. Ojeda Valiente
* Fecha                 : 11/AGO/2019
* Tarea realizada       : Clase para conectar/desconectar a un Servidor FTP y enviarle comandos
*------------------------------------------------------------------------------------------------------------------------
  *
  *
  #DEFINE BIT_ATTRIBUTE_READONLY       0
  #DEFINE BIT_ATTRIBUTE_HIDDEN         1
  #DEFINE BIT_ATTRIBUTE_SYSTEM         2
  #DEFINE BIT_ATTRIBUTE_DIRECTORY      4  
  #DEFINE BIT_ATTRIBUTE_ARCHIVE        5
  #DEFINE BIT_ATTRIBUTE_ENCRYPTED      6  
  #DEFINE BIT_ATTRIBUTE_NORMAL         7  
  #DEFINE BIT_ATTRIBUTE_TEMPORARY      8
  #DEFINE BIT_ATTRIBUTE_SPARSE_FILE    9
  #DEFINE BIT_ATTRIBUTE_REPARSE_POINT 10  
  #DEFINE BIT_ATTRIBUTE_COMPRESSED    11  
  #DEFINE BIT_ATTRIBUTE_OFFLINE       12  
  
  #DEFINE BYTE_1 1
  #DEFINE BYTE_2 256
  #DEFINE BYTE_3 65536
  #DEFINE BYTE_4 16777216
  #DEFINE BYTE_M 4294967295
  
  #DEFINE ERROR_NO_HAY_MAS_ARCHIVOS 18
  
  #DEFINE FILE_ATTRIBUTE_NORMAL    128
  
  #DEFINE FTP_TRANSFER_TYPE_BINARY   2
  
  #DEFINE INTERNET_OPEN_TYPE_DIRECT 1
  #DEFINE INTERNET_SERVICE_FTP      1

  #DEFINE VAR_MAX_BYTES 260
  #DEFINE VAR_NULL      Chr(0)
  *
  *
  DEFINE CLASS CLASE_FTP AS Custom
    
    cAgente          = "Walter R. Ojeda Valiente" + VAR_NULL
    cCarpetaRemota   = ""
    cContrasena      = ""
    cDatosArchivo    = ""
    cMensajeError    = ""
    cNombreUsuario   = ""
    cPuertoNro       = "21"
    cServidorFTP     = ""
    
    lApiCargadas     = .F.     && Para no volver a cargar las DLL en la memoria, si es que ya estaban cargadas
    
    nCodigoResultado = 0     && El kernel del Windows32 devuelve un número indicando cual fue el último error ocurrido
    nInternetHandle  = 0     && El handle a una conexión de Internet 
    nFtpHandle       = 0     && El handle a una conexión FTP
    *
    *
    FUNCTION BORRAR_ARCHIVO_REMOTO
    LPARAMETERS tcArchivo
    LOCAL lnResultado
      
      lnResultado = 0
      
      IF This.nFtpHandle > 0 THEN
        tcArchivo   = tcArchivo + VAR_NULL
        lnResultado = FtpDeleteFile(This.nFtpHandle, @tcArchivo)
        This.OBTENER_ERROR(lnResultado = 0, "No pude borrar el archivo remoto")
      ENDIF
      
      RETURN (lnResultado = 1)     && lnResultado = 1 significa que el archivo remoto fue borrado exitosamente
      
    ENDFUNC
    *
    *
    FUNCTION BORRAR_CARPETA_REMOTA
    LPARAMETERS tcCarpeta
    LOCAL lnResultado
      
      lnResultado = 0
      
      IF This.nFtpHandle > 0 THEN
        tcCarpeta   = tcCarpeta + VAR_NULL
        lnResultado = FtpRemoveDirectory(This.nFtpHandle, @tcCarpeta)
        This.OBTENER_ERROR(lnResultado = 0, "No pude borrar la carpeta remota")
      ENDIF
      
      RETURN (lnResultado = 1)     && lnResultado = 1 significa que la carpeta remota fue borrada exitosamente
      
    ENDFUNC
    *
    *
    FUNCTION CAMBIAR_A_LA_CARPETA_REMOTA
    LPARAMETERS tcNombreCarpeta
    LOCAL lnResultado, lcCarpetaTemporal
      
      lnResultado = 0
      
      tcNombreCarpeta   = tcNombreCarpeta + VAR_NULL
      lcCarpetaTemporal = Space(VAR_MAX_BYTES)
      
      lnResultado = FtpSetCurrentDirectory(This.nFtpHandle, @tcNombreCarpeta)
      
      This.OBTENER_ERROR(lnResultado <> 1, "No me pude cambiar a la carpeta*" + tcNombreCarpeta)
      
      IF lnResultado = 1 THEN
        This.cCarpetaRemota = tcNombreCarpeta
      ENDIF
      
    ENDFUNC
    *
    *
    FUNCTION CARGAR_FUNCIONES_API
      
      IF This.lApiCargadas THEN     && Si ya se habían declarado y cargado en la memoria las funciones API, no es necesario volver a hacerlo
        RETURN(.T.)
      ENDIF
      
      DECLARE INTEGER FileTimeToSystemTime IN KERNEL32 ;
              STRING @lpcBuffer, ;
              STRING @lpcBuffer

      DECLARE INTEGER GetLastError IN KERNEL32
      
      DECLARE INTEGER FtpCreateDirectory IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcDirectory
      
      DECLARE INTEGER FtpDeleteFile IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcFileName
      
      DECLARE INTEGER FtpFindFirstFile IN WININET ;
              INTEGER nConnect_Handle    , ;
              STRING  @lpcSearchStr      , ;
              STRING  @lpcWIN32_FIND_DATA, ;
              INTEGER nFlags             , ;
              INTEGER nContext

      DECLARE INTEGER FtpGetCurrentDirectory IN WININET ;
              INTEGER nConnectHandle, ;
              STRING  @lpcDirectory , ;
              INTEGER @nMax_Path
      
      DECLARE INTEGER FtpGetFile IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcRemoteFile, ;
              STRING  @lpcNewFile, ;
              INTEGER nFailIfExists, ;
              INTEGER nAttributes, ;
              INTEGER nFlags, ;
              INTEGER nContext
      
      DECLARE INTEGER FtpPutFile IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcNewFile, ;
              STRING  @lpcRemoteFile, ;
              INTEGER nFlags, ;
              INTEGER nContext
      
      DECLARE INTEGER FtpRemoveDirectory IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcDirectory
              
      DECLARE INTEGER FtpRenameFile IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcRemoteFile, ;
              STRING  @lpcNewFile
      
      DECLARE INTEGER FtpSetCurrentDirectory IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcDirectory
      
      DECLARE INTEGER InternetCloseHandle    IN WININET ;
              INTEGER nConnect_Handle
      
      DECLARE INTEGER InternetConnect        IN WININET ;
              INTEGER nInet_Handle, ;
              STRING  @lpcServer  , ;
              SHORT   nPort       , ;
              STRING  @lpcUserName, ;
              STRING  @lpcPassword, ;
              INTEGER nService    , ;
              INTEGER nFlags      , ;
              INTEGER nContext
      
      DECLARE INTEGER InternetFindNextFile IN WININET ;
              INTEGER nConnect_Handle, ;
              STRING  @lpcWIN32_FIND_DATA
      
      DECLARE INTEGER InternetOpen           IN WININET ;
              STRING  @lpcAgent      , ;
              INTEGER nAccessType    , ;
              STRING  @lpcProxyName  , ;
              STRING  @lpcProxyBypass, ;
              INTEGER nFlags
      
      This.lApiCargadas = .T.
      
      RETURN(.T.)
      
    ENDFUNC
    *
    *
    FUNCTION CONECTAR_SERVIDOR_FTP
    LOCAL lnResultado, lcCarpetaTemporal, lnFtpHandle
      
      WITH This
        *--- Trata de conectarse a Internet
        .nInternetHandle = InternetOpen((.cAgente), INTERNET_OPEN_TYPE_DIRECT, VAR_NULL, VAR_NULL, 0)
        .OBTENER_ERROR(.nInternetHandle = 0, "No pude conectarme a Internet**Verifica que haya una conexión")
        *--- No se pudo conectar a Internet
        IF .nInternetHandle <= 0 THEN
          .CERRAR_FTP()
          RETURN(.F.)
        ENDIF
        *--- Si se pudo conectar a Internet, trata de conectarse al Servidor FTP
        lnFtpHandle = InternetConnect(.nInternetHandle, (.cServidorFTP), VAL(.cPuertoNro), (.cNombreUsuario), (.cContrasena), INTERNET_SERVICE_FTP, 0, 0)
        .OBTENER_ERROR(lnFtpHandle <= 0, "No me pude conectar al Servidor FTP**Probablemente los datos del Servidor o del usuario son incorrectos")
        *--- Si se pudo conectar al Servidor FTP, trata de obtener la carpeta remota raíz
        IF lnFtpHandle > 0 THEN
          .nFtpHandle       = lnFtpHandle
          lcCarpetaTemporal = .OBTENER_CARPETA_ACTUAL()
          IF !Empty(lcCarpetaTemporal) THEN
            .cCarpetaRemota = lcCarpetaTemporal
          ENDIF
        ENDIF
      ENDWITH
      
    ENDFUNC
    *
    *
    FUNCTION CREAR_CARPETA_REMOTA
    LPARAMETERS tcNombreCarpeta
    LOCAL lnResultado
      
      lnResultado = 0
      
      IF This.nFtpHandle > 0 THEN
        tcNombreCarpeta = tcNombreCarpeta + VAR_NULL
        lnResultado     = FtpCreateDirectory(This.nFtpHandle, @tcNombreCarpeta)
        This.OBTENER_ERROR(lnResultado <> 1, "No se pudo crear la carpeta remota")
      ENDIF
      
      RETURN (lnResultado = 1)     && lnResultado = 1 significa que la carpeta remota fue creada exitosamente
      
    ENDFUNC
    *
    *
    FUNCTION ENVIAR_ARCHIVO_AL_SERVIDOR_FTP
    LPARAMETERS tcArchivoLocal, tcArchivoRemoto
    LOCAL lnResultado
      
      lnResultado = 0
       
      IF This.nFtpHandle > 0 THEN
        tcArchivoRemoto = Iif(Vartype(tcArchivoRemoto) <> "C", tcArchivoLocal, tcArchivoRemoto)
        tcArchivoLocal  = tcArchivoLocal  + VAR_NULL
        tcArchivoRemoto = tcArchivoRemoto + VAR_NULL
        lnResultado      = FtpPutFile(This.nFtpHandle, @tcArchivoLocal, @tcArchivoRemoto, FTP_TRANSFER_TYPE_BINARY, 0)
        This.OBTENER_ERROR(lnResultado <> 1, "No pude enviar el archivo al Servidor FTP")
      ENDIF
      
      RETURN (lnResultado = 1)     && lnResultado = 1 significa que el archivo fue enviado exitosamente al Servidor FTP
      
    ENDFUNC
    *
    *
    FUNCTION EXISTE_EL_ARCHIVO_EN_EL_SERVIDOR_FTP
    LPARAMETERS tcNombreArchivo
    LOCAL lcEstructura, lnHandleTemp
    LOCAL lcNombreArchivo, lcNombreAlternativo, lcTamano, lcDateTimeCreacion, lcDateTimeUltimoAcceso, lcDateTimeModificacion, lcAtributos
      
      This.cDatosArchivo = ""
      
      tcNombreArchivo = Strtran(tcNombreArchivo, VAR_NULL, "") + VAR_NULL
      
      lcEstructura = Space(319)     && Hay que alojar espacio para la estructura que se retornará
      lnHandleTemp = FtpFindFirstFile(This.nFtpHandle, @tcNombreArchivo, @lcEstructura, 0, 0)     && Se encuentra el primer archivo
      
      This.OBTENER_ERROR(lnHandleTemp = 0, "No existe el archivo en el Servidor FTP")
      
      IF lnHandleTemp = 0 .OR. This.nCodigoResultado = ERROR_NO_HAY_MAS_ARCHIVOS THEN
        RETURN (.F.)
      ENDIF
      
      DIMENSION taArrayCarpeta[1, 6]
      
      This.AGREGAR_AL_ARRAY(lcEstructura, @taArrayCarpeta)
      
      lcNombreArchivo        = Strtran(taArrayCarpeta[1, 1], VAR_NULL, "")
      lcTamano               = Transform(taArrayCarpeta[1, 2])
      lcDateTimeCreacion     = Ttoc(taArrayCarpeta[1, 3])
      lcDateTimeUltimoAcceso = Ttoc(taArrayCarpeta[1, 4])
      lcDateTimeModificacion = Ttoc(taArrayCarpeta[1, 5])
      lcAtributos            = taArrayCarpeta[1, 6]
      
      This.cDatosArchivo = lcNombreArchivo        + "|" ;
                         + lcTamano               + "|" ;
                         + lcDateTimeCreacion     + "|" ;
                         + lcDateTimeUltimoAcceso + "|" ;
                         + lcDateTimeModificacion + "|" ;
                         + lcAtributos
      
      This.DESCONECTAR_SERVIDOR_FTP()
      This.RECONECTAR_SERVIDOR_FTP()     && Se debe desconectar y volver a conectar al Servidor FTP para que se puedan volver a obtener los archivos
      
      RETURN (.T.)
      
    ENDFUNC
    *
    *
    FUNCTION OBTENER_ATRIBUTOS
    LPARAMETERS tcBuffer
    LOCAL lcAtributos, lnValor
      
      lcAtributos = ""
      
      lnValor = (ASC(SUBSTR(tcBuffer, 1, 1)) * BYTE_1) ;
              + (ASC(SUBSTR(tcBuffer, 2, 1)) * BYTE_2) ;
              + (ASC(SUBSTR(tcBuffer, 3, 1)) * BYTE_3) ;
              + (ASC(SUBSTR(tcBuffer, 4, 1)) * BYTE_4)
      
      DO CASE
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_READONLY) 
          lcAtributos = lcAtributos + 'R'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_HIDDEN) 
          lcAtributos = lcAtributos + 'H'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_SYSTEM) 
          lcAtributos = lcAtributos + 'S'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_DIRECTORY) 
          lcAtributos = lcAtributos + 'D'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_ARCHIVE) 
          lcAtributos = lcAtributos + 'A'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_NORMAL) 
          lcAtributos = lcAtributos + 'N'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_TEMPORARY) 
          lcAtributos = lcAtributos + 'T'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_COMPRESSED) 
          lcAtributos = lcAtributos + 'C'
        CASE BITTEST(lnValor, BIT_ATTRIBUTE_OFFLINE) 
          lcAtributos = lcAtributos + 'O'
      ENDCASE      
      
      RETURN (lcAtributos)
      
    ENDFUNC
    *
    *
    FUNCTION OBTENER_CARPETA_ACTUAL
    LOCAL lnResultado, lcCarpetaActual
      
      lcCarpetaActual = ""
      
      IF This.nFtpHandle > 0 THEN
        lcCarpetaActual = Space(VAR_MAX_BYTES)
        lnResultado     = FtpGetCurrentDirectory(This.nFtpHandle, @lcCarpetaActual, VAR_MAX_BYTES)
        IF lnResultado > 0 THEN
          lcCarpetaActual = Left(lcCarpetaActual, At(VAR_NULL, lcCarpetaActual) - 1)
        ENDIF
      ENDIF
      
      RETURN(lcCarpetaActual)
      
    ENDFUNC
    *
    *
    FUNCTION OBTENER_CONTENIDO_DE_LA_CARPETA_REMOTA
    LPARAMETERS taArrayCarpeta, tcMascara
    LOCAL lcEstructura, lnHandleTemp, lnResultado, lnFtpHandle
      
      *--- taArrayCarpeta es un array donde se guardarán los datos de los archivos y carpetas encontrados
      *--- tcMascara es la máscara para elegir cuales archivos se desea obtener, por ejemplo: *.*, *.PRG, *.SCX, etc.
      
      IF This.nFtpHandle > 0 THEN
        tcMascara = tcMascara + VAR_NULL
        DIMENSION taArrayCarpeta[1, 6]
        * [x, 1] = Nombre del archivo o de la carpeta
        * [x, 2] = Tamaño del archivo
        * [x, 3] = Fecha de creación del archivo
        * [x, 4] = Hora del último acceso al archivo
        * [x, 5] = Hora de la última modificación al archivo
        * [x, 6] = Atributos del archivo
        taArrayCarpeta[1, 1] = .F.
        lcEstructura = Space(319)     && Hay que alojar espacio para la estructura que se retornará
        lnHandleTemp = FtpFindFirstFile(This.nFtpHandle, @tcMascara, @lcEstructura, 0, 0)     && Se encuentra el primer archivo
        This.OBTENER_ERROR(lnHandleTemp = 0, "No pude obtener el primer archivo de la carpeta")
        IF lnHandleTemp = 0 .OR. This.nCodigoResultado = ERROR_NO_HAY_MAS_ARCHIVOS THEN
          RETURN (.F.)
        ENDIF
        *--- Se agregan al array los datos del primer archivo obtenido (Nombre, tamaño, fecha de creación, atributos, etc.)
        This.AGREGAR_AL_ARRAY(lcEstructura, @taArrayCarpeta)
        lnResultado = 1
        DO WHILE This.nCodigoResultado <> ERROR_NO_HAY_MAS_ARCHIVOS .AND. lnResultado <> 0
          lcEstructura = Space(319)     && Hay que alojar espacio para la estructura que se retornará
          lnResultado  = InternetFindNextFile(lnHandleTemp, @lcEstructura)
          This.OBTENER_ERROR(.F.)
          IF This.nCodigoResultado <> ERROR_NO_HAY_MAS_ARCHIVOS .AND. lnResultado <> 0 THEN
            This.AGREGAR_AL_ARRAY(lcEstructura, @taArrayCarpeta)
          ENDIF
        ENDDO
        This.DESCONECTAR_SERVIDOR_FTP()
        This.RECONECTAR_SERVIDOR_FTP()     && Se debe desconectar y volver a conectar al Servidor FTP para que se puedan volver a obtener los archivos
      ELSE
        RETURN (.F.)
      ENDIF
      
      RETURN (.T.)
      
    ENDFUNC
    *
    *
    FUNCTION OBTENER_DATETIME
    LPARAMETERS tcFecha
    LOCAL lcBufferFecha, lnResultado, ltDateTime, lnAno, lnMes, lnDia, lnHor, lnMin, lnSeg, lcDateTime
      
      lcBufferFecha = Space(16)
      
      lnResultado = FileTimeToSystemTime(@tcFecha, @lcBufferFecha)
      This.OBTENER_ERROR(.F.)
      
      IF lnResultado = 0 THEN     && Si ocurrió un error, se devuelve una fecha por defecto
        ltDateTime = {^1901/01/01 00:00:01}
        RETURN (ltDateTime)
      ENDIF
      
      lnAno = ASC(SUBSTR(lcBufferFecha,  1, 1)) + (ASC(SUBSTR(lcBufferFecha,  2, 1)) * BYTE_2)
      lnMes = ASC(SUBSTR(lcBufferFecha,  3, 1)) + (ASC(SUBSTR(lcBufferFecha,  4, 1)) * BYTE_2)
      lnDia = ASC(SUBSTR(lcBufferFecha,  7, 1)) + (ASC(SUBSTR(lcBufferFecha,  8, 1)) * BYTE_2)
      lnHor = ASC(SUBSTR(lcBufferFecha,  9, 1)) + (ASC(SUBSTR(lcBufferFecha, 10, 1)) * BYTE_2)
      lnMin = ASC(SUBSTR(lcBufferFecha, 11, 1)) + (ASC(SUBSTR(lcBufferFecha, 12, 1)) * BYTE_2)
      lnSeg = ASC(SUBSTR(lcBufferFecha, 13, 1)) + (ASC(SUBSTR(lcBufferFecha, 13, 1)) * BYTE_2)
      
      lcDateTime = "^" + TRANSFORM(lnAno) + '/' + TRANSFORM(lnMes) + '/' + TRANSFORM(lnDia) + ' ' ;
                 +       TRANSFORM(lnHor) + ':' + TRANSFORM(lnMin) + ':' + TRANSFORM(lnSeg)
      
      ltDateTime = {&lcDateTime }
      
      RETURN (ltDateTime)
      
    ENDFUNC
    *
    *
    FUNCTION RECIBIR_ARCHIVO_REMOTO
    LPARAMETERS tcArchivoRemoto, tcArchivoLocal, tlErrorSiExiste
    LOCAL lnResultado, lnError
      
      lnResultado = 0
      
      IF This.nFtpHandle > 0 THEN
        lnError         = Iif(tlErrorSiExiste, 1, 0)
        tcArchivoRemoto = tcArchivoRemoto + VAR_NULL
        tcArchivoLocal  = tcArchivoLocal  + VAR_NULL
        lnResultado     = FtpGetFile(This.nFtpHandle, @tcArchivoRemoto, @tcArchivoLocal, lnError, FILE_ATTRIBUTE_NORMAL, FTP_TRANSFER_TYPE_BINARY, 0)
        This.OBTENER_ERROR(lnResultado = 0, "No pude recibir el archivo")
      ENDIF
      
      RETURN (lnResultado = 1)     && lnResultado = 1 significa que el archivo fue recibido exitosamente desde el Servidor FTP
    
    ENDFUNC
    *
    *
    FUNCTION RENOMBRAR_ARCHIVO_REMOTO
    LPARAMETERS tcNombreViejo, tcNombreNuevo
    LOCAL lnResultado
      
      lnResultado = 0
      
      IF This.nFtpHandle > 0 THEN
        tcNombreViejo = tcNombreViejo + VAR_NULL
        tcNombreNuevo = tcNombreNuevo + VAR_NULL
        lnResultado   = FtpRenameFile(This.nFtpHandle, @tcNombreViejo, @tcNombreNuevo)
        This.OBTENER_ERROR(lnResultado = 0, "No pude renombrar el archivo")
      ENDIF
      
      RETURN (lnResultado = 1)     && lnResultado = 1 significa que el archivo fue renombrado exitosamente en el Servidor FTP
      
    ENDFUNC
    *
    *
    PROCEDURE AGREGAR_AL_ARRAY
    LPARAMETERS tcEstructura, taArrayDatos
    LOCAL lcNombreArchivo, lcNombreAlternativo, lnTamanoArchivo, ltDateTimeCreacion, ltDateTimeUltimoAcceso, ltDateTimeModificacion, lcAtributos
    LOCAL lnArrayLen, lnTamanoAlto, lnTamanoBajo, lcBufferDateTime
      
      IF Vartype(taArrayDatos[1, 1]) == "L" THEN     && El array nunca ha sido llenado con datos
        DIMENSION taArrayDatos[1, 6]
      ELSE
        DIMENSION taArrayDatos[Alen(taArrayDatos, 1) + 1 , 6]
      ENDIF
      
      *--- Se obtiene la cantidad de filas del array
      lnArrayLen = Alen(taArrayDatos, 1)
      
      *--- Nombre del archivo
      lcNombreArchivo = Substr(tcEstructura, 45, VAR_MAX_BYTES)
      lcNombreArchivo = Left(lcNombreArchivo, AT(VAR_NULL, lcNombreArchivo) - 1)
      
      *--- Nombre alternativo del archivo
      lcNombreAlternativo = Right(tcEstructura, 14)
      lcNombreAlternativo = Left(lcNombreAlternativo, AT(VAR_NULL, lcNombreAlternativo) - 1)
      
      *--- Tamaño del archivo
      lnTamanoAlto    = (ASC(SUBSTR(tcEstructura, 29, 1)) * BYTE_1) ;
                      + (ASC(SUBSTR(tcEstructura, 30, 1)) * BYTE_2) ;
                      + (ASC(SUBSTR(tcEstructura, 31, 1)) * BYTE_3) ;
                      + (ASC(SUBSTR(tcEstructura, 32, 1)) * BYTE_4)
      lnTamanoBajo    = (ASC(SUBSTR(tcEstructura, 33, 1)) * BYTE_1) ;
                      + (ASC(SUBSTR(tcEstructura, 34, 1)) * BYTE_2) ;
                      + (ASC(SUBSTR(tcEstructura, 35, 1)) * BYTE_3) ;
                      + (ASC(SUBSTR(tcEstructura, 36, 1)) * BYTE_4) 
      lnTamanoArchivo = (lnTamanoAlto * BYTE_M) + lnTamanoBajo
      
      *--- Fecha y hora de creación del archivo
      lcBufferDateTime   = SUBSTR(tcEstructura, 5, 8)
      ltDateTimeCreacion = This.OBTENER_DATETIME(lcBufferDateTime )
      
      *--- Fecha y hora de último acceso al archivo
      lcBufferDateTime       = SUBSTR(tcEstructura, 13, 8)
      ltDateTimeUltimoAcceso = This.OBTENER_DATETIME(lcBufferDateTime )
      
      *--- Fecha y hora de la última modificación al archivo
      lcBufferDateTime       = SUBSTR(tcEstructura, 21, 8)
      ltDateTimeModificacion = This.OBTENER_DATETIME(lcBufferDateTime )
      
      *--- Atributos del archivo
      lcAtributos = This.OBTENER_ATRIBUTOS(Left(tcEstructura, 4))
      
      *--- Se agregan al array los datos obtenidos del archivo
      taArrayDatos[lnArrayLen, 1] = Strtran(Alltrim(lcNombreArchivo), VAR_NULL, "")
      taArrayDatos[lnArrayLen, 2] = lnTamanoArchivo
      taArrayDatos[lnArrayLen, 3] = ltDateTimeCreacion
      taArrayDatos[lnArrayLen, 4] = ltDateTimeUltimoAcceso
      taArrayDatos[lnArrayLen, 5] = ltDateTimeModificacion
      taArrayDatos[lnArrayLen, 6] = lcAtributos
      
    ENDPROC
    *
    *
    PROCEDURE DESCONECTAR_SERVIDOR_FTP
      
      IF This.nFtpHandle <> 0 THEN
        InternetCloseHandle(This.nFtpHandle)
      ENDIF
      
      This.nFtpHandle = 0
      
    ENDPROC
    *
    *
    PROCEDURE INIT
      *-- Se cargan las DLL que necesitará usar esta clase
      This.CARGAR_FUNCIONES_API()
    ENDPROC
    *
    *
    PROCEDURE OBTENER_ERROR
    LPARAMETERS tlHayError, tcMensajeError
      
      IF tlHayError THEN
        This.cMensajeError = tcMensajeError
      ENDIF
      
      This.nCodigoResultado = GetLastError()
      
      DO CASE
        CASE This.nCodigoResultado = 80
          This.cMensajeError = This.cMensajeError + "*Ya existe un archivo con el mismo nombre"
        OTHERWISE
          IF This.nCodigoResultado <> 0 .AND. !Empty(This.cMensajeError) THEN
            This.cMensajeError = This.cMensajeError + "*Código del Resultado: " + Transform(This.nCodigoResultado)
          ENDIF
      ENDCASE
      
    ENDPROC
    *
    *
    PROCEDURE RECONECTAR_SERVIDOR_FTP
    LOCAL lnHandle, lcCarpetaActual, lnResultado
      
      WITH This
        .nFtpHandle = 0
        lnHandle = InternetConnect(.nInternetHandle, (.cServidorFTP), VAL(.cPuertoNro), (.cNombreUsuario), (.cContrasena), INTERNET_SERVICE_FTP, 0, 0)
        .OBTENER_ERROR(lnHandle <= 0, "No me pude conectar al Servidor FTP**Verifica los datos de conexión")
        lcCarpetaActual = .cCarpetaRemota
        IF lnHandle <> 0 THEN
          lnResultado = FtpSetCurrentDirectory(lnHandle, @lcCarpetaActual)
          IF lnResultado = 1 THEN
            .nFtpHandle = lnHandle
            RETURN(.T.)
          ELSE
            .OBTENER_ERROR(lnResultado <> 1, "No pude establecer la carpeta remota")
            RETURN(.F.)
          ENDIF
        ELSE
          RETURN(.F.)
        ENDIF
      ENDWITH
      
    ENDPROC
    *
    *
  ENDDEFINE
  *
  *
  