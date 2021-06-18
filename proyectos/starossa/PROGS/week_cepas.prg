FUNCTION Week2021()

CREATE CURSOR Tabla (fecha c(10), w n(2))

LOCAL dDate

dDate = CTOD('04-01-2021')

DO WHILE YEAR(dDate) = 2021
	SELECT Tabla
	APPEND BLANK
	replace fecha WITH DTOC(dDate), W WITH WEEK(dDate,2,2)
	dDate = dDate + 7
ENDDO 

SELECT Tabla
vista()