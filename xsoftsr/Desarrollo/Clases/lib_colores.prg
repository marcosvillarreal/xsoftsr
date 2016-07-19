#DEFINE  HLSMAX   240 &&/* H,L, and S vary over 0-HLSMAX */
#DEFINE  RGBMAX   255   &&/* R,G, and B vary over 0-RGBMAX */
*/* HLSMAX BEST IF DIVISIBLE BY 6 */
*/* RGBMAX, HLSMAX must each fit in a byte. */

*/* Hue is INDEFINIDO if Saturation is 0 (grey-scale) */
*/* This value determines where the Hue scrollbar is */
*/* initially set for achromatic colors */
#DEFINE INDEFINIDO INT(HLSMAX*2/3)


FUNCTION Get_ColorDegradado
	*-- ESTA RUTINA CALCULA EL DEGRADADO DE UN COLOR DADO UN PORCENTAJE.
	*-- DE ACUERDO AL SIGNO DEL PORCENTAJE SE CALCULA UN COLOR MÁS CLARO U OSCURO.

	*-- Devuelve el color indicado degradado de acuerdo al porcentaje indicado.
	*-- Parámetros: nColorRGB, %nDegradado. Devuevle: nColorRGB
	LPARAMETERS tnRGB, tnPorcentajeDegradacion

	LOCAL lnR, lnG, lnB, lnRGB, lnBase
	RGBCOMP(tnRGB, @lnR, @lnG, @lnB)

	DO CASE
	CASE NOT BETWEEN(tnPorcentajeDegradacion, -100, 100)
		*-- Porcentaje inválido: Sin cambio
		lnRGB	= tnRGB
	CASE SIGN(tnPorcentajeDegradacion) = 1
		*-- Incremento: Tiende a blanco (255)
		lnBase	= 0 + ABS(tnPorcentajeDegradacion) / 100
		lnR2	= MIN(lnR + ROUND((255 - lnR) * lnBase, 0), 255)
		lnG2	= MIN(lnG + ROUND((255 - lnG) * lnBase, 0), 255)
		lnB2	= MIN(lnB + ROUND((255 - lnB) * lnBase, 0), 255)
		lnRGB	= RGB(lnR2, lnG2, lnB2)
	CASE SIGN(tnPorcentajeDegradacion) = -1
		*-- Decremento: Tiende a negro (0)
		lnBase	= 1 - ABS(tnPorcentajeDegradacion) / 100
		lnR2	= MAX(ROUND((lnR) * lnBase, 0), 0)
		lnG2	= MAX(ROUND((lnG) * lnBase, 0), 0)
		lnB2	= MAX(ROUND((lnB) * lnBase, 0), 0)
		lnRGB	= RGB(lnR2, lnG2, lnB2)
	OTHERWISE
		*-- Sin cambio
		lnRGB	= tnRGB
	ENDCASE

	RETURN lnRGB
ENDFUNC


FUNCTION HLStoRGB
	LPARAMETERS hue,lum,sat,R,G,B

	LOCAL R,G,B &&                /* RGB component values */
	LOCAL Magic1,Magic2 &&       /* calculated magic numbers (really!) */
	STORE 0 TO R,G,B,Magic1,Magic2

	IF (sat = 0) &&{            /* achromatic case */
		STORE (lum*RGBMAX)/HLSMAX TO R,G,B

		IF (hue # INDEFINIDO)
			*'This is technically an error.
			*'The RGBtoHLS routine will always return
			*'
			*'Hue = UNDEFINED (in this case 160)
			*'when Sat = 0.
			*'if you are writing a color mixer and
			*'letting the user input color values,
			*'you may want to set Hue = UNDEFINED
			*'in this case.
		ENDIF

	ELSE  &&{                    /* chromatic case */
		* set up magic numbers */
		IF (lum <= (HLSMAX/2))
			*Magic2 = INT(((lum*(HLSMAX + sat) + (HLSMAX/2))/HLSMAX))
			Magic2 = INT(((lum*(HLSMAX + sat) + 0.5)/HLSMAX))
		ELSE
			*Magic2 = INT((lum + sat - ((lum*sat) + (HLSMAX/2))/HLSMAX))
			Magic2 = INT((lum + sat - ((lum*sat) + 0.5)/HLSMAX))
			*Magic1 = (2*lum-Magic2)
		ENDIF
		Magic1 = INT((2*lum-Magic2))

		* Get RGB, change units from HLSMAX to RGBMAX */
		R = INT((HueToRGB(Magic1,Magic2,hue+(HLSMAX/3))*RGBMAX + (HLSMAX/2))/HLSMAX)
		G = INT((HueToRGB(Magic1,Magic2,hue)*RGBMAX + (HLSMAX/2)) / HLSMAX)
		B = INT((HueToRGB(Magic1,Magic2,hue-(HLSMAX/3))*RGBMAX + (HLSMAX/2))/HLSMAX)
		R = MIN(R, 255)
		G = MIN(G, 255)
		B = MIN(B, 255)
	ENDIF

	RETURN(RGB(R,G,B))
ENDFUNC



FUNCTION  RGBtoHLS
	LPARAMETERS R,G,B,H,L,S
	* R,G,B se pueden indicar de 2 formas:
	* -Indicando cada uno de ellos
	* -Indicando en B el color RGB completo (resultado de la función RGB() )

	*LOCAL R,G,B          &&/* input RGB values */
	LOCAL cMax,cMin      &&/* max and min RGB values */
	LOCAL Rdelta,Gdelta,Bdelta  &&; /* intermediate value: % of spread from max */

	* get R, G, and B out of DWORD */
	IF B > 255
		R = RGB_Red(B)
		G = RGB_Green(B)
		B = RGB_Blue(B)
	ENDIF


	*/* calculate lightness */
	cMax = MAX(R,G,B)
	cMin = MIN(R,G,B)
	L = INT(( ((cMax+cMin)*HLSMAX) + RGBMAX ) / (2*RGBMAX))

	IF (cMax == cMin) &&{           /* r=g=b --> achromatic case */
		S = 0                     &&/* saturation */
		H = INDEFINIDO             &&/* hue */
	ELSE &&{                        /* chromatic case */
		*/* saturation */
		SET STEP ON
		IF (L <= (HLSMAX/2))
			S = INT(( ((cMax-cMin)*HLSMAX) + ((cMax+cMin)/2) ) / (cMax+cMin))
		ELSE
			S = INT(( ((cMax-cMin)*HLSMAX) + ((2*RGBMAX-cMax-cMin)/2) ) / (2*RGBMAX-cMax-cMin))
		ENDIF

		*/* hue */
		*Rdelta = ( ((cMax-R) * (HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin)
		*Gdelta = ( ((cMax-G) * (HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin)
		*Bdelta = ( ((cMax-B) * (HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin)
		Rdelta = ( ((cMax-R) * (HLSMAX/6)) + 0.5 ) / (cMax-cMin)
		Gdelta = ( ((cMax-G) * (HLSMAX/6)) + 0.5 ) / (cMax-cMin)
		Bdelta = ( ((cMax-B) * (HLSMAX/6)) + 0.5 ) / (cMax-cMin)

		DO CASE
		CASE (R == cMax)
			H = Bdelta - Gdelta
		CASE (G == cMax)
			H = (HLSMAX/3) + Rdelta - Bdelta
		OTHERWISE && /* B == cMax */
			H = ((2*HLSMAX)/3) + Gdelta - Rdelta
		ENDCASE

		IF (H < 0)
			H = H + HLSMAX
		ENDIF
		IF (H > HLSMAX)
			H = H - HLSMAX
		ENDIF
		H = ROUND(H,0)
	ENDIF
ENDFUNC



FUNCTION RGB_Red (tiRGBColor)
	RETURN INT(BITAND(tiRGBColor, 0xFF))
ENDFUNC



FUNCTION RGB_Green (tiRGBColor)
	RETURN INT(BITAND(tiRGBColor, 0x100FF00) / 0x100)
ENDFUNC



FUNCTION RGB_Blue (tiRGBColor)
	RETURN INT(BITAND(tiRGBColor, 0xFF0000) / 0x10000)
ENDFUNC



FUNCTION ColorContrastante (tiRGBColor)
	*-- Retorna Blanco o Negro, de acuerdo a lo que se vea mejor
	*-- para el color especificado.
	*-- Útil para setear forecolor de etiquetas (labels) con
	*-- fondo transparente (indicar el backcolor del form, no
	*-- el del sistema!)
	LOCAL H,L,S
	HLS = RGBtoHLS(0,0,tnRGBCol,@H,@L,@S)
	RETURN IIF(L > (HLSMAX / 2), 0 , 0xFFFFFF)
ENDFUNC


FUNCTION EscalaDeGris (tiRGBColor)
	*-- Retorna la versión acromática del color indicado
	LOCAL H,L,S
	=RGBtoHLS(0,0,tnRGBCol,@H,@L,@S)
	S = 0
	H = INDEFINIDO
	RETURN HLStoRGB(H,L,S)
ENDFUNC


FUNCTION Tinte (tiRGBColor, tiMatiz)
	*-- Cambia el Matiz de un color al especificado.
	*-- Por ejemplo, cambiando el matiz de todos los pixels de una imágen
	*-- a 80 pintará la imágen de verde.
	LOCAL H,L,S
	DO CASE
	CASE Matiz < 0
		Matiz = 0
	CASE Matiz > HLSMAX
		Matiz = HLSMAX
	ENDCASE
	=RGBtoHLS(0,0,tnRGBCol,@H,@L,@S)
	RETURN HLStoRGB(H,L,S)
ENDFUNC



FUNCTION Abrillantar (tiRGBColor, tiPorciento)
	*-- Iluminar un color dado un porcentaje entero.
	LOCAL hue,lum,sat
	IF tiPorciento <= 0 Then
		RETURN tiRGBColor
	ENDIF
	=RGBtoHLS(0,0,tiRGBColor,@hue,@lum,@sat)
	lum = lum + (lum * tiPorciento / 100)
	IF lum > HSLMAX Then
		lum = HSLMAX
	ENDIF
	lum = INT(lum)
	RETURN HLStoRGB(hue,lum,sat)
ENDFUNC


FUNCTION Oscurecer (tiRGBColor, tiPorciento)
	*-- Oscurecer un color dado un porcentaje entero.
	LOCAL hue,lum,sat
	IF tiPorciento <= 0 Then
		RETURN tiRGBColor
	ENDIF
	=RGBtoHLS(0,0,tiRGBColor,@hue,@lum,@sat)
	lum = lum - (lum * tiPorciento / 100)
	IF lum < 0 Then
		lum = 0
	ENDIF
	lum = INT(lum)
	RETURN HLStoRGB(hue,lum,sat)
ENDFUNC


FUNCTION IluminacionInversa (tiRGBColor)
	*-- Hace brillantes a los colores oscuros y viceversa,
	*-- sin cambiar el matiz o la saturación.
	LOCAL hue,lum,sat
	=RGBtoHLS(0,0,tiRGBColor,@hue,@lum,@sat)
	lum = HSLMAX - lum
	RETURN HLStoRGB(hue,lum,sat)
ENDFUNC


FUNCTION ColorInverso (tiRGBColor)
	*-- Intercambia un color por su complementario,
	*-- sin cambiar el matiz o la saturación.
	LOCAL hue,lum,sat
	=RGBtoHLS(0,0,tiRGBColor,@hue,@lum,@sat)
	hue = HSLMAX - hue
	RETURN HLStoRGB(hue,lum,sat)
ENDFUNC


FUNCTION HUEtoRGB
	LPARAMETERS n1, n2, hue
	*/* utility routine for HLStoRGB */
	*WORD HueToRGB(WORD n1,WORD n2,WORD hue)

	*/* HLSMAX BEST IF DIVISIBLE BY 6 */
	*/* RGBMAX, HLSMAX must each fit in a byte. */

	*/* Hue is INDEFINIDO if Saturation is 0 (grey-scale) */
	*/* This value determines where the Hue scrollbar is */
	*/* initially set for achromatic colors */

	*/* range check: note values passed add/subtract thirds of range */
	IF (hue < 0)
		hue = hue + HLSMAX
	ENDIF
	IF (hue > HLSMAX)
		hue = hue - HLSMAX
	ENDIF
	hue = INT(hue)
	*/* return r,g, or b value from this tridrant */
	IF (hue < (HLSMAX/6))
		RETURN ( n1 + (((n2-n1)*hue+(HLSMAX/12))/(HLSMAX/6)) )
	ENDIF
	IF (hue < (HLSMAX/2))
		RETURN ( n2 )
	ENDIF
	IF (hue < ((HLSMAX*2)/3))
		RETURN ( n1 + (((n2-n1)*(((HLSMAX*2)/3)-hue)+(HLSMAX/12))/(HLSMAX/6)))
	ELSE
		RETURN ( n1 )
	ENDIF
ENDFUNC
