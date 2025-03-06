use datos
go

--update movctacte set bloqueado=1
--where idctacte = 1001077 and saldo = 0 and fecha <='20230101'
go
--update movctacte set bloqueado=0
--from movctacte 
--left join maopera  on Movctacte.idmaopera = maopera.id
--left join afectacte on movctacte.id = afectacte.iddebe
--left join movctacte as movafectador on afectacte.idhaber = movafectador.id
--where movctacte.idctacte = 1001077 and movctacte.bloqueado=1
--and (movafectador.saldo <> 0 or movafectador.fecha >'20230101')