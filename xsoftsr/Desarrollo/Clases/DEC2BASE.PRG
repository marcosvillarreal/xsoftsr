PARAMETERS nNumDec, nBase

IF !Between(nBase, 2, 64)
	IF nBase < 2
		nBase = 2
	ENDIF
	
	IF nBase > 64
		nBase = 64
	ENDIF
ENDIF

PRIVATE cCadena, nResult

cCadena = ""

Do While .T.
	nResult = INT(nNumDec / nBase)
	
	If nResult < nBase
		If nBase >= 10
			cCadena = getletrahex(ALLTRIM(STR(INT(MOD(nNumDec,nBase)), 15))) + cCadena
			cCadena = getletrahex(ALLTRIM(STR(nResult, 15))) + cCadena
		Else
			cCadena = ALLTRIM(STR(INT(MOD(nNumDec,nBase)), 15)) + cCadena
			cCadena = ALLTRIM(STR(nResult, 15)) + cCadena
		EndIf
		
		EXIT
	Else
		If nBase >= 10
			cCadena = getletrahex(ALLTRIM(STR(INT(MOD(nNumDec,nBase)), 15))) + cCadena
		Else
			cCadena = ALLTRIM(STR(INT(MOD(nNumDec,nBase)), 15)) + cCadena
		EndIf
		
		nNumDec = nResult
	EndIf
EndDo

RETURN cCadena


FUNCTION getletrahex
PARAMETERS cNumero
	
Do Case
	Case UPPER(cNumero) = "10"
		cNumero = "A"
	Case UPPER(cNumero) = "11"
		cNumero = "B"
	Case UPPER(cNumero) = "12"
		cNumero = "C"
	Case UPPER(cNumero) = "13"
		cNumero = "D"
	Case UPPER(cNumero) = "14"
		cNumero = "E"
	Case UPPER(cNumero) = "15"
		cNumero = "F"
	Case UPPER(cNumero) = "16"
		cNumero = "G"
	Case UPPER(cNumero) = "17"
		cNumero = "H"
	Case UPPER(cNumero) = "18"
		cNumero = "I"
	Case UPPER(cNumero) = "19"
		cNumero = "J"
	Case UPPER(cNumero) = "20"
		cNumero = "K"
	Case UPPER(cNumero) = "21"
		cNumero = "L"
	Case UPPER(cNumero) = "22"
		cNumero = "M"
	Case UPPER(cNumero) = "23"
		cNumero = "N"
	Case UPPER(cNumero) = "24"
		cNumero = "O"
	Case UPPER(cNumero) = "25"
		cNumero = "P"
	Case UPPER(cNumero) = "26"
		cNumero = "Q"
	Case UPPER(cNumero) = "27"
		cNumero = "R"
	Case UPPER(cNumero) = "28"
		cNumero = "S"
	Case UPPER(cNumero) = "29"
		cNumero = "T"
	Case UPPER(cNumero) = "30"
		cNumero = "U"
	Case UPPER(cNumero) = "31"
		cNumero = "V"
	Case UPPER(cNumero) = "32"
		cNumero = "W"
	Case UPPER(cNumero) = "33"
		cNumero = "X"
	Case UPPER(cNumero) = "34"
		cNumero = "Y"
	Case UPPER(cNumero) = "35"
		cNumero = "Z"
	Case UPPER(cNumero) = "36"
		cNumero = "{"
	Case UPPER(cNumero) = "37"
		cNumero = "|"
	Case UPPER(cNumero) = "38"
		cNumero = "}"
	Case UPPER(cNumero) = "39"
		cNumero = "~"
	Case UPPER(cNumero) = "40"
		cNumero = ""
	Case UPPER(cNumero) = "41"
		cNumero = "Ä"
	Case UPPER(cNumero) = "42"
		cNumero = "Å"
	Case UPPER(cNumero) = "43"
		cNumero = "Ç"
	Case UPPER(cNumero) = "44"
		cNumero = "É"
	Case UPPER(cNumero) = "45"
		cNumero = "Ñ"
	Case UPPER(cNumero) = "46"
		cNumero = "Ö"
	Case UPPER(cNumero) = "47"
		cNumero = "Ü"
	Case UPPER(cNumero) = "48"
		cNumero = "á"
	Case UPPER(cNumero) = "49"
		cNumero = "à"
	Case UPPER(cNumero) = "50"
		cNumero = "â"
	Case UPPER(cNumero) = "51"
		cNumero = "ä"
	Case UPPER(cNumero) = "52"
		cNumero = "ã"
	Case UPPER(cNumero) = "53"
		cNumero = "å"
	Case UPPER(cNumero) = "54"
		cNumero = "ç"
	Case UPPER(cNumero) = "55"
		cNumero = "é"
	Case UPPER(cNumero) = "56"
		cNumero = "è"
	Case UPPER(cNumero) = "57"
		cNumero = "ê"
	Case UPPER(cNumero) = "58"
		cNumero = "ë"
	Case UPPER(cNumero) = "59"
		cNumero = "í"
	Case UPPER(cNumero) = "60"
		cNumero = "ì"
	Case UPPER(cNumero) = "61"
		cNumero = "î"
	Case UPPER(cNumero) = "62"
		cNumero = "ï"
	Case UPPER(cNumero) = "63"
		cNumero = "ñ"
EndCase

RETURN cNumero