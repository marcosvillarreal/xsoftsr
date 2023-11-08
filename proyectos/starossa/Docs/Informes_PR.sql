use datos
go


--select distinct c.cnumero as codigo,c.cnombre as razonsocial,pr.nombre as provincia, l.nombre  as localidad ,c.cdireccion as direccion
--,cv.nombre as canalvta,'ACTIVO' as estado
--from maopera  as m
--inner join cabefac as ca on m.id = ca.idmaopera
--inner join cuerfac as cu on ca.idmaopera = cu.idmaopera
--inner join producto as p on cu.idarticulo = p.id
--inner join ctacte as c on ca.idctacte = c.id
--inner join provincia as pr on c.idprovincia = pr.id
--inner join localidad as l on c.idlocalidad = l.id
--inner join canalvta as cv on c.idcanalvta = cv.id
--where m.estado = '0' and m.clasecomp in ('A','B','C','H','X')
--and ca.fecha between '20230101' and '20230831'
--and p.idctacte = 7099 and p.espromocion = 0

--go

--select distinct convert(char(10),ca.fecha,105) as fecha,c.cnumero as codigo,c.cnombre as razonsocial,pr.nombre as provincia, l.nombre  as localidad ,c.cdireccion as direccion
--,cv.nombre as canalvta,v.nombre as vendedor,mar.nombre as marca,p.codalfa,p.codbarra13 as ean,p.nombre as producto,cu.cantidad,cu.preunitasiva,round(cu.cantidad*cu.preunitasiva,3)
--from maopera  as m
--inner join cabefac as ca on m.id = ca.idmaopera
--inner join cuerfac as cu on ca.idmaopera = cu.idmaopera
--inner join producto as p on cu.idarticulo = p.id
--inner join ctacte as c on ca.idctacte = c.id
--inner join provincia as pr on c.idprovincia = pr.id
--inner join localidad as l on c.idlocalidad = l.id
--inner join canalvta as cv on c.idcanalvta = cv.id
--inner join vendedor as v on m.idvendedor = v.id
--inner join marca as mar on p.idmarca = mar.id
--where m.estado = '0' and m.clasecomp in ('A','B','C','H','X')
--and ca.fecha between '20230101' and '20230630'
--and p.idctacte = 7099 and p.espromocion = 0

--go
--select p.numero,p.codalfa,p.codbarra13 as ean,p.nombre as producto
--,isnull((select top 1 existe  from existenc as e where e.idarticulo = p.id and e.iddeposito = 524),0) as stock
--from producto  as p
--where p.idctacte = 7099 and p.espromocion = 0

--go
---------------------------------
------Padron de todos los clientes que compran alcochol

--select distinct c.cnumero as codigo,c.cnombre as razonsocial,pr.nombre as provincia, l.nombre  as localidad ,c.cdireccion as direccion
--,cv.nombre as canalvta,'ACTIVO' as estado
--from maopera  as m
--inner join cabefac as ca on m.id = ca.idmaopera
--inner join cuerfac as cu on ca.idmaopera = cu.idmaopera
--inner join producto as p on cu.idarticulo = p.id
--inner join ctacte as c on ca.idctacte = c.id
--inner join provincia as pr on c.idprovincia = pr.id
--inner join localidad as l on c.idlocalidad = l.id
--inner join canalvta as cv on c.idcanalvta = cv.id
--inner join rubro as r on p.idrubro = r.id
--where m.estado = '0' and m.clasecomp in ('A','B','C','H','X')
--and ca.fecha between '20230101' and '20230831'
--and p.espromocion = 0
--and r.idtipoprod = 2

---------------Clientes cepas
select distinct c.cnumero as codigo,c.cnombre as razonsocial,pr.nombre as provincia, l.nombre  as localidad ,c.cdireccion as direccion
,cv.nombre as canalvta,'ACTIVO' as estado
from maopera  as m
inner join cabefac as ca on m.id = ca.idmaopera
inner join cuerfac as cu on ca.idmaopera = cu.idmaopera
inner join producto as p on cu.idarticulo = p.id
inner join ctacte as c on ca.idctacte = c.id
inner join provincia as pr on c.idprovincia = pr.id
inner join localidad as l on c.idlocalidad = l.id
inner join canalvta as cv on c.idcanalvta = cv.id
where m.estado = '0' and m.clasecomp in ('A','B','C','H','X')
and ca.fecha between '20230101' and '20231031'
and p.idctacte = 7102 and p.espromocion = 0