function sseek
	parameters tuExpr

	*-- GUARDAR VALOR DE NEAR
	local lcNearIni
	lcNearIni=set('near')
	set near on

	*-- BUSCAR DATO
	seek tuExpr

	*-- RESTABLECER NEAR
	set near &lcNearIni

	return .t.
endfunc

*-------------------------------------
*-- CONVIERTE UN CURSOR EN MODIFICABLE
procedure hazmodificable

	lparameters m.alias

	use (dbf(m.alias)) in 0 again alias hazmodificable
	use in (m.alias)
	use (dbf("hazmodificable")) in 0 again alias (m.alias)
	use in hazmodificable

endproc

*-----------------------------
*-- VERIFICA Nº DE CUIT VALIDO
FUNCTION vericuit
PARAMETER m_cuit
LOCAL _cuit,i,_digito,j,suma,RESTO,dv,sale
_cuit=''
sale = .F.
FOR i=1 TO LEN(m_cuit)
	IF SUBS(m_cuit,i,1)$'0123456789'
		_cuit=_cuit+SUBS(m_cuit,i,1)
	ENDIF
NEXT
IF LEN(_cuit)<>11
	sale=.F.
ELSE
	_digito=VAL(RIGHT(_cuit,1))
	j=2
	suma=0
	dv=0
	FOR i=10 TO 1 STEP -1
		suma = suma + VAL(SUBS(_cuit,i,1)) * j
		j = j + 1
		j=IIF(j=8,2,j)
	NEXT
	RESTO=MOD(suma,11)
	IF RESTO=0
		dv=0
	ELSE
		dv=11 - RESTO
		dv=IIF(dv=10,9,dv)
	ENDIF
	sale= IIF(_digito=dv,.T.,.F.)
ENDIF
RETURN sale

FUNCTION cuit
PARAMETERS tCuit
local lcCuit
lcCuit=''
if type('tCuit')='N'
	lcCuit=alltrim(str(tCuit))
else
	lcCuit=tCuit
endif
if len(lcCuit)#11
	return ''
else
	RETURN LEFT(lcCuit,2)+'-'+SUBSTR(lcCuit,2,10)+'-'+RIGHT(lcCuit,1)
endif

FUNCTION limpiar_teclado
CLEAR TYPEAHEAD
KEYBOARD CHR(32)
INKEY()

FUNCTION buscardato
PARAMETERS tuvalor,tcalias,tcorden,tcnear
LOCAL lcestadonearini,lnreg
lcestadonearini=SET('near')
SET NEAR &tcnear
=SEEK(tuvalor,tcalias,tcorden)
lnreg=IIF(EOF(tcalias),0,RECNO(tcalias))
SET NEAR &lcestadonearini
RETURN lnreg

PROCEDURE isoperator
PARAMETERS ccar
RETURN INLIST(ccar,'*','/','+','-','^',' ','<','>','=',')')

PROCEDURE variables
PARAMETERS cexpr,avariab
* cExpr: expresión a evaluar
* aVariab(): nombre de variables encontradas en cExpr
* nI:entero, indice
* bInVar: lógico, si se encuentra dentro de una variable
* cCar: cadena, caracter analizado actualmente
* nTamMat: numero de elementos de aVar

DIMENSION avariab(1)
binvar=.F.
ntammat=0

FOR ni=1 TO LEN(cexpr)
	ccar=SUBSTR(cexpr,ni,1) && Barre cada uno de los caracteres
	IF NOT binvar && Primera letra de una posible variable
		IF ISALPHA(ccar) OR ccar='_'
			binvar=.T.
			ntammat=ntammat+1
			DO redim WITH avariab, ntammat
			avariab(ntammat)=ccar
		ENDIF
	ELSE && Ya me encuentro en una variable
		IF ccar='(' && Significa que no era una variable, sino una funcion 'xxx('
			binvar=.F.
			ntammat=ntammat-1
			DO redim WITH avariab, ntammat
		ELSE
			IF isoperator(ccar) && Es un operador, llegamos al fin de la variable
				binvar=.F.
				cvaract=UPPER(avariab(ntammat))
				IF cvaract='AND' OR cvaract='NOT' OR cvaract='OR' && La variable es;
						en realidad un operador lógico, por lo que lo excluimos
					ntammat=ntammat-1
					DO redim WITH avariab, ntammat
				ENDIF
			ELSE && Se agregan más letras (o números) a la variable
				avariab(ntammat)=avariab(ntammat)+ccar
			ENDIF
		ENDIF
	ENDIF
NEXT ni

PROCEDURE redim
PARAMETERS amatriz, ntam
IF ntam>0 then
	DIMENSION amatriz(ntam)
ENDIF

FUNCTION seek_dato
PARAMETERS tcdatobuscado,tbtipobusqueda
IF tbtipobusqueda
	SET NEAR ON
ELSE
	SET NEAR OFF
ENDIF
SEEK(tcdatobuscado)
SET NEAR OFF
RETURN .T.

FUNCTION strzero
PARAMETERS tcdato,tntamfinal
RETURN REPLICATE('0',tntamfinal-LEN(tcdato))+tcdato

FUNCTION numtocod
PARAMETERS tnnum,tntamcod
RETURN strzero(ALLTRIM(STR(tnnum)),tntamcod)

FUNCTION strz
PARAMETER tnconv,tntam
LOCAL lcconv
lcconv=ALLTRIM(STR(tnconv))
lcconv=REPLICATE('0',tntam-LEN(lcconv))+lcconv
RETURN lcconv

FUNCTION strzc
PARAMETER tcconv,tntam
LOCAL lcconv
lcconv=ALLTRIM(tcconv)
lcconv=REPLICATE('0',tntam-LEN(lcconv))+lcconv
RETURN lcconv

PROCEDURE cargararbol
PARAMETERS tpadrebuscado,tnorden
*-- Declaración de variables.
LOCAL lpadrebuscado
LOCAL lnregactual
LOCAL lnvalitemdata && Valor de Item Data
*-- Inicialización de variables.
lpadrebuscado=tpadrebuscado
*-- Busqueda de lPadreBuscado
SELECT plancue
SET ORDER TO ctamadre
SEEK lpadrebuscado
*-- Desplazarse por todos los elementos que tienen como padre a lPadreBuscado;
para luego llamar a CargarArbol con cada uno de ellos.
DO WHILE !EOF() AND ctamadre=lpadrebuscado
	lnregactual=RECNO()
	REPLACE orden WITH tnorden
	tnorden=tnorden+1
	=cargararbol(codcta,@tnorden)
	GO lnregactual
	SKIP
ENDDO

FUNCTION posiciono_cuenta
LOCAL _cuenta
SELE cuerasto
_cuenta=cuerasto.codcta
SET ORDER TO gab
SEEK STR(_cuenta,10)+STR(goinfocont.nejeact*10^8+3,14)
=MESSAGEBOX(STR(cuerasto.codasto,14))
=MESSAGEBOX(STR(goinfocont.nejeact*10^8+3,14))
RETURN .T.


PROCEDURE Xnro_letras
PARAMETERS m_acobrar,nroletras
PRIVATE cadena,subca,subca1,subca2

cadena = LTRIM(TRANSFORM(ABS(m_acobrar),'999,999,999,999.99'))
IF m_acobrar < 0
	subca1 = 'PESOS - '
ELSE
	subca1='PESOS '
ENDIF
DO WHILE .T.
	IF LEN(ALLTRIM(cadena))>=15
		subca=SUBS(cadena,1,LEN(LTRIM(cadena))-15)
		subca2=enletras(subca)
		subca1=subca1+subca2+' MIL '
		cadena = RIGH(cadena,14)
		LOOP
	ENDIF
	IF LEN(ALLTRIM(cadena)) >=11
		subca=SUBS(cadena,1,LEN(LTRIM(cadena))-11)
		subca2=enletras(subca)
		IF RIGH(subca2,5)<>'CE!RO'
			IF VAL(subca)=1
				subca1=subca1+subca2+' MI!LLON '
			ELSE
				subca1=subca1+subca2+' MI!LLO!NES '
			ENDIF
		ELSE
			subca1 = subca1 + ' MI!LLO!NES '
		ENDIF
		cadena= RIGH(cadena,10)
		LOOP
	ENDIF
	IF LEN(ALLTRIM(cadena)) >=7
		subca=SUBS(cadena,1,LEN(LTRIM(cadena))-7)
		subca2=enletras(subca)
		IF RIGH(subca2,5)<>'CE!RO'
			subca1=subca1+subca2+' MIL '
		ENDIF
		cadena=RIGH(cadena,6)
		LOOP
	ENDIF
	IF LEN(cadena)>=3
		subca=SUBS(cadena,1,LEN(LTRIM(cadena))-3)
		subca2=enletras(subca)
		IF RIGH(subca2,5)<>'CE!RO' .OR. LEN(LTRIM(subca))=1
			IF RIGH(subca2,3) = 'U!N'
				subca2=subca2+'O'
			ENDIF
			subca1=subca1+subca2+' CON '
		ELSE
			subca1=subca1+'CON '
		ENDIF
		cadena=RIGH(cadena,2)
		LOOP
	ENDIF
	subca=SUBS(cadena,1,2)
	subca2=enletras(subca)
	IF VAL(RIGH(ALLTRIM(subca),2)) <= 1
		subca1=subca1+subca2+' CTVO'
	ELSE
		subca1=subca1+subca2+' CTVOS'
	ENDIF
	EXIT
ENDDO
nroletras=subca1
RETURN

FUNCTION Xenletras
PARAMETERS subca
PRIVATE salir,abuscar
DIMENSION unidad(29),decena(9),centena(9)
unidad[01]='U!N'
unidad[02]='DOS'
unidad[03]='TRES'
unidad[04]='CUA!TRO'
unidad[05]='CIN!CO'
unidad[06]='SEIS'
unidad[07]='SIE!TE'
unidad[08]='O!CHO'
unidad[09]='NUE!VE'
unidad[10]='DIEZ'
unidad[11]='ON!CE'
unidad[12]='DO!CE'
unidad[13]='TRE!CE'
unidad[14]='CA!TOR!CE'
unidad[15]='QUIN!CE'
unidad[16]='DIE!CI!SEIS'
unidad[17]='DIE!CI!SIE!TE'
unidad[18]='DIE!CI!O!CHO'
unidad[19]='DIE!CI!NUE!VE'
unidad[20]='VEIN!TE'
unidad[21]='VEIN!TI!U!N'
unidad[22]='VEIN!TI!DOS'
unidad[23]='VEIN!TI!TRES'
unidad[24]='VEIN!TI!CUA!TRO'
unidad[25]='VEIN!TI!CIN!CO'
unidad[26]='VEIN!TI!SEIS'
unidad[27]='VEIN!TI!SIE!TE'
unidad[28]='VEIN!TI!O!CHO'
unidad[29]='VEIN!TI!NUE!VE'

decena[01]='DIEZ'
decena[02]='VEIN!TE'
decena[03]='TREIN!TA'
decena[04]='CUA!REN!TA'
decena[05]='CIN!CUEN!TA'
decena[06]='SE!SEN!TA'
decena[07]='SE!TEN!TA'
decena[08]='O!CHEN!TA'
decena[09]='NO!VEN!TA'

centena[01]='CIEN'
centena[02]='DOS!CIEN!TOS'
centena[03]='TRES!CIEN!TOS'
centena[04]='CUA!TRO!CIEN!TOS'
centena[05]='QUI!NIEN!TOS'
centena[06]='SEIS!CIEN!TOS'
centena[07]='SE!TE!CIEN!TOS'
centena[08]='O!CHO!CIEN!TOS'
centena[09]='NO!VE!CIEN!TOS'

abuscar = 0
abuscar = ABS(VAL(subca))
DO CASE
CASE abuscar=0
	RETURN('CE!RO')
CASE abuscar >=1 .AND. abuscar<30
	RETURN( unidad[ abuscar ] )
CASE abuscar >=30 .AND. abuscar< 100
	IF RIGH(ALLTRIM(subca),1)='0'
		RETURN(decena[val(left(righ(subca,2),1))])
	ELSE
		salir = decena[val(left(righ(subca,2),1))]
		salir = salir +' Y '+unidad[val(righ(subca,1))]
		RETURN(salir)
	ENDIF
CASE abuscar >=100 .AND. abuscar<1000
	IF RIGH(ALLTRIM(subca),2)='00'
		RETURN(centena[val(left(ltrim(subca),1))])
	ELSE
		IF RIGH(ALLTRIM(subca),1)='0'
			IF VAL(LEFT(LTRIM(subca),1))=1
				RETURN ('CIEN!TO '+decena[val(subs(subca,2,1))])
			ELSE
				RETURN(centena[val(left(ltrim(subca),1))]+' '+decena[val(subs(ltrim(subca),2,1))])
			ENDIF
		ELSE
			IF VAL(LEFT(LTRIM(subca),1))=1
				salir = 'CIEN!TO'
			ELSE
				salir=centena[val(left(ltrim(subca),1))]
			ENDIF
			IF VAL(RIGH(subca,2)) <=30
				salir=salir+' '+unidad[val(righ(subca,2))]
			ELSE
				salir=salir +' '+decena[val(subs(subca,2,1))]
			ENDIF
			RETURN (salir)
		ENDIF
	ENDIF
ENDCASE
RETURN(salir)


FUNCTIO importeenletras
PARAMETERS tynumero
LOCAL lcimporte
lcimporte=''
DO nro_letras WITH tynumero,lcimporte
lcimporte=STRTRAN(lcimporte,'!','')
RETURN lcimporte

*!*	function vericuit
*!*	PARAMETER m_cuit
*!*	local _cuit,i,_digito,j,suma,resto,dv,sale
*!*	if lastkey()=5 ; return .t. ; endif
*!*	_cuit=''
*!*	sale = .f.
*!*	for i=1 to len(m_cuit)
*!*	    if subs(m_cuit,i,1)$'0123456789' ; _cuit=_cuit+subs(m_cuit,i,1) ; endif
*!*	next
*!*	if len(_cuit)<>11 ; do errores with 'LA CUIT ES INVALIDA ...' ; return .f. ; endif
*!*	_digito=val(right(_cuit,1))
*!*	j=2 ; suma=0 ; dv=0
*!*	for i=10 to 1 step -1
*!*	    suma = suma + val(subs(_cuit,i,1)) * j
*!*	    j = j + 1
*!*	    if j=8 ; j=2 ; endif
*!*	next
*!*	resto=mod(suma,11)
*!*	if resto=0
*!*	   dv=0
*!*	else
*!*	   dv=11 - resto
*!*	   if dv=10 ; dv=9 ; endif
*!*	endif

*!*	if len(alltrim(m_cuit))<>13
*!*	    if .not. '-'$m_cuit
*!*	       m_cuit=left(m_cuit,2)+'-'+subs(m_cuit,3,8)+'-'+strzero(_digito,1)
*!*	    endif
*!*	    do errores with 'LA CUIT ES INVALIDA ...'
*!*	    return .f.
*!*	endif

*!*	sale= if(_digito=dv,.t.,.f.)
*!*	if .not. sale
*!*	    do errores with 'LA CUIT ES INVALIDA ...'
*!*	endif
*!*	return sale

Function DECLARA_L
public unidad[29],decena[9],centena[9],operador[11]

unidad[01]='U!N'
unidad[02]='DOS'
unidad[03]='TRES'
unidad[04]='CUA!TRO'
unidad[05]='CIN!CO'
unidad[06]='SEIS'
unidad[07]='SIE!TE'
unidad[08]='O!CHO'
unidad[09]='NUE!VE'
unidad[10]='DIEZ'
unidad[11]='ON!CE'
unidad[12]='DO!CE'
unidad[13]='TRE!CE'
unidad[14]='CA!TOR!CE'
unidad[15]='QUIN!CE'
unidad[16]='DIE!CI!SEIS'
unidad[17]='DIE!CI!SIE!TE'
unidad[18]='DIE!CI!O!CHO'
unidad[19]='DIE!CI!NUE!VE'
unidad[20]='VEIN!TE'
unidad[21]='VEIN!TI!U!N'
unidad[22]='VEIN!TI!DOS'
unidad[23]='VEIN!TI!TRES'
unidad[24]='VEIN!TI!CUA!TRO'
unidad[25]='VEIN!TI!CIN!CO'
unidad[26]='VEIN!TI!SEIS'
unidad[27]='VEIN!TI!SIE!TE'
unidad[28]='VEIN!TI!O!CHO'
unidad[29]='VEIN!TI!NUE!VE'

decena[01]='DIEZ'
decena[02]='VEIN!TE'
decena[03]='TREIN!TA'
decena[04]='CUA!REN!TA'
decena[05]='CIN!CUEN!TA'
decena[06]='SE!SEN!TA'
decena[07]='SE!TEN!TA'
decena[08]='O!CHEN!TA'
decena[09]='NO!VEN!TA'

centena[01]='CIEN'
centena[02]='DOS!CIEN!TOS'
centena[03]='TRES!CIEN!TOS'
centena[04]='CUA!TRO!CIEN!TOS'
centena[05]='QUI!NIEN!TOS'
centena[06]='SEIS!CIEN!TOS'
centena[07]='SE!TE!CIEN!TOS'
centena[08]='O!CHO!CIEN!TOS'
centena[09]='NO!VE!CIEN!TOS'

*!*	decena := {'DIEZ','VEIN!TE','TREIN!TA','CUA!REN!TA','CIN!CUEN!TA','SE!SEN!TA','SE!TEN!TA','O!CHEN!TA','NO!VEN!TA'}
*!*	centena :={'CIEN','DOS!CIEN!TOS','TRES!CIEN!TOS','CUA!TRO!CIEN!TOS','QUI!NIEN!TOS','SEIS!CIEN!TOS','SE!TE!CIEN!TOS','O!CHO!CIEN!TOS','NO!VE!CIEN!TOS'}
*!*	operador := {'*', '/', '+', '-', '(', ')', ',' ,'>', '<', '=', '.'}

RETURN

PROCEDURE NRO_LETRAS
parameters m_acobrar,nroletras
private cadena,subca,subca1,subca2
declara_l()
cadena = ltrim(transform(abs(m_acobrar),'999,999,999,999.99'))
subca1=''
*subca1 = iif(m_acobrar < 0,'PESOS - ','PESOS ')
DO WHILE .T.
	if len(alltrim(cadena))>=15
		subca=subs(cadena,1,len(ltrim(cadena))-15)
		subca2=ENLETRAS(subca)
		subca1=subca1+subca2+' MIL '
		cadena = righ(cadena,14)
		loop
	endif
	if len(alltrim(cadena)) >=11
		subca=subs(cadena,1,len(ltrim(cadena))-11)
		subca2=ENLETRAS(subca)
		if righ(subca2,5)<>'CE!RO'
			subca1= subca1 + subca2 + iif(val(subca)=1,' MI!LLON ',' MI!LLO!NES ')
		else
			subca1 = subca1 + ' MI!LLO!NES '
		endif
		cadena= righ(cadena,10)
		loop
	endif
	if len(alltrim(cadena)) >=7
		subca=subs(cadena,1,len(ltrim(cadena))-7)
		subca2=ENLETRAS(subca)
		if righ(subca2,5)<>'CE!RO'
			subca1=subca1+subca2+' MIL '
		endif
		cadena=righ(cadena,6)
		loop
	endif
	if len(cadena)>=3
		subca=subs(cadena,1,len(ltrim(cadena))-3)
		subca2=ENLETRAS(subca)
		if righ(subca2,5)<>'CE!RO' .or. len(ltrim(subca))=1
			if righ(subca2,3) = 'U!N'
				subca2=subca2+'O'
			endif
			subca1=subca1+subca2+' CON '
		else
			subca1=subca1+'CON '
		endif
		cadena=righ(cadena,2)
		loop
	endif
	subca=subs(cadena,1,2)
	subca2=ENLETRAS(subca)
	subca1= subca1 + subca2 + iif(val(righ(alltrim(subca),2)) <= 1,' CTVO',' CTVOS')
	exit
ENDDO
nroletras=subca1

RETURN


FUNCTION ENLETRAS
parameters subca
private salir,abuscar
declara_l()

abuscar = 0
abuscar = abs(val(subca))
DO CASE
CASE abuscar=0
	RETURN('CE!RO')
CASE abuscar >=1 .and. abuscar<30
	RETURN( unidad[ abuscar ] )
CASE abuscar >=30 .and. abuscar< 100
	IF righ(alltrim(subca),1)='0'
		RETURN(decena[val(left(righ(subca,2),1))])
	ELSE
		salir = decena[val(left(righ(subca,2),1))]
		salir = salir +' Y '+unidad[val(righ(subca,1))]
		RETURN(salir)
	ENDIF
CASE abuscar >=100 .and. abuscar<1000
	IF righ(alltrim(subca),2)='00'
		RETURN(centena[val(left(ltrim(subca),1))])
	ELSE
		IF righ(alltrim(subca),1)='0'
			IF val(left(ltrim(subca),1))=1
				RETURN ('CIEN!TO '+decena[val(subs(subca,2,1))])
			ELSE
				RETURN(centena[val(left(ltrim(subca),1))]+' '+decena[val(subs(ltrim(subca),2,1))])
			ENDIF
		eLSE
			IF val(left(ltrim(subca),1))=1
				salir = 'CIEN!TO'
			ELSE
				salir=centena[val(left(ltrim(subca),1))]
			ENDIF
			IF VAL(RIGH(subca,2)) <=30
				salir=salir+' '+unidad[val(righ(subca,2))]
			ELSE
				salir=salir +' '+decena[val(subs(subca,2,1))]
				salir=salir+' Y '+unidad[val(righ(subca,1))]
			ENDIF
			RETURN (salir)
		endif
	ENDIF
ENDCASE
RETURN(salir)
