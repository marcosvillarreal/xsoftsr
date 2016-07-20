*-------------------------------------------------
*-- CREAR TABLA DE EJERCICIO PARA NUEVA EMPRESA --
*-------------------------------------------------

procedure EmpresaAlta
parameters tnEmp,tcRuta
*-- CADENA A AGREGAR A LAS TABLAS --
local lcEmp,lcArchivo,lcdir,_quecopio,_dondecopio
lcEmp=strtran(str(tnEmp,3,0),' ','0')
*-- VERIFICAR SI EXISTE EL DIRECTORIO
lcdir=tcRuta+'Empresa'+lcemp
md &lcdir
_quecopio=tcRuta+'estructura\ejercicios\ejercicio.dbf'
copy file &_quecopio to &lcdir
endpro
*----------------------
*-- FIN EMPRESA_ALTA --
*----------------------
*-----------------------------------
*-- BORRAR INFORMACION DE EMPRESA --
*-----------------------------------
procedure EmpresaBaja
parameters tnEmp,tcRuta
local lcEmp,lcArchivo,lnInd,laArc(1)
lcEmp=strtran(str(tnEmp,3,0),' ','0')
lcdir=tcRuta+'Empresa'+lcemp
*-- BORRAR TABLAS
lcTabla='_'+lcEmp+'*.dbf'
lnArc=adir(laArc,tcRuta+lcTabla)
for lnInd=1 to lnArc
	lcTablaBorrar=left(laArc(lnInd,1),len(laArc(lnInd,1))-4)
	drop table (lcTablaBorrar) recycle
next lnInd

*-- BUSCAR VISTAS DE CUERASTO
local lnVistas
lnVistas=adbobject(laVistas,'VIEW')
for lnInd=1 to lnVistas
	*-- BORRAR VISTAS
	if left(laVistas(lnInd),4)='_'+lcEmp
		delete view (laVistas(lnInd))
	endif
next lnInd

endproc
*----------------------
*-- FIN EMPRESA_BAJA --
*----------------------

*----------------------------------------------
*-- CREAR LAS TABLAS PARA UN NUEVO EJERCICIO --
*----------------------------------------------
procedure EjercicioAlta
parameters tnEmp,tnEje,tcRuta
local lcEmpEje,lcArchivo,lcEmpEjeAnt,lcTablaPlancueAnt,lcdir,lcdireje

lcEmpEjeAnt=tcruta+'Empresa'+strtran(str(tnEmp,3,0),' ','0') ;
	+'\'+'Ejercicio'+strtran(str(tnEje-1,4,0),' ','0')
	
lcEmpEje=tcruta+'Empresa'+strtran(str(tnEmp,3,0),' ','0') ;
	+'\'+'Ejercicio'+strtran(str(tnEje,4,0),' ','0')
	
	
md &lcempeje
*-- Copiar la base de datos del directorio ESTUCTURAS ---*
wait 'Aguarde mientras se crea la base '+ chr(13) +;
     'de Datos para este ejercicio de la empresa ...' window nowait

_quecopio=tcRuta+'estructura\*.*'

copy file &_quecopio to &lcempeje

wait clear 

	
*-- CREAR PLAN DE CUENTAS
lcTablaPlancueAnt=lcEmpEjeAnt+'\plancue.dbf'
lcTabla=lcEmpEje+'\plancue'

*-- TOMAR DATOS DE PLANCUE ANTERIOR (SI EXISTE)
if file(lcTablaPlancueAnt)
	sele (lctabla)
	append from (lcTablaPlancueAnt)
endif

endproc
*------------------------
*-- FIN EJERCICIO_ALTA --
*------------------------

function cuenta_imputable
parameters tnCodcta
*-- Guardar entorno --
	local lcAlias,lnRegIni
	lcAlias=alias()
	sele plancue
	if bof() or eof()
		lnRegIni=0
	else
		lnRegIni=recno()
	endif
*---------------------
local lbImputable,lnOrdenIni,lnNivelIni
=seek(tnCodCta,'plancue','codcta')
if eof()
	&& Cuenta inicial no encontrada (no imputable)
	lbImputable=.f.
else
	lnOrdenIni=plancue.orden
	lnNivelIni=plancue.nivel
	=seek(lnOrdenIni+1,'plancue','orden')
	if eof()
		&&e Cuenta siguiente no encontrada (cuenta imputable)
		lbImputable=.t.
	else
		lbImputable=iif(plancue.nivel>lnNivelIni,.f.,.t.)
	endif
endif
*-- Restaurar entorno --
	if lnRegIni>0
		go lnRegIni
	endif
	sele (lcAlias)
*-----------------------
return lbImputable

function posee_movimientos
parameters tnCodCta

=seek(tnCodCta,'cuerasto','codcta')
if eof('cuerasto')
	return .f.
else
	return .t.
endif

function buscar_num_asto
parameters tnCodAsto
*-- Guardar información de alias y registros --
local lcAlias,lnRegIni,lnNumAsto
lnRegIni=0
lcAlias=alias()
select cabeasto
if !(bof() or eof())
	lnRegIni=recno()
endif
*-- Buscar el código de asiento en las cabezas --
=seek(tnCodAsto,'cabeasto','codasto')
lnNumAsto=cabeasto.numero_asto
if lnRegIni>0
	go lnRegIni in cabeasto
endif
if eof()
	&& Número no encontrado
	select (lcAlias)
	return .f.
else
	select (lcAlias)
	return lnNumAsto
endif
*----------------------------------------------------------------------------------------
function sumas_cta
parameters tdDesde,tdHasta,tnCodCta,tcAliasCuerAsto, ;
	tnDebe,tnHaber

local lcAlias
lcAlias=alias()
tnDebe=0
tnHaber=0

select (tcAliasCuerAsto)
set order to cta_fecha

set near on
=seek(str(tnCodCta,10)+dtos(tdDesde),tcAliasCuerAsto,'cta_fecha')
set near off
if eof()
	SELECT (LCALIAS)
	RETURN .F.
ELSE
	scan while tnCodCta=codcta and !eof() and fecha<=tdHasta
		tnDebe=tnDebe+debe
		tnHaber=tnHaber+haber
	endscan
endif
select (lcAlias)
*----------------------------------------------------------------------------------------
function saldo_cta
parameters tdDesde,tdHasta,tnCodCta,tcAliasCuerAsto, ;
	tnSaldo
local lnDebe,lnHaber,lbResOK
lbResOK=sumas_cta(tdDesde,tdHasta,tnCodCta,tcAliasCuerAsto,@lnDebe,@lnHaber)
if lbResOK
	tnSaldo=lnDebe-lnHaber
else
	return .f.
endif
*----------------------------------------------------------------------------------------
function fin_informe
gbFinInforme=.t.
return .t.
*----------------------------------------------------------------------------------------
function fin_grupo
parameters tbValor
gbFinGrupo=tbValor
return .t.

function sumacta
parameters tdDesde,tdHasta,tnNumCta ;
	,tnDebe,tnHaber

local laSumas(2)

sele sum(debe),sum(haber) from cuerasto ;
	inner join plancue on cuerasto.codcta=plancue.codcta ;
	inner join cabeasto on cabeasto.codasto=cuerasto.codasto ;
	where plancue.numcta=tnNumCta ;
		and cabeasto.fecha between tdDesde and tdHasta ;
	into array laSumas
	
if _tally>0
	tnDebe=laSumas(1)
	tnHaber=laSumas(2)
else
	store 0 to tnDebe,tnHaber
endif