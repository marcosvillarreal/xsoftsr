#INCLUDE ".\INCLUDE\PRINCIPAL.H"
*-- DEFINICIÓN DE CLASES ,PROCEDIMIENTOS Y FUNCIONES AUXILIARES

FUNCTION LibFoxToolsCargada
	LOCAL llFoxToolsCargada
	llFoxToolsCargada = "FOXTOOLS.FLL" $ SET("LIBRARY")
	IF NOT llFoxToolsCargada
		DO CASE
		CASE FILE("FOXTOOLS.FLL")
			SET LIBRARY TO "FOXTOOLS.FLL" ADDITIVE
			llFoxToolsCargada = .T.
		CASE FILE(ADDBS(HOME()) + "FOXTOOLS.FLL")
			SET LIBRARY TO (ADDBS(HOME()) + "FOXTOOLS.FLL") ADDITIVE
			llFoxToolsCargada = .T.
		ENDCASE
	ENDIF
	RETURN llFoxToolsCargada
ENDFUNC



PROCEDURE PCOVERAGE
	LPARAMETERS tnActivar

	IF tnActivar = 1
		SET COVERAGE TO (SET("DEFAULT") + CURDIR() + "COVER.LOG")
		_SCREEN.CLS
		_SCREEN.PRINT("COVERAGE ACTIVO")
	ELSE
		SET COVERAGE TO
		_SCREEN.CLS
		_SCREEN.PRINT("COVERAGE INACTIVO")
	ENDIF
ENDPROC



FUNCTION _MESSAGEBOX
	*-- REEMPLAZO DEL MESSAGEBOX
	LPARAMETERS tcMensaje,tnancho,tnalto, tiBotones, tcTitulo, tnTimeout ,tnTimeoutValue
	LOCAL loMensaje, lnRetorno
	loMensaje = NEWOBJECT("messagebox_form", "lib_comctl_aux.vcx", "", tcMensaje, tiBotones, tcTitulo, tnTimeout ,tnTimeoutValue,tnancho,tnalto)
	loMensaje.Show(1)
	lnRetorno	= loMensaje.IDOpcion
	RETURN lnRetorno
ENDFUNC



PROCEDURE PausarMientrasPresiona
	*-- PAUSA LA EJECUCIÓN HASTA QUE SE LIBERE LA TECLA INDICADA.
	LPARAMETERS tuTecla

	*-- PARÁMETROS:
	*-- tuTecla		Código ASCII o carácter de la tecla

	LOCAL lcSetEscape, lnASCII
	lcSetEscape	= SET("ESCAPE")
	SET ESCAPE OFF
	DECLARE SHORT GetKeyState IN WIN32API INTEGER KEYCODE

	IF VARTYPE(tuTecla) = "C"
		lnASCII	= ASC(UPPER(tuTecla))
	ELSE
		lnASCII	= ASC(UPPER(CHR(tuTecla)))
	ENDIF

	LOCAL lnSetTypeahead
	lnSetTypeahead = SET("TYPEAHEAD")
	SET TYPEAHEAD TO 0
	DO WHILE GetKeyState(lnASCII) < 0
		INKEY(0.001, "H")
	ENDDO
	CLEAR TYPEAHEAD
	SET TYPEAHEAD TO (lnSetTypeahead)
	SET ESCAPE &lcSetEscape.
ENDPROC




DEFINE CLASS BusTV_ColeccionListImages AS SESSION
	***********************************************************************************************
	*	CLASE PARA MANEJO DE LAS IMÁGENES DE UN CONTROL IMAGELIST (oBusImg)
	***********************************************************************************************
	*	    Autor: Fernando D. Bozzo
	*	   Creado: 14/02/2004
	*	 Licencia: Código Abierto - Libre distribución sin restricciones
	*	  Versión: 2.11
	***********************************************************************************************
	ImageList		= ""	&& Nombre de la tabla de imágenes
	COUNT			= 0		&& Cantidad de Nodos Total
	LargoUserImageKey	= 0
	
	PROCEDURE INIT
		SET SAFETY OFF
		SET TALK OFF
		SET DELETED ON

		THIS.DATABIND_IMAGELIST()
	ENDPROC


	PROCEDURE DESTROY
		IF USED("TV_ImageList")
			USE IN "TV_ImageList"
		ENDIF
	ENDPROC


	PROCEDURE DATABIND_IMAGELIST
		*-- ESTE MÉTODO VINCULA LA TABLA DE IMÁGENES AL CONTROL IMAGELIST
		WITH THIS
			LOCAL laTags(1), laFields(1), lcOnError, lnError, llRetorno, lnCampo, lnCampos, lnTag, lnSelect
			llRetorno	= .T.
			lnSelect	= SELECT()
			USE IN (SELECT("TV_ImageList"))
			lcOnError	= ON("ERROR")
			ON ERROR lnError = ERROR()
			lnError = 0
			IF NOT EMPTY(.ImageList)
				IF AT(".", .ImageList) = 0
					.ImageList	= FORCEEXT(.ImageList, "DBF")
				ENDIF
				IF FILE(.ImageList)
					USE (.ImageList) SHARED AGAIN ALIAS "TV_ImageList"
					IF lnError > 0
						*-- Error el abrir la tabla
						_MESSAGEBOX("VFP IMAGELIST:" + CR ;
							+ "Ocurrió un error al abrir la tabla '" + .ImageList + "':" + CR + CR ;
							+ "Código: " + TRANSFORM(lnError) + CR ;
							+ "Mensaje: " + MESSAGE() + CR ;
							+ "Línea: " + MESSAGE(1) + CR ;
							, MB_OK + MB_ICONEXCLAMATION ;
							, "ERROR EN LA TABLA DE IMÁGENES '" + .ImageList + "'")
						llRetorno	=  .F.
					ELSE
						*-- OK
						.LargoUserImageKey	= FSIZE("Key", "TV_ImageList")
						
						*-- Actualizo el contador de imágenes
						COUNT ALL FOR NOT DELETED() TO THIS.COUNT
						
						*-- Verifico que estén los índices necesarios
						FOR lnTag = 1 TO 4
							IF NOT EMPTY(TAG(lnTag)) AND NOT TAG(lnTag) $ "INDEX,KEY"
								*-- Nombre de índice incorrecto
								_MESSAGEBOX("VFP IMAGELIST:" + CR ;
									+ "La tabla '" + .ImageList + "'" + CR + ;
									+ "no tiene los índices llamados INDEX y KEY exclusivamente requeridos" + CR + CR ;
									+ "Regenere los índices de la siguiente forma:" + CR ;
									+ "USE '" + .ImageList + "' EXCLUSIVE" + CR ;
									+ "DELETE TAG ALL" + CR ;
									+ "INDEX ON INDEX TAG INDEX" + CR ;
									+ "INDEX ON KEY TAG KEY" + CR ;
									, MB_OK + MB_ICONEXCLAMATION ;
									, "ERROR EN LA TABLA DE IMÁGENES '" + .ImageList + "'")
								llRetorno	=  .F.
							ELSE
								*-- Verifico la clave del índice
								IF NOT EMPTY(KEY(lnTag)) AND NOT KEY(lnTag) $ "INDEX,KEY"
									*-- Clave errónea
									_MESSAGEBOX("VFP IMAGELIST:" + CR ;
										+ "La tabla '" + .ImageList + "'" + CR + ;
										+ "no tiene los índices INDEX y/o KEY con la clave requerida" + CR + CR ;
										+ "Regenere los índices de la siguiente forma:" + CR ;
										+ "USE '" + .ImageList + "' EXCLUSIVE" + CR ;
										+ "DELETE TAG ALL" + CR ;
										+ "INDEX ON INDEX TAG INDEX" + CR ;
										+ "INDEX ON KEY TAG KEY" + CR ;
										, MB_OK + MB_ICONEXCLAMATION ;
										, "ERROR EN LA TABLA DE IMÁGENES '" + .ImageList + "'")
									llRetorno	=  .F.
								ENDIF
							ENDIF
						ENDFOR
					ENDIF
				ELSE
					_MESSAGEBOX("La tabla '" + .ImageList + "'" + CR ;
						+ "indicada en la propiedad 'Tabla' del control ImageList" + CR ;
						+ "no se encuentra en la ruta del PATH o no existe." + CR + CR ;
						+ "(PATH=" + SET("PATH") ;
						, MB_OK + MB_ICONEXCLAMATION ;
						, "NO SE ENCUENTRA LA TABLA " + .ImageList + "!")
					llRetorno	=  .F.
				ENDIF
			ENDIF

			IF EMPTY(lcOnError)
				ON ERROR
			ELSE
				ON ERROR &lcOnError.
			ENDIF
			
			SELECT(lnSelect)

			RETURN llRetorno
		ENDWITH
	ENDPROC
	
	
	PROCEDURE ADD
		*-- AGREGA UNA IMÁGEN A LA COLECCIÓN DE IMÁGENES
		LPARAMETERS tnIndice, tcClave, tcImagen
		IF USED("TV_ImageList")
			lnCount	= THIS.COUNT + 1
			IF EMPTY(tcImagen)
				_MESSAGEBOX("ADD(): No indicó el nombre de la imágen." ;
					, MB_OK + MB_ICONEXCLAMATION ;
					, "ERROR EN CONTROL IMAGELIST")
				RETURN NULL
			ENDIF
			IF EMPTY(tcClave)
				tcClave	= ""
			ENDIF
			IF EMPTY(tcClave) OR EMPTY(THIS.Get_NombreImagen(tcClave))
				IF EMPTY(tnIndice) OR NOT BETWEEN(tnIndice, 1, lnCount)
					tnIndice = lnCount
				ELSE
					REPLACE ALL Index WITH Index + 1 FOR Index >= tnIndice NOOPTIMIZE
				ENDIF
				INSERT INTO "TV_ImageList" ;
					(Key, Index, Picture) ;
					VALUES ;
					(tcClave, tnIndice, tcImagen)
				THIS.COUNT	= lnCount
			ELSE
				_MESSAGEBOX("La clave '" + tcClave + "' está repetida." ;
					, MB_OK + MB_ICONEXCLAMATION ;
					, "ERROR EN CONTROL IMAGELIST")
			ENDIF
		ELSE
			_MESSAGEBOX("No se indicó el nombre de la tabla de imágenes a usar." ;
				, MB_OK + MB_ICONEXCLAMATION ;
				, "ERROR EN CONTROL IMAGELIST")
			RETURN NULL
		ENDIF
	ENDPROC
	
	
	PROCEDURE REMOVE
		LPARAMETERS tuClave
		IF USED("TV_ImageList")
			IF NOT EMPTY(THIS.Get_NombreImagen(tuClave))
				DELETE IN "TV_ImageList"
			ELSE
				RETURN .F.
			ENDIF
		ELSE
			_MESSAGEBOX("No se indicó el nombre de la tabla de imágenes a usar." ;
				, MB_OK + MB_ICONEXCLAMATION ;
				, "ERROR EN CONTROL IMAGELIST")
			RETURN .F.
		ENDIF
	ENDPROC
	
	
	PROCEDURE CLEAR
		LPARAMETERS tnIndice, tcClave, tcImagen
		IF USED("TV_ImageList")
			SCAN ALL
				DELETE
			ENDSCAN
		ELSE
			_MESSAGEBOX("No se indicó el nombre de la tabla de imágenes a usar." ;
				, MB_OK + MB_ICONEXCLAMATION ;
				, "ERROR EN CONTROL IMAGELIST")
			RETURN NULL
		ENDIF
	ENDPROC


	PROCEDURE Get_NombreImagen
		*-- DEVUELVE EL NOMBRE Y RUTA DE LA IMÁGEN DADOS SU ÍNDICE (INDEX) O CLAVE (KEY)
		LPARAMETERS teIndice

		IF NOT EMPTY(teIndice) ;
				AND USED("TV_ImageList") ;
				AND (VARTYPE(teIndice) = "N" AND (TV_ImageList.INDEX = teIndice OR SEEK(teIndice, "TV_ImageList", "Index")) ;
				OR VARTYPE(teIndice) = "C" AND (TV_ImageList.KEY = teIndice OR SEEK(teIndice, "TV_ImageList", "Key")))
			RETURN TV_ImageList.PICTURE
		ELSE
			RETURN ""
		ENDIF
	ENDPROC


	PROCEDURE Get_IndexImagen
		*-- DEVUELVE EL INDICE (INDEX) DE LA IMÁGEN DADA SU CLAVE (KEY)
		LPARAMETERS tcIndice

		IF VARTYPE(tcIndice) = "C"
			tcIndice	= PADR(tcIndice, THIS.LargoUserImageKey)
			IF USED("TV_ImageList") AND (TV_ImageList.KEY = tcIndice OR SEEK(tcIndice, "TV_ImageList", "Key"))
				RETURN TV_ImageList.INDEX
			ELSE
				RETURN 0
			ENDIF
		ELSE
			RETURN ""
		ENDIF
	ENDPROC


ENDDEFINE




DEFINE CLASS BusTV_ColeccionNodos AS SESSION
	***********************************************************************************************
	*	CLASE PARA MANEJO DE LOS NODOS DE UN CONTROL TREEVIEW (oBusNodes)
	***********************************************************************************************
	*	    Autor: Fernando D. Bozzo
	*	   Creado: 30/12/2003
	*	 Licencia: Código Abierto - Libre distribución sin restricciones
	*	  Versión: 2.00
	***********************************************************************************************
	*	NOTA: PARA VER BIÉN LOS ESQUEMAS DE ABAJO SE DEBE USAR LETRA COURIER NEW.
	*--------------------------------------------------------------------------------------------------
	*   ÁRBOL GENERAL DE DATOS        ÁRBOL BINARIO EQUIVALENTE                ÁRBOL VISUAL EQUIVALENTE
	*   DE EJEMPLO:                   HIJO IZQUIERDO - HERMANO DERECHO         (ÁRBOL QUE VE EL USUARIO)
	*                                 (ÁRBOL A USAR PARA EVALUAR EL            
	*                                 ÁRBOL GENERAL DE DATOS)
	*
	*   A                                    A                                 A
	*   |                                   /                                  |
	*   B--C--D                            B                                   +--B
	*   |  |  |                           / \                                  |  +--K
	*   |  |  +--E--F                    /   \                                 |  +--L
	*   |  |     |                      /     \                                |  |  +--N
	*   |  |     +-G                   /       \                               |  +--M
	*   |  |                          K         C                              +--C
	*   |  +--H--I                     \       / \                             |  +--H
	*   |        |                      L     /   \                            |  +--I
	*   |        +--J                  / \   /     \                           |     +--J
	*   |                             N   M H       D                          +--D
	*   +--K--L--M                           \     /                              +--E
	*         |                               I   E                               |  +--G
	*         +--N                           /   / \                              +--F
	*                                       J   G   F
	*
	*
	*	CASOS MÁS IMPORTANTES:
	*	- Para saber si un nodo tiene hijo izquierdo, se debe verificar que KHijo_I no sea vacío y
	*	  que exista el nodo KHijo_I.
	*	- Para saber si un nodo tiene hermano derecho, se debe verificar que KHerm_D no sea vacío y
	*	  que exista el nodo KHerm_D.
	*	- Para buscar el último hermano derecho se deben recorrer todos los hermanos derechos hasta
	*	  encontrar uno cuyo KHerm_D sea vacío.
	*	- Para buscar el primer hermano izquierdo, se debe buscar el Hijo izquierdo del padre del nodo dado.
	*	- Para armar el árbol de datos igual que una vista del explorador de archivos, se debe hacer una
	*	  búsqueda Pre-Order (Nodo Raíz, Hijo izquierdo, Hermano derecho).
	PROTECTED Pila
	Pila = NULL
	DECLARE ITEM(1,1)
	COUNT			= 0		&& Cantidad de Nodos Total
	VCOUNT			= 0		&& Cantidad de Nodos Visibles
	KNodoSelected	= SPACE_10
	OrdenSelected	= 0
	KNodoHighLight	= SPACE_10
	OrdenHighLight	= 0
	LargoUserKey		= 0


	PROCEDURE INIT
		LPARAMETERS tnLargoUserKey
		
		LOCAL lcIndex
		tnLargoUserKey	= IIF(EMPTY(tnLargoUserKey), 32, tnLargoUserKey)
		THIS.LargoUserKey	= tnLargoUserKey
		SET SAFETY OFF
		SET TALK OFF
		*SET DELETED ON

		*-- CURSOR DEL TREEVIEW
		*-- --------------------------
		*-- Sobre los campos:
		*-- KPadre		Es la clave del nodo Padre
		*-- KNodo		Es la clave del nodo
		*-- KHijo_I		Es la clave del nodo Hijo Izquierdo
		*-- KHerm_D		Es la clave del nodo Hermano Derecho
		*-- Indice		Es el índice correlativo único del nodo
		*-- Orden		Es un índice asignado para ser usado por la interfaz visual
		*-- Nivel_I		Nivel de anidamiento (para representar las líneas de nivel)
		*-- PrimerHijo	Indica si el nodo es el primer hijo del padre
		*-- Niveles		Su interpretación binaria mantiene todos los niveles intermedios
		*--				(líneas de nivel) del nodo actual.
		CREATE CURSOR "TV_Nodos" ;
			(KPadre C(10) NOCPTRANS, ;
			KNodo C(10) NOCPTRANS, ;
			KHijo_I C(10) NOCPTRANS, ;
			KHerm_D C(10) NOCPTRANS, ;
			Indice I, ;
			Orden I, ;
			Nivel_I I, ;
			PrimerHijo L, ;
			Niveles I, ;
			Bold L, ;
			Bold2 L, ;
			Checked L NULL, ;
			Expanded L, ;
			ExpandedImage I, ;
			ExpandedImage2 I, ;
			IMAGE I, ;
			IMAGE2 I, ;
			KEY M, ;
			SelectedImage I, ;
			SelectedImage2 I, ;
			SORTED L, ;
			TEXT M, ;
			TEXT2 M, ;
			VISIBLE L, ;
			BACKCOLOR I DEFAULT 16777215, ;
			FORECOLOR2 I DEFAULT 0, ;
			FORECOLOR I DEFAULT 0, ;
			TAG M)

		*-- Sobre los campos del cursor del TreeView:
		*-- -----------------------------------------
		*--   Los únicos campos necesarios para mantener las relaciones entre nodos
		*-- son: KPadre, KNodo, KHijo_I, KHerm_D e Indice.
		*--   Los demás campos son necesarios para la etapa de ordenamiento y visualización
		*-- en el formato de árbol equivalente a la ventana de directorios del explorador de archivos.
		INDEX ON Indice TAG Indice
		INDEX ON KNodo + KPadre TAG KNodoPadre
		INDEX ON KPadre + KNodo TAG KPadreNodo
		INDEX ON KHijo_I TAG KHijo_I
		INDEX ON KHerm_D + KPadre TAG KHerDPadre
		INDEX ON Orden TAG Orden
		lcIndex	= "INDEX ON PADR(KEY," + STR(tnLargoUserKey,3) + ") TAG KUser"
		&lcIndex.
		SET ORDER TO 0

		LOCAL loBus
		loBus	= CREATEOBJECT("BusTV_Ordenar")
		THIS.ADDPROPERTY("oBusOrdenar", loBus)
		loBus	= CREATEOBJECT("BusTV_Listar")
		THIS.ADDPROPERTY("oBusListar", loBus)
		loBus	= CREATEOBJECT("BusTV_Borrar")
		THIS.ADDPROPERTY("oBusBorrar", loBus)
		loBus	= CREATEOBJECT("BusTV_ContraerTodos")
		THIS.ADDPROPERTY("oBusContraerTodos", loBus)
		loBus	= CREATEOBJECT("BusTV_ExpandirTodos")
		THIS.ADDPROPERTY("oBusExpandirTodos", loBus)

		SELECT "TV_Nodos"
		THIS.CLEAR()
	ENDPROC


	PROCEDURE DESTROY
		IF USED("TV_Nodos")
			USE IN "TV_Nodos"
		ENDIF
		IF USED("TV_ImageList")
			USE IN "TV_ImageList"
		ENDIF
	ENDPROC


	********** ATRIBUTOS DEL NODO **********

	*-- FLAGS INTERNOS
	FUNCTION Get_Nivel_I(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Nivel_I, .F.)
	ENDFUNC
	FUNCTION Get_PrimerHijo(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), PrimerHijo, .F.)
	ENDFUNC
	FUNCTION Get_Niveles(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Niveles, .F.)
	ENDFUNC
	FUNCTION Get_KPadre(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), KPadre, .F.)
	ENDFUNC
	FUNCTION Get_KHijo_I(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), KHijo_I, .F.)
	ENDFUNC
	FUNCTION Get_KHerm_D(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), KHerm_D, .F.)
	ENDFUNC
	FUNCTION Get_Orden(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Orden, .F.)
	ENDFUNC


	*-- INDICADOR DE COLOR DE FONDO DEL NODO
	FUNCTION Get_BackColor(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), BackColor, .F.)
	ENDFUNC
	FUNCTION Set_BackColor(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE BackColor WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE COLOR DE FIGURA DEL NODO
	FUNCTION Get_ForeColor(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), ForeColor, .F.)
	ENDFUNC
	FUNCTION Set_ForeColor(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE ForeColor WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE COLOR DE FIGURA DEL NODO-2
	FUNCTION Get_ForeColor2(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), ForeColor2, .F.)
	ENDFUNC
	FUNCTION Set_ForeColor2(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE ForeColor2 WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE NODO EN NEGRITA
	FUNCTION Get_Bold(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Bold, .F.)
	ENDFUNC
	FUNCTION Set_Bold(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE Bold WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE NODO EN NEGRITA-2
	FUNCTION Get_Bold2(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Bold2, .F.)
	ENDFUNC
	FUNCTION Set_Bold2(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE Bold2 WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE NODO TILDADO CON CKECK
	FUNCTION Get_Checked(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Checked, .F.)
	ENDFUNC
	FUNCTION Set_Checked(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE Checked WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE NODO EXPANDIDO
	FUNCTION Get_Expanded(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Expanded, .F.)
	ENDFUNC
	FUNCTION Set_Expanded(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			IF teValue
				THIS.NodoExpandir(tcKNodo)	&& Expandir hijos
			ELSE
				THIS.NodoContraer(tcKNodo)	&& Contraer hijos
			ENDIF
		ENDIF
	ENDFUNC

	*-- IMAGEN DEL NODO EXPANDIDO
	FUNCTION Get_ExpandedImage(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), ExpandedImage, .F.)
	ENDFUNC
	FUNCTION Set_ExpandedImage(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE ExpandedImage WITH teValue
		ENDIF
	ENDFUNC

	*-- IMAGEN DEL NODO EXPANDIDO-2
	FUNCTION Get_ExpandedImage2(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), ExpandedImage2, .F.)
	ENDFUNC
	FUNCTION Set_ExpandedImage2(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE ExpandedImage2 WITH teValue
		ENDIF
	ENDFUNC

	*-- IMAGEN DEL NODO
	FUNCTION Get_Image(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), IMAGE, .F.)
	ENDFUNC
	FUNCTION Set_Image(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE IMAGE WITH teValue
		ENDIF
	ENDFUNC

	*-- IMAGEN DEL NODO-2
	FUNCTION Get_Image2(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), IMAGE2, .F.)
	ENDFUNC
	FUNCTION Set_Image2(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE IMAGE2 WITH teValue
		ENDIF
	ENDFUNC

	*-- INDICADOR DE SELECCION DEL NODO
	FUNCTION Get_Selected(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), (KNodo = THIS.KNodoSelected), .F.)
	ENDFUNC
	FUNCTION Set_Selected(tcKNodo, teValue)
		WITH THIS
			IF .ExisteKNodo(tcKNodo, .T.)
				DO CASE
				CASE teValue
					*-- Existe y se eligió como Seleccionado
					.KNodoSelected	= KNodo
					.OrdenSelected	= Orden
				CASE .KNodoSelected = KNodo
					*-- Existe, era el nodo Seleccionado y ahora se deselecciona
					.KNodoSelected	= SPACE_10
					.OrdenSelected	= 0
				ENDCASE
			ENDIF
		ENDWITH && THIS
	ENDFUNC

	*-- IMAGEN DEL NODO SELECCIONADO
	FUNCTION Get_SelectedImage(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), SelectedImage, .F.)
	ENDFUNC
	FUNCTION Set_SelectedImage(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE SelectedImage WITH teValue
		ENDIF
	ENDFUNC

	*-- IMAGEN DEL NODO SELECCIONADO-2
	FUNCTION Get_SelectedImage2(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), SelectedImage2, .F.)
	ENDFUNC
	FUNCTION Set_SelectedImage2(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE SelectedImage2 WITH teValue
		ENDIF
	ENDFUNC

	*-- NODO ORDENADO ALFABÉTICAMENTE
	FUNCTION Get_Sorted(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), SelectedImage, .F.)
	ENDFUNC
	FUNCTION Set_Sorted(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE SORTED WITH teValue
		ENDIF
	ENDFUNC

	*-- TAG
	FUNCTION Get_Tag(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), TAG, .F.)
	ENDFUNC
	FUNCTION Set_Tag(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE TAG WITH teValue
		ENDIF
	ENDFUNC

	*-- TEXTO DEL NODO
	FUNCTION Get_Text(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), TEXT, .F.)
	ENDFUNC
	FUNCTION Set_Text(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE TEXT WITH teValue
		ENDIF
	ENDFUNC

	*-- TEXTO DEL NODO-2
	FUNCTION Get_Text2(tcKNodo)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), TEXT2, .F.)
	ENDFUNC
	FUNCTION Set_Text2(tcKNodo, teValue)
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			REPLACE TEXT2 WITH teValue
		ENDIF
	ENDFUNC



	FUNCTION Get_Child(tcKNodo)
		*-- HIJO
		IF THIS.ExisteKNodo(tcKNodo, .T.) ;
				AND NOT EMPTY(KHijo_I) ;
				AND KHijo_I # RAIZ_ABS ;
				AND SEEK(KHijo_I, "TV_Nodos", "KNodoPadre")
			RETURN KNodo
		ELSE
			RETURN SPACE_10
		ENDIF
	ENDFUNC

	FUNCTION Get_Children(tcKNodo)
		*-- CANTIDAD DE HIJOS
		LOCAL lnChildren
		IF THIS.ExisteKNodo(tcKNodo, .T.) ;
				AND NOT EMPTY(KHijo_I) ;
				AND SEEK(KHijo_I, "TV_Nodos", "KNodoPadre")
			lnChildren = 1
			DO WHILE NOT EMPTY(KHerm_D) AND SEEK(KHerm_D, "TV_Nodos", "KNodoPadre")
				lnChildren	= lnChildren + 1
			ENDDO
		ELSE
			lnChildren	= 0
		ENDIF
		RETURN lnChildren
	ENDFUNC

	FUNCTION Get_FirstSibling(tcKNodo)
		*-- PRIMER HERMANO IZQUIERDO
		IF THIS.ExisteKNodo(tcKNodo, .T.) ;
				AND (PrimerHijo ;
				OR SEEK(KPadre, "TV_Nodos", "KNodoPadre") ;
				AND SEEK(KHijo_I, "TV_Nodos", "KNodoPadre"))
			RETURN KNodo
		ELSE
			RETURN tcKNodo
		ENDIF
	ENDFUNC

	FUNCTION Get_Index(tcKNodo)
		*-- INDICE (INDEX)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Indice, 0)
	ENDPROC

	FUNCTION Get_Key(tcKNodo)
		*-- CLAVE (KEY)
		RETURN IIF(THIS.ExisteKNodo(tcKNodo, .T.), Key, 0)
	ENDPROC

	FUNCTION Get_LastSibling(tcKNodo)
		*-- ÚLTIMO HERMANO DERECHO
		IF THIS.ExisteKNodo(tcKNodo, .T.) ;
				AND NOT EMPTY(KPadre) ;
				AND SEEK(SPACE_10 + KPadre, "TV_Nodos", "KHerDPadre")
			RETURN KNodo
		ELSE
			RETURN tcKNodo
		ENDIF
	ENDFUNC

	FUNCTION Get_Next(tcKNodo)
		*-- SIGUIENTE HERMANO
		IF THIS.ExisteKNodo(tcKNodo, .T.) ;
				AND NOT EMPTY(KHerm_D) ;
				AND SEEK(KHerm_D, "TV_Nodos", "KNodoPadre")
			RETURN KNodo
		ELSE
			RETURN SPACE_10
		ENDIF
	ENDFUNC

	FUNCTION Get_Parent(tcKNodo)
		*-- PADRE
		IF THIS.ExisteKNodo(tcKNodo, .T.) ;
				AND NOT EMPTY(KPadre) ;
				AND KPadre # RAIZ_ABS ;
				AND SEEK(KPadre, "TV_Nodos", "KNodoPadre")
			RETURN KNodo
		ELSE
			RETURN SPACE_10
		ENDIF
	ENDFUNC

	FUNCTION Get_Previous(tcKNodo)
		*-- HERMANO ANTERIOR
		IF THIS.ExisteKNodo(tcKNodo, .T.) AND SEEK(KNodo, "TV_Nodos", "KHerDPadre")
			RETURN KNodo
		ELSE
			RETURN SPACE_10
		ENDIF
	ENDFUNC

	FUNCTION Get_Root(tcKNodo)
		*-- NODO RAIZ
		WITH THIS
			LOCAL lcNodo, lcNodoAnt
			lcNodo		= tcKNodo
			lcNodoAnt	= SPACE_10
			DO WHILE NOT EMPTY(lcNodo)
				lcNodoAnt	= lcNodo
				lcNodo		= .Get_Parent(@lcNodo)
			ENDDO
		ENDWITH
		RETURN lcNodoAnt
	ENDFUNC
	********** ATRIBUTOS DEL NODO **********


	FUNCTION NodoContraer(tcKNodo)
		*-- CONTRAE UNA RAMA DEL ÁRBOL CUYO PADRE ES EL NODO DADO.
		IF THIS.ExisteKNodo(tcKNodo, .T.) AND Expanded &&AND NOT EMPTY(KHijo_I)
			REPLACE Expanded WITH .F.
		ENDIF
	ENDFUNC


	FUNCTION NodoExpandir(tcKNodo)
		*-- EXPANDE UNA RAMA DEL ÁRBOL CUYO PADRE ES EL NODO DADO.
		IF THIS.ExisteKNodo(tcKNodo, .T.) AND NOT Expanded &&AND NOT EMPTY(KHijo_I)
			REPLACE Expanded WITH .T.
		ENDIF
	ENDFUNC


	PROCEDURE NodoContraerTodos
		*-- CONTRAE TODOS LOS NODOS DE UNA RAMA DEL ÁRBOL CUYO PADRE ES EL NODO DADO.
		LPARAMETERS tcKNodo

		IF THIS.ExisteKNodo(tcKNodo, .T.) AND NOT EMPTY(KHijo_I)
			THIS.oBusContraerTodos.RecorrerSubArbol_PreOrden(THIS, tcKNodo, .T.)
		ENDIF
	ENDPROC


	PROCEDURE NodoExpandirTodos
		*-- EXPANDE UNA RAMA DEL ÁRBOL CUYO PADRE ES EL NODO DADO.
		LPARAMETERS tcKNodo

		IF THIS.ExisteKNodo(tcKNodo, .T.) AND NOT EMPTY(KHijo_I)
			THIS.oBusExpandirTodos.RecorrerSubArbol_PreOrden(THIS, tcKNodo, .T.)
		ENDIF
	ENDPROC


	PROCEDURE EnsureVisible
		*-- ASEGURA QUE EL NODO INDICADO QUEDE VISIBLE, EXPANDIENDO
		*-- LOS PADRES HASTA LA RAÍZ.
		LPARAMETERS tcKNodo
		LOCAL lcKNodo
		lcKNodo	= tcKNodo
		WITH THIS
			DO WHILE NOT EMPTY(lcKNodo)
				lcKNodo	= .Get_Parent(lcKNodo)
				IIF(EMPTY(lcKNodo), .T., .Set_Expanded(lcKNodo, .T.))
			ENDDO
		ENDWITH
	ENDPROC


	PROCEDURE EnsureInvisible
		*-- ASEGURA QUE EL NODO INDICADO NO QUEDE VISIBLE, CONTRAYENDO
		*-- LOS PADRES HASTA LA RAÍZ.
		*-- (OPUESTO A EnsureVisible)
		LPARAMETERS tcKNodo
		LOCAL lcKNodo
		lcKNodo	= tcKNodo
		WITH THIS
			IF NOT EMPTY(lcKNodo)
				IIF(EMPTY(.Get_Child(lcKNodo)), .T., .Set_Expanded(lcKNodo, .F.))
				DO WHILE NOT EMPTY(lcKNodo)
					lcKNodo	= .Get_Parent(lcKNodo)
					IIF(EMPTY(lcKNodo), .T., .Set_Expanded(lcKNodo, .F.))
				ENDDO
			ENDIF
		ENDWITH
	ENDPROC


	FUNCTION OBJKNODO
		*-- DEVUELVE UN OBJETO NODO DE SÓLO DATOS SI SE PASA EL KNODO
		LPARAMETERS tcKNodo
		LOCAL loNodo
		IF THIS.ExisteKNodo(tcKNodo, .T.)
			SCATTER MEMO NAME loNodo
		ELSE
			loNodo = NULL
		ENDIF
		RETURN loNodo
	ENDFUNC

	PROCEDURE ITEM_ACCESS
		*-- PARÁMETRO DEL USUARIO PARA INDICE O CLAVE DE USUARIO
		LPARAMETERS tuNodo, tuFlag
		*-- PARÁMETROS:
		*-- tuNodo		Indica el Nº o Clave del Nodo
		*-- tuFlag		(Uso Interno) Si se indica tuNodo+1 se buscará por Orden interno (para recorrido de arbol)
		*				Este Flag sólo sirve si tuNodo es el orden del nodo y se ha ordenado el árbol con el método Ordenar().
		LOCAL lcNodo, loNodo
		DO CASE
		CASE EMPTY(tuNodo)
			*-- Ubico el nodo RAIZ
			lcNodo	= THIS.Get_KNodo_X_Index()			&& Si devuelve un valor, deja el puntero de registro en el nodo.
		CASE VARTYPE(tuNodo) = "N" AND tuFlag = tuNodo + 1
			*-- Ubico un nodo por su Nº de Orden
			lcNodo	= THIS.Get_KNodo_X_Orden(tuNodo)	&& Si devuelve un valor, deja el puntero de registro en el nodo.
		OTHERWISE
			*-- Ubico un nodo por su Nº de Indice o Clave
			lcNodo	= THIS.Get_KNodo_X_Index(tuNodo)	&& Si devuelve un valor, deja el puntero de registro en el nodo.
		ENDCASE

		IF EMPTY(lcNodo)
			loNodo	= NULL
		ELSE
			*-- BUSCO EL NODO DADO Y DEVUELVO UN OBJETO NODO
			SCATTER MEMO NAME loNodo
		ENDIF

		RETURN loNodo
	ENDPROC


	PROCEDURE Ordenar
		**********************************************************************
		*	ORDENO TODO EL ARBOL POR PRE-ORDEN
		**********************************************************************
		WITH THIS
			LOCAL lcNodo, lnVCOUNT_Ant, lnVResta
			lcNodo	= .Get_KNodo_X_Index()	&& DESDE EL NODO RAIZ ABSOLUTO

			IF EMPTY(lcNodo)
				RETURN .F.
			ELSE
				PRIVATE poTHIS, pnVCOUNT, pnNiveles, pnNivel_I_Ant
				pnVCOUNT		= 0
				REPLACE ALL Orden WITH 0
				poTHIS		= THIS
				pnNiveles	= INT(0)
				pnNivel_I_Ant	= 0
				lnVCOUNT_Ant	= .VCOUNT
				.oBusOrdenar.RecorrerSubArbol_PreOrden(THIS, lcNodo, .T.)
				.VCOUNT		= pnVCOUNT
				lnVResta	= lnVCOUNT_Ant - pnVCOUNT

				*-- Una vez reordenado el árbol, ajusto el orden del nodo con el foco
				*-- (Selected) y del nodo con el resalte (HighLight).
				*-- ------------------------------------------------------------------
				IF pnVCOUNT > 0
					*-- ORDEN DEL NODO CON EL FOCO
					IF NOT EMPTY(.KNodoSelected)
						IF SEEK(.KNodoSelected, "TV_Nodos", "KNodoPadre")
							IF EMPTY(Orden)
								*-- Si el nodo existe y no tiene Orden, es que quedó contraído.
								lcKNodoSelected = .KNodoSelected
								DO WHILE NOT EMPTY(lcKNodoSelected) AND EMPTY(Orden)
									lcKNodoSelected	= .Get_Parent(lcKNodoSelected)
								ENDDO
								.OrdenSelected	= Orden
								.KNodoSelected	= lcKNodoSelected
							ELSE
								*-- Si el nodo existe y tiene Orden, reasigno el orden
								*-- del nodo seleccionado.
								.OrdenSelected = Orden
							ENDIF
						ELSE
							*-- Si el nodo no existe, es que se eliminó.
							.OrdenSelected	= 0
							.KNodoSelected	= SPACE_10
						ENDIF
					ELSE
						*-- No hay nodo seleccionado
						.OrdenSelected	= 0
						.KNodoSelected	= SPACE_10
					ENDIF && NOT EMPTY(.KNodoSelected)

					*-- ORDEN DEL NODO RESALTADO
					IF NOT EMPTY(.KNodoHighLight)
						IF SEEK(.KNodoHighLight, "TV_Nodos", "KNodoPadre")
							.OrdenHighLight = Orden
						ELSE
							.OrdenHighLight = 0
							.KNodoHighLight	= SPACE_10
						ENDIF
					ENDIF
				ELSE
					*-- No hay nodos
					.OrdenSelected	= 0
					.KNodoSelected	= SPACE_10
					.OrdenHighLight = 0
					.KNodoHighLight	= SPACE_10
				ENDIF

				RETURN .T.
			ENDIF
		ENDWITH
	ENDPROC


	PROCEDURE ListNodos
		LPARAMETERS tuNodo

		LOCAL lcNodo
		lcNodo	= THIS.Get_KNodo_X_Index(tuNodo)	&& Si devuelve un valor, deja el puntero de registro en el nodo.

		IF EMPTY(lcNodo)
			RETURN .F.
		ELSE
			*-- LISTO EL NODO Y SUS HIJOS
			THIS.oBusListar.RecorrerSubArbol_PreOrden(THIS, lcNodo, .T.)
			RETURN .T.
		ENDIF
	ENDPROC


	PROCEDURE REMOVE
		***********************************************************************************************
		*	ELIMINA EL NODO INDICADO DEL ÁRBOL
		***********************************************************************************************
		LPARAMETERS tuNodo

		LOCAL lcNodo
		lcNodo	= THIS.Get_KNodo_X_Index(tuNodo)	&& Si devuelve un valor, deja el puntero de registro en el nodo.

		IF EMPTY(lcNodo)
			RETURN .F.
		ELSE
			*-- ELIMINO EL NODO Y SUS HIJOS
			PRIVATE pnBorrados, pcHerm_D, pcHijo_I, pcPadre, pcRaiz, pnIndice, pnCount
			pnBorrados	= 0
			pnCount		= THIS.COUNT
			pcRaiz		= lcNodo
			pcPadre		= KPadre
			pcHijo_I	= KHijo_I
			pcHerm_D	= KHerm_D
			pnIndice	= Indice
			
			*-- Verifico si es hermano primero
			IF SEEK(pcRaiz, "TV_Nodos", "KHerDPadre")
				*-- No es hermano primero: Es intermedio o último y no es hijo único.
				*-- ESTOY UBICADO EN EL HERMANO IZQUIERDO DEL NODO A BORRAR
				REPLACE KHerm_D WITH IIF(EMPTY(pcHerm_D), "", pcHerm_D)
			ELSE
				*-- Es hermano primero.
				IF NOT EMPTY(pcPadre) AND SEEK(pcPadre, "TV_Nodos", "KNodoPadre")
					REPLACE KHijo_I WITH IIF(EMPTY(pcHerm_D), "", pcHerm_D)
				ENDIF
			ENDIF
			
			THIS.oBusBorrar.RecorrerSubArbol_PreOrden(THIS, lcNodo, .T.)

			*-- ACTUALIZO EL CONTADOR DE NODOS.
			THIS.COUNT	= pnCount
			RETURN .T.
		ENDIF
	ENDPROC


	PROCEDURE ADD
		***********************************************************************************************
		*	AGREGA EL NODO INDICADO AL ÁRBOL
		***********************************************************************************************
		LPARAMETERS tuRelativa, tnRelacion, tcClave, tcTexto, teImagen, teImagenSel

		*-- PARÁMETROS
		* tuRelativa	Opcional. El número de índice o clave de un objeto Node ya existente.
		*				Su relación con el nuevo nodo viene determinada por el argumento siguiente,
		*				tnRelacion.
		* tnRelacion	Opcional. Especifica la ubicación relativa del objeto Node, como se
		*				describe en Valores.
		* tcClave		Opcional. Una cadena única que puede usarse para recuperar el objeto Node
		*				con el método Item.
		* tcTexto		Requerido. La cadena que aparece en el objeto Node.
		* teImagen		Opcional. El índice de una imagen de un control ImageList asociado.
		* teImagenSel	Opcional. El índice de una imagen de un control ImageList asociado
		*				que se muestra cuando se selecciona el objeto Node.

		*-- Los valores válidos para tnRelacion son:
		* Constante	Valor	Descripción
		* ---------	-------	-----------------------------------------------------------------------
		* tvwFirst		0	Primero. El objeto Node se sitúa antes de todos los demás nodos al
		*					mismo nivel que el especificado en relativo.
		* tvwLast		1	Último. El objeto Node se sitúa después de todos los demás nodos al
		*					mismo nivel que el especificado en relativo. Los objetos Node que se
		*					agregan secuencialmente se irán situando detrás del último agregado.
		* tvwNext		2	(Predeterminado) Siguiente. El objeto Node se sitúa después del
		*					especificado en relativo.
		* tvwPrevious	3	Anterior. El objeto Node se sitúa antes del especificado en relativo.
		* tvwChild		4	Secundario. El objeto Node es secundario con respecto al nodo
		*					especificado en relativo.

		LOCAL llError, loNodo, lnIndice, lcNodo, lcPadre, lcHijo_I, lcHerm_D
		IF EMPTY(tcTexto)
			_MESSAGEBOX("El Texto no puede ser vacío")
			RETURN .F.
		ENDIF

		tcClave		= IIF(EMPTY(tcClave), "", tcClave)
		tcTexto		= ALLTRIM(tcTexto)
		IF EMPTY(teImagen)
			teImagen	= 0
		ENDIF
		IF EMPTY(teImagenSel)
			teImagenSel	= 0
		ENDIF
		IF VARTYPE(tnRelacion) = "L"
			*-- Si tnRelación es lógico
			tnRelacion	= 2
		ENDIF
		IF EMPTY(tuRelativa)
			*-- Si no se indica tuRelativa se asume carácter vacío
			tuRelativa	= SPACE_10
		ENDIF
		IF EMPTY(tuRelativa)
			*-- Cualquier nueva raíz será hija de la raíz absoluta
			tuRelativa	= RAIZ_ABS
			tnRelacion	= 4
		ELSE
			*-- La clave relativa no es vacía
			tuRelativa	= THIS.Get_KNodo_X_Index(tuRelativa)	&& Si devuelve un valor, deja el puntero de registro en el nodo.
			llError	= EMPTY(tuRelativa)
		ENDIF

		DO CASE
		CASE llError
			*-- HUBO UN ERROR

		CASE tnRelacion = 0 && PRIMERO
			IF THIS.ExisteKNodo(tuRelativa, .T.) AND SEEK(KPadre, "TV_Nodos", "KNodoPadre")
				*-- El nodo actual es el Padre del 1er.nodo
				lcNodo		= SYS(2015)
				lcHijo_I	= KHijo_I
				REPLACE KHijo_I WITH lcNodo

				IF SEEK(lcHijo_I, "TV_Nodos", "KNodoPadre")
					*-- El nodo actual es el 1er.hermano
					lcPadre		= KPadre
					lcHerm_D	= KNodo
					lnIndice 	= THIS.COUNT + 1
					INSERT INTO "TV_Nodos" ;
						(KPadre, ;
						KNodo, ;
						KHerm_D, ;
						Indice, ;
						KNodo, ;
						KEY, ;
						TEXT, ;
						IMAGE, ;
						SelectedImage) ;
						VALUES ;
						(lcPadre, ;
						lcNodo, ;
						lcHerm_D, ;
						lnIndice, ;
						lcNodo, ;
						tcClave, ;
						tcTexto, ;
						teImagen, ;
						teImagenSel)
					THIS.COUNT = lnIndice
				ELSE
					_MESSAGEBOX("PRIMERO: El nodo de clave [" + TRANSFORM(lcHijo_I) + "] no existe.")
					llError	= .T.
				ENDIF
			ELSE
				_MESSAGEBOX("PRIMERO: El nodo de clave [" + TRANSFORM(tuRelativa) + "] no existe.")
				llError	= .T.
			ENDIF

		CASE tnRelacion = 1 && ULTIMO
			*-- CONSIDERACIONES:
			*-- El último nodo es aquél cuyo hermano derecho es vacío
			IF THIS.ExisteKNodo(tuRelativa, .T.)
				lcPadre		= KPadre
				IF SEEK(SPACE_10 + lcPadre, "TV_Nodos", "KHerDPadre")
					lcNodo		= SYS(2015)
					REPLACE KHerm_D WITH lcNodo
					lnIndice 	= THIS.COUNT + 1
					INSERT INTO "TV_Nodos" ;
						(KPadre, ;
						KNodo, ;
						Indice, ;
						KNodo, ;
						KEY, ;
						TEXT, ;
						IMAGE, ;
						SelectedImage) ;
						VALUES ;
						(lcPadre, ;
						lcNodo, ;
						lnIndice, ;
						lcNodo, ;
						tcClave, ;
						tcTexto, ;
						teImagen, ;
						teImagenSel)
					THIS.COUNT = lnIndice
				ELSE
					_MESSAGEBOX("ÚLTIMO: El nodo de clave [" + SPACE_10 + lcPadre + "] no existe.")
					llError	= .T.
				ENDIF
			ELSE
				_MESSAGEBOX("ÚLTIMO: El nodo de clave [" + TRANSFORM(tuRelativa) + "] no existe.")
				llError	= .T.
			ENDIF

		CASE tnRelacion = 2 && SIGUIENTE
			*-- CONSIDERACIONES:
			*-- El Siguiente de un nodo cualquiera NUNCA será Primer nodo
			*-- El Siguiente de un nodo cualquiera NUNCA será Hijo_Izq de otro nodo
			IF THIS.ExisteKNodo(tuRelativa, .T.)
				lnIndice 	= THIS.COUNT + 1
				lcPadre		= KPadre
				lcNodo		= SYS(2015)
				lcHerm_D	= KHerm_D
				REPLACE KHerm_D WITH lcNodo
				INSERT INTO "TV_Nodos" ;
					(KPadre, ;
					KNodo, ;
					KHerm_D, ;
					Indice, ;
					KNodo, ;
					KEY, ;
					TEXT, ;
					IMAGE, ;
					SelectedImage) ;
					VALUES ;
					(lcPadre, ;
					lcNodo, ;
					lcHerm_D, ;
					lnIndice, ;
					lcNodo, ;
					tcClave, ;
					tcTexto, ;
					teImagen, ;
					teImagenSel)
				THIS.COUNT = lnIndice
			ELSE
				_MESSAGEBOX("SIGUIENTE: El nodo de clave [" + TRANSFORM(tuRelativa) + "] no existe.")
				llError	= .T.
			ENDIF

		CASE tnRelacion = 3 && ANTERIOR
			IF (KHerm_D = tuRelativa OR SEEK(tuRelativa, "TV_Nodos", "KHerDPadre"))
				*-- El nodo actual es el hermano izquierdo del nodo indicado
				lcPadre		= KPadre
				lcNodo		= SYS(2015)
				lcHerm_D	= KHerm_D
				REPLACE KHerm_D WITH lcNodo

				lnIndice 	= THIS.COUNT + 1
				INSERT INTO "TV_Nodos" ;
					(KPadre, ;
					KNodo, ;
					KHerm_D, ;
					Indice, ;
					KNodo, ;
					KEY, ;
					TEXT, ;
					IMAGE, ;
					SelectedImage) ;
					VALUES ;
					(lcPadre, ;
					lcNodo, ;
					lcHerm_D, ;
					lnIndice, ;
					lcNodo, ;
					tcClave, ;
					tcTexto, ;
					teImagen, ;
					teImagenSel)
				THIS.COUNT = lnIndice
			ELSE
				*-- No tiene Hermanos.
				IF (KHijo_I = tuRelativa OR SEEK(tuRelativa, "TV_Nodos", "KHijo_I"))
					*-- El nodo actual es el Padre del 1er.nodo
					lcNodo		= SYS(2015)
					lcHijo_I	= Hijo_I
					REPLACE KHijo_I WITH lcNodo

					IF SEEK(lcHijo_I, "TV_Nodos", "KNodoPadre")
						*-- El nodo actual es el 1er.hermano
						lcPadre		= KPadre
						lcHerm_D	= KNodo
						lnIndice 	= THIS.COUNT + 1
						INSERT INTO "TV_Nodos" ;
							(KPadre, ;
							KNodo, ;
							KHerm_D, ;
							Indice, ;
							KNodo, ;
							KEY, ;
							TEXT, ;
							IMAGE, ;
							SelectedImage) ;
							VALUES ;
							(lcPadre, ;
							lcNodo, ;
							lcHerm_D, ;
							lnIndice, ;
							lcNodo, ;
							tcClave, ;
							tcTexto, ;
							teImagen, ;
							teImagenSel)
						THIS.COUNT = lnIndice
					ELSE
						_MESSAGEBOX("ANTERIOR: El nodo de clave [" + TRANSFORM(lcHijo_I) + "] no existe.")
						llError	= .T.
					ENDIF
				ELSE
					_MESSAGEBOX("ANTERIOR: El nodo de clave [" + TRANSFORM(tuRelativa) + "] no existe.")
					llError	= .T.
				ENDIF
			ENDIF

		CASE tnRelacion = 4 && SECUNDARIO (HIJO)
			*-- CONSIDERACIONES:
			*-- Si el Hijo_Izq del nodo es vacío, entonces el nuevo nodo será Hijo_Izq
			*-- Si el Hijo_Izq del nodo no es vacío, entonces el nuevo nodo será el último de los hermanos.
			IF THIS.ExisteKNodo(tuRelativa, .T.)
				lcHijo_I	= KHijo_I
				lcPadre		= tuRelativa
				IF EMPTY(lcHijo_I)
					*-- El Hijo_Izq del nodo es vacío, entonces el nuevo nodo será el Hijo_Izq.
					lcNodo		= SYS(2015)
					REPLACE KHijo_I WITH lcNodo
					lnIndice 	= THIS.COUNT + 1
					INSERT INTO "TV_Nodos" ;
						(KPadre, ;
						KNodo, ;
						Indice, ;
						KNodo, ;
						KEY, ;
						TEXT, ;
						IMAGE, ;
						SelectedImage) ;
						VALUES ;
						(lcPadre, ;
						lcNodo, ;
						lnIndice, ;
						lcNodo, ;
						tcClave, ;
						tcTexto, ;
						teImagen, ;
						teImagenSel)
					THIS.COUNT = lnIndice
				ELSE
					*-- El Hijo_Izq del nodo no es vacío, entonces el nuevo nodo será el último de los hermanos.
					IF SEEK(SPACE_10 + tuRelativa, "TV_Nodos", "KHerDPadre")
						lcNodo		= SYS(2015)
						REPLACE KHerm_D WITH lcNodo
						lnIndice 	= THIS.COUNT + 1
						INSERT INTO "TV_Nodos" ;
							(KPadre, ;
							KNodo, ;
							Indice, ;
							KNodo, ;
							KEY, ;
							TEXT, ;
							IMAGE, ;
							SelectedImage) ;
							VALUES ;
							(lcPadre, ;
							lcNodo, ;
							lnIndice, ;
							lcNodo, ;
							tcClave, ;
							tcTexto, ;
							teImagen, ;
							teImagenSel)
						THIS.COUNT = lnIndice
					ELSE
						_MESSAGEBOX("SECUNDARIO: El nodo de clave [" + SPACE_10 + tuRelativa + "] no existe.")
						llError	= .T.
					ENDIF
				ENDIF
			ELSE
				_MESSAGEBOX("SECUNDARIO: El nodo de clave [" + TRANSFORM(tuRelativa) + "] no existe.")
				llError	= .T.
			ENDIF
		ENDCASE

		RETURN lcNodo
	ENDPROC


	PROCEDURE CLEAR
		WITH THIS
			ZAP IN "TV_Nodos"
			.COUNT = 0
			.VCOUNT = 0
			.KNodoSelected	= SPACE_10
			.OrdenSelected	= 0
			.KNodoHighLight	= SPACE_10
			.OrdenHighLight	= 0

			*-- Creo el nodo raíz
			INSERT INTO "TV_Nodos" ;
				(KNodo) ;
				VALUES ;
				(RAIZ_ABS)
		ENDWITH
	ENDPROC


	PROCEDURE Get_KNodo_X_Index
		***********************************************************************************************
		*	DEVUELVE LA CLAVE INTERNA DE UN NODO (KNODO) DADO SU ÍNDICE O CLAVE DEL USUARIO.
		***********************************************************************************************
		LPARAMETERS tuNodo

		LOCAL lcNodo
		lcNodo	= ""
		DO CASE
		CASE EMPTY(tuNodo)
			*-- Devuelvo la raíz absoluta
			lcNodo	= RAIZ_ABS
		CASE VARTYPE(tuNodo) = "N"
			*-- tuNodo es una clave Numérica
			lcNodo	= IIF(Indice = tuNodo OR SEEK(tuNodo, "TV_Nodos", "Indice"), KNodo, "")
		CASE VARTYPE(tuNodo) = "C"
			*-- tuNodo es una clave Carácter del Usuario
			lcNodo	= IIF(TV_Nodos.KEY = PADR(tuNodo, THIS.LargoUserKey) OR SEEK(PADR(tuNodo, THIS.LargoUserKey), "TV_Nodos", "KUser"), KNodo, "")
		ENDCASE

		RETURN lcNodo
	ENDPROC


	PROCEDURE Get_KNodo_X_Orden
		***********************************************************************************************
		*	DEVUELVE LA CLAVE INTERNA DE UN NODO (KNODO) DADO SU ORDEN.
		***********************************************************************************************
		LPARAMETERS tuNodo

		LOCAL lcNodo

		IF EMPTY(tuNodo)
			*-- Devuelvo la raíz absoluta
			lcNodo	= IIF(SEEK(RAIZ_ABS, "TV_Nodos", "KNodoPadre"), RAIZ_ABS, "")
		ELSE
			*-- tuNodo es una clave Numérica
			lcNodo	= IIF(SEEK(tuNodo, "TV_Nodos", "Orden"), KNodo, "")
		ENDIF

		RETURN lcNodo
	ENDPROC


	FUNCTION ExisteKNodo(tcNodo, tlMoverPuntero)
		*-- DEVUELVE .T. SI EXISTE EL KNODO INDICADO Y .F. NI NO EXISTE.
		*-- ADICIONALMENTE PUEDE DEJAR UBICADO EL PUNTERO DE REGISTRO.
		RETURN (KNodo = tcNodo OR INDEXSEEK(tcNodo, tlMoverPuntero, "TV_Nodos", "KNodoPadre"))
	ENDFUNC
ENDDEFINE


DEFINE CLASS _PilaArbol AS _OBJVACIO
	***********************************************************************************************
	*	CLASE PARA MANEJO DE UNA PILA DE VALORES PARA EL ARBOL DE DATOS ESPECÍFICAMENTE
	***********************************************************************************************
	PROTECTED aValores(1, 2)
	*DECLARE aValores(1, 2)		&& Guarda las propiedades del valor
	COUNT			= 0
	KNodo			= ""
	KHerm_D			= ""

	PROCEDURE KNodo_ACCESS
		WITH THIS
			RETURN .aValores(.COUNT, 1)
		ENDWITH
	ENDPROC

	PROCEDURE KHerm_D_ACCESS
		WITH THIS
			RETURN .aValores(.COUNT, 2)
		ENDWITH
	ENDPROC

	PROCEDURE APILAR
		LPARAMETERS teValor1, teValor2
		*-- PARÁMETROS:
		*-- teValor1	KNodo
		*-- teValor2	KHerm_D
		WITH THIS
			LOCAL lnCount
			lnCount	= .COUNT + 1
			DECLARE .aValores(lnCount, 2)
			.aValores(lnCount, 1)	= teValor1
			.aValores(lnCount, 2)	= teValor2
			.COUNT	= lnCount
		ENDWITH && THIS
	ENDPROC

	PROCEDURE DESAPILAR
		WITH THIS
			LOCAL lnCount, lcTipoPariente
			lnCount	= .COUNT - 1

			IF lnCount >= 0
				IF lnCount = 0
					DECLARE .aValores(1, 2)
					ADEL(.aValores, 1)
				ELSE
					DECLARE .aValores(lnCount, 2)
				ENDIF
				.COUNT	= lnCount
				RETURN .T.
			ELSE
				RETURN .F.
			ENDIF
		ENDWITH && THIS
	ENDPROC

	PROCEDURE CLEAR
		WITH THIS
			DECLARE .aValores(1, 2)
			=ADEL(.aValores, 1)
			.COUNT = 0
		ENDWITH
	ENDPROC
ENDDEFINE


DEFINE CLASS _Pila AS _OBJVACIO
	***********************************************************************************************
	*	CLASE PARA MANEJO DE UNA PILA DE VALORES
	***********************************************************************************************
	*PROTECTED aValores(1)
	DECLARE aValores(1)
	COUNT			= 0
	VALUE			= ""

	PROCEDURE Value_ACCESS
		WITH THIS
			RETURN IIF(EMPTY(.COUNT), "", .aValores(.COUNT))
		ENDWITH
	ENDPROC

	PROCEDURE APILAR
		LPARAMETERS teValor

		WITH THIS
			LOCAL lnCount
			lnCount	= .COUNT + 1
			DECLARE .aValores(lnCount)
			.aValores(lnCount)	= teValor
			.COUNT	= lnCount
		ENDWITH && THIS
	ENDPROC

	PROCEDURE DESAPILAR
		WITH THIS
			LOCAL lnCount
			lnCount	= .COUNT - 1

			IF lnCount >= 0
				IF lnCount = 0
					DECLARE .aValores(1)
					ADEL(.aValores, 1)
				ELSE
					DECLARE .aValores(lnCount)
				ENDIF
				.COUNT	= lnCount
				RETURN .T.
			ELSE
				RETURN .F.
			ENDIF
		ENDWITH && THIS
	ENDPROC

	PROCEDURE CLEAR
		WITH THIS
			DECLARE .aValores(1)
			=ADEL(.aValores, 1)
			.COUNT = 0
			.VALUE = 0
		ENDWITH
	ENDPROC
ENDDEFINE



DEFINE CLASS BusTV_RecorridoArbol AS _OBJVACIO
	***********************************************************************************************
	*	CLASE PARA RECORRIDO PRE-ORDER DEL ARBOL DE DATOS
	***********************************************************************************************
	PROCEDURE RecorrerSubArbol_PreOrden
		LPARAMETERS toNodos, tuNodo, tlNodoInterno
		LOCAL loPila, lcNodo, lcUltimoHijo_I

		lcNodo	= IIF(tlNodoInterno, ;
			IIF(KNodo = tuNodo OR SEEK(tuNodo, "TV_Nodos", "KNodoPadre"), KNodo, ""), ;
			toNodos.Get_KNodo_X_Index(tuNodo))

		WITH THIS
			loPila	= CREATEOBJECT("_PilaArbol")
			IF KNodo = RAIZ_ABS
				*-- EL NODO INDICADO ES LA RAIZ ABSOLUTA DEL ARBOL
				lcNodo	= KHijo_I
				lcUltimoHijo_I	= lcNodo

				DO WHILE loPila.COUNT > 0 OR NOT EMPTY(lcNodo)
					DO CASE
					CASE NOT EMPTY(lcNodo)
						=SEEK(lcNodo, "TV_Nodos", "KNodoPadre")
						loPila.APILAR(lcNodo, KHerm_D)
						IF .NextNode(lcNodo, loPila.COUNT, lcNodo = lcUltimoHijo_I)
							*-- Si NextNode devuelve .T. entonces sigo buscando más hijos
							lcNodo	= KHijo_I
						ELSE
							*-- Si NextNode devuelve .F. entonces no busco más hijos y sigo
							*-- con los hermanos.
							lcNodo	= SPACE_10
						ENDIF
						lcUltimoHijo_I	= lcNodo

					CASE loPila.COUNT > 0
						lcNodo	= loPila.KHerm_D
						loPila.DESAPILAR()

					ENDCASE
				ENDDO
			ELSE
				*-- EL NODO INDICADO NO ES LA RAIZ DEL ARBOL
				lcNodo	= KNodo
				lcUltimoHijo_I	= SPACE_10

				DO WHILE .T. &&loPila.COUNT > 0 OR NOT EMPTY(lcNodo)
					DO CASE
					CASE NOT EMPTY(lcNodo)
						=SEEK(lcNodo, "TV_Nodos", "KNodoPadre")
						loPila.APILAR(lcNodo, KHerm_D)
						IF .NextNode(lcNodo, loPila.COUNT, lcNodo = lcUltimoHijo_I)
							*-- Si NextNode devuelve .T. entonces sigo buscando más hijos
							lcNodo	= KHijo_I
						ELSE
							*-- Si NextNode devuelve .F. entonces no busco más hijos y sigo
							*-- con los hermanos.
							lcNodo	= SPACE_10
						ENDIF
						lcUltimoHijo_I	= lcNodo

					CASE loPila.COUNT > 0
						lcNodo	= loPila.KHerm_D
						loPila.DESAPILAR()
						IF loPila.COUNT = 0
							EXIT
						ENDIF

					ENDCASE
				ENDDO
			ENDIF
		ENDWITH && THIS
	ENDPROC


	PROCEDURE NextNode
		LPARAMETERS tuNodo, tnNodos_I, tlPrimerHijo
		*-- Evento generado cuando se encuentra un nuevo nodo
	ENDPROC
ENDDEFINE



DEFINE CLASS BusTV_Ordenar AS BusTV_RecorridoArbol
	*-- SUBCLASE DE BUSTV_RECORRIDOARBOL
	*-- PARA ORDENAR LOS NODOS
	PROCEDURE NextNode
		LPARAMETERS tuNodo, tnNodos_I, tlPrimerHijo
		*-- Evento generado cuando se encuentra un nuevo nodo
		pnVCOUNT		= pnVCOUNT + 1
		lnDifNiveles	= tnNodos_I - pnNivel_I_Ant
		DO CASE
		CASE tnNodos_I > pnNivel_I_Ant
			pnNiveles	= BITLSHIFT(pnNiveles, lnDifNiveles)
		CASE tnNodos_I < pnNivel_I_Ant
			pnNiveles	= BITRSHIFT(pnNiveles, ABS(lnDifNiveles))
		ENDCASE
		pnNiveles	= IIF(EMPTY(KHerm_D), BITCLEAR(pnNiveles, 0), BITOR(pnNiveles, 1))

		REPLACE ;
			Orden WITH pnVCOUNT, ;
			Nivel_I WITH tnNodos_I, ;
			PrimerHijo WITH tlPrimerHijo, ;
			Niveles WITH pnNiveles

		pnNivel_I_Ant	= tnNodos_I

		RETURN Expanded
	ENDPROC
ENDDEFINE



DEFINE CLASS BusTV_Listar AS BusTV_RecorridoArbol
	*-- SUBCLASE DE BUSTV_RECORRIDOARBOL
	*-- PARA LISTAR LOS NODOS
	PROCEDURE NextNode
		LPARAMETERS tuNodo, tnNodos_I, tlPrimerHijo
		*-- Evento generado cuando se encuentra un nuevo nodo
		lcText	= ADDBS(TV_Nodos.TEXT)
		lcText	= JUSTSTEM(LEFT(lcText, LEN(lcText) - 1))
		*STRTOFILE(SPACE(8 * tnNodos_I - 1) + lcText + CHR(13) + CHR(10), "DIRS_TV.TXT", .T.)
		? SPACE(8 * tnNodos_I - 1) + TV_Nodos.TEXT
	ENDPROC
ENDDEFINE



DEFINE CLASS BusTV_Borrar AS BusTV_RecorridoArbol
	*-- SUBCLASE DE BUSTV_RECORRIDOARBOL
	*-- PARA BORRAR NODOS Y SUBÁRBOLES
	PROCEDURE NextNode
		LPARAMETERS tuNodo, tnNodos_I, tlPrimerHijo
		*-- Evento generado cuando se encuentra un nuevo nodo
		LOCAL lnIndiceActual, lnRecno
		lnRecno			= RECNO()
		lnIndiceActual	= Indice
		REPLACE ;
			Indice WITH 0, ;
			Orden WITH 0
		pnBorrados	= pnBorrados + 1

		*-- ACTUALIZO EL CONTADOR DE NODOS.
		pnCount		= pnCount - 1
		IF pnCount > 0	&& Todavía quedan nodos en el árbol
			*-- RENUMERO LOS NODOS DE INDICE MAYOR
			REPLACE ALL ;
				Indice WITH Indice - 1 ;
				FOR Indice > lnIndiceActual ;
				NOOPTIMIZE
			GOTO (lnRecno)
		ENDIF
	ENDPROC
ENDDEFINE



DEFINE CLASS BusTV_ContraerTodos AS BusTV_RecorridoArbol
	*-- SUBCLASE DE BUSTV_RECORRIDOARBOL
	*-- PARA CONTRAER TODOS LOS SUBNODOS DE UN NODO DADO
	PROCEDURE NextNode
		LPARAMETERS tuNodo, tnNodos_I, tlPrimerHijo
		*-- Evento generado cuando se encuentra un nuevo nodo
		IF NOT EMPTY(KHijo_I)
			REPLACE Expanded WITH .F.
		ENDIF
	ENDPROC
ENDDEFINE



DEFINE CLASS BusTV_ExpandirTodos AS BusTV_RecorridoArbol
	*-- SUBCLASE DE BUSTV_RECORRIDOARBOL
	*-- PARA EXPANDIR TODOS LOS SUBNODOS DE UN NODO DADO
	PROCEDURE NextNode
		LPARAMETERS tuNodo, tnNodos_I, tlPrimerHijo
		*-- Evento generado cuando se encuentra un nuevo nodo
		IF NOT EMPTY(KHijo_I)
			REPLACE Expanded WITH .T.
		ENDIF
	ENDPROC
ENDDEFINE




DEFINE CLASS BusTV_Nodo AS RELATION
	***********************************************************************************************
	*	CLASE DE NEGOCIO DEL NODO (NODO NO-VISUAL QUE SE DEVUELVE AL USUARIO)
	***********************************************************************************************
	*-- NODO A DEVOLVER CUANDO SE CONSULTA SELECTEDITEM O POR CLAVE O INDICE, O CON EL METODO ITEM().
	HIDDEN APPLICATION
	HIDDEN BASECLASS
	HIDDEN CHILDALIAS
	HIDDEN CHILDORDER
	HIDDEN CLASS
	HIDDEN CLASSLIBRARY
	HIDDEN COMMENT
	HIDDEN NAME
	HIDDEN ONETOMANY
	*HIDDEN PARENT
	HIDDEN PARENTALIAS
	HIDDEN PARENTCLASS
	HIDDEN RELATIONALEXPR
	*HIDDEN TAG

	PROTECTED oTV, KNodo

	oTV				= NULL	&& USO INTERNO
	KNodo			= ""	&& USO INTERNO

	BackColor		= 16777215		&& Blanco
	ForeColor		= 0				&& Negro
	ForeColor2		= 0				&& Negro
	Bold			= "Dinámico"
	Bold2			= "Dinámico"
	Checked			= "Dinámico"
	CHILD			= "Dinámico"
	Children		= "Dinámico"
	Expanded		= "Dinámico"
	ExpandedImage	= "Dinámico"
	ExpandedImage2	= "Dinámico"
	FirstSibling	= "Dinámico"
	FULLPATH		= "Dinámico"
	IMAGE			= "Dinámico"
	IMAGE2			= "Dinámico"
	INDEX			= "Dinámico"
	KEY				= "Dinámico"
	LastSibling		= "Dinámico"
	NEXT			= "Dinámico"
	*Parent			= NULL					&& Ya corresponde a la clase de base
	Previous		= "Dinámico"
	Root			= "Dinámico"
	SELECTED		= "Dinámico"
	SelectedImage	= "Dinámico"
	SelectedImage2	= "Dinámico"
	SORTED			= "Dinámico"
	*Tag				= ""				&& Ya corresponde a la clase de base
	TEXT			= "Dinámico"
	TEXT2			= "Dinámico"

	PROCEDURE INIT
		LPARAMETERS toTV, tcKNodo
		WITH THIS
			.oTV			= toTV		&& USO INTERNO
			.KNodo			= tcKNodo	&& USO INTERNO
		ENDWITH && THIS
	ENDPROC

	PROCEDURE DESTROY
		*_SCREEN.PRINT(PROGRAM() + CHR(13))
	ENDPROC

	FUNCTION Get_KNodo
		RETURN THIS.KNodo
	ENDFUNC
	FUNCTION Get_KPadre
		RETURN THIS.oTV.oBusNodes.Get_KPadre(THIS.KNodo)
	ENDFUNC
	FUNCTION Get_KHijo_I
		RETURN THIS.oTV.oBusNodes.Get_KHijo_I(THIS.KNodo)
	ENDFUNC
	FUNCTION Get_KHerm_D
		RETURN THIS.oTV.oBusNodes.Get_KHerm_D(THIS.KNodo)
	ENDFUNC
	FUNCTION Get_Nivel_I
		RETURN THIS.oTV.oBusNodes.Get_Nivel_I(THIS.KNodo)
	ENDFUNC
	FUNCTION Get_Niveles
		RETURN THIS.oTV.oBusNodes.Get_Niveles(THIS.KNodo)
	ENDFUNC
	FUNCTION Get_PrimerHijo
		RETURN THIS.oTV.oBusNodes.Get_PrimerHijo(THIS.KNodo)
	ENDFUNC
	FUNCTION Get_Orden
		RETURN THIS.oTV.oBusNodes.Get_Orden(THIS.KNodo)
	ENDFUNC

	*-- INDICADOR DE COLOR DE FONDO DEL NODO
	FUNCTION BackColor_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_BackColor(THIS.KNodo)
	ENDFUNC
	FUNCTION BackColor_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_BackColor(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE COLOR DE FIGURA DEL NODO
	FUNCTION ForeColor_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_ForeColor(THIS.KNodo)
	ENDFUNC
	FUNCTION ForeColor_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_ForeColor(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE COLOR DE FIGURA DEL NODO-2
	FUNCTION ForeColor2_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_ForeColor2(THIS.KNodo)
	ENDFUNC
	FUNCTION ForeColor2_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_ForeColor2(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE NODO EN NEGRITA
	FUNCTION Bold_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Bold(THIS.KNodo)
	ENDFUNC
	FUNCTION Bold_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Bold(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE NODO EN NEGRITA-2
	FUNCTION Bold2_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Bold2(THIS.KNodo)
	ENDFUNC
	FUNCTION Bold2_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Bold2(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE NODO CON CHECKBOX MARCADO/DESMARCADO
	FUNCTION Checked_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Checked(THIS.KNodo)
	ENDFUNC
	FUNCTION Checked_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Checked(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE NODO EXPANDIDO
	FUNCTION Expanded_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Expanded(THIS.KNodo)
	ENDFUNC
	FUNCTION Expanded_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Expanded(THIS.KNodo, teValue)
		*-- Genero evento Expand() o Collapse() para el usuario
		IIF(teValue, THIS.oTV.Expand(THIS), THIS.oTV.Collapse(THIS))
	ENDFUNC

	*-- IMAGEN DEL NODO EXPANDIDO
	FUNCTION ExpandedImage_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_ExpandedImage(THIS.KNodo)
	ENDFUNC
	FUNCTION ExpandedImage_ASSIGN(teValue)
		teValue	= IIF(EMPTY(teValue), 0, IIF(VARTYPE(teValue) = "N", teValue, THIS.oTV.ImageList.ListImages(teValue)))
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_ExpandedImage(THIS.KNodo, teValue)
	ENDFUNC

	*-- IMAGEN DEL NODO EXPANDIDO-2
	FUNCTION ExpandedImage2_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_ExpandedImage2(THIS.KNodo)
	ENDFUNC
	FUNCTION ExpandedImage2_ASSIGN(teValue)
		teValue	= IIF(EMPTY(teValue), 0, IIF(VARTYPE(teValue) = "N", teValue, THIS.oTV.ImageList.ListImages(teValue)))
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_ExpandedImage2(THIS.KNodo, teValue)
	ENDFUNC

	*-- RUTA COMPLETA DEL NODO (FULPATH)
	FUNCTION Fullpath_ACCESS
		LOCAL lcFullPath, loNodo
		WITH THIS
			loNodo		= THIS
			lcFullPath	= ""
			DO WHILE NOT ISNULL(loNodo)
				lcFullPath	= loNodo.Text + IIF(EMPTY(lcFullPath), "", .oTV.PathSeparator) + lcFullPath
				loNodo	= loNodo.PARENT
			ENDDO
		ENDWITH
		RETURN lcFullPath
	ENDFUNC

	*-- IMAGEN DEL NODO
	FUNCTION Image_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Image(THIS.KNodo)
	ENDFUNC
	FUNCTION Image_ASSIGN(teValue)
		teValue	= IIF(EMPTY(teValue), 0, IIF(VARTYPE(teValue) = "N", teValue, THIS.oTV.ImageList.ListImages(teValue)))
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Image(THIS.KNodo, teValue)
	ENDFUNC

	*-- IMAGEN DEL NODO-2
	FUNCTION Image2_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Image2(THIS.KNodo)
	ENDFUNC
	FUNCTION Image2_ASSIGN(teValue)
		teValue	= IIF(EMPTY(teValue), 0, IIF(VARTYPE(teValue) = "N", teValue, THIS.oTV.ImageList.ListImages(teValue)))
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Image2(THIS.KNodo, teValue)
	ENDFUNC

	*-- INDICADOR DE SELECCION DEL NODO
	FUNCTION Selected_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Selected(THIS.KNodo)
	ENDFUNC
	FUNCTION Selected_ASSIGN(teValue)
		THIS.oTV.oBusNodes.Set_Selected(THIS.KNodo, teValue)
		THIS.oTV.Actualizar_Diferido()
	ENDFUNC

	*-- IMAGEN DEL NODO SELECCIONADO
	FUNCTION SelectedImage_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_SelectedImage(THIS.KNodo)
	ENDFUNC
	FUNCTION SelectedImage_ASSIGN(teValue)
		teValue	= IIF(EMPTY(teValue), 0, IIF(VARTYPE(teValue) = "N", teValue, THIS.oTV.ImageList.ListImages(teValue)))
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_SelectedImage(THIS.KNodo, teValue)
	ENDFUNC

	*-- IMAGEN DEL NODO SELECCIONADO-2
	FUNCTION SelectedImage2_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_SelectedImage(THIS.KNodo)
	ENDFUNC
	FUNCTION SelectedImage2_ASSIGN(teValue)
		teValue	= IIF(EMPTY(teValue), 0, IIF(VARTYPE(teValue) = "N", teValue, THIS.oTV.ImageList.ListImages(teValue)))
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_SelectedImage2(THIS.KNodo, teValue)
	ENDFUNC

	*-- NODO ORDENADO ALFABÉTICAMENTE
	FUNCTION Sorted_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Sorted(THIS.KNodo)
	ENDFUNC
	FUNCTION Sorted_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Sorted(THIS.KNodo, teValue)
	ENDFUNC

	*-- TAG DEL NODO
	FUNCTION Tag_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Tag(THIS.KNodo)
	ENDFUNC
	FUNCTION Tag_ASSIGN(teValue)
		*-- No uso Actualizar_Diferido() porque no afecta a la visualización.
		THIS.oTV.oBusNodes.Set_Tag(THIS.KNodo, teValue)
	ENDFUNC

	*-- TEXTO DEL NODO
	FUNCTION Text_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Text(THIS.KNodo)
	ENDFUNC
	FUNCTION Text_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Text(THIS.KNodo, teValue)
	ENDFUNC

	*-- TEXTO DEL NODO-2
	FUNCTION Text2_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Text2(THIS.KNodo)
	ENDFUNC
	FUNCTION Text2_ASSIGN(teValue)
		THIS.oTV.Actualizar_Diferido()
		THIS.oTV.oBusNodes.Set_Text2(THIS.KNodo, teValue)
	ENDFUNC



	*-- HIJO (CHILD)
	PROCEDURE Child_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_Child(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC

	*-- CANTIDAD DE HIJOS (CHILDREN)
	PROCEDURE Children_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Children(THIS.KNodo)
	ENDPROC

	*-- PRIMER HERMANO IZQUIERDO (FIRSTSIBLING)
	PROCEDURE FirstSibling_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_FirstSibling(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC

	*-- INDICE (INDEX)
	PROCEDURE Index_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Index(THIS.KNodo)
	ENDPROC

	*-- CLAVE (KEY)
	PROCEDURE Key_ACCESS
		RETURN THIS.oTV.oBusNodes.Get_Key(THIS.KNodo)
	ENDPROC

	*-- ÚLTIMO HERMANO DERECHO
	PROCEDURE LastSibling_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_LastSibling(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC

	*-- SIGUIENTE HERMANO
	PROCEDURE Next_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_Next(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC

	*-- PADRE
	PROCEDURE Parent_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_Parent(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC

	*-- HERMANO ANTERIOR
	PROCEDURE Previous_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_Previous(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC

	*-- NODO RAIZ
	PROCEDURE Root_ACCESS
		LOCAL lcKNodo, loNodo
		lcKNodo	= THIS.oTV.oBusNodes.Get_Root(THIS.KNodo)
		IF EMPTY(lcKNodo)
			RETURN NULL
		ELSE
			loNodo	= CREATEOBJECT("BusTV_Nodo", THIS.oTV, @lcKNodo)
			RETURN loNodo
		ENDIF
	ENDPROC


	*-- ASEGURAR VISIBILIDAD DEL NODO
	PROCEDURE EnsureVisible
		WITH THIS
			.oTV.oBusNodes.EnsureVisible(.KNodo)
			.oTV.tmrTareas.DoCmd("VisualizarNodo('" + TRANSFORM(.KNodo) + "')", .oTV.cmdFoco, 150, 1)
		ENDWITH && THIS
	ENDPROC
ENDDEFINE



DEFINE CLASS _OBJVACIO AS RELATION && USO RELATION PORQUE ES LA MÁS LIGERA EN VFP 6.
	*HIDDEN PROCEDURE ADDPROPERTY
	*ENDPROC
	HIDDEN PROCEDURE DESTROY
	ENDPROC
	HIDDEN PROCEDURE ERROR
	ENDPROC
	HIDDEN PROCEDURE INIT
	ENDPROC
	HIDDEN PROCEDURE READEXPRESSION
	ENDPROC
	HIDDEN PROCEDURE READMETHOD
	ENDPROC
	*HIDDEN PROCEDURE RESETTODEFAULT
	*ENDPROC
	HIDDEN PROCEDURE WRITEEXPRESSION
	ENDPROC

	HIDDEN APPLICATION
	HIDDEN BASECLASS
	HIDDEN CHILDALIAS
	HIDDEN CHILDORDER
	HIDDEN CLASS
	HIDDEN CLASSLIBRARY
	HIDDEN COMMENT
	HIDDEN NAME
	HIDDEN ONETOMANY
	HIDDEN PARENT
	HIDDEN PARENTALIAS
	HIDDEN PARENTCLASS
	HIDDEN RELATIONALEXPR
	HIDDEN TAG
ENDDEF



DEFINE CLASS o_Tabs AS _COLLECTION
	Add_FDU = ""
	Remove_FDU = ""
	Clear_FDU = ""
	lControlesExistentesAgregados = .F.

	PROCEDURE ADD
		LPARAMETERS tnIndice, tcClave, tcTitulo, tcImagen

		WITH THIS.PARENT.cntTabs
			LOCAL lnTab, lnInsertarAntesDe

			lnInsertarAntesDe = 0

			IF ISNULL(tnIndice)
				*-- Con NULL indico que se deben agregar los Tabs
				*-- ya existentes a la colección.

				IF THIS.lControlesExistentesAgregados
					RETURN
				ELSE
					*-- Ordeno y guardo las posiciones TOP y LEFT de todos los tabs
					WITH THIS.PARENT
						LOCAL lnTabCount, lnTab, loTab
						lnTabCount = .cntTabs.CONTROLCOUNT
						IF lnTabCount = 0
							RETURN
						ENDIF
						LOCAL ARRAY laTabs(lnTabCount)
						DECLARE .aTabs(lnTabCount, 3)

						*-- Guardo los valores INDEX de cada Tab
						FOR lnTab = 1 TO lnTabCount
							loTab = .cntTabs.CONTROLS(lnTab)
							.aTabs(lnTab, 1)	= lnTab
							.aTabs(lnTab, 2)	= loTab.INDEX &&loTab.LEFT
							.aTabs(lnTab, 3)	= loTab
						ENDFOR

						*-- Ordeno los valores INDEX de cada Tab
						=ASORT(.aTabs, 2)

						*-- Agrego los Tabs existentes a la colección
						FOR lnTab = 1 TO lnTabCount
							loTab = .aTabs(lnTab, 3)
							_COLLECTION::ADD(loTab, loTab.KEY)
						ENDFOR
					ENDWITH

					THIS.lControlesExistentesAgregados = .T.
				ENDIF && lControlesExistentesAgregados

			ELSE
				DO CASE
				CASE EMPTY(tnIndice)
					tnIndice = .CONTROLCOUNT + 1
				CASE tnIndice > .CONTROLCOUNT + 1
					tnIndice = .CONTROLCOUNT + 1
				CASE tnIndice < 1
					tnIndice = 1
				CASE tnIndice < .CONTROLCOUNT + 1
					*-- Insertar
					lnInsertarAntesDe = tnIndice
				ENDCASE

				.ADDOBJECT(SYS(2015), "cnt_Tab", .T.)

				WITH .CONTROLS(.CONTROLCOUNT)
					._Caption		= tcTitulo
					.IMAGE			= IIF(EMPTY(tcImagen), "", tcImagen)
					.INDEX			= tnIndice
					.KEY			= tcClave
					.TABINDEX		= tnIndice
					.TabSkin		= THIS.PARENT.TabSkin
					.FONTNAME		= THIS.PARENT.FONTNAME
					.FONTSIZE		= THIS.PARENT.FONTSIZE
					.FONTBOLD		= THIS.PARENT.FONTBOLD
					.FONTITALIC		= THIS.PARENT.FONTITALIC
					.FONTUNDERLINE	= THIS.PARENT.FONTUNDERLINE
					.FONTSTRIKETHRU	= THIS.PARENT.FONTSTRIKETHRU
					.FORECOLOR		= THIS.PARENT.FORECOLOR
					.FOCUSFORECOLOR	= THIS.PARENT.FORECOLOR
					.ORIENTATION	= THIS.PARENT.Placement
					.CLICK_FDU		= "THIS.PARENT.PARENT._TabClick(THIS)" &&IIF(EMPTY(THIS.PARENT.TabClick_FDU), "THIS.PARENT.PARENT._TabClick(THIS)", THIS.PARENT.TabClick_FDU)
					*.BEFORECLICK_FDU= IIF(EMPTY(THIS.BeforeTabClick_FDU), "THIS.PARENT.PARENT.BeforeTabClick()", THIS.BeforeTabClick_FDU)
					._Inicializar()
				ENDWITH

				*-- Agrego el Tab a la colección luego de haberlo creado
				IF EMPTY(lnInsertarAntesDe)
					_COLLECTION::ADD(.CONTROLS(.CONTROLCOUNT), tcClave)
				ELSE
					_COLLECTION::ADD(.CONTROLS(.CONTROLCOUNT), tcClave, lnInsertarAntesDe)
				ENDIF

				*-- Regenero los INDEX de cada Tab
				FOR lnTab = 1 TO THIS.COUNT
					loTab = THIS.ITEM(lnTab)
					loTab.INDEX	= lnTab
					loTab.TABINDEX	= lnTab
				ENDFOR

				*-- Reposiciono todas las pestañas
				IF THIS.PARENT.lInicializado
					THIS.PARENT.AcomodarTabs()
				ENDIF

			ENDIF

			*-- Ejecuto función de Usuario
			IIF(NOT EMPTY(THIS.ADD_FDU), EVALUATE(THIS.ADD_FDU), .T.)

		ENDWITH && THIS.PARENT.cntTabs
	ENDPROC



	PROCEDURE CLEAR
		*-- Primero quito los Tabs de la colección
		_COLLECTION::CLEAR()

		WITH THIS.PARENT.cntTabs
			LOCAL lnTab

			FOR lnTab = .CONTROLCOUNT TO 1 STEP -1
				.CONTROLS(lnTab).VISIBLE = .F.
				.REMOVEOBJECT(.CONTROLS(lnTab).NAME)
			ENDFOR
		ENDWITH && THIS

		*-- Ejecuto función de Usuario
		IIF(NOT EMPTY(THIS.CLEAR_FDU), EVALUATE(THIS.CLEAR_FDU), .T.)

	ENDPROC



	PROCEDURE REMOVE
		LPARAMETERS teIndice

		*-- Primero quito el Tab de la colección
		_COLLECTION::REMOVE(teIndice)

		WITH THIS.PARENT.cntTabs
			LOCAL lcClave, llRemover, loControl, lnTab

			DO CASE
			CASE VARTYPE(teIndice) = "N"
				*-- Indicó un índice
				FOR lnTab = 1 TO .CONTROLCOUNT
					IF .CONTROLS(lnTab).INDEX == teIndice
						llRemover = .T.
						.REMOVEOBJECT(.CONTROLS(lnTab).NAME)
						EXIT
					ENDIF
				ENDFOR

			CASE VARTYPE(teIndice) = "C"
				*-- Indicó una clave (key)
				FOR lnTab = 1 TO .CONTROLCOUNT
					IF .CONTROLS(lnTab).KEY == teIndice
						llRemover = .T.
						.REMOVEOBJECT(.CONTROLS(lnTab).NAME)
						EXIT
					ENDIF
				ENDFOR

			ENDCASE

			IF llRemover
				*-- Regenero los INDEX de cada Tab
				FOR lnTab = 1 TO THIS.COUNT
					loTab = THIS.ITEM(lnTab)
					loTab.INDEX	= lnTab
				ENDFOR

				*-- Reposiciono todas las pestañas
				IF THIS.PARENT.lInicializado
					THIS.PARENT.AcomodarTabs()
				ENDIF

				*-- Ejecuto función de Usuario
				IIF(NOT EMPTY(THIS.REMOVE_FDU), EVALUATE(THIS.REMOVE_FDU), .T.)

			ENDIF
		ENDWITH && THIS.PARENT.cntTabs
	ENDPROC

ENDDEFINE



