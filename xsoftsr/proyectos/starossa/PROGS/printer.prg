miprinter="\\Server_compufar\ColaHP600"

*COPY FILE "c:\sql.txt" TO &miprinter


SET DEVICE TO PRINTER &miprinter
SET PRINTER TO (miprinter)
SET CONSOLE OFF
SET PRINTER ON

? '*****************************************************'
? '*****************************************************'

SET DEVICE TO SCREEN
SET CONSOLE ON
SET PRINTER OFF			
SET PRINTER TO 
