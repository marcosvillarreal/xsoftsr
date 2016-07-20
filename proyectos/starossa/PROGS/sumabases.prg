SELECT titulos.cuenta,titulos.nombre as titulo,VAL(STR(nvl(sum(sellos.nbase),0),13,2)) as bases FROM filatelia!titulos;
left JOIN filatelia!sellos ON titulos.cuenta=sellos.idtitulo;
group by titulos.cuenta into cursor csrbases nofilter
sele csrbases
brow

*ele csrPlancue.cuenta,VAL(STR(nvl(sum(csrAstoAct.debe),0),13,2)) as debe ;
*!*		,VAL(STR(nvl(sum(csrAstoAct.haber),0),13,2)) as haber from csrPlancue ;
*!*		left join csrAstoAct on csrPlancue.cuenta=csrAstoAct.cuenta ;
*!*		group by csrPlancue.cuenta ;
*!*		where csrPlancue.orden between thisform.nOrdDesde and thisform.nOrdHasta ;
*!*		into cursor csrACT nofilter
