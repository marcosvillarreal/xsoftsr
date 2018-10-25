use datos
go
select p.id,p.numero,p.nombre,p.prevtaf1 as precio,promo.*
,cast(round((case when isnull(promo.canbase,0) = 1 
then p.prevtaf1 * (1 - promo.bonifica/100)
else p.prevtaf1 end),3) as numeric(11,3)) as prevtaf1
from producto as p
left join (select ca.idprodgenera, ca.id as idcabepromo, cu.bonifica , cu.fechasta ,cu.candesde as canbase from cabepromopub as ca
inner join cuerpromopub as cu on ca.id = cu.idcabepromo
) as promo on p.id = promo.idprodgenera
--where p.numero = 9550
go


--select a.numero,a.nombre as nombre
--,cast(round((case when isnull(p.canbase,0) = 1 
--then a.prevtaf1 * (1 - p.bonifica/100)
--else a.prevtaf1 end),3) as numeric(11,3)) as prevtaf1
--,a.prevtaf3,isnull(s.nombre,'') as nomvariedad,isnull(e.iddeposito,0) as iddeposito 
--,isnull(e.existe,0) as existedisp,a.codbarra13,s.codigo 
--from producto a 
--left join subproducto s on s.idarticulo=a.id 
--left join existenc e on (e.idsubarti=isnull(s.id,0) and e.idarticulo=a.id) 
--left join (select ca.idprodgenera, ca.id as idcabepromo, cu.bonifica , cu.fechasta ,cu.candesde as canbase from cabepromopub as ca
--inner join cuerpromopub as cu on ca.id = cu.idcabepromo
--) as p on a.id = p.idprodgenera
--where (espromocion=0 and idestado=1 and "+strCondicion+") order by a.nombre