parameters tncuenta

*--------------------------------------------
*-- DECLARACIÓN E INICIALIZACIÓN DE VARIABLES
local lcAliasIni,lnRegIni,lcNombre

if !empty(tncuenta)

	*---------------------------------
	*-- GUARDAR INFORMACIÓN DE ENTORNO
	local lcAliasIni
	lcAliasIni=alias()
	sele plancue
	lnRegIni=iif(bof() or eof(),0,recno())

	*--------------------------
	*-- BUSCAR NOMBRE DE CUENTA
	sele plancue
	lcNombre=lookup(nombre,tnCuenta,cuenta,'cuenta')

	*-----------------------------------
	*-- RESTAURAR INFORMACIÓN DE ENTORNO
	if lnRegIni#0
		go lnRegIni
	endif
	sele (lcAliasIni)

else

	lcNombre=''

endif

*---------------------------------
*-- DEVOLVER NOMBRE O CADENA VACIA

return lcNombre