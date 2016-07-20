lparameters m.unidad

if pcount() = 0
	m.unidad = sys(5)
endif

m.unidad = left(m.unidad, 1) + ":\" && asegurarnos de que incluye el backslash y los 2 puntos

local nombrevol, tamaño, numeroserie, maximo, flags, nombresf, lnsf

nombrevol = ""
tamaño = 0
numeroserie = 0
maximo = 0
flags = 0
nombresf = ""
lnsf = 0

DECLARE INTEGER GetVolumeInformation IN Kernel32;
	String  Unidad ,;
	String  @NombreVOL ,;
	Integer Tama ,;
	Integer @NumeroSER ,;
	Integer @TamaMAX ,;
	Integer @Flags ,;
	String  @NombreSF ,;
	Integer LNSF


=GetVolumeInformation (m.unidad , @nombrevol, 255, @numeroserie, @maximo,@Flags, @nombresf, 255)
return numeroserie


