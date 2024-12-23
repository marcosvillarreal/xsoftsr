*===================
*= ARCHIVO PRINCIPAL
*===================
*
*	VER AL PIE alguna consideracion con respecto a campos tablas
*
*select min(id) from ctacte c where not exists (select cnumero from ctacte d where c.id=d.cnumero )

clear all
set classlib to
l='j:\xsoftsr'
*l='X:'
set talk off
PUBLIC lldesarrollo,PIDSISTEMA
lldesarrollo=(_vfp.startmode()#4)

PIDSISTEMA = 1
_vfp.AutoYield = .f.

lctituloGestion = "Gestión de Ventas " + IIF(lldesarrollo," - Beta","")

lcVersion = "01.00.21"

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

cRutaCAE = sys(5)+CURDIR()+"caevacio.jpg"
cLogoFac	= SYS(5)+CURDIR()+"logofac.jpg"
cRutaQR		= SYS(5)+CURDIR()+"qr.jpg"

If lldesarrollo
   lcdd=L+'\proyectos\starossa\'   
*-- RUTA
   _rutaclases =lcdd+'Clases'
   _rutaclased =L+'\desarrollo\clases'
   _rutabmpd   =L+'\desarrollo\graficos'
   _rutaprogs  =lcdd+'Progs'
   _rutamenu   =lcdd+'Menus'
   _rutadatos  =lcdd+'Datos'
   _rutabmps   =lcdd+'graphics'
   _rutaforms  =lcdd+'forms'
   _rutareports=lcdd+'reports' 
    _rutaformsDesarrollo =L+'\desarrollo\forms'
   _rutaffc  =L+'\desarrollo\clases\ffc'
   _rutalib = L +'\desarrollo\lib'   
   cRutaCAE	= _rutabmps + '\caevacio.jpg'
   cLogoFAC	= _rutabmps + '\logofac.jpg'
   cRutaQR	= _rutabmps + "\qr.jpg"
   
   _rutaformsb  =lcdd+'forms\banco'
   _rutaformsc  =lcdd+'forms\caja' 
   _rutaformscc  =lcdd+'forms\ctacte' 
   _rutaformsre  =lcdd+'forms\rendicion' 
   _rutaformsa  =lcdd+'forms\arqueo'
   _rutaformse  =lcdd+'forms\exportar'
   _rutaformvta  =lcdd+'forms\venta'
   _rutaformped  =lcdd+'forms\pedidos'
   _rutaformpre  =lcdd+'forms\precio'
   _rutaformpm  =lcdd+'forms\pm'
   _rutaformst  =lcdd+'forms\stock'
   _rutaformcp  =lcdd+'forms\compras'
   _rutaformut  =lcdd+'forms\util'
   _rutaformtar  =lcdd+'forms\tarjetas'
   _rutaformwha  =lcdd+'forms\whatsapp'
   _rutaformest =lcdd+'forms\estadistica'
   _rutaformart =lcdd+'forms\articulos'
     _rutaformsync =lcdd+'forms\sync'
      _rutaformpatron =lcdd+'forms\patron'
      _rutaformimpu =lcdd+'forms\impu'
   Set default to (lcdd) &&;(lcddc)

   Set path to &_rutaclases,&_rutaprogs,&_rutamenu,&_rutadatos,&_rutabmps,&_rutaforms;
               ,&_rutareports,&_rutaclased,&_rutabmpd,&_rutaformsDesarrollo,&_rutaffc;
               ,&_rutalib, &_rutaformsb, &_rutaformscc, &_rutaformsc, &_rutaformsre;
               ,&_rutaformsa,&_rutaformse,&_rutaformvta,&_rutaformped,&_rutaformpre;
               ,&_rutaformpm,&_rutaformst,&_rutaformcp,&_rutaformut,&_rutaformtar;
               ,&_rutaformwha,&_rutaformest,&_rutaformart,&_rutaformsync,&_rutaformpatron ;
               ,&_rutaformimpu
Endif


Set classlib to aplicacion.vcx additive && Objeto Aplicacion

*-- APERTURA DE CLASES Y ARCHIVOS DE PROCEDIMIENTOS

   SET PROCEDURE  TO  proc.prg ADDITIVE  && Procedimientos generales
   SET PROCEDURE TO googlemaps.prg ADDITIVE 
   SET PROCEDURE  TO  syserror.prg ADDITIVE  
   SET PROCEDURE TO procfiscal.prg ADDITIVE 
   SET PROCEDURE  TO registry.prg ADDITIVE 
   SET PROCEDURE TO syerrhand.prg ADDITIVE 
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
	 SET CLASSLIB TO onegocioslocal ADDITIVE 
*	SET LIBRARY TO vfpconnection.fll ADDITIVE 
	*BarCode
	SET PROCEDURE TO FoxBarcode.prg ADDITIVE 
	SET PROCEDURE TO gpImage2.prg ADDITIVE
	*SET PROCEDURE TO importexcelprovee.prg ADDITIVE 
	 SET PROCEDURE TO FoxBarcodeQR ADDITIVE
	 SET PROCEDURE TO mapsApiKey.prg ADDITIVE 
	 SET PROCEDURE TO  foxypreviewercaller.prg ADDITIVE 
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
   PUBLIC oConfigTermi,GoogleMapsKeyAPI
   
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
ObjReporter.AddProperty('logo',"logogestion.jpg")
objReporter.AddProperty('logofac',cLogoFac)
ObjReporter.AddProperty('numcae',cRutaCAE)
ObjReporter.AddProperty('fileqr',cRutaQR)

GoogleMapsKeyAPI = 'AIzaSyBcWBS6HjNKZ2QkFWeQoiOQFtP6thnE8to'

IF lldesarrollo
	ObjReporter.logo = lcdd+'graphics\logogestion.jpg'
ENDIF 

PUBLIC fBCode

fBCode = CREATEOBJECT("FoxBarcode")

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
	
	goapp.version = lcVersion &&"01.00.21"
	
	PUBLIC  gcicono
	     
	PcmsgIU  = 'Información al Usuario'
	PcmsgIP  = 'Información al Programador'
	   
	gcicono=lcdd+'help.ico'
	LcLlaveCf = SPACE(8)
	      
	on error do errorsys
	           		                          
	do setup
	
	LeerConfigTermi()
	
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


