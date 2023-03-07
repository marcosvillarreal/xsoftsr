use datos
go
select --vendedor.nombre, maopera.numcomp,maopera.idvendedor,
cabefac.*--,pedipda.* 
from maopera 
left join vendedor on maopera.idvendedor = vendedor.id
inner join cabefac on maopera.id = cabefac.idmaopera
inner join pedipda on cabefac.idmaopera = pedipda.idmaopera
where terminal= 8 and maopera.origen='FAC'
and maopera.id between 2890846 and 2890873
and cabefac.id in (2461782,2461781)
order by maopera.id desc