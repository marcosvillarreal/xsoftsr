*-- Autor:	Fernando D. Bozzo
*-- Fecha:	16/05/2003 01:26
*-- Versión: 1.0
*-- Email:	fdbozzo@lycos.es
*-- Código abierto


FUNCTION Distribuir3Imagenes
	LPARAMETERS toImagen1, toImagen2, toImagen3, tiLeft, tiTop, tiWidth, tiHeight, tcOrientacion, tiLimiteMaxRecorte
	
	*-- PARÁMETROS:
	*-- toImagen1				Referencia del control para la imágen Sup-Izq / Inf-Izq / Izq-Sup / Der-Sup
	*-- toImagen2				Referencia del control para la imágen Sup-Centro / Inf-Centro / Izq-Centro / Der-Centro
	*-- toImagen3				Referencia del control para la imágen Sup-Der / Inf-Der / Izq-Inf / Der-Inf
	*-- tiLeft					Posición izquierda del área de ubicación
	*-- tiTop					Posición superior del área de ubicación
	*-- tiWidth					Ancho del área de ubicación
	*-- tiHeight				Altura del área de ubicación
	*-- tcOrientacion			Orientación de las imágenes. Valores: (H)orizontal, (V)ertical
	*-- [tiLimiteMaxRecorte]	(Opc) Indica hasta cuántos píxels de altura puede tener la imágen.
	*--							Si el límite es 0 (o no se indica) o es superado, se estira la imágen.
	IF EMPTY(tiLimiteMaxRecorte)
		*tiLimiteMaxRecorte = 1/0 && Nunca se llegará a este límite.
		tiLimiteMaxRecorte = 0
	ENDIF

	toImagen1.STRETCH = 0 && Recortar
	toImagen2.STRETCH = 0 && Recortar
	toImagen3.STRETCH = 0 && Recortar

	IF UPPER(tcOrientacion) = "V"
		*-- ORIENTACIÓN VERTICAL

		*-- Imágen 1 (Superior / Izquierda)
		DO CASE
		CASE EMPTY(toImagen1.PICTURE)
			*-- No hay imágen
			toImagen1.MOVE(0,0,0,0)
		CASE toImagen1.WIDTH > tiLimiteMaxRecorte
			*-- Supera el límite de Recorte: SE ESTIRA EN SENTIDO HORIZONTAL Y SE RESPETA LA ALTURA
			toImagen1.STRETCH = 2 && Estirar
			toImagen1.MOVE(tiLeft, tiTop, tiWidth)
		OTHERWISE
			*-- Está dentro del área de recorte
			toImagen1.MOVE(tiLeft, tiTop)
		ENDCASE

		*-- Imágen 2 (CENTRAL)
		toImagen2.STRETCH = 2 && Estirar
		DO CASE
		CASE EMPTY(toImagen2.PICTURE)
			*-- No hay imágen
			toImagen2.MOVE(0,0,0,0)
		CASE toImagen2.WIDTH > tiLimiteMaxRecorte
			*-- Supera el límite de Recorte: SE ESTIRA EN SENTIDO HORIZONTAL Y VERTICAL
			toImagen2.MOVE(tiLeft, toImagen1.TOP + toImagen1.HEIGHT, tiWidth, tiHeight - toImagen1.HEIGHT - toImagen3.HEIGHT)
		OTHERWISE
			*-- Está dentro del área de recorte: SE ESTIRA EN SENTIDO VERTICAL Y SE RESPETA EL ANCHO
			toImagen2.MOVE(tiLeft, toImagen1.TOP + toImagen1.HEIGHT, toImagen2.WIDTH, tiHeight - toImagen1.HEIGHT - toImagen3.HEIGHT)
		ENDCASE

		*-- Imágen 3 (Inferior / Derecha)
		DO CASE
		CASE EMPTY(toImagen3.PICTURE)
			*-- No hay imágen
			toImagen3.MOVE(0,0,0,0)
		CASE toImagen3.WIDTH > tiLimiteMaxRecorte
			*-- Supera el límite de Recorte: SE ESTIRA EN SENTIDO HORIZONTAL Y SE RESPETA LA ALTURA
			toImagen3.STRETCH = 2 && Estirar
			toImagen3.MOVE(tiLeft, tiHeight - toImagen3.HEIGHT, tiWidth)
		OTHERWISE
			*-- Está dentro del área de recorte
			toImagen3.MOVE(tiLeft, tiHeight - toImagen3.HEIGHT)
		ENDCASE

	ELSE
		*-- ORIENTACIÓN HORIZONTAL

		*-- Imágen 1 (Superior / Izquierda)
		DO CASE
		CASE EMPTY(toImagen1.PICTURE)
			*-- No hay imágen
			toImagen1.MOVE(0,0,0,0)
		CASE toImagen1.HEIGHT > tiLimiteMaxRecorte
			*-- Supera el límite de Recorte: SE ESTIRA EN SENTIDO VERTICAL Y SE RESPETA EL ANCHO
			toImagen1.STRETCH = 2 && Estirar
			toImagen1.MOVE(tiLeft, tiTop, toImagen1.Width, tiHeight)
		OTHERWISE
			*-- Está dentro del área de recorte
			toImagen1.MOVE(tiLeft, tiTop)
		ENDCASE

		*-- Imágen 2 (CENTRAL)
		toImagen2.STRETCH = 2 && Estirar
		DO CASE
		CASE EMPTY(toImagen2.PICTURE)
			*-- No hay imágen
			toImagen2.MOVE(0,0,0,0)
		CASE toImagen2.HEIGHT > tiLimiteMaxRecorte
			*-- Supera el límite de Recorte: SE ESTIRA EN SENTIDO HORIZONTAL Y VERTICAL
			toImagen2.MOVE(toImagen1.LEFT + toImagen1.WIDTH, tiTop, tiWidth - toImagen1.WIDTH - toImagen3.WIDTH, tiHeight)
		OTHERWISE
			*-- Está dentro del área de recorte: SE ESTIRA EN SENTIDO HORIZONTAL Y SE RESPETA LA ALTURA
			toImagen2.MOVE(toImagen1.LEFT + toImagen1.WIDTH, tiTop, tiWidth - toImagen1.WIDTH - toImagen3.WIDTH)
		ENDCASE

		*-- Imágen 3 (Inferior / Derecha)
		DO CASE
		CASE EMPTY(toImagen3.PICTURE)
			*-- No hay imágen
			toImagen3.MOVE(0,0,0,0)
		CASE toImagen3.HEIGHT > tiLimiteMaxRecorte
			*-- Supera el límite de Recorte: SE ESTIRA EN SENTIDO VERTICAL Y SE RESPETA EL ANCHO
			toImagen3.STRETCH = 2 && Estirar
			*toImagen3.MOVE(toImagen1.LEFT + toImagen1.WIDTH + toImagen2.WIDTH, tiTop, toImagen3.WIDTH, tiHeight)
			toImagen3.MOVE(tiWidth - toImagen3.WIDTH, tiTop, toImagen3.WIDTH, tiHeight)
		OTHERWISE
			*-- Está dentro del área de recorte
			*toImagen3.MOVE(toImagen1.LEFT + toImagen1.WIDTH + toImagen2.WIDTH, tiTop)
			toImagen3.MOVE(tiWidth - toImagen3.WIDTH, tiTop)
		ENDCASE

	ENDIF
ENDFUNC



FUNCTION ProporcionTamaño
	LPARAMETERS tnOffset, tnRelacionDestino, tnAltoOrigen, tnAnchoOrigen, tnAltoDestino, tnAnchoDestino
	LOCAL loOrigen

	*-- TIPOS DE PARÁMETROS:
	*-- Se pueden pasar de 2 formas:
	*--		* Valores idependientes: Se harán los cálculos y se devolverán los resultados en los parámetros 3 y 4.
	*--			- Se deben pasar todos los parámetros.

	*--		* Referencias de controles: Se harán los cálculos y se ajustará directamente el control Origen.
	*--			- Se pueden pasar 3 ó 4 parámetros. Si se pasan los parámetros hasta el 3ro., el cuarto será el PARENT

	*-- PARÁMETROS PARA VALORES INDEPENDIENTES:
	*-- [tnOffset]			Es un valor opcional que se sumará al tamaño final del control
	*-- tnRelacionDestino	Es la relación de tamaño a calcular para el Origen respecto del Destino
	*-- @tnAltoOrigen		Es el alto original del control a ajustar (Pasar por referencia)
	*-- @tnAnchoOrigen		Es el ancho original del control a ajustar (Pasar por referencia)
	*-- tnAltoDestino		Es el alto del control a tomar como base
	*-- tnAnchoDestino		Es el ancho del control a tomar como base

	*-- PARÁMETROS PARA REFERENCIAS DE CONTROLES:
	*-- [tnOffset]			Es un valor opcional que se sumará al tamaño final del control
	*-- tnRelacionDestino	Es la relación de tamaño a calcular para el Origen respecto del Destino
	*-- tnAltoOrigen		Es el control a ajustar sus dimensiones
	*-- [tnAnchoOrigen]		Es el control a usar como base (si no se indica es el contenedor del otro)

	*-- NOTA:
	*-- Esto sirve para calcular el tamaño proporcional de un control que vá dentro de otro
	*-- y del que se pretende que conserve la proporcionalidad de tamaño.

	*-- NOTA 2:
	*-- Si se va a calcular más de una vez la proporcionalidad de tamaño, para respetar las
	*-- dimensiones originales del control guardarlas en propiedades cuando se inicialice (INIT).

	*-- NOTA 3:
	*-- No hay ningún tipo de validación, porque asumo que se sabe lo que se hace.

	IF VARTYPE(tnAltoOrigen) = "O"
		*-- Guardo dimensiones originales (sólo una vez)
		IF NOT PEMSTATUS(tnAltoOrigen, "_Height_Orig", 5) OR EMPTY(tnAltoOrigen._Height_Orig)
			tnAltoOrigen.ADDPROPERTY("_Height_Orig", tnAltoOrigen.HEIGHT)
		ENDIF
		IF NOT PEMSTATUS(tnAltoOrigen, "_Width_Orig", 5) OR EMPTY(tnAltoOrigen._Width_Orig)
			tnAltoOrigen.ADDPROPERTY("_Width_Orig", tnAltoOrigen.WIDTH)
		ENDIF
		IF VARTYPE(tnAnchoOrigen) # "O"
			tnAnchoOrigen = tnAltoOrigen.PARENT
		ENDIF
		loOrigen = tnAltoOrigen
		*-- Redefino las variables, ya que ahora tnAltoOrigen es el control Origen
		*-- y tnAnchoOrigen el control Destino.
		tnAltoDestino	= tnAnchoOrigen.HEIGHT + tnOffset
		tnAnchoDestino	= tnAnchoOrigen.WIDTH + tnOffset
		tnAnchoOrigen	= loOrigen._Width_Orig
		tnAltoOrigen	= loOrigen._Height_Orig
	ENDIF

	*-- Imagen menor o igual al control
	IF tnAltoDestino / tnAltoOrigen >= tnAnchoDestino / tnAnchoOrigen
		*-- La relación de altura es mayor o igual a la relación de ancho
		lnAnchoFinal = ROUND(tnAnchoDestino * tnRelacionDestino, 0)
		lnAlturaFinal = ROUND(lnAnchoFinal * tnAltoOrigen / tnAnchoOrigen, 0)
	ELSE
		*-- La relación de altura es menor a la relación de ancho
		lnAlturaFinal = ROUND(tnAltoDestino * tnRelacionDestino, 0)
		lnAnchoFinal = ROUND(lnAlturaFinal * tnAnchoOrigen / tnAltoOrigen, 0)
	ENDIF

	IF VARTYPE(loOrigen) = "O"
		loOrigen.HEIGHT = ABS(lnAlturaFinal)
		loOrigen.WIDTH = ABS(lnAnchoFinal)
	ELSE
		tnAltoOrigen = ABS(lnAlturaFinal)
		tnAltoOrigen = ABS(lnAnchoFinal)
	ENDIF

	RETURN
ENDFUNC



FUNCTION CalcularPosicionMouse
	*-- ESTA FUNCIÓN MODIFICA LAS COORDENADAS DADAS CON MROW/MCOL O nXCoord/nYCoord
	*-- PARA PODER COMPARAR CON LAS COORDENADAS FÍSICAS (LEFT/TOP) DE LOS OBJETOS
	*-- DEL FORM.
	*-- SE USA PARA SABER LA COORDENADA X,Y CALCULADA DE UNA COORDENADA X,Y DADA
	*-- QUE SE CORRESPONDE A LA DE LOS OBJETOS DENTRO DEL FORM.
	LPARAMETERS toForm, tnXCoord, tnYCoord

	WITH toForm
		LOCAL lnXCalc, lnYCalc
		lnXCalc = 0
		lnYCalc = 0
		
		IF .Titlebar = 1
			IF .HalfHeightCaption
				lnYCalc = lnYCalc + SYSMETRIC(34) && Alto título ventana ed medio título
			ELSE
				lnYCalc = lnYCalc + SYSMETRIC(9) && Alto título ventana
			ENDIF
			*-- Tiene barra de título
			IF .BorderStyle = 3 && Borde tamaño ajustable
				lnXCalc = lnXCalc + SYSMETRIC(3) && Ancho marco ventana ajustable
				lnYCalc = lnYCalc + SYSMETRIC(4) && Alto marco ventana ajustable
			ELSE
				lnXCalc = lnXCalc + SYSMETRIC(13) && Ancho marco ventana Doble o Panel
				lnYCalc = lnYCalc + SYSMETRIC(12) && Alto marco ventana Doble o Panel
			ENDIF
		ELSE
			*-- No tiene barra de título
			DO CASE
			CASE .BorderStyle = 0 && Sin borde
			CASE .BorderStyle = 1 && Borde 1 línea
				lnXCalc = lnXCalc + SYSMETRIC(10) && Ancho marco ventana no-ajustable
				lnYCalc = lnYCalc + SYSMETRIC(11) && Alto marco ventana no-ajustable 
			CASE .BorderStyle = 2 && Borde línea doble
				lnXCalc = lnXCalc + SYSMETRIC(13) && Ancho marco ventana Doble o Panel
				lnYCalc = lnYCalc + SYSMETRIC(12) && Alto marco ventana Doble o Panel
			CASE .BorderStyle = 3 && Borde tamaño ajustable
				lnXCalc = lnXCalc + SYSMETRIC(3) && Ancho marco ventana ajustable
				lnYCalc = lnYCalc + SYSMETRIC(4) && Alto marco ventana ajustable
			ENDCASE
		ENDIF
		
		*-- Agrego el desplazamiento dentro del form
		*lnXCalc	= lnXCalc - .ViewPortLeft
		*lnYCalc	= lnYCalc - .ViewPortTop
		
		*-- Agrego el desplazamiento del form
		lnXCalc	= lnXCalc + .Left
		lnYCalc	= lnYCalc + .Top

		IF .ShowWindow = 0
			lnXCalc	= lnXCalc + _SCREEN.Left
			lnYCalc	= lnYCalc + _SCREEN.Top
			
			IF _SCREEN.WindowState > 1 AND _SCREEN.Visible
				lnXCalc	= lnXCalc + MAX(0, _VFP.Left)
				lnYCalc	= lnYCalc + MAX(0, _VFP.Top)
			ENDIF
		ENDIF
		
		tnXCoord = tnXCoord + lnXCalc
		tnYCoord = tnYCoord + lnYCalc
	ENDWITH && toForm
ENDFUNC

