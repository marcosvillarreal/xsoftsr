* LISTADO DE CLIENTES *
local lodestino
lodestino=createobject("getdestimp","Listado de clientes")
lodestino.show
if not lodestino.lcancel
	if lodestino.preview
		report form cliente_imp preview noconsole
	else
		report form cliente_imp to printer noconsole	
	endif
endif		