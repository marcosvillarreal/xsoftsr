*-- PROCEDIMIENTOS PARA EL MANEJO DE RECIBOS --
* Tablas que deben estar abiertas
* pLocal
* bloqueo_recibo
* Recibos

function Bloqueo_recibo(tnProxRecibo)
	*-- VARIABLES LOCALES --
	*-- Bloqueo --
	local bloqueo_ok
	*-- Datos recibo --
	local lnTalon,lnRegTalon
	*-- BUSCAR EL TALONARIO --
	lnTalon=uValorParametroLocal('TALON')
	*-- Buscar el registro correspondiente al talon --
	lnRegTalon=buscardato(lnTalon,'bloqueo_recibo','n_talon','off')
	if lnRegTalon#0
		bloqueo_ok=.f.
		do while !bloqueo_ok
			bloqueo_ok=rlock(str(lnRegTalon),'bloqueo_recibo') && no sale hasta que puede bloquear.
		enddo
		tnProxRecibo=Bloqueo_recibo.n_recibo+1
		return .t.
	else
		tnProxRecibo=0
		return .f.
	endif
endfunc

function Imprimir_recibo
	parameters tctipo_recibo,tcrecibimos_de,tnimporte,tcconcepto,tndolares,tacheques, ;
		tdFecha,tnRecibo

	public grec_num_recibo,grec_cTipoComp,grec_recibimos_de,grec_importe,grec_concepto, ;
		grec_dolares,grec_cheques,grec_fecha
	local lbRecibo_ok,lnRtaReciboOK
	
	grec_num_recibo=tnRecibo
	grec_cTipoComp=tcTipo_Recibo
	grec_recibimos_de=tcrecibimos_de
	grec_importe=tnimporte
	grec_concepto=tcconcepto
	grec_dolares=tndolares
	grec_cheques=tacheques
	grec_fecha=tdfecha
	
	report form recibo to printer noconsole
	lbRecibo_Ok=.f.
	lnRtaReciboOK=messagebox('¿El recibo se imprimió correctamente?',36+256, ;
			'Pedido de confirmación')
	lbRecibo_ok=lnRtaReciboOK=6
	return lbRecibo_ok
endfunc

function Guardar_recibo
	parameters tctipo_recibo,tcrecibimos_de,tnimporte,tcconcepto,tndolares,tccheques, ;
		tdFecha,tnRecibo,tnPase,tnTalon
	*-- ACTUALIZAR INFORMACIÓN DEL ÚLTIMO RECIBO IMPRESO PARA TALÓN ACTUAL --
	sele bloqueo_recibo
	replace n_recibo with tnRecibo
	replace d_ult_impreso with tdfecha
	*-- AGREGAR RECIBO IMPRESO A TABLA DE RECIBOS --
	insert into recibos(n_talon,n_recibo,c_recibimo,n_importe,c_concepto, ;
		n_dolares,c_cheques,npase,ctipomov) ;
		value(tnTalon,tnRecibo,tcrecibimos_de,tnimporte,tcconcepto, ;
		tndolares,tccheques,tnpase,tctipo_recibo)
	return .t.
endfunc

function Desbloquear_recibo
	unlock in bloqueo_recibo
	return .t.
endfunc