
procedure errorsys

	lldesarrollo=(_vfp.startmode()#4)
	LOCAL aFoxErr,nTotErr
	DIMENSION aFoxErr[1]
	nTotErr = AERROR(aFoxErr)
	nError  = AfoxErr[1,1]	
	
		DO CASE
			CASE nError=1938                  && no parent
				RETURN
			CASE nError=2059      	      &&  corta estructura endtry
				RETURN               		      		
			CASE nToterr>0 AND nError = 1420  && Corrupt Ole object in General field.
				Mensaje_error(nError)
				RETURN
			CASE nToterr>0 AND nError = 1429  && error conexion ADO
			        =Mensaje_error(nError)
			        lcmensaje = 'Error de conexión a la Base de Datos Seleccionada'+CHR(13)+;
			                    'Consulte a su Administrador de Sistemas'
			        =Oavisar.usuario(lcmensaje,0)
			       IF !lldesarrollo 
			           QUIT 
			       ELSE
			          CANCEL all
			          CLEAR ALL 
			       ENDIF    
			CASE nError=1115  && error GETCURSORADAPTER en obtenercursor, cuando el alias es cursor vfp
			     RETURN 			        
			CASE nError=1426  && error com cuando uso excel
			     GO BOTTOM IN ALIAS()
			     RETURN 
			CASE nError = 5                   && record out of range
 				if eof()
  			          go bott
*				    skip
 			      endif
				RETURN
			CASE nError = 4                   && fin de archivo
  				go bott
				return     		
			CASE nError = 1884     		  && Uniqueness ID error
			*	IF CURSORGETPROP("buffering")=1
			*		MESSAGEBOX(ERR_UNIQUEKEY_LOC)
			*		RETURN
			*	ENDIF
			*	IF MESSAGEBOX(ERR_UNIQUEKEY_LOC+" "+ERR_UNIQUEKEY2_LOC,36)=6
			*		TABLEREVERT(.T.)
			*	ENDIF
				RETURN
			CASE nError = 12 OR nError = 13    		  && variable no found
 				=Mensaje_error(nError)
			       IF !lldesarrollo 
			           QUIT 
			       ELSE
			          CANCEL all
			          CLEAR ALL 
			       ENDIF    
			CASE nError = 2203  && recursos insuficiente
				Mensaje_error(nError)
				RETURN			       
			OTHERWISE	
				=Mensaje_error(nError)
				CLEAR CLASSLIB onegocioslocal
				RETURN	
		ENDCASE
RETURN 

function Mensaje_error(nError)
	LOCAL lclocalprogram,lcmensaje,gnx

	lcmensaje = 'Linea nº '+MESSAGE(1) +CHR(13)+"Error nº: "+STR(nError)+CHR(13);
	+'Error '+MESSAGE()+chr(13)+' Alias '+alias()+' registro '+str(recno())+chr(13);
	+'Control activo '+sys(18) 

	lclocalprogram = PROGRAM(1) &&""	
	lcmensaje = lcmensaje +" "+ lclocalprogram
	*=Oavisar.usuario(lcmensaje,0) 
	Grabar_log(lcmensaje)
	
	Do Form frmerror Name oform Linked With nError,lcmensaje,lclocalprogram To luvalorbuscado

	uvalorbuscado=luvalorbuscado
	Release oform

	If uvalorbuscado=1 && Aceptar
	   return
		*Return To Master
	Else && cancelar	  
	    && me fijo si hay una transaccion abierta
	    
		If Txnlevel()>0
			If !'NATIVE'$LcDataSourceType 
				If LcDataSourceType="ADO" 
					DO CASE 
					CASE Vartype(Oca)="O"
						Oca.Datasource.ActiveConnection.rollbacktrans()
					CASE VARTYPE(oCadapter)="O"
						 oCadapter.Datasource.ActiveConnection.rollbacktrans()
					ENDCASE 
				Else
					lnOkSql =Sqlrollback(lnConectorODBC)
				Endif
			Endif
			Rollback
		Endif
		
		local llFormActivo
		llFormActivo=type('application.activeform')='O'
		if llFormActivo
			application.ActiveForm.Unload()
			
		ENDIF
		Do Form frmlogout 
	ENDIF
RETURN

