
CLOSE DATABASES
OPEN DATABASE ? EXCLUSIVE

SET CPCOMPILE TO 1252
codepage = 1252
SET CPDIALOG ON

SET DATABASE TO DATOS
USE datos!keysid IN 0 ALIAS Csrkeysid EXCLUSIVE
SELECT CsrKeysid
ZAP

x=ADIR(larrayname,"c:\xsoftsql\proyectos\starossa\datos\*.DBF")
FOR I=1 TO X
    lcalias = LARRAYNAME[I,1]
    ip = AT(".",lcalias)
    IF ip>0
       lcalias = LEFT(lcalias,ip-1)
    ENDIF 
    
   B= "datos!"+lcalias
    
    IF "KEYSID"$UPPER(b)
         LOOP 
    ENDIF 
    IF "EMPRESA"$UPPER(b)
         LOOP 
    ENDIF 
    IF "SISTEMA"$UPPER(b)
         LOOP 
    ENDIF 
    IF "GESTION"$UPPER(B)
    	LOOP 
    ENDIF

    IF "DATAMENU"$UPPER(B)
    	LOOP 
    ENDIF

    IF "CATEIBBA"$UPPER(B)
    	LOOP 
    ENDIF

    IF "PARADIARIO"$UPPER(B)
    	LOOP 
    ENDIF

    IF "PARAVARIO"$UPPER(B)
    	LOOP 
    ENDIF
        	
    IF USED("Csrarch")
        USE IN CsrArch
    ENDIF 

   IF USED("Csrcursor")
       SELECT Csrcursor
       USE 
   ENDIF 
      
    USE &B  IN 0 ALIAS Csrarch EXCLUSIVE 
    SELECT Csrarch
    SET ORDER TO ID    
    =AFIELDS(LCARRAY)
    xx = ASCAN(lcarray,"ID")
    
    lninc = 0
    IF xx >0
       lninc = lcarray[xx,17]
    ENDIF 
    
   IF lninc=0
      SELECT MAX(CsrArch.id) as idkey FROM Csrarch INTO CURSOR Csrcursor
       lcalias = UPPER(lcalias)
       lnid = CsrCursor.idkey + 1
       IF VARTYPE(lnid)#"N"
          lnid = 1
       ENDIF 
      INSERT INTO Keysid (Tabla,nextid,ctipocomp) VALUES (lcalias, lnid ,'')           
        
   ENDIF 
     
NEXT



