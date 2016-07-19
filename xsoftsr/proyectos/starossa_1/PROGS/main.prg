*===================
*= ARCHIVO PRINCIPAL
*===================
*
*	VER AL PIE alguna consideracion con respecto a campos tablas
*
*select min(id) from ctacte c where not exists (select cnumero from ctacte d where c.id=d.cnumero )

clear all
set classlib to
l='C:'
set talk off
lldesarrollo=(_vfp.startmode()#4)

_vfp.AutoYield = .f.

lctituloGestion = "Gestión de Ventas .-"

If !lldesarrollo
   If f_activawin(lctituloGestion)
  
      =messagebox('Ya Estaba activo !!!!',48,'Información al Usuario')
     _Screen.windowstate=2
      _screen.lockscreen=.f.
      _screen.visible=.t.
      _screen.refresh      
			 * El programa ya estaba activo:
      Return && Termina el programa
   Endif
ENDIF

Set cursor off

lccaption=_screen.caption

Set cursor on

lcdd=alltrim(curdir()) && directorio de arranque

If lldesarrollo
   lcdd=L+'\XsoftSR\proyectos\starossa_1\'
*-- RUTA
   _rutaclases =lcdd+'Clases'
   _rutaclased =L+'\XsoftSR\desarrollo\clases'
   _rutabmpd   =L+'\XsoftSR\desarrollo\graficos'
   _rutaprogs  =lcdd+'Progs'
   _rutamenu   =lcdd+'Menus'
   _rutadatos  =lcdd+'Datos'
   _rutabmps   =lcdd+'graphics'
   _rutaforms  =lcdd+'forms'
   _rutareports=lcdd+'reports' 
    _rutaformsDesarrollo =L+'\XsoftSR\desarrollo\forms'
   _rutaffc  =L+'\XsoftSR\desarrollo\clases\ffc'
    _rutalib = L +'\xsoftsql\desarrollo\lib'   
   
    _rutaformsb  =lcdd+'forms\banco'
    _rutaformsc  =lcdd+'forms\caja' 
    _rutaformsa  =lcdd+'forms\arqueo'   
    _rutaformsct  =lcdd+'forms\ctacte' 
    _rutaformsr  =lcdd+'forms\rendicion' 
    _rutaformse  =lcdd+'forms\exportar' 
   Set default to (lcdd) &&;(lcddc)

   Set path to &_rutaclases,&_rutaprogs,&_rutamenu,&_rutadatos,&_rutabmps,&_rutaforms;
               ,&_rutareports,&_rutaclased,&_rutabmpd,&_rutaformsDesarrollo,&_rutaffc;
               ,&_rutalib,&_rutaformsb,&_rutaformsc,&_rutaformsa ,&_rutaformsct;
               ,&_rutaformsr,&_rutaformse
Endif


Set classlib to aplicacion.vcx additive && Objeto Aplicacion

*-- APERTURA DE CLASES Y ARCHIVOS DE PROCEDIMIENTOS

   SET PROCEDURE  TO  proc.prg ADDITIVE  && Procedimientos generales
   SET PROCEDURE  TO  syserror.prg ADDITIVE  
   SET PROCEDURE TO procfiscal.prg ADDITIVE 
   SET PROCEDURE  TO registry.prg ADDITIVE 
   SET PROCEDURE  TO  syerrhand.prg ADDITIVE     
   SET CLASSLIB TO  reindexer ADDITIVE 
   SET CLASSLIB TO  clasesgenerales ADDITIVE 
   SET CLASSLIB TO  controles ADDITIVE 
   SET CLASSLIB TO  iabm.vcx ADDITIVE 
   SET CLASSLIB TO  calc.vcx ADDITIVE  && Calculadora   
   SET CLASSLIB TO  icontrolespersonalizados ADDITIVE 
   SET CLASSLIB TO odata ADDITIVE 
   SET CLASSLIB TO rcscalendar ADDITIVE 
   SET CLASSLIB TO _reportlistener.vcx ADDITIVE 
*   SET  CLASSLIB  TO  xfrxlib ADDITIVE 
*   SET LIBRARY TO xfrxlib.fll ADDITIVE 
	 SET CLASSLIB  TO  ZIP ADDITIVE 

*clear all

_screen.lockscreen=.t.
_Screen.windowstate=2
_Screen.caption=lctituloGestion
_Screen.icon='help.ico'
_screen.picture= 'fondo51.bmp'
_Screen.closable=.f.
_Screen.visible=.t.

PUBLIC LcConectionString,LcDataSourceType,lcOrigenPublico,PcmsgIU,PcmsgIP,LcWebService,LcLlaveCf,Pnterminal,pnsucursal
PUBLIC lcConectionODBC,lnconectorODBC
   
 STORE '' TO LcConectionString,LcDataSourceType,lcOrigenPublico,LcWebService,lcConectionODBC
 STORE 0 TO Pnterminal,Pnsucursal,lnconectorODBC

PUBLIC OAvisar
Oavisar=CREATEOBJECT('avisar')

 Public goapp,ObjReporter
 
goapp=createobject('app',!lldesarrollo,lldesarrollo)
 
ObjReporter= CREATEOBJECT("Custom")
ObjReporter.AddProperty('titulo1',"")
ObjReporter.AddProperty('titulo2',"")
ObjReporter.AddProperty('titulo3',"")
ObjReporter.AddProperty('titulo4',"")

IF TYPE('goApp')='O'
*-- CARGAR PROPIEDADES DE RUTA EN OBJETO APLICACION
	IF lldesarrollo && Aplicacion en modo desarrollo
		goapp.cdefault=set('default')
		goapp.cpath=set('path')
	ELSE  && Aplicacion en modo ejecución
		IF LcDataSourceType = "NATIVE"
			Set defa to (goapp.cdefault)
			Set path to (goapp.cpath)
		ENDIF          
	ENDIF 
	
	goapp.version = "01.00.00"
	
	PUBLIC  gcicono
	     
	PcmsgIU  = 'Información al Usuario'
	PcmsgIP  = 'Información al Programador'
	   
	gcicono=lcdd+'help.ico'
	LcLlaveCf = SPACE(8)
	      
	on error do errorsys
	           		                          
	do setup
    
	_screen.LockScreen=.f.
	
	oavisar.proceso('S','Inicializando el sistema, aguarde unos instantes por favor ...')

    WAIT WINDOW "Verificando ActiveX instalados ..." nowait
    DO Verifica_OCX WITH "Check"
    
    _screen.LockScreen=.t.	
	 
	DO directivasfiscal    && en procfiscal.prg
	DO directivasHasar
	  
	= Fwin32()    && funciones api win32

	 =ObtenerServidor()
	  
	IF LEN(TRIM(LcConectionString))=0
		DO FORM configbd
		=ObtenerServidor()
	ENDIF    

	PUBLIC loConnDataSource,lcIdObjCon,lcIdObjneg,lcServidor,ObjNeg

	LeerXMLClassID("objetodll.xml")
	
	If lldesarrollo 
		oavisar.usuario('Conectado a  '+ALLTRIM(goapp.servidor)+'\'+LTRIM(goapp.initcatalo))
	ENDIF 
	
	   * en proc.prg   
	IF ExisteDSN()  			
		IF !ConeccionADO()
			CANCEL 
			CLEAR ALL
			RETURN 
		ENDIF 
	ELSE
		CANCEL 
		CLEAR ALL
		RETURN 
	ENDIF 
	
	WAIT CLEAR 

* en proc.prg

*!*		IF !lldesarrollo 
*!*			IF !LeerVersionExe(1)
*!*				CANCEL
*!*				CLEAR ALL
*!*				RETURN 	
*!*		      ENDIF 
*!*		ENDIF 

	LeerEmpresa()
	    
	Goapp.idusuario           = 0
	Goapp.perfilusuario     = 0
	Goapp.nombreusuario= ""
	    		
	DO FORM frmlogin
		 
	LOCAL oMenu
	oMenu= null
	oDesktop = ''
	oMenu = NEWOBJECT("createmenu","symde.vcx",.NULL.,.T.,odesktop,Goapp.perfilusuario,"'verdana',9","")
	oMenu.createMenu()   
	oMenu = null

	DO FORM frmmenu
	   
	 *  Do mnuppal.mpr
	                  
	 _screen.visible=.t.
	   
	_screen.lockscreen=.f.

	Read events   
ENDIF

loConnDataSource = null 

cancel all
clear all
 
Return

*-----------------------------
FUNCTION F_ActivaWin(cCaption)
*-----------------------------

LOCAL nHWD
DECLARE INTEGER FindWindow IN WIN32API ;
STRING cNULL,;
STRING cWinName

DECLARE SetForegroundWindow IN WIN32API ;
INTEGER nHandle

DECLARE SetActiveWindow IN WIN32API ;
INTEGER nHandle

DECLARE ShowWindow IN WIN32API ;
INTEGER nHandle, ;
INTEGER nState

nHWD = FindWindow(0, cCaption)
IF nHWD > 0
    * VENTANA YA ACTIVA
    * LA "LLAMAMOS":
    ShowWindow(nHWD,9)

    * LA PONEMOS ENCIMA
    SetForegroundWindow(nHWD)

    * LA ACTIVAMOS
    SetActiveWindow(nHWD)
    RETURN .T.
ELSE
    * VENTANA NO ACTIVA
    RETURN .F.
ENDIF

FUNCTION Fwin32
	DECLARE Beep IN WIN32API INTEGER nFrequency, INTEGER nDuration
RETURN .t.

DEFINE CLASS MiImagen AS IMAGE
	PROCEDURE ResizeFondo
		WITH THIS
		.LEFT = INT(_SCREEN.WIDTH  - .WIDTH)/ 2
		.TOP = INT(_SCREEN.HEIGHT - .HEIGHT)/ 2
		ENDWITH
	ENDPROC
	
	PROCEDURE DESTROY
		UNBINDEVENT(THIS)
	ENDPROC
ENDDEFINE


