USE MOVISOC ALIAS MOVISOC

=cursorsetprop('buffering',5)

BEGIN TRANSACTION
append blank
? cid,eof()
? recno(),eof()
go recno('movisoc') in movisoc
? recno(),eof()
=tableupdate(2,.t.,'movisoc')
append blank

? cid,eof()
? recno(),eof()
go recno('movisoc') in movisoc
sele movisoc
? recno(),eof()
? cid,eof()
go top
brow
rollback

