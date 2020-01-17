Dim Archivo
Set obj_FSO = CreateObject("Scripting.FileSystemObject")  

Set Archivo = obj_FSO.CreateTextFile("C:\Aplicaciones\MapeoImpresora.sql", True)  
Archivo.WriteLine "Use Datos"  

ok = MsgBox("Desea activar impresion a Mostrador?",VBYESNO)
If ok = 6 Then
   	Archivo.WriteLine "Execute CambiarMapeoImp 5,1"  	
else 
	ok = MsgBox("Desea desactivar impresion a Mostrador?",VBYESNO)
	If ok = 6 Then
		Archivo.WriteLine "Execute CambiarMapeoImp 5,0"  
	end if 
end if

'Cerramos el fichero  
Archivo.Close
Dim WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
Return = WshShell.Run("MapearImpresora.bat", 1, false)  