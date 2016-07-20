*!*	FUNCTION BORRARDSN 
*!*	  *****   To Delete a DSN: 
*!*	  *'Set the driver to SQL Server because most common.
*!*	  strDriver = "SQL Server"
*!*	  *'Set the attributes delimited by null.
*!*	  *'See driver documentation for a complete list of attributes.
*!*	  strAttributes = "DSN=DSN_TEMP" + Chr(0)
*!*	  *'To show dialog, use Form1.Hwnd instead of vbAPINull.
*!*	  intRet = SQLConfigDataSource(vbAPINull, ODBC_REMOVE_DSN, ;
*!*	                 strDriver, strAttributes)
*!*	  If intRet
*!*	    MessageBox( "DSN Deleted" )
*!*	  Else
*!*	    MessageBox( "Delete Failed" )
*!*	  EndIf
*!*	ENDFUNC 

*!*	PROCEDURE lconectar

*!*	lc_password =ALLTRIM(configuracion.passwordbd)
*!*	lc_usuario_ =ALLTRIM(configuracion.usernamebd)
*!*	lc_sname =ALLTRIM(configuracion.server_name)
*!*	lc_sip  =ALLTRIM(configuracion.server_IP)
*!*	lc_nombre =ALLTRIM(configuracion.nombre_bd)

*!*	lcsplash.lbl_verifica.caption="Conectando a Base de datos"
*!*	lcStringConn="Driver={SQL Server}"+;
*!*	             ";Server="+lc_sname+;
*!*	             ";Database="+lc_nombre+;
*!*	             ";Uid="+lc_usuario_+;
*!*	             ";Pwd="+lc_password
*!*	***Evitar que aparezca  la ventana de login
*!*	SQLSETPROP(0,"DispLogin",3)
*!*	lc_con=SQLSTRINGCONNECT(lcStringConn)
*!*	if m.lc_con<0
*!*	  =AERROR(laError)
*!*	  *nopc=MESSAGEBOX(laError,0+16,"Error")
*!*	      lc_con=SQLCONNECT("localdb","admin","adm3340sdfee3")
*!*	      if m.lc_con<0
*!*	       nopc=MESSAGEBOX("No se pudo conectar",0+48,"Error")
*!*	      ELSE
*!*	       DO FORM frm_logon
*!*	       READ EVENTS
*!*	      ENDIF
*!*	ELSE

*!*	 DO FORM frm_logon
*!*	 READ EVENTS
*!*	endif

*!*	m.nResult = SQLExec( m.lc_con,"select * from mitabla","micursor")
*!*	if m.nresult>0
*!*	 sele micursor
*!*	 browse   && ver datos
*!*	else
*!*	 wait windows "error de consulta"
*!*	endif
