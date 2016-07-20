define class HeaderOrden as Header

	nOrden=0

	procedure click()
		this.parent.parent.HeaderClick(this.nOrden)
	endproc

enddefine

define class colorden as column

	add object Header as 'HeaderOrden' noinit
	add object txtCampo as 'textbox'
	
	procedure init()
		parameters tnOrden
		this.Header.nOrden=tnOrden
	endproc

enddefine