use datos
go
delete from maopera where id > 1000000
go
delete from cabefac where idmaopera > 1000000
go
delete from cuerfac where idmaopera > 1000000
go
delete from movstock where idmaopera > 1000000
go
delete from existenc
go
delete from nmaopera
go
delete from ncabefac
go
delete from ncuerfac
go
delete from tablaimp where idmaopera > 1000000
go
delete from tablaasi where idmaopera > 1000000
go
delete from fletecarga
go
delete from fleteplanilla
go
delete from fleteren
go
delete from renflete
go
delete from renmaope
go
delete from movcaja
go
delete from movbcocar
go
delete from movctacte
go
delete from anmaopera
go
delete from ncuervari
go
delete from cuervari where idmaopera > 1000000
go
delete from afebcocar
go
delete from afenpedido
go
delete from afectacte
go
update ctacte set saldo=0
go
delete from cabecpra
go
delete from cuercpra
go
delete from cuervaricpra
go
delete from cabeord
go
delete from cuerord
go
delete from cuervariord
go
