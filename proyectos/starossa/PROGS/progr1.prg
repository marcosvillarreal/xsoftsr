SELECT Manual.*, Monodro.ddroga, Acciofar.daccf, Ubicacion.nombre AS NOMUBI;
,Estprodu.nombre as nomest, Dtopami.nombre as nomdto, Tipoprod.nombre as nomtip;
,Unormati.nombre as nomunor, Tipovta.nombre as nomvta, Multidro.cmudroga, Origen.nombre;
,Tipoiva.nombre as NOMIVA, Vias.dvias, Tipounid.dtuni, Upotenci.dupot, Formas.dffar,Tamanos.dtama;
	FROM  Manual;
		INNER JOIN Manextra ON  Manual.registro = Manextra.registro;
		INNER JOIN Ubicacion  ON  Manual.hela = Ubicacion.numero:
		INNER JOIN Estprodu  ON  Manual.baja = Estprodu.numero;
		INNER JOIN Dtopami  ON  Manual.pami = Dtopami.numero; 
		INNER JOIN Tipoprod  ON  Manual.tipo = Tipoprod.numero;
		INNER JOIN Unormati  ON  Manual.iomf = Unormati.numero;
		INNER JOIN Tipovta  ON  Manual.vta = Tipovta.vta;  
		INNER JOIN Multidro  ON  Manual.registro = Multidro.registro;
		INNER JOIN Origen  ON  Manual.impo = Origen.numero;
		INNER JOIN Tipoiva  ON  Manual.iva = Tipoiva.numero; 
		INNER JOIN Vias  ON  Manextra.cvias = Vias.cvias;
		INNER JOIN Tipounid  ON  Manextra.ctuni = Tipounid.ctuni;
		INNER JOIN Upotenci  ON  Manextra.cupot = Upotenci.cupot;
		INNER JOIN Formas  ON  Manextra.cffar = Formas.cffar; 
		INNER JOIN Tamanos  ON  Manextra.ctama = Tamanos.ctama;
		INNER JOIN Acciofar  ON  Manextra.caccf = Acciofar.caccf;
		INNER JOIN Monodro  ON  Manextra.cdroga = Monodro.cdroga; 
	ORDER BY Manual.producto


RETURN .t.

