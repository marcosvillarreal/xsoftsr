use datos
go
select --vendedor.nombre, maopera.numcomp,maopera.idvendedor,
cabefac.idmaopera,vendedor.nombre,cabefac.cnombre,cabefac.total,maopera.numcomp--,pedipda.* ,
--tablaimp.*
from maopera 
left join vendedor on maopera.idvendedor = vendedor.id
inner join cabefac on maopera.id = cabefac.idmaopera
inner join pedipda on cabefac.idmaopera = pedipda.idmaopera
--left join tablaimp on maopera.id = tablaimp.idmaopera
where terminal= 8 and maopera.origen='FAC'
--maopera.origen='FPE'
and maopera.id between 2890846 and 2890873
--and cabefac.idmaopera in (2890868)
order by maopera.id desc --, tablaimp.id
--select * from cuerfac where idmaopera = 2890868

--go
--select * from cabeunifica where id = 1000837
--select * from cabepromo where idprodgenera in (1004870,1004143,1003663)