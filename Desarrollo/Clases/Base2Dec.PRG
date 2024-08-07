PARAMETERS cBaseNumero, nBase

IF !Between(nBase, 2, 64)
	IF nBase < 2
		nBase = 2
	ENDIF
	
	IF nBase > 64
		nBase = 64
	ENDIF
ENDIF

PRIVATE nLargo

nValue = 0
nLargo = LEN(cBaseNumero)

For nContNums = nLargo TO 1 STEP -1
	cNumero = SUBST(cBaseNumero, nContNums, 1)
	
	Do Case
		Case UPPER(cNumero) = "A"
			cNumero = "10"
		Case UPPER(cNumero) = "B"
			cNumero = "11"
		Case UPPER(cNumero) = "C"
			cNumero = "12"
		Case UPPER(cNumero) = "D"
			cNumero = "13"
		Case UPPER(cNumero) = "E"
			cNumero = "14"
		Case UPPER(cNumero) = "F"
			cNumero = "15"
		Case UPPER(cNumero) = "G"
			cNumero = "16"
		Case UPPER(cNumero) = "H"
			cNumero = "17"
		Case UPPER(cNumero) = "I"
			cNumero = "18"
		Case UPPER(cNumero) = "J"
			cNumero = "19"
		Case UPPER(cNumero) = "K"
			cNumero = "20"
		Case UPPER(cNumero) = "L"
			cNumero = "21"
		Case UPPER(cNumero) = "M"
			cNumero = "22"
		Case UPPER(cNumero) = "N"
			cNumero = "23"
		Case UPPER(cNumero) = "O"
			cNumero = "24"
		Case UPPER(cNumero) = "P"
			cNumero = "25"
		Case UPPER(cNumero) = "Q"
			cNumero = "26"
		Case UPPER(cNumero) = "R"
			cNumero = "27"
		Case UPPER(cNumero) = "S"
			cNumero = "28"
		Case UPPER(cNumero) = "T"
			cNumero = "29"
		Case UPPER(cNumero) = "U"
			cNumero = "30"
		Case UPPER(cNumero) = "V"
			cNumero = "31"
		Case UPPER(cNumero) = "W"
			cNumero = "32"
		Case UPPER(cNumero) = "X"
			cNumero = "33"
		Case UPPER(cNumero) = "Y"
			cNumero = "34"
		Case UPPER(cNumero) = "Z"
			cNumero = "35"
		Case UPPER(cNumero) = "{"
			cNumero = "36"
		Case UPPER(cNumero) = "|"
			cNumero = "37"
		Case UPPER(cNumero) = "}"
			cNumero = "38"
		Case UPPER(cNumero) = "~"
			cNumero = "39"
		Case UPPER(cNumero) = ""
			cNumero = "40"
		Case UPPER(cNumero) = "�"
			cNumero = "41"
		Case UPPER(cNumero) = "�"
			cNumero = "42"
		Case UPPER(cNumero) = "�"
			cNumero = "43"
		Case UPPER(cNumero) = "�"
			cNumero = "44"
		Case UPPER(cNumero) = "�"
			cNumero = "45"
		Case UPPER(cNumero) = "�"
			cNumero = "46"
		Case UPPER(cNumero) = "�"
			cNumero = "47"
		Case UPPER(cNumero) = "�"
			cNumero = "48"
		Case UPPER(cNumero) = "�"
			cNumero = "49"
		Case UPPER(cNumero) = "�"
			cNumero = "50"
		Case UPPER(cNumero) = "�"
			cNumero = "51"
		Case UPPER(cNumero) = "�"
			cNumero = "52"
		Case UPPER(cNumero) = "�"
			cNumero = "53"
		Case UPPER(cNumero) = "�"
			cNumero = "54"
		Case UPPER(cNumero) = "�"
			cNumero = "55"
		Case UPPER(cNumero) = "�"
			cNumero = "56"
		Case UPPER(cNumero) = "�"
			cNumero = "57"
		Case UPPER(cNumero) = "�"
			cNumero = "58"
		Case UPPER(cNumero) = "�"
			cNumero = "59"
		Case UPPER(cNumero) = "�"
			cNumero = "60"
		Case UPPER(cNumero) = "�"
			cNumero = "61"
		Case UPPER(cNumero) = "�"
			cNumero = "62"
		Case UPPER(cNumero) = "�"
			cNumero = "63"
	EndCase
	
	nValue = nValue + ((nBase ^ (nLargo - nContNums)) * VAL(cNumero))
EndFor

RETURN nValue