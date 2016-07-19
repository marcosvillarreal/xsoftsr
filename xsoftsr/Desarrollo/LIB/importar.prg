set exclu on

*-----------------------------------------------------------
*-- ACTUALIZAR TABLAS A PARTIR DE TABLAS DE MISMA ESTRUCTURA
*--		EN OTRO DIRECTORIO
lcDirDesde='c:\trabajo\@temp\fenix\dato'
lcDirDestino='c:\trabajo\fenix\dato'

*-------------------------------
*-- BUSCAR ARCHIVOS DBF EN DESDE
local lnDBFs
lnDBFs=adir(laDBFs,lcDirDesde+'\*.DBF')

*-------------------------------
*-- RECORRER ARCHIVOS E IMPORTAR
local lnInd
for lnInd=1 to lnDBFs
	if messagebox('Desde:'+lcDirDesde+'\'+laDBFs(lnInd,1) ;
		+chr(13)+'A:'+lcDirDestino+'\'+laDBFs(lnInd,1);
		,32+4,'Pedido de Confirmación')=6
		use (lcDirDestino+'\'+laDBFs(lnInd,1))
		sele (laDBFs(lnInd,1))
		append from (lcDirDesde+'\'+laDBFs(lnInd,1))
		use
	endif
next lnInd