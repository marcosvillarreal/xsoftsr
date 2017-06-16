use datos
go
--select * from producto where numero = 10032
--select * from existenc where idarticulo = 1003572
select maopera.origen,movstock.id,movstock.idmaopera,movstock.fecha,movstock.cantidad
,movstock.switch,movstock.signo,movstock.existefac,movstock.existedisp,movstock.existecarga
,maopera.switch,fleteplanilla.fecha,maopera.estado,maopera.clasecomp ,anmaopera.idafecta,anmaopera.idmaopera
from movstock 
left join maopera on movstock.idmaopera =maopera.id
left join fletecarga on maopera.id = fletecarga.idmaopera
left join fleteplanilla on fletecarga.idfleteplan = fleteplanilla.id
left join anmaopera on maopera.id = anmaopera.idafecta
where idarticulo =  1003572  order by movstock.id desc
go
