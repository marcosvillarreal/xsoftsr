parameters tcRutaDato

on error do ManejaErrorVeriIndex with error(),message()

set exclu on

acti screen
clear

local lnInd

*------------------------
*-- VALIDAR BASE DE DATOS
lnDBCs=adir(laDBCs,tcRutaDato+'\*.DBC')
for lnInd= 1 to lnDBCs
	?'Base de datos '+laDBCs(lnInd,1)
	open data (tcRutaDato+'\'+laDBCs(lnInd,1))
	vali data
	close data
next lnInd

*----------------------
*-- BUSCAR ARCHIVOS DBF
local lnDBFs
lnDBFs=adir(laDBFs,tcRutaDato+'\*.DBF')

*--------------------------------------
*-- RECORRER ARCHIVOS Y VERIFICAR DATOS
for lnInd=1 to lnDBFs
	use (tcRutaDato+'\'+laDBFs(lnInd,1))
	sele (laDBFs(lnInd,1))
	? laDBFs(lnInd,1)
	*-- CALCULAR EL Nº DE INDICES
	
	*-- RECORRER INDICES
	lnJ=0
	llError=.f.
	DO WHILE !llError
		lnJ=lnJ+1
		set order to lnJ
		go top
		scan
			*-- SOLO RECORRER LOS REGISTROS
		endscan
	enddo
next lnInd

use

on error

procedure ManejaErrorVeriIndex
parameters tnError,tcMensaje,lnInd,laDBFs
	llError=.t.

	do case 
	case tnError=1683 && No se encontró el índice

	case tnError=26 && No posee índices

	otherwise
		=messagebox(alltrim(str(tnError))+' '+tcMensaje)
	endcase

	return